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

@WebServlet("/user/community")
public class CommunityServlet extends HttpServlet {

    private ContentService contentService;

    @Override
    public void init() throws ServletException {
        this.contentService = new ContentService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("approvedContent", contentService.getApprovedContent());
        req.getRequestDispatcher("/user/community.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("loggedUser");

        String title = req.getParameter("title");
        String contentText = req.getParameter("content");

        if (title != null && !title.trim().isEmpty() && contentText != null && !contentText.trim().isEmpty()) {
            FitnessContent fc = new FitnessContent();
            fc.setUserId(user.getId());
            fc.setTitle(title.trim());
            fc.setContent(contentText.trim());

            contentService.createContent(fc);
            session.setAttribute("successMessage", "Your fitness tip has been submitted and is pending admin review.");
        } else {
            session.setAttribute("errorMessage", "Title and content are required.");
        }

        resp.sendRedirect(req.getContextPath() + "/user/community");
    }
}
