package com.fitpulse.servlet;

import com.fitpulse.model.Challenge;
import com.fitpulse.model.User;
import com.fitpulse.service.ChallengeService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/user/challenges")
public class ChallengeServlet extends HttpServlet {
    private ChallengeService challengeService;

    @Override
    public void init() throws ServletException {
        this.challengeService = new ChallengeService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("activeChallenges", challengeService.getActiveChallenges());
        req.getRequestDispatcher("/user/challenges.jsp").forward(req, resp);
    }
}
