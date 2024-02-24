-- name: CreateUser :one
INSERT INTO duouser (username, public_key) VALUES ($1, $2) RETURNING *;