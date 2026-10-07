package com.fitpulse.model;

import java.sql.Timestamp;

public class ChallengeParticipant {
    private int id;
    private int challengeId;
    private int userId;
    private double progressValue;
    private boolean completed;
    private String status;
    private Timestamp joinedAt;

    // For joining with Challenge
    private String challengeTitle;

    public ChallengeParticipant() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getChallengeId() { return challengeId; }
    public void setChallengeId(int challengeId) { this.challengeId = challengeId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public double getProgressValue() { return progressValue; }
    public void setProgressValue(double progressValue) { this.progressValue = progressValue; }

    public boolean isCompleted() { return completed; }
    public void setCompleted(boolean completed) { this.completed = completed; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getJoinedAt() { return joinedAt; }
    public void setJoinedAt(Timestamp joinedAt) { this.joinedAt = joinedAt; }

    public String getChallengeTitle() { return challengeTitle; }
    public void setChallengeTitle(String challengeTitle) { this.challengeTitle = challengeTitle; }
}
