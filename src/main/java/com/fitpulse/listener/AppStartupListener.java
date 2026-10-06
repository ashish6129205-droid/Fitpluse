package com.fitpulse.listener;

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

            // Execute seed.sql
            executeSqlScript(stmt, "/seed.sql");
            System.out.println("Seed script executed.");

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Failed to initialize database: " + e.getMessage());
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
        System.out.println("FitPulse Application Shutting Down.");
    }
}
