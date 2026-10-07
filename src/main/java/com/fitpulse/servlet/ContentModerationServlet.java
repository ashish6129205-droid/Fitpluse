package com.fitpulse.servlet;

import com.fitpulse.model.FitnessContent;
import com.fitpulse.model.User;
import com.fitpulse.service.ContentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/moderation")
public class ContentModerationServlet extends HttpServlet {
    private ContentService contentService;

    @Override
    public void init() throws ServletException {
        this.contentService = new ContentService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("pendingContent", contentService.getPendingContent());
        req.getRequestDispatcher("/admin/moderation.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User admin = (User) session.getAttribute("loggedUser");

        try {
            int contentId = Integer.parseInt(req.getParameter("contentId"));
            String status = req.getParameter("status"); // APPROVED or REJECTED

            if ("APPROVED".equals(status) || "REJECTED".equals(status)) {
                contentService.updateContentStatus(admin.getId(), contentId, status);
                session.setAttribute("successMessage", "Content " + status.toLowerCase() + " successfully.");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid request.");
        }

        resp.sendRedirect(req.getContextPath() + "/admin/moderation");
    }
}
