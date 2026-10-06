package com.fitpulse.filter;

import com.fitpulse.model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String path = req.getRequestURI();

        // Public paths
        if (path.endsWith("/") || path.endsWith("/login") || path.endsWith("/login.jsp") ||
            path.endsWith("/index.jsp") || path.endsWith("/health") || path.contains("/css/")) {
            chain.doFilter(request, response);
            return;
        }

        boolean isLoggedIn = (session != null && session.getAttribute("loggedUser") != null);

        if (!isLoggedIn) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("loggedUser");

        // Role-based access control
        if (path.startsWith(req.getContextPath() + "/admin/") && !"ADMIN".equals(user.getRole())) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Admins Only");
            return;
        }

        if (path.startsWith(req.getContextPath() + "/user/") && !"USER".equals(user.getRole())) {
            // Usually, admins might be able to see user pages, but strict isolation requested:
            if (!"ADMIN".equals(user.getRole())) {
                res.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
                return;
            }
        }

        chain.doFilter(request, response);
    }
}
