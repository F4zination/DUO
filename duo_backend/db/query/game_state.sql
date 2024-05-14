-- name: CreateGameState :one
INSERT INTO game_state 
(current_player_id, card_on_top_of_stack, is_clockwise, owner_id, stack_id)
VALUES
($1, $2, $3, $4, $5)
RETURNING *;

-- name: GetGameStateById :one
SELECT * FROM game_state WHERE id = $1;

-- name: UpdateGameState :one
UPDATE game_state
SET
    current_player_id = COALESCE(sqlc.narg('current_player_id'), current_player_id),
    card_on_top_of_stack = COALESCE(sqlc.narg('card_on_top_of_stack'), card_on_top_of_stack),
    is_clockwise = COALESCE(sqlc.narg('is_clockwise'), is_clockwise)
WHERE id = $1
RETURNING *;

-- name: DeleteGameState :one
DELETE FROM game_state WHERE id = $1 RETURNING *;

-- name: AddPlayerToGame :one
INSERT INTO game_player_rel
(game_id, player_id, player_position)
VALUES
($1, $2, $3)
RETURNING *;

-- name: GetPlayersGameId :one
SELECT * FROM game_player_rel WHERE player_id = $1;

-- name: GetPlayersInGame :many
SELECT * FROM game_player_rel WHERE game_id = $1;

-- name: RemovePlayerFromGame :one
DELETE FROM game_player_rel WHERE game_id = $1 AND player_id = $2 RETURNING *;

-- name: GetGameDrawStack :many
SELECT * FROM game_stack_draw_card_rel WHERE game_id = $1;

-- name: GetGamePlaceStack :many
SELECT * FROM game_stack_place_card_rel WHERE game_id = $1;

-- name: AddGamePlaceStack :one
INSERT INTO game_stack_place_card_rel
(game_id, card_id, stack_position)
VALUES
($1, $2, $3)
RETURNING *;

-- name: AddGameDrawStack :one
INSERT INTO game_stack_draw_card_rel
(game_id, card_id, stack_position)
VALUES
($1, $2, $3)
RETURNING *;

-- name: RemoveGameDrawStack :one
DELETE FROM game_stack_draw_card_rel WHERE game_id = $1 AND card_id = $2 AND stack_position = $3 RETURNING *;

-- name: RemoveGamePlaceStack :one
DELETE FROM game_stack_place_card_rel WHERE game_id = $1 AND card_id = $2 AND stack_position = $3 RETURNING *;
