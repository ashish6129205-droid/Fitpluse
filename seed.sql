INSERT INTO users (name, email, password_hash, role, age, height_cm, weight_kg, fitness_goal, active)
VALUES
    ('Demo User', 'user@fittrack.demo', '$2a$10$Jv.C5o77kEs2Ji/4a5ehXO.hfEttBMc7RkF.3ARGWgpN2CymZ9fOK', 'USER', 28, 175.5, 70.0, 'Build Muscle', true),
    ('Admin User', 'admin@fittrack.demo', '$2a$10$rcNgsci.4L/4CsEGKzTfvOB5RgCN9XHkxVtnRCBqKCsLAD7gjirDG', 'ADMIN', 35, 180.0, 80.0, 'General Fitness', true)
ON CONFLICT (email) DO NOTHING;
