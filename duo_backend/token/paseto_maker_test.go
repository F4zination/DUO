package token

import (
	"testing"
	"time"

	"github.com/duo/util"
	"github.com/stretchr/testify/require"
)

func TestPasetoMaker(t *testing.T) {
	maker, err := NewPasetoMaker(util.RandomString(32))
	require.NoError(t, err)

	username := util.RandomString(20)
	duration := time.Minute

	issuedAt := time.Now()
	expiredAt := issuedAt.Add(duration)

	token, payload, createErr := maker.CreateToken(util.RandomUUID(), username, duration)
	require.NoError(t, createErr)
	require.NotEmpty(t, token)
	require.NotEmpty(t, payload)

	payload, verifyErr := maker.VerifyToken(token)
	require.NoError(t, verifyErr)
	require.NotEmpty(t, payload)

	require.NotZero(t, payload.ID)
	require.Equal(t, username, payload.Username)
	require.WithinDuration(t, issuedAt, payload.IssuedAt, time.Second)
	require.WithinDuration(t, expiredAt, payload.ExpiredAt, time.Second)
}

func TestExpiredPasetoMaker(t *testing.T) {
	maker, err := NewPasetoMaker(util.RandomString(32))
	require.NoError(t, err)

	token, payload, err := maker.CreateToken(util.RandomUUID(), util.RandomString(15), -time.Minute)
	require.NoError(t, err)
	require.NotEmpty(t, token)
	require.NotEmpty(t, payload)

	payload, verifyErr := maker.VerifyToken(token)
	require.Error(t, verifyErr)
	require.EqualError(t, verifyErr, ErrExpiredToken.Error())
	require.Nil(t, payload)
}
