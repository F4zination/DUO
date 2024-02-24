import 'dart:convert';
import 'package:duo_client/pb/auth_messages.pb.dart';
import 'package:duo_client/utils/connection/abstract_connection.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/utils/encryption/encryption_handler.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:duo_client/pb/duo_service.pbgrpc.dart';
import 'package:pointycastle/export.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';

class GrpcServerConnection extends AbstractServerConnection {
  late final ClientChannel channel;
  late final DUOServiceClient client;
  final storage = const FlutterSecureStorage();
  final Logger log = Logger('GrpcServerConnection');

  @override
  void init() {
    channel = ClientChannel(
      Constants.host,
      port: Constants.port,
      //TODO make secure
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    client = DUOServiceClient(channel);
  }

  /// Registers a user with the server
  @override
  Future<int> registerUser(String username) async {
    // Generate RSA key pair
    final (publicPEMKey, privatePEMKey) =
        await EncryptionHandler.createPemKeyPair();

    try {
      RegisterResponse resp = await client.register(RegisterRequest()
        ..username = username
        ..publicKey = publicPEMKey);

      await storage.write(key: 'username', value: username);
      await storage.write(key: 'userid', value: resp.uuid);
      await storage.write(key: keyToAccessToken, value: resp.authToken);
      await storage.write(key: keyToPrivateKey, value: privatePEMKey);
    } catch (e) {
      return -1;
    }
    return 0;
  }

  @override
  Future<int> loginUser(String uuid) async {
    LoginChallengeRequest lcr =
        await client.requestLoginChallenge(LoginRequest()..uuid = uuid);

    String privateKey = (await storage.read(key: keyToPrivateKey)) ?? '';

    final String decryptedChallenge = EncryptionHandler.decryptChallenge(
      lcr.challenge,
      privateKey,
    );
    return 0;
  }
}
