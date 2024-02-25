CREATE TABLE IF NOT EXISTS game_session (
    id SERIAL PRIMARY KEY,
    pin VARCHAR(255) NOT NULL,
    owner_id UUID NOT NULL UNIQUE,
    max_players INT NOT NULL
);

CREATE INDEX owner_id_idx ON game_session (owner_id);
ALTER TABLE game_session ADD CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES duouser(uuid);