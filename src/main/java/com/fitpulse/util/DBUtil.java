package com.fitpulse.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Provides database connections using environment variables.
 * Never hardcode credentials here.
 */
public class DBUtil {

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError("PostgreSQL JDBC driver not found: " + e.getMessage());
        }
    }

    public static Connection getConnection() throws SQLException {
        String url = System.getenv("DB_URL");
        String user = System.getenv("DB_USER");
        String password = System.getenv("DB_PASSWORD");

        if (url == null || url.isBlank()) {
            url = "jdbc:postgresql://localhost:5432/fitpulsedb";
        }
        if (user == null || user.isBlank()) {
            user = "postgres";
        }
        if (password == null) {
            password = "";
        }
        return DriverManager.getConnection(url, user, password);
    }
}
