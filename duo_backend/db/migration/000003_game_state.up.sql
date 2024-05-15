CREATE TABLE IF NOT EXISTS game_state (
    id SERIAL PRIMARY KEY,
    current_player_id UUID NOT NULL,
    card_on_top_of_stack VARCHAR(50) NULL,
    owner_id UUID NOT NULL,
    stack_id UUID NOT NULL,
    is_clockwise BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE game_state ADD CONSTRAINT fk_current_player_id FOREIGN KEY (current_player_id) REFERENCES duouser(uuid) ON DELETE CASCADE;

CREATE TABLE IF NOT EXISTS game_player_rel (
    game_id BIGINT NOT NULL,
    player_id UUID NOT NULL,
    player_position INT NOT NULL
);

CREATE INDEX game_id_idx ON game_player_rel (game_id);
CREATE INDEX player_id_idx ON game_player_rel (player_id);

-- ALTER TABLE game_player_rel ADD CONSTRAINT fk_game_id FOREIGN KEY (game_id) REFERENCES game_state(id) ON DELETE CASCADE;
ALTER TABLE game_player_rel ADD CONSTRAINT fk_player_id FOREIGN KEY (player_id) REFERENCES duouser(uuid) ON DELETE CASCADE;

CREATE TABLE IF NOT EXISTS game_stack_draw_card_rel (
    game_id BIGINT NOT NULL,
    card_id VARCHAR(70) NOT NULL,
    stack_position INT NOT NULL
);

ALTER TABLE game_stack_draw_card_rel ADD CONSTRAINT fk_game_id FOREIGN KEY (game_id) REFERENCES game_state(id) ON DELETE CASCADE;

CREATE TABLE IF NOT EXISTS game_stack_place_card_rel (
    game_id BIGINT NOT NULL,
    card_id VARCHAR(70) NOT NULL,
    stack_position INT NOT NULL
);

ALTER TABLE game_stack_place_card_rel ADD CONSTRAINT fk_game_id FOREIGN KEY (game_id) REFERENCES game_state(id) ON DELETE CASCADE;
