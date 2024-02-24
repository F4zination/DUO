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
func CreateLoginChallenge(publicPEMKey string) (string, string, error) {
	challenge, challengeErr := CryptoRandomString(32)
	if challengeErr != nil {
		return "", "", challengeErr
	}

	publicKeyBlock, _ := pem.Decode([]byte(publicPEMKey))
	if publicKeyBlock == nil {
		return "", "", fmt.Errorf("failed to decode public key")
	}
	publicKey, publicKeyErr := x509.ParsePKCS1PublicKey(publicKeyBlock.Bytes)
	if publicKeyErr != nil {
		return "", "", publicKeyErr
	}
	ciphertext, err := rsa.EncryptPKCS1v15(rand.Reader, publicKey, []byte(challenge))
	if err != nil {
		return "", "", err
	}
	return challenge, EncodeBase64(ciphertext), nil
}

func EncodeBase64(b []byte) string {
	return base64.StdEncoding.EncodeToString(b)
}

func DecodeBase64(s string) ([]byte, error) {
	return base64.StdEncoding.DecodeString(s)
}
