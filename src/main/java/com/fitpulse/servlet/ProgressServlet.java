package com.fitpulse.servlet;

import com.fitpulse.model.ProgressEntry;
import com.fitpulse.model.User;
import com.fitpulse.service.ProgressService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/user/progress")
public class ProgressServlet extends HttpServlet {
    private ProgressService progressService;

    @Override
    public void init() throws ServletException {
        this.progressService = new ProgressService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("loggedUser");

        req.setAttribute("progressEntries", progressService.getProgressForUser(user.getId()));
        req.getRequestDispatcher("/user/progress.jsp").forward(req, resp);
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
                ProgressEntry entry = progressService.getProgressById(id);
                if (entry != null && entry.getUserId() == user.getId()) {
                    progressService.deleteProgress(id);
                }
            }
        } else {
            Date entryDate = Date.valueOf(req.getParameter("entryDate"));
            Double weightKg = parseDoubleSafe(req.getParameter("weightKg"));
            Double waistCm = parseDoubleSafe(req.getParameter("waistCm"));
            Double chestCm = parseDoubleSafe(req.getParameter("chestCm"));
            Double armsCm = parseDoubleSafe(req.getParameter("armsCm"));

            ProgressEntry entry = new ProgressEntry();
            entry.setUserId(user.getId());
            entry.setEntryDate(entryDate);
            entry.setWeightKg(weightKg);
            entry.setWaistCm(waistCm);
            entry.setChestCm(chestCm);
            entry.setArmsCm(armsCm);

            progressService.addProgress(entry);
        }

        resp.sendRedirect(req.getContextPath() + "/user/progress");
    }

    private Double parseDoubleSafe(String val) {
        if (val == null || val.trim().isEmpty()) {
            return null;
        }
        try {
            return Double.parseDouble(val.trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
