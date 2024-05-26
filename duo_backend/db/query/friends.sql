-- name: AddFriendRequest :one
INSERT INTO friend_requests (requester_id, requestee_id, requester_name, status)
VALUES ($1, $2, $3, 'pending')
ON CONFLICT (requester_id, requestee_id) DO NOTHING
RETURNING *;

-- name: DeleteFriendRequest :one
DELETE FROM friend_requests
WHERE requester_id = $1 AND requestee_id = $2
RETURNING *;

-- name: UpdateFriendRequestStatus :one
UPDATE friend_requests
SET status = $3
WHERE requester_id = $1 AND requestee_id = $2
RETURNING *;

-- name: GetOpenFriendRequestByRequesteeId :many
SELECT * FROM friend_requests
WHERE requestee_id = $1
AND status = 'pending';

-- name: GetFriendsByUserId :many
SELECT * FROM friendships JOIN duouser ON (
    (friendships.user1_id = duouser.id AND friendships.user2_id = $1)
    OR
    (friendships.user2_id = duouser.id AND friendships.user1_id = $1)
)
WHERE user1_id = $1 OR user2_id = $1;

-- name: AddFriendship :one
INSERT INTO friendships (user1_id, user2_id)
VALUES (
    CASE WHEN $1 < $2 THEN $1 ELSE $2 END,
    CASE WHEN $1 < $2 THEN $2 ELSE $1 END
)
ON CONFLICT (user1_id, user2_id) DO NOTHING
RETURNING *;

-- name: DeleteFriendship :one
DELETE FROM friendships
WHERE CASE WHEN $1 < $2 THEN user1_id ELSE user2_id END = $1
AND CASE WHEN $1 < $2 THEN user2_id ELSE user1_id END = $2
RETURNING *;
