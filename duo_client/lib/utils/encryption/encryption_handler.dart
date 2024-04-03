import 'dart:convert';

import '../constants.dart';
import 'package:pointycastle/export.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';

class EncryptionHandler {
  /// Creates a new RSA key pair and returns the public and private key as pem strings
  static Future<(String, String)> createPemKeyPair() async {
    var helper = RsaKeyHelper();
    final keyPair = await helper.computeRSAKeyPair(helper.getSecureRandom());

    var encodedPublicKey =
        helper.encodePublicKeyToPemPKCS1(keyPair.publicKey as RSAPublicKey);
    var encodedPrivateKey =
        helper.encodePrivateKeyToPemPKCS1(keyPair.privateKey as RSAPrivateKey);
    return (encodedPublicKey, encodedPrivateKey);
  }

  /// Creates the private key from the pem string
  static RSAPrivateKey parsePrivateKeyFromPem(String key) {
    var helper = RsaKeyHelper();
    return helper.parsePrivateKeyFromPem(key);
  }

  /// Decrypts the challenge from the api server with the private key
  static String decryptChallenge(
      String encryptedChallenge, String privatePEMKey) {
    RSAPrivateKey privateKey = parsePrivateKeyFromPem(privatePEMKey);

    var decodedChallenge = base64.decode(encryptedChallenge);
    var decodedChallengeString = String.fromCharCodes(decodedChallenge);

    var decryptedChallenge = decrypt(decodedChallengeString, privateKey);

    decryptedChallenge = decryptedChallenge.substring(
        decryptedChallenge.length - Constants.decryptedChallengeLength);

    return decryptedChallenge;
  }
}
