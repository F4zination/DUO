-- name: CreateLobby :one
INSERT INTO lobby (owner_id, max_players) VALUES ($1, $2) RETURNING *;

-- name: GetLobbyByID :one
SELECT * FROM lobby WHERE id = $1;

-- name: GetLobbyByOwnerUUID :one
SELECT * FROM lobby WHERE owner_id = $1;

-- name: DeleteLobbyByID :one
DELETE FROM lobby WHERE id = $1 RETURNING *;