package com.fitpulse.util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.net.URI;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * Provides database connections using HikariCP and environment variables.
 * Never hardcode credentials here.
 */
public class DBUtil {

    private static HikariDataSource dataSource;

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError("PostgreSQL JDBC driver not found: " + e.getMessage());
        }

        initDataSource();
    }

    private static void initDataSource() {
        String dbUrlEnv = System.getenv("DATABASE_URL");
        if (dbUrlEnv == null || dbUrlEnv.isBlank()) {
            dbUrlEnv = System.getenv("DB_URL");
        }

        String url = null;
        String user = System.getenv("DB_USER");
        String password = System.getenv("DB_PASSWORD");

        if (dbUrlEnv != null && !dbUrlEnv.isBlank()) {
            if (dbUrlEnv.startsWith("postgres://") || dbUrlEnv.startsWith("postgresql://")) {
                try {
                    URI dbUri = new URI(dbUrlEnv);
                    if (dbUri.getUserInfo() != null) {
                        String[] userInfo = dbUri.getUserInfo().split(":", 2);
                        user = userInfo[0];
                        if (userInfo.length > 1) {
                            password = userInfo[1];
                        }
                    }
                    String portPart = dbUri.getPort() != -1 ? ":" + dbUri.getPort() : "";
                    String queryPart = dbUri.getQuery() != null ? "?" + dbUri.getQuery() : "";
                    url = "jdbc:postgresql://" + dbUri.getHost() + portPart + dbUri.getPath() + queryPart;
                } catch (URISyntaxException e) {
                    throw new RuntimeException("Invalid database URI syntax: " + e.getMessage());
                }
            } else {
                url = dbUrlEnv;
            }
        }

        if (url == null || url.isBlank()) {
            url = "jdbc:postgresql://localhost:5432/fitpulsedb";
        }
        if (user == null || user.isBlank()) {
            user = "postgres";
        }
        if (password == null) {
            password = "";
        }

        HikariConfig config = new HikariConfig();
        config.setJdbcUrl(url);
        config.setUsername(user);
        config.setPassword(password);
        config.setMaximumPoolSize(10);
        config.setMinimumIdle(2);
        config.setIdleTimeout(30000);
        config.setConnectionTimeout(20000);

        dataSource = new HikariDataSource(config);
    }

    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    public static void closeDataSource() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
        }
    }
}
