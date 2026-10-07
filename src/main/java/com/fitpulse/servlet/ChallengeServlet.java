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
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("loggedUser");

        req.setAttribute("activeChallenges", challengeService.getActiveChallenges());
        req.setAttribute("joinedIds", challengeService.getJoinedChallengeIds(user.getId()));
        req.setAttribute("history", challengeService.getJoinedChallengesHistory(user.getId()));

        req.getRequestDispatcher("/user/challenges.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("loggedUser");

        String action = req.getParameter("action");
        if ("join".equals(action)) {
            try {
                int challengeId = Integer.parseInt(req.getParameter("challengeId"));
                challengeService.joinChallenge(user.getId(), challengeId);
                session.setAttribute("successMessage", "Challenge joined successfully!");
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("errorMessage", "Failed to join challenge. You might have already joined.");
            }
        }

        resp.sendRedirect(req.getContextPath() + "/user/challenges");
    }
}
