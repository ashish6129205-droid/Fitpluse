package com.fitpulse.dao.impl;

import com.fitpulse.dao.ProgressEntryDao;
import com.fitpulse.model.ProgressEntry;
import com.fitpulse.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProgressEntryDaoImpl implements ProgressEntryDao {

    @Override
    public ProgressEntry findById(int id) {
        String sql = "SELECT * FROM progress_entries WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToEntry(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<ProgressEntry> findByUserId(int userId) {
        List<ProgressEntry> entries = new ArrayList<>();
        String sql = "SELECT * FROM progress_entries WHERE user_id = ? ORDER BY entry_date ASC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    entries.add(mapRowToEntry(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return entries;
    }

    @Override
    public void create(ProgressEntry entry) {
        String sql = "INSERT INTO progress_entries (user_id, weight_kg, waist_cm, chest_cm, arms_cm, entry_date) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, entry.getUserId());
            if (entry.getWeightKg() != null) ps.setDouble(2, entry.getWeightKg()); else ps.setNull(2, Types.DOUBLE);
            if (entry.getWaistCm() != null) ps.setDouble(3, entry.getWaistCm()); else ps.setNull(3, Types.DOUBLE);
            if (entry.getChestCm() != null) ps.setDouble(4, entry.getChestCm()); else ps.setNull(4, Types.DOUBLE);
            if (entry.getArmsCm() != null) ps.setDouble(5, entry.getArmsCm()); else ps.setNull(5, Types.DOUBLE);
            ps.setDate(6, entry.getEntryDate());

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    entry.setId(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(ProgressEntry entry) {
        String sql = "UPDATE progress_entries SET weight_kg = ?, waist_cm = ?, chest_cm = ?, arms_cm = ?, entry_date = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (entry.getWeightKg() != null) ps.setDouble(1, entry.getWeightKg()); else ps.setNull(1, Types.DOUBLE);
            if (entry.getWaistCm() != null) ps.setDouble(2, entry.getWaistCm()); else ps.setNull(2, Types.DOUBLE);
            if (entry.getChestCm() != null) ps.setDouble(3, entry.getChestCm()); else ps.setNull(3, Types.DOUBLE);
            if (entry.getArmsCm() != null) ps.setDouble(4, entry.getArmsCm()); else ps.setNull(4, Types.DOUBLE);
            ps.setDate(5, entry.getEntryDate());
            ps.setInt(6, entry.getId());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM progress_entries WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private ProgressEntry mapRowToEntry(ResultSet rs) throws SQLException {
        ProgressEntry entry = new ProgressEntry();
        entry.setId(rs.getInt("id"));
        entry.setUserId(rs.getInt("user_id"));
        entry.setWeightKg(rs.getObject("weight_kg") != null ? rs.getDouble("weight_kg") : null);
        entry.setWaistCm(rs.getObject("waist_cm") != null ? rs.getDouble("waist_cm") : null);
        entry.setChestCm(rs.getObject("chest_cm") != null ? rs.getDouble("chest_cm") : null);
        entry.setArmsCm(rs.getObject("arms_cm") != null ? rs.getDouble("arms_cm") : null);
        entry.setEntryDate(rs.getDate("entry_date"));
        entry.setCreatedAt(rs.getTimestamp("created_at"));
        return entry;
    }
}
