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
import java.io.PrintWriter;
import java.util.List;

/**
 * Servlet handling the export of a user's workout history to a CSV file.
 */
@WebServlet("/user/export-workouts")
public class WorkoutExportServlet extends HttpServlet {
    private WorkoutService workoutService;

    @Override
    public void init() throws ServletException {
        this.workoutService = new WorkoutService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("loggedUser");

        resp.setContentType("text/csv");
        resp.setHeader("Content-Disposition", "attachment; filename=\"workouts.csv\"");

        List<Workout> workouts = workoutService.getWorkoutsForUser(user.getId());

        try (PrintWriter writer = resp.getWriter()) {
            writer.println("Date,Type,Intensity,Duration(min),Calories,Steps,Notes");
            for (Workout w : workouts) {
                String notes = w.getNotes() != null ? w.getNotes().replace(",", ";").replace("\n", " ") : "";
                String intensity = w.getIntensity() != null ? w.getIntensity() : "";
                writer.printf("%s,%s,%s,%d,%d,%d,%s%n",
                        w.getWorkoutDate(),
                        w.getWorkoutType(),
                        intensity,
                        w.getDurationMin(),
                        w.getCalories(),
                        w.getSteps(),
                        notes
                );
            }
        }
    }
}
