package com.fitpulse.servlet;

import com.fitpulse.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.fitpulse.service.ActivityLogService;

@WebServlet("/admin/users")
public class ManageUsersServlet extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        this.userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("users", userService.getAllUsers());
        req.getRequestDispatcher("/admin/users.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        int userId = Integer.parseInt(req.getParameter("userId"));

        if ("activate".equals(action)) {
            userService.updateUserStatus(userId, true);
            ActivityLogService.getInstance().logActivityAsync(userId, "USER_ACTIVATED", "Admin activated user ID " + userId);
        } else if ("deactivate".equals(action)) {
            userService.updateUserStatus(userId, false);
            ActivityLogService.getInstance().logActivityAsync(userId, "USER_DEACTIVATED", "Admin deactivated user ID " + userId);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/users");
    }
}
