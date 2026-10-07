package com.fitpulse.servlet;

import com.fitpulse.model.User;
import com.fitpulse.model.Workout;
import com.fitpulse.service.WorkoutService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import com.fitpulse.service.ActivityLogService;
import java.sql.Date;

@WebServlet("/user/workouts")
public class WorkoutServlet extends HttpServlet {
    private WorkoutService workoutService;

    @Override
    public void init() throws ServletException {
        this.workoutService = new WorkoutService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("loggedUser");

        req.setAttribute("workouts", workoutService.getWorkoutsForUser(user.getId()));
        req.getRequestDispatcher("/user/workouts.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("loggedUser");

        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Workout workout = workoutService.getWorkoutById(id);
            if (workout != null && workout.getUserId() == user.getId()) {
                workoutService.deleteWorkout(id);
                session.setAttribute("successMessage", "Workout deleted successfully.");
            }
        } else {
            String type = req.getParameter("workoutType");
            int duration = Integer.parseInt(req.getParameter("durationMin"));
            int calories = req.getParameter("calories") != null && !req.getParameter("calories").trim().isEmpty() ? Integer.parseInt(req.getParameter("calories")) : 0;
            int steps = req.getParameter("steps") != null && !req.getParameter("steps").trim().isEmpty() ? Integer.parseInt(req.getParameter("steps")) : 0;
            Date workoutDate = Date.valueOf(req.getParameter("workoutDate"));
            String notes = req.getParameter("notes");
            String intensity = req.getParameter("intensity");

            Workout workout = new Workout();
            workout.setUserId(user.getId());
            workout.setWorkoutType(type);
            workout.setDurationMin(duration);
            workout.setCalories(calories);
            workout.setSteps(steps);
            workout.setWorkoutDate(workoutDate);
            workout.setNotes(notes);
            workout.setStatus("APPROVED");
            workout.setIntensity(intensity);

            workoutService.logWorkout(workout);
            ActivityLogService.getInstance().logActivityAsync(user.getId(), "LOG_WORKOUT", "Logged " + type + " for " + duration + " min");
            session.setAttribute("successMessage", "Workout logged successfully!");
        }

        resp.sendRedirect(req.getContextPath() + "/user/workouts");
    }
}
