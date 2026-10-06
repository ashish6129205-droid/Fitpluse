package com.fitpulse.service;

import com.fitpulse.dao.GoalDao;
import com.fitpulse.dao.impl.GoalDaoImpl;
import com.fitpulse.model.Goal;

import java.util.List;

public class GoalService {

    private final GoalDao goalDao;

    public GoalService() {
        this.goalDao = new GoalDaoImpl();
    }

    public void addGoal(Goal goal) {
        goalDao.create(goal);
    }

    public List<Goal> getGoalsForUser(int userId) {
        return goalDao.findByUserId(userId);
    }

    public Goal getGoalById(int id) {
        return goalDao.findById(id);
    }

    public void updateGoal(Goal goal) {
        goalDao.update(goal);
    }

    public void deleteGoal(int id) {
        goalDao.delete(id);
    }
}
