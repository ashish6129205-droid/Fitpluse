package com.fitpulse.model;

public class UserRank {
    private int userId;
    private String userName;
    private int totalCalories;
    private int completedChallenges;

    public UserRank(int userId, String userName) {
        this.userId = userId;
        this.userName = userName;
        this.totalCalories = 0;
        this.completedChallenges = 0;
    }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public int getTotalCalories() { return totalCalories; }
    public void setTotalCalories(int totalCalories) { this.totalCalories = totalCalories; }
    public void addCalories(int calories) { this.totalCalories += calories; }

    public int getCompletedChallenges() { return completedChallenges; }
    public void setCompletedChallenges(int completedChallenges) { this.completedChallenges = completedChallenges; }
    public void incrementCompletedChallenges() { this.completedChallenges++; }
}
