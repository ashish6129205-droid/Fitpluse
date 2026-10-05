package com.fitpulse.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Goal {

    private int id;
    private int userId;
    private String goalType;
    private double targetValue;
    private double currentValue;
    private String unit;
    private Date deadline;
    private boolean completed;
    private Timestamp createdAt;

    public Goal() {
    }

    public Goal(int id, int userId, String goalType, double targetValue, double currentValue,
                String unit, Date deadline, boolean completed, Timestamp createdAt) {
        this.id = id;
        this.userId = userId;
        this.goalType = goalType;
        this.targetValue = targetValue;
        this.currentValue = currentValue;
        this.unit = unit;
        this.deadline = deadline;
        this.completed = completed;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getGoalType() {
        return goalType;
    }

    public void setGoalType(String goalType) {
        this.goalType = goalType;
    }

    public double getTargetValue() {
        return targetValue;
    }

    public void setTargetValue(double targetValue) {
        this.targetValue = targetValue;
    }

    public double getCurrentValue() {
        return currentValue;
    }

    public void setCurrentValue(double currentValue) {
        this.currentValue = currentValue;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Date getDeadline() {
        return deadline;
    }

    public void setDeadline(Date deadline) {
        this.deadline = deadline;
    }

    public boolean isCompleted() {
        return completed;
    }

    public void setCompleted(boolean completed) {
        this.completed = completed;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public int getProgressPercent() {
        if (targetValue <= 0) {
            return 0;
        }
        int percent = (int) Math.round((currentValue / targetValue) * 100.0);
        return Math.min(percent, 100);
    }
}
