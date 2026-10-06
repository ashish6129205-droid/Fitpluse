package com.fitpulse.servlet;

import com.fitpulse.model.User;
import com.fitpulse.service.WorkoutService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/user/dashboard")
public class UserDashboardServlet extends HttpServlet {
    private WorkoutService workoutService;

    @Override
    public void init() throws ServletException {
        this.workoutService = new WorkoutService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("loggedUser");

        req.setAttribute("recentWorkouts", workoutService.getWorkoutsForUser(user.getId()));

        req.getRequestDispatcher("/user/dashboard.jsp").forward(req, resp);
    }
}
