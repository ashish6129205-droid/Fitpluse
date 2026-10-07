package com.fitpulse.listener;

import com.fitpulse.model.User;
import com.fitpulse.service.UserService;
import com.fitpulse.util.DBUtil;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.Statement;

@WebListener
public class AppStartupListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("FitPulse Application Starting - Initializing Database...");

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement()) {

            // Execute schema.sql
            executeSqlScript(stmt, "/schema.sql");
            System.out.println("Schema creation script executed.");

            // Ensure password_hash is wide enough
            stmt.execute("ALTER TABLE users ALTER COLUMN password_hash TYPE VARCHAR(255);");
            stmt.execute("ALTER TABLE workouts ADD COLUMN IF NOT EXISTS intensity VARCHAR(50);");
            stmt.execute("ALTER TABLE challenges ADD COLUMN IF NOT EXISTS participant_count INTEGER NOT NULL DEFAULT 0;");
            stmt.execute("ALTER TABLE challenge_participants ADD COLUMN IF NOT EXISTS status VARCHAR(20) DEFAULT 'ACTIVE';");
            stmt.execute("CREATE TABLE IF NOT EXISTS fitness_content (id SERIAL PRIMARY KEY, user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE, title VARCHAR(150) NOT NULL, content TEXT NOT NULL, status VARCHAR(20) NOT NULL DEFAULT 'PENDING', created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP);");
            stmt.execute("CREATE TABLE IF NOT EXISTS activity_log (id SERIAL PRIMARY KEY, user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE, action VARCHAR(100) NOT NULL, details VARCHAR(500), created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP);");
            stmt.execute("ALTER TABLE activity_log ADD COLUMN IF NOT EXISTS thread_name VARCHAR(100);");

            // We no longer rely on seed.sql. We use UserService.upsertUser for deterministic hashing.
            seedDemoUsers();
            System.out.println("Seed demo users processed via UserService.");

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Failed to initialize database: " + e.getMessage());
        }
    }

    private void seedDemoUsers() {
        UserService userService = new UserService();

        User user = new User();
        user.setName("Demo User");
        user.setEmail("user@fittrack.demo");
        user.setRole("USER");
        userService.upsertUser(user, "User@123");

        User admin = new User();
        admin.setName("Admin User");
        admin.setEmail("admin@fittrack.demo");
        admin.setRole("ADMIN");
        userService.upsertUser(admin, "Admin@123");
    }

    private void executeSqlScript(Statement stmt, String resourcePath) throws Exception {
        try (InputStream is = getClass().getResourceAsStream(resourcePath)) {
            if (is == null) {
                System.out.println("Script not found: " + resourcePath);
                return;
            }
            String sqlScript = new String(is.readAllBytes(), StandardCharsets.UTF_8);
            String[] statements = sqlScript.split(";");
            for (String statement : statements) {
                if (!statement.trim().isEmpty()) {
                    stmt.execute(statement.trim());
                }
            }
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        com.fitpulse.service.ActivityLogService.getInstance().shutdown();
        System.out.println("FitPulse Application Shutting Down.");
    }
}
