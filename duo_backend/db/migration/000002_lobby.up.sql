CREATE TABLE IF NOT EXISTS lobby (
    id SERIAL PRIMARY KEY,
    owner_id UUID NOT NULL UNIQUE,
    stack_id UUID NOT NULL,
    max_players INT NOT NULL
);

CREATE INDEX owner_id_idx ON lobby (owner_id);
ALTER TABLE lobby ADD CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES duouser(uuid);
ALTER TABLE lobby ADD CONSTRAINT fk_stack_id FOREIGN KEY (stack_id) REFERENCES duouser(uuid);