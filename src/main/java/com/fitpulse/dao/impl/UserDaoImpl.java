package com.fitpulse.dao.impl;

import com.fitpulse.dao.UserDao;
import com.fitpulse.model.User;
import com.fitpulse.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDaoImpl implements UserDao {

    @Override
    public User findById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public User findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<User> findAll() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY created_at DESC";
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                users.add(mapRowToUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    @Override
    public void create(User user) {
        String sql = "INSERT INTO users (name, email, password_hash, role, age, height_cm, weight_kg, fitness_goal, active) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPasswordHash());
            ps.setString(4, user.getRole() != null ? user.getRole() : "USER");
            if (user.getAge() != null) ps.setInt(5, user.getAge()); else ps.setNull(5, Types.INTEGER);
            if (user.getHeightCm() != null) ps.setDouble(6, user.getHeightCm()); else ps.setNull(6, Types.DOUBLE);
            if (user.getWeightKg() != null) ps.setDouble(7, user.getWeightKg()); else ps.setNull(7, Types.DOUBLE);
            ps.setString(8, user.getFitnessGoal());
            ps.setBoolean(9, user.isActive());

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    user.setId(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(User user) {
        String sql = "UPDATE users SET name = ?, age = ?, height_cm = ?, weight_kg = ?, fitness_goal = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getName());
            if (user.getAge() != null) ps.setInt(2, user.getAge()); else ps.setNull(2, Types.INTEGER);
            if (user.getHeightCm() != null) ps.setDouble(3, user.getHeightCm()); else ps.setNull(3, Types.DOUBLE);
            if (user.getWeightKg() != null) ps.setDouble(4, user.getWeightKg()); else ps.setNull(4, Types.DOUBLE);
            ps.setString(5, user.getFitnessGoal());
            ps.setInt(6, user.getId());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateSystemFields(User user) {
        String sql = "UPDATE users SET password_hash = ?, role = ?, active = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getPasswordHash());
            ps.setString(2, user.getRole());
            ps.setBoolean(3, user.isActive());
            ps.setInt(4, user.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateStatus(int userId, boolean active) {
        String sql = "UPDATE users SET active = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBoolean(1, active);
            ps.setInt(2, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private User mapRowToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setName(rs.getString("name"));
        user.setEmail(rs.getString("email"));
        user.setPasswordHash(rs.getString("password_hash"));
        user.setRole(rs.getString("role"));
        user.setAge(rs.getObject("age") != null ? rs.getInt("age") : null);
        user.setHeightCm(rs.getObject("height_cm") != null ? rs.getDouble("height_cm") : null);
        user.setWeightKg(rs.getObject("weight_kg") != null ? rs.getDouble("weight_kg") : null);
        user.setFitnessGoal(rs.getString("fitness_goal"));
        user.setActive(rs.getBoolean("active"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        return user;
    }
}
