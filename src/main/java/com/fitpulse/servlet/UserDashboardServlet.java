package com.fitpulse.servlet;

import com.fitpulse.model.User;
import com.fitpulse.model.Workout;
import com.fitpulse.model.Goal;
import com.fitpulse.model.Challenge;
import com.fitpulse.service.WorkoutService;
import com.fitpulse.service.GoalService;
import com.fitpulse.service.ChallengeService;

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

    @Override
    public void init() throws ServletException {
        this.workoutService = new WorkoutService();
        this.goalService = new GoalService();
        this.challengeService = new ChallengeService();
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

        req.getRequestDispatcher("/user/dashboard.jsp").forward(req, resp);
    }
}
