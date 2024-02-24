package util

import (
	"crypto/rand"
	"crypto/rsa"
	"crypto/x509"
	"encoding/base64"
	"encoding/pem"
	"fmt"
)

// / CreateLoginChallenge creates a login challenge and encrypts it with the user's public key
// / Returns the encrypted challenge and the challenge itself (plaintext, encrypted, error)
func CreateLoginChallenge(publicKey string) (string, string, error) {
	challenge, challengeErr := CryptoRandomString(8)
	if challengeErr != nil {
		return "", "", challengeErr
	}

	publicKeyBlock, _ := pem.Decode([]byte(publicKey))
	if publicKeyBlock == nil || publicKeyBlock.Type != "RSA PUBLIC KEY" {
		return "", "", fmt.Errorf("invalid public key, maybe not an rsa key")
	}

	rsaKey, parseErr := x509.ParsePKCS1PublicKey(publicKeyBlock.Bytes)
	if parseErr != nil {
		return "", "", parseErr
	}

	encryptedText, encErr := rsa.EncryptPKCS1v15(rand.Reader, rsaKey, []byte(challenge))
	if encErr != nil {
		return "", "", encErr
	}

	return challenge, string(encryptedText), nil
}

func EncodeBase64(b []byte) string {
	return base64.StdEncoding.EncodeToString(b)
}

func DecodeBase64(s string) ([]byte, error) {
	return base64.StdEncoding.DecodeString(s)
}
