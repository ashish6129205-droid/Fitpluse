<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - Welcome</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body.welcome-page, .welcome-wrapper {
            height: 100vh;
            max-height: 100vh;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 1.25rem 2.5rem;
            background: radial-gradient(circle at 50% 20%, #1e293b 0%, #0b0f19 75%);
            box-sizing: border-box;
        }
    </style>
</head>
<body class="welcome-page">
<div class="welcome-wrapper w-100 p-0 m-0">
    <!-- Navbar -->
    <nav class="navbar navbar-dark bg-transparent pt-0 px-0 d-flex justify-content-between align-items-center w-100" style="border: none !important; position: static;">
        <a class="navbar-brand fw-bold text-white d-flex align-items-center gap-2 m-0 p-0" href="#" style="font-size: 1.25rem;">
            FitPulse <span class="bg-success rounded-circle shadow-sm" style="width: 8px; height: 8px; box-shadow: 0 0 10px #10b981 !important; background-color: #10b981 !important;"></span>
        </a>
        <div>
            <a href="${pageContext.request.contextPath}/login" class="welcome-nav-login-btn">Login</a>
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="flex-grow-1 d-flex flex-column justify-content-center align-items-center text-center w-100">
        <h1 class="fw-bold mb-3" style="color: #ffffff; font-size: clamp(2rem, 3.5vw, 2.75rem); line-height: 1.15; max-width: 900px; letter-spacing: -0.5px;">
            Elevate Your Performance. Track Every Rep. Crush Every Goal.
        </h1>
        <p style="color: #94a3b8; font-size: clamp(0.9rem, 1.2vw, 1.05rem); max-width: 680px; margin: 0 auto 1.25rem;">
            A high-performance fitness platform powered by atomic JDBC transactions, active streak tracking, and interactive analytics.
        </p>

        <div>
            <a href="${pageContext.request.contextPath}/login" style="background: #10b981; color: #ffffff; font-weight: 600; padding: 10px 28px; border-radius: 8px; box-shadow: 0 0 20px rgba(16, 185, 129, 0.4); text-decoration: none; display: inline-block; transition: all 0.2s;">Login to Your Account</a>
        </div>

        <!-- Features Pills -->
        <div style="margin-top: 1.25rem; display: flex; justify-content: center; gap: 14px; flex-wrap: wrap;">
            <span style="background: rgba(255, 255, 255, 0.05); border: 1px solid rgba(255, 255, 255, 0.1); color: #cbd5e1; padding: 5px 14px; border-radius: 9999px; font-size: 0.8rem;">⚡ Atomic Transactions</span>
            <span style="background: rgba(255, 255, 255, 0.05); border: 1px solid rgba(255, 255, 255, 0.1); color: #cbd5e1; padding: 5px 14px; border-radius: 9999px; font-size: 0.8rem;">📊 Dynamic Analytics</span>
            <span style="background: rgba(255, 255, 255, 0.05); border: 1px solid rgba(255, 255, 255, 0.1); color: #cbd5e1; padding: 5px 14px; border-radius: 9999px; font-size: 0.8rem;">🏆 Global Leaderboard</span>
        </div>
    </div>

    <!-- Footer -->
    <footer class="text-center w-100">
        <p style="color: #64748b; font-size: 0.8rem; margin: 0;">© 2026 FitPulse. All rights reserved.</p>
    </footer>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
