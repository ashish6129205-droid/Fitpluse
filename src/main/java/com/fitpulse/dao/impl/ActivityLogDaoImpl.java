package com.fitpulse.dao.impl;

import com.fitpulse.dao.ActivityLogDao;
import com.fitpulse.model.ActivityLog;
import com.fitpulse.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ActivityLogDaoImpl implements ActivityLogDao {

    @Override
    public void create(ActivityLog log) {
        String sql = "INSERT INTO activity_log (user_id, action, details, thread_name) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, log.getUserId());
            ps.setString(2, log.getAction());
            ps.setString(3, log.getDetails());
            ps.setString(4, log.getThreadName());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<ActivityLog> getLatestLogs(int limit) {
        List<ActivityLog> logs = new ArrayList<>();
        String sql = "SELECT a.*, u.email as user_email FROM activity_log a " +
                     "JOIN users u ON a.user_id = u.id ORDER BY a.created_at DESC LIMIT ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ActivityLog log = new ActivityLog();
                    log.setId(rs.getInt("id"));
                    log.setUserId(rs.getInt("user_id"));
                    log.setAction(rs.getString("action"));
                    log.setDetails(rs.getString("details"));
                    log.setCreatedAt(rs.getTimestamp("created_at"));

                    try {
                        log.setThreadName(rs.getString("thread_name"));
                    } catch (SQLException ignore) {}

                    log.setUserEmail(rs.getString("user_email"));
                    logs.add(log);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return logs;
    }
}
