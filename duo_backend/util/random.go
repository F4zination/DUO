package util

import (
	cr "crypto/rand"
	"math/big"
	"math/rand"
	"strings"
	"time"

	"github.com/google/uuid"
)

const (
	alphabet          = "abcdefghijklmnopqrstuvxyz"
	challengeAlphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
)

func init() {
	rand.NewSource(time.Now().UnixNano())
}

func RandomUUID() uuid.UUID {
	return uuid.New()
}

func RandomInt(min, max int64) int64 {
	return rand.Int63n(max-min+1) + min
}

func CryptoRandomString(length int) (string, error) {
	var sb strings.Builder
	var alphLength = len(challengeAlphabet)

	for i := 0; i < length; i++ {
		n, randErr := cr.Int(cr.Reader, big.NewInt(int64(alphLength)))
		if randErr != nil {
			return "", randErr
		}
		sb.WriteByte(challengeAlphabet[n.Int64()])
	}
	return sb.String(), nil
}

func RandomString(length int) string {
	var sb strings.Builder
	var alphLength = len(alphabet)

	for i := 0; i < length; i++ {
		sb.WriteByte(alphabet[rand.Intn(alphLength)])
	}
	return sb.String()
}
