package com.fitpulse.dao.impl;

import com.fitpulse.dao.ChallengeDao;
import com.fitpulse.exception.DaoException;
import com.fitpulse.model.Challenge;
import com.fitpulse.model.ChallengeParticipant;
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

    @Override
    public void joinChallenge(int userId, int challengeId) {
        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        PreparedStatement ps3 = null;

        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);

            // Query 1: Insert participant
            String sql1 = "INSERT INTO challenge_participants (challenge_id, user_id, status) VALUES (?, ?, 'ACTIVE')";
            ps1 = conn.prepareStatement(sql1);
            ps1.setInt(1, challengeId);
            ps1.setInt(2, userId);
            ps1.executeUpdate();

            // Query 2: Update participant count
            String sql2 = "UPDATE challenges SET participant_count = participant_count + 1 WHERE id = ?";
            ps2 = conn.prepareStatement(sql2);
            ps2.setInt(1, challengeId);
            ps2.executeUpdate();

            // Query 3: Activity Log
            String sql3 = "INSERT INTO activity_log (user_id, action, details) VALUES (?, 'JOIN_CHALLENGE', 'Joined challenge ID ' || ?)";
            ps3 = conn.prepareStatement(sql3);
            ps3.setInt(1, userId);
            ps3.setInt(2, challengeId);
            ps3.executeUpdate();

            conn.commit();

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    throw new DaoException("Error rolling back transaction: " + ex.getMessage(), ex);
                }
            }
            throw new DaoException("Failed to join challenge: " + e.getMessage(), e);
        } finally {
            if (ps3 != null) try { ps3.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (ps2 != null) try { ps2.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (ps1 != null) try { ps1.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @Override
    public List<Integer> getJoinedChallengeIds(int userId) {
        List<Integer> ids = new ArrayList<>();
        String sql = "SELECT challenge_id FROM challenge_participants WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ids.add(rs.getInt("challenge_id"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ids;
    }

    @Override
    public List<ChallengeParticipant> getJoinedChallenges(int userId) {
        List<ChallengeParticipant> history = new ArrayList<>();
        String sql = "SELECT cp.*, c.title as challenge_title FROM challenge_participants cp " +
                     "JOIN challenges c ON cp.challenge_id = c.id WHERE cp.user_id = ? ORDER BY cp.joined_at DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ChallengeParticipant cp = new ChallengeParticipant();
                    cp.setId(rs.getInt("id"));
                    cp.setChallengeId(rs.getInt("challenge_id"));
                    cp.setUserId(rs.getInt("user_id"));
                    cp.setProgressValue(rs.getDouble("progress_value"));
                    cp.setCompleted(rs.getBoolean("completed"));
                    cp.setJoinedAt(rs.getTimestamp("joined_at"));

                    try {
                        cp.setStatus(rs.getString("status"));
                    } catch (SQLException ignore) {}

                    cp.setChallengeTitle(rs.getString("challenge_title"));
                    history.add(cp);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return history;
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

        try {
            challenge.setParticipantCount(rs.getInt("participant_count"));
        } catch (SQLException ignore) {}

        return challenge;
    }
}
