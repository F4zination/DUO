-- name: CreateLobby :one
INSERT INTO lobby (owner_id, stack_id, max_players) VALUES ($1, $2, $3) RETURNING *;

-- name: GetLobbyByID :one
SELECT * FROM lobby WHERE id = $1;

-- name: GetLobbyByOwnerUUID :one
SELECT * FROM lobby WHERE owner_id = $1;

-- name: UpdateStackUUID :one
UPDATE lobby SET stack_id = $1 WHERE id = $2 RETURNING *;

-- name: DeleteLobbyByID :one
DELETE FROM lobby WHERE id = $1 RETURNING *;