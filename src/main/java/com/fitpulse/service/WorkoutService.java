package com.fitpulse.service;

import com.fitpulse.dao.WorkoutDao;
import com.fitpulse.dao.impl.WorkoutDaoImpl;
import com.fitpulse.model.Workout;

import java.util.List;

public class WorkoutService {

    private final WorkoutDao workoutDao;

    public WorkoutService() {
        this.workoutDao = new WorkoutDaoImpl();
    }

    public WorkoutService(WorkoutDao workoutDao) {
        this.workoutDao = workoutDao;
    }

    public void logWorkout(Workout workout) {
        workoutDao.create(workout);
    }

    public List<Workout> getWorkoutsForUser(int userId) {
        return workoutDao.findByUserId(userId);
    }

    public List<Workout> getAllWorkouts() {
        return workoutDao.findAll();
    }

    public Workout getWorkoutById(int id) {
        return workoutDao.findById(id);
    }

    public void updateWorkout(Workout workout) {
        workoutDao.update(workout);
    }

    public void deleteWorkout(int id) {
        workoutDao.delete(id);
    }
}
