package com.fitpulse.servlet;

import com.zaxxer.hikari.HikariDataSource;
import com.fitpulse.util.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/admin/settings")
public class AdminSettingsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setAttribute("registrationEnabled", true);
        req.setAttribute("maintenanceMode", false);
        req.setAttribute("sessionTimeout", 30);

        int maxPoolSize = 10;
        int minimumIdle = 2;

        req.setAttribute("maxPoolSize", maxPoolSize);
        req.setAttribute("minimumIdle", minimumIdle);

        req.getRequestDispatcher("/admin/settings.jsp").forward(req, resp);
    }
}
