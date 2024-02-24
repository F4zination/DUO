-- name: CreateUser :one
INSERT INTO duouser (username, public_key) VALUES ($1, $2) RETURNING *;

-- name: GetUserByUUID :one
SELECT * FROM duouser WHERE uuid = $1;

-- name: CreateUserLogin :one
INSERT INTO user_login (user_uuid, challenge) VALUES ($1, $2) RETURNING *;

-- name: GetUserLoginByUUID :one
SELECT * FROM user_login WHERE user_uuid = $1 LIMIT 1;

-- name: DeleteUserLoginByUUID :execresult
DELETE FROM user_login WHERE user_uuid = $1;