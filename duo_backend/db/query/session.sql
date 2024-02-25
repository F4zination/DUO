-- name: CreateSession :one
INSERT INTO game_session (pin, owner_id) VALUES ($1, $2) RETURNING *;

-- name: GetSessionByID :one
SELECT * FROM game_session WHERE id = $1;

-- name: GetSessionByOwnerUUID :one
SELECT * FROM game_session WHERE owner_id = $1;

-- name: DeleteSessionByID :one
DELETE FROM game_session WHERE id = $1 RETURNING *;