// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.17.2
// source: user.sql

package db

import (
	"context"
	"database/sql"

	"github.com/google/uuid"
)

const createUser = `-- name: CreateUser :one
INSERT INTO duouser (username, public_key) VALUES ($1, $2) RETURNING uuid, username, public_key
`

type CreateUserParams struct {
	Username  string `json:"username"`
	PublicKey string `json:"public_key"`
}

func (q *Queries) CreateUser(ctx context.Context, arg CreateUserParams) (Duouser, error) {
	row := q.db.QueryRowContext(ctx, createUser, arg.Username, arg.PublicKey)
	var i Duouser
	err := row.Scan(&i.Uuid, &i.Username, &i.PublicKey)
	return i, err
}

const createUserLogin = `-- name: CreateUserLogin :one
INSERT INTO user_login (user_uuid, challenge) VALUES ($1, $2) RETURNING user_uuid, challenge, login_time
`

type CreateUserLoginParams struct {
	UserUuid  uuid.UUID `json:"user_uuid"`
	Challenge string    `json:"challenge"`
}

func (q *Queries) CreateUserLogin(ctx context.Context, arg CreateUserLoginParams) (UserLogin, error) {
	row := q.db.QueryRowContext(ctx, createUserLogin, arg.UserUuid, arg.Challenge)
	var i UserLogin
	err := row.Scan(&i.UserUuid, &i.Challenge, &i.LoginTime)
	return i, err
}

const deleteUserLoginByUUID = `-- name: DeleteUserLoginByUUID :execresult
DELETE FROM user_login WHERE user_uuid = $1
`

func (q *Queries) DeleteUserLoginByUUID(ctx context.Context, userUuid uuid.UUID) (sql.Result, error) {
	return q.db.ExecContext(ctx, deleteUserLoginByUUID, userUuid)
}

const getUserByUUID = `-- name: GetUserByUUID :one
SELECT uuid, username, public_key FROM duouser WHERE uuid = $1
`

func (q *Queries) GetUserByUUID(ctx context.Context, uuid uuid.UUID) (Duouser, error) {
	row := q.db.QueryRowContext(ctx, getUserByUUID, uuid)
	var i Duouser
	err := row.Scan(&i.Uuid, &i.Username, &i.PublicKey)
	return i, err
}

const getUserLoginByUUID = `-- name: GetUserLoginByUUID :one
SELECT user_uuid, challenge, login_time FROM user_login WHERE user_uuid = $1 LIMIT 1
`

func (q *Queries) GetUserLoginByUUID(ctx context.Context, userUuid uuid.UUID) (UserLogin, error) {
	row := q.db.QueryRowContext(ctx, getUserLoginByUUID, userUuid)
	var i UserLogin
	err := row.Scan(&i.UserUuid, &i.Challenge, &i.LoginTime)
	return i, err
}