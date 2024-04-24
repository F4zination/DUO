import 'dart:convert';
import 'package:duo_client/provider/storage_provider.dart';

import '../../pb/auth_messages.pb.dart';
import '../../pb/session_messages.pb.dart';
import 'abstract_connection.dart';
import '../constants.dart';
import '../encryption/encryption_handler.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import '../../pb/duo_service.pbgrpc.dart';
import 'package:pointycastle/export.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';

class GrpcServerConnection extends AbstractServerConnection {
  late final ClientChannel channel;
  late final DUOServiceClient client;
  late final VoidCallback _notifyListeners;
  final StorageProvider _storage;

  GrpcServerConnection(this._storage, this._notifyListeners) : super() {
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

      await _storage.setUsername(username);
      await _storage.setUserId(resp.uuid);
      await _storage.setAccessToken(resp.authToken);
      await _storage.setPrivateKey(privatePEMKey);
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

      String privateKey = _storage.privateKey;
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

      await _storage.setExpireDate(lr.expiresAt.toDateTime());
      await _storage.setAccessToken(lr.token);
    } catch (e) {
      return -1;
    }

    // If the login was successful, return 0

    return 0;
  }

  @override
  Future<int> createSession(String token, String pin) async {
    try {
      CreateSessionResponse response =
          await client.createSession(CreateSessionRequest()
            ..token = token
            ..pin = pin);

      if (response.sessionId != 0) {
        print('Session ID: ${response.sessionId}');

        return response.sessionId;
      }
    } catch (e) {
      print('Error: $e');
      return -1;
    }
    return 0;
  }

  @override
  Future<int> joinSession(String token, int sessionId) async {
    try {
      ResponseStream<SessionStream> stream =
          client.joinSession(JoinSessionRequest()
            ..token = token
            ..sessionId = sessionId);

      await for (SessionStream ss in stream) {
        print('Received: ${ss.sessionState.users.length}');
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
}
