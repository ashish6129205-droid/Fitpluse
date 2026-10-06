package com.fitpulse.servlet;

import com.fitpulse.model.Workout;
import com.fitpulse.service.WorkoutService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/moderation")
public class ContentModerationServlet extends HttpServlet {
    private WorkoutService workoutService;

    @Override
    public void init() throws ServletException {
        this.workoutService = new WorkoutService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("workouts", workoutService.getAllWorkouts());
        req.getRequestDispatcher("/admin/moderation.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int workoutId = Integer.parseInt(req.getParameter("workoutId"));
        String status = req.getParameter("status"); // APPROVED or REJECTED

        Workout workout = workoutService.getWorkoutById(workoutId);
        if (workout != null && ("APPROVED".equals(status) || "REJECTED".equals(status))) {
            workout.setStatus(status);
            workoutService.updateWorkout(workout);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/moderation");
    }
}
