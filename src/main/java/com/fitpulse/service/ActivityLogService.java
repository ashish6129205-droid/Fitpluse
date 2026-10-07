package com.fitpulse.service;

import com.fitpulse.dao.ActivityLogDao;
import com.fitpulse.dao.impl.ActivityLogDaoImpl;
import com.fitpulse.model.ActivityLog;

import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.logging.Logger;

public class ActivityLogService {

    private static final Logger LOGGER = Logger.getLogger(ActivityLogService.class.getName());

    // Singleton pattern for the executor service to live across the app lifecycle
    private static ActivityLogService instance;
    private final ExecutorService executorService;
    private final ActivityLogDao logDao;

    private ActivityLogService() {
        this.executorService = Executors.newFixedThreadPool(3); // Small pool for Render free tier
        this.logDao = new ActivityLogDaoImpl();
    }

    public static synchronized ActivityLogService getInstance() {
        if (instance == null) {
            instance = new ActivityLogService();
        }
        return instance;
    }

    public void logActivityAsync(int userId, String action, String details) {
        // Submit the task to the background thread pool
        executorService.submit(() -> {
            try {
                String threadName = Thread.currentThread().getName();
                ActivityLog log = new ActivityLog();
                log.setUserId(userId);
                log.setAction(action);
                log.setDetails(details);
                log.setThreadName(threadName);

                logDao.create(log);
                LOGGER.info("Logged activity asynchronously: [" + action + "] on thread: " + threadName);
            } catch (Exception e) {
                LOGGER.severe("Failed to log activity asynchronously: " + e.getMessage());
            }
        });
    }

    public List<ActivityLog> getLatestLogs(int limit) {
        return logDao.getLatestLogs(limit);
    }

    public void shutdown() {
        LOGGER.info("Shutting down ActivityLogService ExecutorService...");
        executorService.shutdown();
        try {
            if (!executorService.awaitTermination(5, TimeUnit.SECONDS)) {
                executorService.shutdownNow();
            }
        } catch (InterruptedException e) {
            executorService.shutdownNow();
            Thread.currentThread().interrupt();
        }
    }
}
