package com.fitpulse.servlet;

import com.fitpulse.model.User;
import com.fitpulse.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/user/profile")
public class ProfileServlet extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        this.userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/user/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("loggedUser");

        String name = req.getParameter("name");
        String ageStr = req.getParameter("age");
        String heightStr = req.getParameter("heightCm");
        String weightStr = req.getParameter("weightKg");
        String fitnessGoal = req.getParameter("fitnessGoal");

        if (name != null && !name.trim().isEmpty()) {
            user.setName(name.trim());
        }

        if (ageStr != null && !ageStr.trim().isEmpty()) {
            try { user.setAge(Integer.parseInt(ageStr.trim())); } catch (NumberFormatException e) { }
        }

        if (heightStr != null && !heightStr.trim().isEmpty()) {
            try { user.setHeightCm(Double.parseDouble(heightStr.trim())); } catch (NumberFormatException e) { }
        }

        if (weightStr != null && !weightStr.trim().isEmpty()) {
            try { user.setWeightKg(Double.parseDouble(weightStr.trim())); } catch (NumberFormatException e) { }
        }

        if (fitnessGoal != null) {
            user.setFitnessGoal(fitnessGoal.trim());
        }

        userService.updateProfile(user);

        // Update session object
        session.setAttribute("loggedUser", userService.getUserById(user.getId()));
        session.setAttribute("successMessage", "Profile updated successfully.");

        resp.sendRedirect(req.getContextPath() + "/user/profile");
    }
}
