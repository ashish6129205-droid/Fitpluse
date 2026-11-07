package com.fitpulse.servlet;

import com.fitpulse.dao.UserDao;
import com.fitpulse.dao.impl.UserDaoImpl;
import com.fitpulse.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    private final UserDao userDao = new UserDaoImpl();

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

        User user = userDao.findByEmail(email.trim());

        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("resetEmail", email.trim());
            resp.sendRedirect(req.getContextPath() + "/reset-password");
        } else {
            req.setAttribute("errorMessage", "No account found with this email.");
            req.getRequestDispatcher("/forgot-password.jsp").forward(req, resp);
        }
    }
}