import 'dart:convert';
import 'package:duo_client/pb/auth_messages.pb.dart';
import 'package:duo_client/pb/session_messages.pb.dart';
import 'package:duo_client/provider/storage_provider.dart';
import 'package:duo_client/utils/connection/abstract_connection.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/utils/encryption/encryption_handler.dart';
import 'package:grpc/grpc.dart';
import 'package:duo_client/pb/duo_service.pbgrpc.dart';
import 'package:pointycastle/export.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';

class GrpcServerConnection extends AbstractServerConnection {
  late final ClientChannel channel;
  late final DUOServiceClient client;
  final storage = const FlutterSecureStorage();

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

    // Try to register the user with the server and store the private key and user id
    try {
      RegisterResponse resp = await client.register(RegisterRequest()
        ..username = username
        ..publicKey = publicPEMKey);

      await storage.write(key: keyToUsername, value: username);
      await storage.write(key: keyToUserId, value: resp.uuid);
      await storage.write(key: keyToAccessToken, value: resp.authToken);
      await storage.write(key: keyToPrivateKey, value: privatePEMKey);
    } catch (e) {
      // If the registration fails, return -1
      return -1;
    }
    return 0;
  }

  /// Logs in a user with the server
  @override
  Future<int> loginUser(String uuid) async {
    String decryptedChallenge = '';

    ////////////////////////////////////////////
    // Request a login challenge from the server
    ////////////////////////////////////////////
    try {
      LoginChallengeRequest lcr =
          await client.requestLoginChallenge(LoginRequest()..uuid = uuid);

      String privateKey = (await storage.read(key: keyToPrivateKey)) ?? '';
      var helper = RsaKeyHelper();

      RSAPrivateKey privKey = helper.parsePrivateKeyFromPem(privateKey);

      var decodedChallenge = base64.decode(lcr.challenge);
      var decodedChallengeString = String.fromCharCodes(decodedChallenge);

      decryptedChallenge = decrypt(
        decodedChallengeString,
        privKey,
      );

      decryptedChallenge =
          decryptedChallenge.substring(decryptedChallenge.length - 32);
    } catch (e) {
      return -1;
    }
    ////////////////////////////////////////////
    //  Submit the decrypted challenge to the server
    ////////////////////////////////////////////
    try {
      LoginResponse lr =
          await client.submitLoginChallenge(LoginChallengeResponse()
            ..uuid = uuid
            ..decryptedChallenge = decryptedChallenge);

      await storage.write(key: keyToAccessToken, value: lr.token);
      await storage.write(key: keyToExpireDate, value: lr.expiresAt.toString());
    } catch (e) {
      return -1;
    }

    // If the login was successful, return 0
    return 0;
  }

  @override
  Future<int> createSession(String token, int pin) async {
    try {
      ResponseStream<SessionStream> stream =
          await client.createSession(CreateSessionRequest()
            ..token = token
            ..pin = pin);

      await for (SessionStream ss in stream) {
        print('Received: ${ss.sessionId}');
      }
    } catch (e) {
      return -1;
    }
    return 0;
  }

  @override
  Future<int> joinSession(String token, int sessionId, int pin) async {
    try {
      ResponseStream<SessionStream> stream =
          await client.joinSession(JoinSessionRequest()
            ..token = token
            ..sessionId = sessionId
            ..pin = pin);

      await for (SessionStream ss in stream) {
        print('Received: ${ss.sessionId}');
      }
    } catch (e) {
      return -1;
    }
    return 0;
  }

  @override
  Future<int> disconnectSession(String token, int sessionId) async {
    try {
      DisconnectSessionResponse res =
          await client.disconnectSession(DisconnectSessionRequest()
            ..token = token
            ..sessionId = sessionId);

      if (res.success) {
        return 0;
      } else {
        return -1;
      }
    } catch (e) {
      return -1;
    }
  }

  @override
  Future<int> deleteSession(String token, int sessionId) async {
    try {
      DeleteSessionResponse res =
          await client.deleteSession(DeleteSessionRequest()
            ..token = token
            ..sessionId = sessionId);

      if (res.success) {
        return 0;
      } else {
        return -1;
      }
    } catch (e) {
      return -1;
    }
  }
}
