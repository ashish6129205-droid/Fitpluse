package com.fitpulse.servlet;

import com.fitpulse.dao.UserDao;
import com.fitpulse.dao.impl.UserDaoImpl;
import com.fitpulse.util.PasswordUtil;
import com.fitpulse.service.PasswordResetService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {

    private UserDao userDao;

    @Override
    public void init() throws ServletException {
        this.userDao = new UserDaoImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("resetUserEmail") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.getRequestDispatcher("/reset-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("resetUserEmail") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String email = (String) session.getAttribute("resetUserEmail");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        if (password == null || password.trim().isEmpty() || confirmPassword == null || confirmPassword.trim().isEmpty()) {
            req.setAttribute("errorMessage", "All fields are required.");
            req.getRequestDispatcher("/reset-password.jsp").forward(req, resp);
            return;
        }

        if (!password.equals(confirmPassword)) {
            req.setAttribute("errorMessage", "Passwords do not match.");
            req.getRequestDispatcher("/reset-password.jsp").forward(req, resp);
            return;
        }

        if (password.length() < 6) {
            req.setAttribute("errorMessage", "Password must be at least 6 characters.");
            req.getRequestDispatcher("/reset-password.jsp").forward(req, resp);
            return;
        }

        try {
            String hashed = PasswordUtil.hashPassword(password);
            userDao.updatePassword(email, hashed);

            // Remove email from session to prevent replay
            session.removeAttribute("resetUserEmail");

            resp.sendRedirect(req.getContextPath() + "/login?reset=success");
        } catch (Exception e) {
            req.setAttribute("errorMessage", "An error occurred while resetting your password.");
            req.getRequestDispatcher("/reset-password.jsp").forward(req, resp);
        }
    }
}
