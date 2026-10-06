package com.fitpulse.dao.impl;

import com.fitpulse.dao.GoalDao;
import com.fitpulse.model.Goal;
import com.fitpulse.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GoalDaoImpl implements GoalDao {

    @Override
    public Goal findById(int id) {
        String sql = "SELECT * FROM goals WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToGoal(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Goal> findByUserId(int userId) {
        List<Goal> goals = new ArrayList<>();
        String sql = "SELECT * FROM goals WHERE user_id = ? ORDER BY deadline ASC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    goals.add(mapRowToGoal(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return goals;
    }

    @Override
    public void create(Goal goal) {
        String sql = "INSERT INTO goals (user_id, goal_type, target_value, current_value, unit, deadline, completed) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, goal.getUserId());
            ps.setString(2, goal.getGoalType());
            ps.setDouble(3, goal.getTargetValue());
            ps.setDouble(4, goal.getCurrentValue());
            ps.setString(5, goal.getUnit());
            ps.setDate(6, goal.getDeadline());
            ps.setBoolean(7, goal.isCompleted());

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    goal.setId(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Goal goal) {
        String sql = "UPDATE goals SET goal_type = ?, target_value = ?, current_value = ?, unit = ?, deadline = ?, completed = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, goal.getGoalType());
            ps.setDouble(2, goal.getTargetValue());
            ps.setDouble(3, goal.getCurrentValue());
            ps.setString(4, goal.getUnit());
            ps.setDate(5, goal.getDeadline());
            ps.setBoolean(6, goal.isCompleted());
            ps.setInt(7, goal.getId());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM goals WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Goal mapRowToGoal(ResultSet rs) throws SQLException {
        Goal goal = new Goal();
        goal.setId(rs.getInt("id"));
        goal.setUserId(rs.getInt("user_id"));
        goal.setGoalType(rs.getString("goal_type"));
        goal.setTargetValue(rs.getDouble("target_value"));
        goal.setCurrentValue(rs.getDouble("current_value"));
        goal.setUnit(rs.getString("unit"));
        goal.setDeadline(rs.getDate("deadline"));
        goal.setCompleted(rs.getBoolean("completed"));
        goal.setCreatedAt(rs.getTimestamp("created_at"));
        return goal;
    }
}
