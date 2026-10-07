package com.fitpulse.dao.impl;

import com.fitpulse.dao.ContentDao;
import com.fitpulse.model.FitnessContent;
import com.fitpulse.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContentDaoImpl implements ContentDao {

    @Override
    public void createContent(FitnessContent content) {
        String sql = "INSERT INTO fitness_content (user_id, title, content, status) VALUES (?, ?, ?, 'PENDING')";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, content.getUserId());
            ps.setString(2, content.getTitle());
            ps.setString(3, content.getContent());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<FitnessContent> getApprovedContent() {
        return fetchContentByStatus("APPROVED");
    }

    @Override
    public List<FitnessContent> getPendingContent() {
        return fetchContentByStatus("PENDING");
    }

    private List<FitnessContent> fetchContentByStatus(String status) {
        List<FitnessContent> list = new ArrayList<>();
        String sql = "SELECT f.*, u.name as author_name FROM fitness_content f JOIN users u ON f.user_id = u.id WHERE f.status = ? ORDER BY f.created_at DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    FitnessContent c = new FitnessContent();
                    c.setId(rs.getInt("id"));
                    c.setUserId(rs.getInt("user_id"));
                    c.setAuthorName(rs.getString("author_name"));
                    c.setTitle(rs.getString("title"));
                    c.setContent(rs.getString("content"));
                    c.setStatus(rs.getString("status"));
                    c.setCreatedAt(rs.getTimestamp("created_at"));
                    list.add(c);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public void updateContentStatus(int contentId, String status) {
        String sql = "UPDATE fitness_content SET status = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, contentId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
