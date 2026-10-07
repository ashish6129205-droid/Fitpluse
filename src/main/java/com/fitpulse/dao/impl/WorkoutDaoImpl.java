package com.fitpulse.dao.impl;

import com.fitpulse.dao.WorkoutDao;
import com.fitpulse.model.Workout;
import com.fitpulse.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WorkoutDaoImpl implements WorkoutDao {

    @Override
    public Workout findById(int id) {
        String sql = "SELECT * FROM workouts WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToWorkout(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Workout> findByUserId(int userId) {
        List<Workout> workouts = new ArrayList<>();
        String sql = "SELECT * FROM workouts WHERE user_id = ? ORDER BY workout_date DESC, created_at DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    workouts.add(mapRowToWorkout(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return workouts;
    }

    @Override
    public List<Workout> findAll() {
        List<Workout> workouts = new ArrayList<>();
        String sql = "SELECT w.*, u.name as user_name FROM workouts w JOIN users u ON w.user_id = u.id ORDER BY w.workout_date DESC";
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Workout w = mapRowToWorkout(rs);
                w.setUserName(rs.getString("user_name"));
                workouts.add(w);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return workouts;
    }

    @Override
    public void create(Workout workout) {
        String sql = "INSERT INTO workouts (user_id, workout_type, duration_min, calories, steps, workout_date, notes, status, intensity) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, workout.getUserId());
            ps.setString(2, workout.getWorkoutType());
            ps.setInt(3, workout.getDurationMin());
            ps.setInt(4, workout.getCalories());
            ps.setInt(5, workout.getSteps());
            ps.setDate(6, workout.getWorkoutDate());
            ps.setString(7, workout.getNotes());
            ps.setString(8, workout.getStatus() != null ? workout.getStatus() : "APPROVED");
            ps.setString(9, workout.getIntensity());

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    workout.setId(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Workout workout) {
        String sql = "UPDATE workouts SET workout_type = ?, duration_min = ?, calories = ?, steps = ?, workout_date = ?, notes = ?, status = ?, intensity = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, workout.getWorkoutType());
            ps.setInt(2, workout.getDurationMin());
            ps.setInt(3, workout.getCalories());
            ps.setInt(4, workout.getSteps());
            ps.setDate(5, workout.getWorkoutDate());
            ps.setString(6, workout.getNotes());
            ps.setString(7, workout.getStatus());
            ps.setString(8, workout.getIntensity());
            ps.setInt(9, workout.getId());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM workouts WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Workout mapRowToWorkout(ResultSet rs) throws SQLException {
        Workout workout = new Workout();
        workout.setId(rs.getInt("id"));
        workout.setUserId(rs.getInt("user_id"));
        workout.setWorkoutType(rs.getString("workout_type"));
        workout.setDurationMin(rs.getInt("duration_min"));
        workout.setCalories(rs.getInt("calories"));
        workout.setSteps(rs.getInt("steps"));
        workout.setWorkoutDate(rs.getDate("workout_date"));
        workout.setNotes(rs.getString("notes"));
        workout.setStatus(rs.getString("status"));
        workout.setCreatedAt(rs.getTimestamp("created_at"));

        // Intensity might not exist if column wasn't created yet during tests or old runs, safe check
        try {
            workout.setIntensity(rs.getString("intensity"));
        } catch (SQLException ignore) {
            // Field might not be in result set if DB is out of sync, though AppStartupListener handles it.
        }
        return workout;
    }
}
