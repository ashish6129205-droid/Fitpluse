package com.fitpulse.servlet;

import com.fitpulse.service.AnalyticsService;
import com.fitpulse.model.UserRank;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/leaderboard")
public class LeaderboardServlet extends HttpServlet {
    private AnalyticsService analyticsService;

    @Override
    public void init() throws ServletException {
        this.analyticsService = new AnalyticsService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<UserRank> leaderboard = analyticsService.getGlobalLeaderboard();
        req.setAttribute("leaderboard", leaderboard);
        req.getRequestDispatcher("/user/leaderboard.jsp").forward(req, resp);
    }
}
