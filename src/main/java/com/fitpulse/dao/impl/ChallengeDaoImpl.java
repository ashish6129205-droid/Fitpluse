package com.fitpulse.dao.impl;

import com.fitpulse.dao.ChallengeDao;
import com.fitpulse.model.Challenge;
import com.fitpulse.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ChallengeDaoImpl implements ChallengeDao {

    @Override
    public Challenge findById(int id) {
        String sql = "SELECT * FROM challenges WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToChallenge(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Challenge> findAll() {
        List<Challenge> challenges = new ArrayList<>();
        String sql = "SELECT * FROM challenges ORDER BY created_at DESC";
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                challenges.add(mapRowToChallenge(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return challenges;
    }

    @Override
    public List<Challenge> findActiveChallenges() {
        List<Challenge> challenges = new ArrayList<>();
        String sql = "SELECT * FROM challenges WHERE active = true ORDER BY end_date ASC";
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                challenges.add(mapRowToChallenge(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return challenges;
    }

    @Override
    public void create(Challenge challenge) {
        String sql = "INSERT INTO challenges (title, description, metric, target_value, unit, start_date, end_date, active, created_by) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, challenge.getTitle());
            ps.setString(2, challenge.getDescription());
            ps.setString(3, challenge.getMetric());
            ps.setDouble(4, challenge.getTargetValue());
            ps.setString(5, challenge.getUnit());
            ps.setDate(6, challenge.getStartDate());
            ps.setDate(7, challenge.getEndDate());
            ps.setBoolean(8, challenge.isActive());
            if (challenge.getCreatedBy() != null) ps.setInt(9, challenge.getCreatedBy()); else ps.setNull(9, Types.INTEGER);

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    challenge.setId(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Challenge challenge) {
        String sql = "UPDATE challenges SET title = ?, description = ?, metric = ?, target_value = ?, unit = ?, start_date = ?, end_date = ?, active = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, challenge.getTitle());
            ps.setString(2, challenge.getDescription());
            ps.setString(3, challenge.getMetric());
            ps.setDouble(4, challenge.getTargetValue());
            ps.setString(5, challenge.getUnit());
            ps.setDate(6, challenge.getStartDate());
            ps.setDate(7, challenge.getEndDate());
            ps.setBoolean(8, challenge.isActive());
            ps.setInt(9, challenge.getId());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM challenges WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Challenge mapRowToChallenge(ResultSet rs) throws SQLException {
        Challenge challenge = new Challenge();
        challenge.setId(rs.getInt("id"));
        challenge.setTitle(rs.getString("title"));
        challenge.setDescription(rs.getString("description"));
        challenge.setMetric(rs.getString("metric"));
        challenge.setTargetValue(rs.getDouble("target_value"));
        challenge.setUnit(rs.getString("unit"));
        challenge.setStartDate(rs.getDate("start_date"));
        challenge.setEndDate(rs.getDate("end_date"));
        challenge.setActive(rs.getBoolean("active"));
        challenge.setCreatedBy(rs.getObject("created_by") != null ? rs.getInt("created_by") : null);
        challenge.setCreatedAt(rs.getTimestamp("created_at"));
        return challenge;
    }
}
