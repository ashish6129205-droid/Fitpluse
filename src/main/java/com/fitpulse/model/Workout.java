package com.fitpulse.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Workout {

    private int id;
    private int userId;
    private String workoutType;
    private int durationMin;
    private int calories;
    private int steps;
    private Date workoutDate;
    private String notes;
    private String status;        // "PENDING", "APPROVED", "REJECTED"
    private Timestamp createdAt;
    private String userName;      // filled when joining with users table (admin views)
    private String intensity;     // New field added

    public Workout() {
    }

    public Workout(int id, int userId, String workoutType, int durationMin, int calories,
                   int steps, Date workoutDate, String notes, String status, Timestamp createdAt, String intensity) {
        this.id = id;
        this.userId = userId;
        this.workoutType = workoutType;
        this.durationMin = durationMin;
        this.calories = calories;
        this.steps = steps;
        this.workoutDate = workoutDate;
        this.notes = notes;
        this.status = status;
        this.createdAt = createdAt;
        this.intensity = intensity;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getWorkoutType() { return workoutType; }
    public void setWorkoutType(String workoutType) { this.workoutType = workoutType; }

    public int getDurationMin() { return durationMin; }
    public void setDurationMin(int durationMin) { this.durationMin = durationMin; }

    public int getCalories() { return calories; }
    public void setCalories(int calories) { this.calories = calories; }

    public int getSteps() { return steps; }
    public void setSteps(int steps) { this.steps = steps; }

    public Date getWorkoutDate() { return workoutDate; }
    public void setWorkoutDate(Date workoutDate) { this.workoutDate = workoutDate; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getIntensity() { return intensity; }
    public void setIntensity(String intensity) { this.intensity = intensity; }
}
