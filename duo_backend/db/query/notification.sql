-- name: CreateNotification :one
INSERT INTO notifications (user_id, message, message_type) VALUES ($1, $2, $3) RETURNING *;

-- name: GetNotificationsByUserId :many
SELECT * FROM notifications WHERE user_id = $1 ORDER BY created_at DESC;

-- name: ClearNotificationsByUserId :execresult
DELETE FROM notifications WHERE user_id = $1;
