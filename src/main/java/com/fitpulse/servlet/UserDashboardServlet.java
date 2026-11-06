package com.fitpulse.servlet;

import com.fitpulse.model.User;
import com.fitpulse.model.Workout;
import com.fitpulse.model.Goal;
import com.fitpulse.model.Challenge;
import com.fitpulse.service.WorkoutService;
import com.fitpulse.service.GoalService;
import com.fitpulse.service.ChallengeService;
import com.fitpulse.service.AnalyticsService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/dashboard")
public class UserDashboardServlet extends HttpServlet {
    private WorkoutService workoutService;
    private GoalService goalService;
    private ChallengeService challengeService;
    private AnalyticsService analyticsService;

    @Override
    public void init() throws ServletException {
        this.workoutService = new WorkoutService();
        this.goalService = new GoalService();
        this.challengeService = new ChallengeService();
        this.analyticsService = new AnalyticsService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("loggedUser");

        List<Workout> workouts = workoutService.getWorkoutsForUser(user.getId());
        List<Goal> goals = goalService.getGoalsForUser(user.getId());

        // Calculate totals
        int totalWorkouts = workouts.size();
        int totalCalories = 0;
        for (Workout w : workouts) {
            totalCalories += w.getCalories();
        }

        int activeGoals = 0;
        for (Goal g : goals) {
            if (!g.isCompleted()) {
                activeGoals++;
            }
        }

        // For challenges joined, we don't have user-challenge mapping yet in MVP,
        // so we'll just show active challenges available
        int challengesJoined = challengeService.getActiveChallenges().size();

        req.setAttribute("recentWorkouts", workouts.size() > 5 ? workouts.subList(0, 5) : workouts);
        req.setAttribute("totalWorkouts", totalWorkouts);
        req.setAttribute("totalCalories", totalCalories);
        req.setAttribute("activeGoals", activeGoals);
        req.setAttribute("challengesJoined", challengesJoined); // Represents Active Challenges

        req.setAttribute("currentStreak", analyticsService.calculateUserStreak(user.getId()));

        java.util.Map<String, Integer> weeklyVolumeMap = analyticsService.calculateWeeklyVolume(user.getId());
        req.setAttribute("weeklyVolumeMap", weeklyVolumeMap);

        java.util.Map<String, Integer> calData = analyticsService.getWeeklyCalorieData(user.getId());
        req.setAttribute("calLabels", String.join("','", calData.keySet()));
        req.setAttribute("calValues", String.join(",", calData.values().stream().map(String::valueOf).toArray(String[]::new)));

        // Workout Distribution for Doughnut chart
        // Map types (Running, Strength Training, HIIT, Cycling)
        int runCount = 0;
        int strengthCount = 0;
        int hiitCount = 0;
        int cycleCount = 0;
        int otherCount = 0;

        for (Workout w : workouts) {
            String t = w.getWorkoutType();
            if (t == null) t = "";
            t = t.toLowerCase();
            if (t.contains("run")) runCount++;
            else if (t.contains("strength") || t.contains("weight")) strengthCount++;
            else if (t.contains("hiit") || t.contains("interval")) hiitCount++;
            else if (t.contains("cycl") || t.contains("bike")) cycleCount++;
            else otherCount++;
        }

        req.setAttribute("distLabels", "Running','Strength','HIIT','Cycling','Other");
        req.setAttribute("distValues", runCount + "," + strengthCount + "," + hiitCount + "," + cycleCount + "," + otherCount);

        // Weekly Goal Completion %
        int totalGoalCount = goals.size();
        int completedGoalCount = 0;
        for (Goal g : goals) {
            if (g.isCompleted()) {
                completedGoalCount++;
            }
        }
        int goalCompletionPercent = 0;
        if (totalGoalCount > 0) {
            goalCompletionPercent = (int) Math.round((double) completedGoalCount / totalGoalCount * 100);
        }
        req.setAttribute("goalCompletionPercent", goalCompletionPercent);

        req.getRequestDispatcher("/user/dashboard.jsp").forward(req, resp);
    }
}
