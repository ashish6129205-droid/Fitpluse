package com.fitpulse.model;

import java.sql.Date;
import java.sql.Timestamp;

public class ProgressEntry {

    private int id;
    private int userId;
    private Double weightKg;
    private Double waistCm;
    private Double chestCm;
    private Double armsCm;
    private Date entryDate;
    private Timestamp createdAt;

    public ProgressEntry() {
    }

    public ProgressEntry(int id, int userId, Double weightKg, Double waistCm, Double chestCm,
                         Double armsCm, Date entryDate, Timestamp createdAt) {
        this.id = id;
        this.userId = userId;
        this.weightKg = weightKg;
        this.waistCm = waistCm;
        this.chestCm = chestCm;
        this.armsCm = armsCm;
        this.entryDate = entryDate;
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

    public Double getWeightKg() {
        return weightKg;
    }

    public void setWeightKg(Double weightKg) {
        this.weightKg = weightKg;
    }

    public Double getWaistCm() {
        return waistCm;
    }

    public void setWaistCm(Double waistCm) {
        this.waistCm = waistCm;
    }

    public Double getChestCm() {
        return chestCm;
    }

    public void setChestCm(Double chestCm) {
        this.chestCm = chestCm;
    }

    public Double getArmsCm() {
        return armsCm;
    }

    public void setArmsCm(Double armsCm) {
        this.armsCm = armsCm;
    }

    public Date getEntryDate() {
        return entryDate;
    }

    public void setEntryDate(Date entryDate) {
        this.entryDate = entryDate;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
