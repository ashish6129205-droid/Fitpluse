<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - Welcome</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid min-vh-100 d-flex flex-column" style="background: #0b0f19;">
    <!-- Navbar -->
    <nav class="navbar navbar-dark bg-transparent pt-4 px-4">
        <div class="container">
            <a class="navbar-brand fw-bold text-white d-flex align-items-center gap-2" href="#">
                FitPulse <span class="bg-success rounded-circle shadow-sm" style="width: 8px; height: 8px; box-shadow: 0 0 10px #10b981 !important; background-color: #10b981 !important;"></span>
            </a>
            <div class="d-flex gap-3">
                <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light border-0 fw-medium">Log In</a>
                <a href="${pageContext.request.contextPath}/register" class="btn fw-semibold text-white px-4" style="background: #10b981; border: none; box-shadow: 0 4px 15px rgba(16, 185, 129, 0.4);">Create Account</a>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="container flex-grow-1 d-flex flex-column justify-content-center align-items-center text-center py-5">
        <h1 class="display-3 fw-bolder text-white mb-4" style="letter-spacing: -1px; max-width: 800px;">
            Elevate Your Performance.<br/>Track Every Rep.<br/><span style="color: #10b981;">Crush Every Goal.</span>
        </h1>
        <p class="lead text-light opacity-75 mb-5 mx-auto" style="max-width: 600px; font-weight: 400;">
            A high-performance fitness platform powered by atomic JDBC transactions, active streak tracking, and interactive analytics.
        </p>

        <div class="d-flex flex-column flex-sm-row gap-3 mb-5">
            <a href="${pageContext.request.contextPath}/login" class="btn btn-lg fw-bold text-white px-5 py-3 rounded-pill" style="background: #10b981; border: none; box-shadow: 0 8px 25px rgba(16, 185, 129, 0.5); transition: transform 0.2s;">Login to Your Account</a>
        </div>

        <!-- Features Pills -->
        <div class="d-flex flex-wrap justify-content-center gap-3 mt-4">
            <span class="badge rounded-pill border border-secondary text-light px-3 py-2" style="background: rgba(255,255,255,0.05); font-weight: 500;">⚡ Atomic Transactions</span>
            <span class="badge rounded-pill border border-secondary text-light px-3 py-2" style="background: rgba(255,255,255,0.05); font-weight: 500;">📊 Dynamic Analytics</span>
            <span class="badge rounded-pill border border-secondary text-light px-3 py-2" style="background: rgba(255,255,255,0.05); font-weight: 500;">🏆 Global Leaderboard</span>
        </div>
    </div>

    <!-- Footer -->
    <footer class="py-4 text-center text-secondary" style="font-size: 0.85rem;">
        <div class="container">
            © 2026 FitPulse. All rights reserved.
        </div>
    </footer>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
