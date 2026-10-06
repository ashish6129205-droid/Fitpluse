CREATE TABLE IF NOT EXISTS users (
    id            SERIAL PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    email         VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role          VARCHAR(10)  NOT NULL DEFAULT 'USER',
    age           INTEGER,
    height_cm     DOUBLE PRECISION,
    weight_kg     DOUBLE PRECISION,
    fitness_goal  VARCHAR(255),
    active        BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS workouts (
    id           SERIAL PRIMARY KEY,
    user_id      INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    workout_type VARCHAR(100) NOT NULL,
    duration_min INTEGER NOT NULL,
    calories     INTEGER NOT NULL,
    steps        INTEGER NOT NULL DEFAULT 0,
    workout_date DATE NOT NULL,
    notes        VARCHAR(500),
    status       VARCHAR(10) NOT NULL DEFAULT 'APPROVED',
    created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS progress_entries (
    id         SERIAL PRIMARY KEY,
    user_id    INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    weight_kg  DOUBLE PRECISION,
    waist_cm   DOUBLE PRECISION,
    chest_cm   DOUBLE PRECISION,
    arms_cm    DOUBLE PRECISION,
    entry_date DATE NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS goals (
    id           SERIAL PRIMARY KEY,
    user_id      INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    goal_type    VARCHAR(100) NOT NULL,
    target_value DOUBLE PRECISION NOT NULL,
    current_value DOUBLE PRECISION NOT NULL DEFAULT 0,
    unit         VARCHAR(30),
    deadline     DATE,
    completed    BOOLEAN NOT NULL DEFAULT FALSE,
    created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS challenges (
    id           SERIAL PRIMARY KEY,
    title        VARCHAR(150) NOT NULL,
    description  VARCHAR(1000),
    metric       VARCHAR(50) NOT NULL,
    target_value DOUBLE PRECISION NOT NULL,
    unit         VARCHAR(30),
    start_date   DATE,
    end_date     DATE,
    active       BOOLEAN NOT NULL DEFAULT TRUE,
    created_by   INTEGER REFERENCES users(id) ON DELETE SET NULL,
    created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS challenge_participants (
    id             SERIAL PRIMARY KEY,
    challenge_id   INTEGER NOT NULL REFERENCES challenges(id) ON DELETE CASCADE,
    user_id        INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    progress_value DOUBLE PRECISION NOT NULL DEFAULT 0,
    completed      BOOLEAN NOT NULL DEFAULT FALSE,
    joined_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (challenge_id, user_id)
);

CREATE TABLE IF NOT EXISTS nutrition_logs (
    id           SERIAL PRIMARY KEY,
    user_id      INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    meal_name    VARCHAR(150) NOT NULL,
    calories     INTEGER NOT NULL DEFAULT 0,
    protein_g    DOUBLE PRECISION DEFAULT 0,
    carbs_g      DOUBLE PRECISION DEFAULT 0,
    fat_g        DOUBLE PRECISION DEFAULT 0,
    log_date     DATE NOT NULL,
    created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS water_logs (
    id         SERIAL PRIMARY KEY,
    user_id    INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    glasses    INTEGER NOT NULL,
    log_date   DATE NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS achievements (
    id         SERIAL PRIMARY KEY,
    user_id    INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title      VARCHAR(150) NOT NULL,
    description VARCHAR(500),
    icon       VARCHAR(50),
    earned_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_id, title)
);

CREATE TABLE IF NOT EXISTS settings (
    setting_key   VARCHAR(100) PRIMARY KEY,
    setting_value VARCHAR(500)
);
