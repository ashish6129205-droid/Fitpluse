package com.fitpulse.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.UUID;

public class CsrfFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession();

        // 1. Generate token if it doesn't exist
        String sessionToken = (String) session.getAttribute("csrfToken");
        if (sessionToken == null) {
            sessionToken = UUID.randomUUID().toString();
            session.setAttribute("csrfToken", sessionToken);
        }

        // 2. Add to request scope for JSP rendering
        req.setAttribute("csrfToken", sessionToken);

        // 3. Validate token on state-changing methods
        String method = req.getMethod();
        if ("POST".equalsIgnoreCase(method) || "PUT".equalsIgnoreCase(method) || "DELETE".equalsIgnoreCase(method)) {
            String requestToken = req.getParameter("_csrf");
            if (requestToken == null || requestToken.isEmpty()) {
                requestToken = req.getHeader("X-CSRF-TOKEN");
            }

            if (requestToken == null || !requestToken.equals(sessionToken)) {
                res.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid or missing CSRF token");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
