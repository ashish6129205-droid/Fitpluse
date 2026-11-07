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

            // Execute V1__init_schema.sql
            executeSqlScript(stmt, "/db/migration/V1__init_schema.sql");
            System.out.println("Database migration script executed.");

            // We no longer rely on seed.sql. We use UserService.upsertUser for deterministic hashing.
            String env = System.getenv("APP_ENV");
            if (env == null || "development".equalsIgnoreCase(env)) {
                seedDemoUsers();
                System.out.println("Seed demo users processed via UserService (Development Mode).");
            } else {
                System.out.println("Production mode detected. Skipping demo user seeding.");
            }

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

        // Seed 4-5 activity log audit rows for the admin user
        seedAdminActivityLogs();

        // Seed data for the demo user
        seedDemoUserData();
    }

    private void seedDemoUserData() {
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement()) {

            // Get user ID
            java.sql.ResultSet rs = stmt.executeQuery("SELECT id FROM users WHERE email = 'user@fittrack.demo'");
            if (rs.next()) {
                int userId = rs.getInt("id");

                // Check and Seed Goals
                java.sql.ResultSet rsGoals = stmt.executeQuery("SELECT COUNT(*) FROM goals WHERE user_id = " + userId);
                if (rsGoals.next() && rsGoals.getInt(1) == 0) {
                    stmt.execute("INSERT INTO goals (user_id, goal_type, target_value, current_value, unit, completed) " +
                                 "VALUES (" + userId + ", 'Burn 10,000 Kcal this Month', 10000, 0, 'Kcal', FALSE)");
                    stmt.execute("INSERT INTO goals (user_id, goal_type, target_value, current_value, unit, completed) " +
                                 "VALUES (" + userId + ", 'Run 50 Km in November', 50, 0, 'Km', FALSE)");
                }

                // Check and Seed Community Posts (fitness_content)
                java.sql.ResultSet rsPosts = stmt.executeQuery("SELECT COUNT(*) FROM fitness_content WHERE user_id = " + userId);
                if (rsPosts.next() && rsPosts.getInt(1) == 0) {
                    stmt.execute("INSERT INTO fitness_content (user_id, title, content, status) " +
                                 "VALUES (" + userId + ", 'Optimal Pre-Workout Hydration Strategies', 'Hydration is key. Drink water before you start.', 'APPROVED')");
                    stmt.execute("INSERT INTO fitness_content (user_id, title, content, status) " +
                                 "VALUES (" + userId + ", 'Progressive Overload for Hypertrophy', 'Gradually increase the weight you lift to build muscle.', 'APPROVED')");
                }

                // Check and Seed Body Progress (progress_entries)
                java.sql.ResultSet rsProgress = stmt.executeQuery("SELECT COUNT(*) FROM progress_entries WHERE user_id = " + userId);
                if (rsProgress.next() && rsProgress.getInt(1) == 0) {
                    stmt.execute("INSERT INTO progress_entries (user_id, entry_date, weight_kg, waist_cm, chest_cm, arms_cm) " +
                                 "VALUES (" + userId + ", CURRENT_DATE - INTERVAL '7 days', 71.5, 85.0, 95.0, 32.0)");
                    stmt.execute("INSERT INTO progress_entries (user_id, entry_date, weight_kg, waist_cm, chest_cm, arms_cm) " +
                                 "VALUES (" + userId + ", CURRENT_DATE, 70.0, 83.5, 96.0, 32.5)");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Failed to seed demo user data: " + e.getMessage());
        }
    }

    private void seedAdminActivityLogs() {
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement()) {

            // Get admin ID
            java.sql.ResultSet rs = stmt.executeQuery("SELECT id FROM users WHERE email = 'admin@fittrack.demo'");
            if (rs.next()) {
                int adminId = rs.getInt("id");

                // Check if logs already exist
                java.sql.ResultSet rsLogs = stmt.executeQuery("SELECT COUNT(*) FROM activity_log WHERE user_id = " + adminId);
                rsLogs.next();
                if (rsLogs.getInt(1) == 0) {
                    stmt.addBatch("INSERT INTO activity_log (user_id, action, details, thread_name) VALUES (" + adminId + ", 'USER_LOGIN', 'Admin logged in from 192.168.1.1', 'http-nio-8080-exec-1')");
                    stmt.addBatch("INSERT INTO activity_log (user_id, action, details, thread_name) VALUES (" + adminId + ", 'SYSTEM_CONFIG_UPDATED', 'Updated application theme settings', 'http-nio-8080-exec-2')");
                    stmt.addBatch("INSERT INTO activity_log (user_id, action, details, thread_name) VALUES (" + adminId + ", 'USER_BANNED', 'Banned spam user ID 42', 'http-nio-8080-exec-3')");
                    stmt.addBatch("INSERT INTO activity_log (user_id, action, details, thread_name) VALUES (" + adminId + ", 'CHALLENGE_CREATED', 'Created new global challenge: 30-Day Cardio Shred', 'http-nio-8080-exec-5')");
                    stmt.addBatch("INSERT INTO activity_log (user_id, action, details, thread_name) VALUES (" + adminId + ", 'CONTENT_APPROVED', 'Approved user submitted fitness content', 'http-nio-8080-exec-7')");
                    stmt.executeBatch();
                }
            }
        } catch (Exception e) {
            System.err.println("Failed to seed admin activity logs: " + e.getMessage());
        }
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
        DBUtil.closeDataSource();
        System.out.println("FitPulse Application Shutting Down.");
    }
}
