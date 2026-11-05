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

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        this.userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            req.setAttribute("errorMessage", "Email is required.");
            req.getRequestDispatcher("/forgot-password.jsp").forward(req, resp);
            return;
        }

        try {
            User user = userService.findByEmail(email.trim());
            if (user == null) {
                req.setAttribute("errorMessage", "Email not found in our records.");
                req.getRequestDispatcher("/forgot-password.jsp").forward(req, resp);
                return;
            }

            // For MVP, we'll store the email in session for the reset-password step
            HttpSession session = req.getSession(true);
            session.setAttribute("resetEmail", email.trim());

            resp.sendRedirect(req.getContextPath() + "/reset-password");
        } catch (Exception e) {
            req.setAttribute("errorMessage", "An error occurred while processing your request.");
            req.getRequestDispatcher("/forgot-password.jsp").forward(req, resp);
        }
    }
}
