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
    intensity    VARCHAR(50),
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
    participant_count INTEGER NOT NULL DEFAULT 0,
    created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS challenge_participants (
    id             SERIAL PRIMARY KEY,
    challenge_id   INTEGER NOT NULL REFERENCES challenges(id) ON DELETE CASCADE,
    user_id        INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    progress_value DOUBLE PRECISION NOT NULL DEFAULT 0,
    completed      BOOLEAN NOT NULL DEFAULT FALSE,
    status         VARCHAR(20) DEFAULT 'ACTIVE',
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

CREATE TABLE IF NOT EXISTS fitness_content (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(150) NOT NULL,
    content TEXT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS activity_log (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    action VARCHAR(100) NOT NULL,
    details VARCHAR(500),
    thread_name VARCHAR(100),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_workouts_user_id ON workouts(user_id);
CREATE INDEX IF NOT EXISTS idx_activity_log_user_id ON activity_log(user_id);

DO $$
BEGIN
    ALTER TABLE users ALTER COLUMN password_hash TYPE VARCHAR(255);
EXCEPTION
    WHEN OTHERS THEN NULL;
END $$;

DO $$
BEGIN
    ALTER TABLE workouts ADD COLUMN intensity VARCHAR(50);
EXCEPTION
    WHEN duplicate_column THEN NULL;
END $$;

DO $$
BEGIN
    ALTER TABLE challenges ADD COLUMN participant_count INTEGER NOT NULL DEFAULT 0;
EXCEPTION
    WHEN duplicate_column THEN NULL;
END $$;

DO $$
BEGIN
    ALTER TABLE challenge_participants ADD COLUMN status VARCHAR(20) DEFAULT 'ACTIVE';
EXCEPTION
    WHEN duplicate_column THEN NULL;
END $$;

DO $$
BEGIN
    ALTER TABLE activity_log ADD COLUMN thread_name VARCHAR(100);
EXCEPTION
    WHEN duplicate_column THEN NULL;
END $$;

-- Seed Realistic Demo Data for user@fittrack.demo
DO $$
DECLARE
    demo_user_id INTEGER;
BEGIN
    SELECT id INTO demo_user_id FROM users WHERE email = 'user@fittrack.demo';

    IF demo_user_id IS NOT NULL THEN
        -- 1. Running
        INSERT INTO workouts (user_id, workout_type, duration_min, calories, steps, workout_date, notes, status, intensity)
        VALUES (demo_user_id, 'Running', 45, 450, 6000, CURRENT_DATE - INTERVAL '3 days', 'Morning run', 'APPROVED', 'High');

        -- 2. Strength Training
        INSERT INTO workouts (user_id, workout_type, duration_min, calories, steps, workout_date, notes, status, intensity)
        VALUES (demo_user_id, 'Strength Training', 60, 380, 0, CURRENT_DATE - INTERVAL '2 days', 'Upper body day', 'APPROVED', 'Medium');

        -- 3. Cycling
        INSERT INTO workouts (user_id, workout_type, duration_min, calories, steps, workout_date, notes, status, intensity)
        VALUES (demo_user_id, 'Cycling', 35, 290, 0, CURRENT_DATE - INTERVAL '1 day', 'Evening ride', 'APPROVED', 'Medium');

        -- 4. HIIT Cardio
        INSERT INTO workouts (user_id, workout_type, duration_min, calories, steps, workout_date, notes, status, intensity)
        VALUES (demo_user_id, 'HIIT Cardio', 30, 340, 2000, CURRENT_DATE, 'Quick HIIT session', 'APPROVED', 'High');
    END IF;
END $$;
