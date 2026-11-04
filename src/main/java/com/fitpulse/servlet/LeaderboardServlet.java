package com.fitpulse.servlet;

import com.fitpulse.dao.WorkoutDao;
import com.fitpulse.dao.impl.WorkoutDaoImpl;
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
    private WorkoutDao workoutDao;

    @Override
    public void init() throws ServletException {
        this.workoutDao = new WorkoutDaoImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<UserRank> leaderboard = workoutDao.getLeaderboard();
        req.setAttribute("leaderboard", leaderboard);
        req.getRequestDispatcher("/user/leaderboard.jsp").forward(req, resp);
    }
}
