package com.fitpulse.servlet;

import com.fitpulse.model.Goal;
import com.fitpulse.model.User;
import com.fitpulse.service.GoalService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/user/goals")
public class GoalServlet extends HttpServlet {
    private GoalService goalService;

    @Override
    public void init() throws ServletException {
        this.goalService = new GoalService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("loggedUser");

        req.setAttribute("goals", goalService.getGoalsForUser(user.getId()));
        req.getRequestDispatcher("/user/goals.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("loggedUser");

        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            int id = 0;
            try { id = Integer.parseInt(req.getParameter("id")); } catch(NumberFormatException ignore) {}
            if (id > 0) {
                Goal goal = goalService.getGoalById(id);
                if (goal != null && goal.getUserId() == user.getId()) {
                    goalService.deleteGoal(id);
                }
            }
        } else if ("complete".equals(action)) {
            int id = 0;
            try { id = Integer.parseInt(req.getParameter("id")); } catch(NumberFormatException ignore) {}
            if (id > 0) {
                Goal goal = goalService.getGoalById(id);
                if (goal != null && goal.getUserId() == user.getId()) {
                    goal.setCompleted(true);
                    goalService.updateGoal(goal);
                }
            }
        } else {
            String goalType = req.getParameter("goalType");
            double targetValue = 0;
            try { targetValue = Double.parseDouble(req.getParameter("targetValue")); } catch(NumberFormatException ignore) {}
            String unit = req.getParameter("unit");
            Date deadline = null;
            if (req.getParameter("deadline") != null && !req.getParameter("deadline").isEmpty()) {
                deadline = Date.valueOf(req.getParameter("deadline"));
            }

            Goal goal = new Goal();
            goal.setUserId(user.getId());
            goal.setGoalType(goalType);
            goal.setTargetValue(targetValue);
            goal.setCurrentValue(0);
            goal.setUnit(unit);
            goal.setDeadline(deadline);
            goal.setCompleted(false);

            goalService.addGoal(goal);
        }

        resp.sendRedirect(req.getContextPath() + "/user/goals");
    }
}
