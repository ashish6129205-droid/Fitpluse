package com.fitpulse.service;

import com.fitpulse.model.User;
import com.fitpulse.model.UserRank;
import com.fitpulse.model.Workout;
import com.fitpulse.model.ChallengeParticipant;

import java.time.LocalDate;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class AnalyticsService {

    private final UserService userService;
    private final WorkoutService workoutService;
    private final ChallengeService challengeService;

    public AnalyticsService() {
        this.userService = new UserService();
        this.workoutService = new WorkoutService();
        this.challengeService = new ChallengeService();
    }

    public List<UserRank> getGlobalLeaderboard() {
        List<User> allUsers = userService.getAllUsers();
        List<Workout> allWorkouts = workoutService.getAllWorkouts();
        List<ChallengeParticipant> allParticipants = challengeService.getAllParticipants();

        // Initialize UserRanks
        Map<Integer, UserRank> userRanksMap = allUsers.stream()
                .collect(Collectors.toMap(User::getId, u -> new UserRank(u.getId(), u.getName())));

        // Aggregate calories
        allWorkouts.forEach(w -> {
            UserRank rank = userRanksMap.get(w.getUserId());
            if (rank != null) {
                rank.addCalories(w.getCalories());
            }
        });

        // Aggregate completed challenges
        allParticipants.stream()
                .filter(ChallengeParticipant::isCompleted)
                .forEach(cp -> {
                    UserRank rank = userRanksMap.get(cp.getUserId());
                    if (rank != null) {
                        rank.incrementCompletedChallenges();
                    }
                });

        // Sort by Total Calories (desc), then Completed Challenges (desc)
        return userRanksMap.values().stream()
                .sorted(Comparator.comparingInt(UserRank::getTotalCalories).reversed()
                        .thenComparingInt(UserRank::getCompletedChallenges).reversed())
                .collect(Collectors.toList());
    }

    public int calculateUserStreak(int userId) {
        List<Workout> userWorkouts = workoutService.getWorkoutsForUser(userId);
        if (userWorkouts == null || userWorkouts.isEmpty()) {
            return 0;
        }

        // Get unique workout dates sorted descending
        List<LocalDate> sortedDates = userWorkouts.stream()
                .map(w -> w.getWorkoutDate().toLocalDate())
                .distinct()
                .sorted(Comparator.reverseOrder())
                .collect(Collectors.toList());

        LocalDate today = LocalDate.now();
        LocalDate yesterday = today.minusDays(1);

        if (sortedDates.isEmpty()) return 0;

        LocalDate firstDate = sortedDates.get(0);
        if (!firstDate.equals(today) && !firstDate.equals(yesterday)) {
            return 0; // Streak broken
        }

        int streak = 1;
        for (int i = 1; i < sortedDates.size(); i++) {
            if (sortedDates.get(i).equals(sortedDates.get(i - 1).minusDays(1))) {
                streak++;
            } else {
                break;
            }
        }
        return streak;
    }

    public Map<String, Integer> calculateWeeklyVolume(int userId) {
        LocalDate oneWeekAgo = LocalDate.now().minusDays(7);
        List<Workout> userWorkouts = workoutService.getWorkoutsForUser(userId);

        return userWorkouts.stream()
                .filter(w -> !w.getWorkoutDate().toLocalDate().isBefore(oneWeekAgo))
                .collect(Collectors.groupingBy(
                        Workout::getWorkoutType,
                        Collectors.summingInt(Workout::getDurationMin)
                ));
    }
}
