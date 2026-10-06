package com.fitpulse.dao;

import com.fitpulse.model.Goal;
import java.util.List;

public interface GoalDao {
    Goal findById(int id);
    List<Goal> findByUserId(int userId);
    void create(Goal goal);
    void update(Goal goal);
    void delete(int id);
}
