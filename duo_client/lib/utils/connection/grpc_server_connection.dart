import 'dart:convert';
import 'package:duo_client/pb/auth_messages.pb.dart';
import 'package:duo_client/utils/connection/abstract_connection.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:duo_client/utils/connection/conectivity.dart' as connectivity;
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
      connectivity.host,
      port: connectivity.port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    client = DUOServiceClient(channel);
  }

  /// Registers a user with the server
  @override
  Future<int> registerUser(String username) async {
    // Generate RSA key pair
    var helper = RsaKeyHelper();
    final keyPair = await helper.computeRSAKeyPair(helper.getSecureRandom());

    var encodedPublicKey =
        helper.encodePublicKeyToPemPKCS1(keyPair.publicKey as RSAPublicKey);
    var encodedPrivateKey =
        helper.encodePrivateKeyToPemPKCS1(keyPair.privateKey as RSAPrivateKey);
    try {
      RegisterResponse resp = await client.register(RegisterRequest()
        ..username = username
        ..publicKey = encodedPublicKey);

      await storage.write(key: 'username', value: username);
      await storage.write(key: 'userid', value: resp.uuid);
      await storage.write(key: keyToAccessToken, value: resp.authToken);
      await storage.write(key: keyToPrivateKey, value: encodedPrivateKey);
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
    var helper = RsaKeyHelper();

    RSAPrivateKey privKey = helper.parsePrivateKeyFromPem(privateKey);

    var decodedChallenge = base64.decode(lcr.challenge);
    var decodedChallengeString = String.fromCharCodes(decodedChallenge);

    var decryptedChallenge = decrypt(
      decodedChallengeString,
      privKey,
    );

    decryptedChallenge =
        decryptedChallenge.substring(decryptedChallenge.length - 32);

    print('Decrypted challenge: ${decryptedChallenge}');
    return 0;
  }
}
