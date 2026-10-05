package com.fitpulse.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Challenge {

    private int id;
    private String title;
    private String description;
    private String metric;         // e.g. "calories", "steps", "workouts", "minutes"
    private double targetValue;
    private String unit;
    private Date startDate;
    private Date endDate;
    private boolean active;
    private Integer createdBy;
    private Timestamp createdAt;

    public Challenge() {
    }

    public Challenge(int id, String title, String description, String metric, double targetValue,
                     String unit, Date startDate, Date endDate, boolean active,
                     Integer createdBy, Timestamp createdAt) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.metric = metric;
        this.targetValue = targetValue;
        this.unit = unit;
        this.startDate = startDate;
        this.endDate = endDate;
        this.active = active;
        this.createdBy = createdBy;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getMetric() {
        return metric;
    }

    public void setMetric(String metric) {
        this.metric = metric;
    }

    public double getTargetValue() {
        return targetValue;
    }

    public void setTargetValue(double targetValue) {
        this.targetValue = targetValue;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public Integer getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(Integer createdBy) {
        this.createdBy = createdBy;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
