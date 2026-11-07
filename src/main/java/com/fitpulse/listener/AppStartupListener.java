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

        User abhinab = new User();
        abhinab.setName("Abhinab Kumar Sinha");
        abhinab.setEmail("abhinabkumarsinha@gmail.com");
        abhinab.setRole("USER");
        userService.upsertUser(abhinab, "Abhinab@123");

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement()) {

            // Goals for Abhinab (user_id = 3 assuming sequence/or fetch ID)
            String fetchAbhinabIdSql = "SELECT id FROM users WHERE email = 'abhinabkumarsinha@gmail.com'";
            int abhinabId = -1;
            try(java.sql.ResultSet rs = stmt.executeQuery(fetchAbhinabIdSql)) {
                if(rs.next()) {
                    abhinabId = rs.getInt("id");
                }
            }

            if (abhinabId != -1) {
                // Seed Goals idempotently
                String seedGoalsSql =
                    "INSERT INTO goals (user_id, goal_type, target_value, current_value, unit, deadline, completed, created_at) " +
                    "SELECT " + abhinabId + ", 'Burn 5,000 Kcal this Month', 5000, 3798, 'kcal', '2026-11-30', false, CURRENT_TIMESTAMP " +
                    "WHERE NOT EXISTS (SELECT 1 FROM goals WHERE user_id = " + abhinabId + " AND goal_type = 'Burn 5,000 Kcal this Month');" +

                    "INSERT INTO goals (user_id, goal_type, target_value, current_value, unit, deadline, completed, created_at) " +
                    "SELECT " + abhinabId + ", '5km Morning Cardio Streak', 5, 2, 'days', '2026-11-30', false, CURRENT_TIMESTAMP " +
                    "WHERE NOT EXISTS (SELECT 1 FROM goals WHERE user_id = " + abhinabId + " AND goal_type = '5km Morning Cardio Streak');";
                stmt.execute(seedGoalsSql);

                // Seed Progress Logs idempotently
                String seedProgressSql =
                    "INSERT INTO progress_entries (user_id, weight_kg, waist_cm, chest_cm, arms_cm, entry_date, created_at) " +
                    "SELECT " + abhinabId + ", 71.0, 81.0, 98.0, 35.0, '2026-11-01', CURRENT_TIMESTAMP " +
                    "WHERE NOT EXISTS (SELECT 1 FROM progress_entries WHERE user_id = " + abhinabId + " AND entry_date = '2026-11-01');" +

                    "INSERT INTO progress_entries (user_id, weight_kg, waist_cm, chest_cm, arms_cm, entry_date, created_at) " +
                    "SELECT " + abhinabId + ", 70.0, 80.0, 99.0, 35.5, '2026-11-07', CURRENT_TIMESTAMP " +
                    "WHERE NOT EXISTS (SELECT 1 FROM progress_entries WHERE user_id = " + abhinabId + " AND entry_date = '2026-11-07');";
                stmt.execute(seedProgressSql);

                // Fetch Demo User ID for Community Tips
                String fetchUserIdSql = "SELECT id FROM users WHERE email = 'user@fittrack.demo'";
                int demoUserId = -1;
                try(java.sql.ResultSet rs = stmt.executeQuery(fetchUserIdSql)) {
                    if(rs.next()) {
                        demoUserId = rs.getInt("id");
                    }
                }

                // Seed Community Tips idempotently
                String seedCommunityTipsSql =
                    "INSERT INTO fitness_content (user_id, title, content, status, created_at) " +
                    "SELECT " + abhinabId + ", 'Hydration Window Before Heavy Cardio', 'Drink 400ml water 45 minutes before HIIT workouts to maintain cardiovascular output without bloating.', 'APPROVED', CURRENT_TIMESTAMP " +
                    "WHERE NOT EXISTS (SELECT 1 FROM fitness_content WHERE user_id = " + abhinabId + " AND title = 'Hydration Window Before Heavy Cardio');";

                if (demoUserId != -1) {
                     seedCommunityTipsSql += "INSERT INTO fitness_content (user_id, title, content, status, created_at) " +
                    "SELECT " + demoUserId + ", 'Progressive Overload Rule', 'Track your compound lifts weekly. Aim for 1 additional rep before increasing barbell weight.', 'APPROVED', CURRENT_TIMESTAMP " +
                    "WHERE NOT EXISTS (SELECT 1 FROM fitness_content WHERE user_id = " + demoUserId + " AND title = 'Progressive Overload Rule');";
                }

                stmt.execute(seedCommunityTipsSql);
            }

        } catch (Exception e) {
            System.err.println("Failed to seed demo data: " + e.getMessage());
            e.printStackTrace();
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
