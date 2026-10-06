package com.fitpulse.dao;

import com.fitpulse.model.Workout;
import java.util.List;

public interface WorkoutDao {
    Workout findById(int id);
    List<Workout> findByUserId(int userId);
    List<Workout> findAll();
    void create(Workout workout);
    void update(Workout workout);
    void delete(int id);
}
