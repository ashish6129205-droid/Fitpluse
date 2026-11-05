package com.fitpulse.servlet;

import com.fitpulse.model.User;
import com.fitpulse.service.UserService;
import com.fitpulse.service.PasswordResetService;

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
                req.setAttribute("errorMessage", "Email not found.");
                req.getRequestDispatcher("/forgot-password.jsp").forward(req, resp);
                return;
            }

            // Generate a secure reset token
            String token = PasswordResetService.generateToken(user.getEmail());
            System.out.println("====== MOCK EMAIL ======");
            System.out.println("To: " + user.getEmail());
            System.out.println("Your password reset token is: " + token);
            System.out.println("========================");

            // For MVP, we pass the token in session just to prepopulate the next form,
            // but the backend requires the actual token to complete the reset.
            // Alternatively, redirect to reset-password with a success message asking them to enter the token.
            HttpSession session = req.getSession(true);
            session.setAttribute("successMessage", "Password reset token generated! (Check server logs). Please enter it below.");
            resp.sendRedirect(req.getContextPath() + "/reset-password");
        } catch (Exception e) {
            req.setAttribute("errorMessage", "An error occurred while processing your request.");
            req.getRequestDispatcher("/forgot-password.jsp").forward(req, resp);
        }
    }
}
