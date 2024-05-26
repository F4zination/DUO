CREATE TABLE friend_requests (
    requester_id UUID NOT NULL,
    requestee_id UUID NOT NULL,
    requester_name VARCHAR(255) NOT NULL, -- for faster lookup
    status VARCHAR(255) NOT NULL, --pending, accepted, rejected
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE friend_requests ADD CONSTRAINT friend_requests_pk PRIMARY KEY (requester_id, requestee_id);

ALTER TABLE friend_requests ADD CONSTRAINT friend_requests_requester_id_fk FOREIGN KEY (requester_id) REFERENCES duouser (uuid) ON DELETE CASCADE;
ALTER TABLE friend_requests ADD CONSTRAINT friend_requests_requestee_id_fk FOREIGN KEY (requestee_id) REFERENCES duouser (uuid) ON DELETE CASCADE;

CREATE TABLE friendships (
    user1_id UUID NOT NULL,
    user2_id UUID NOT NULL
);

ALTER TABLE friendships ADD CONSTRAINT friendships_pk PRIMARY KEY (user1_id, user2_id);
ALTER TABLE friendships ADD CONSTRAINT friendships_check CHECK (user1_id < user2_id);

ALTER TABLE friendships ADD CONSTRAINT friendships_user1_id_fk FOREIGN KEY (user1_id) REFERENCES duouser (uuid) ON DELETE CASCADE;
ALTER TABLE friendships ADD CONSTRAINT friendships_user2_id_fk FOREIGN KEY (user2_id) REFERENCES duouser (uuid) ON DELETE CASCADE;