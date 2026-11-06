<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - Premium Fitness Tracking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        .landing-body {
            background-color: var(--bg-primary);
            color: var(--text-primary);
        }
        .hero-section {
            padding: 6rem 0 4rem;
            text-align: center;
        }
        .hero-badge {
            display: inline-flex;
            align-items: center;
            padding: 0.5rem 1rem;
            background: rgba(22, 125, 90, 0.1);
            border: 1px solid rgba(22, 125, 90, 0.2);
            color: var(--accent-primary);
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 600;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-sm);
        }
        .hero-title {
            font-family: var(--font-heading);
            font-size: 4rem;
            font-weight: 800;
            letter-spacing: -0.04em;
            line-height: 1.1;
            margin-bottom: 1.5rem;
            color: var(--text-primary);
        }
        .hero-subtitle {
            font-size: 1.25rem;
            color: var(--text-secondary);
            max-width: 650px;
            margin: 0 auto 3rem;
            line-height: 1.6;
        }
        .feature-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-xl);
            padding: 2.5rem;
            text-align: center;
            margin: 2rem auto;
            max-width: 900px;
            box-shadow: var(--shadow-md);
        }
        .landing-nav {
            background-color: var(--bg-card);
            border-bottom: 1px solid var(--border-color);
        }
        @media (max-width: 768px) {
            .hero-section { padding: 4rem 0 2rem; }
            .hero-title { font-size: 2.5rem; }
            .hero-subtitle { font-size: 1.1rem; }
        }
    </style>
</head>
<body class="landing-body">

<nav class="navbar navbar-expand-lg landing-nav sticky-top py-3">
    <div class="container-fluid px-4">
        <a class="navbar-brand sidebar-brand" href="#">
            <i data-lucide="activity" class="brand-icon"></i> FitPulse
        </a>
        <div class="d-flex ms-auto gap-3">
            <a href="login" class="btn btn-outline-primary px-4">Login</a>
        </div>
    </div>
</nav>

<section class="hero-section">
    <div class="container">
        <div class="hero-badge">
            <i data-lucide="zap" class="me-2" style="width: 16px; height: 16px;"></i> Premium Performance Analytics
        </div>
        <h1 class="hero-title">Train Smarter.<br>Track Better.<br>Perform Stronger.</h1>
        <p class="hero-subtitle">
            Experience the ultimate fitness platform powered by atomic transactional safety, active streak monitoring, and real-time visual analytics. Built for athletes, designed for everyone.
        </p>
        <div class="d-flex justify-content-center gap-3">
            <a href="login" class="btn btn-primary px-5 py-3 fs-5">Login</a>
        </div>
    </div>
</section>

<section class="container mb-5 pb-5">
    <div class="feature-card glassmorphic">
        <div class="d-flex flex-wrap justify-content-center gap-4 mt-4">
            <span class="fs-5 fw-medium"><i data-lucide="shield-check" class="me-1 d-inline" style="width:20px;height:20px;"></i> ⚡ Atomic JDBC Transactions</span>
            <span class="fs-5 fw-medium"><i data-lucide="bar-chart-3" class="me-1 d-inline" style="width:20px;height:20px;"></i> 📊 Real-Time Analytics</span>
            <span class="fs-5 fw-medium"><i data-lucide="trophy" class="me-1 d-inline" style="width:20px;height:20px;"></i> 🏆 Global Leaderboard</span>
            <span class="fs-5 fw-medium"><i data-lucide="lock" class="me-1 d-inline" style="width:20px;height:20px;"></i> 🛡️ BCrypt & CSRF Protected</span>
        </div>
    </div>
</section>

<footer class="py-4 text-center mt-auto" style="border-top: 1px solid var(--border-color); background-color: var(--bg-card);">
    <div class="container">
        <p class="text-secondary mb-0 fw-medium">&copy; 2026 FitPulse. All rights reserved.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    lucide.createIcons();
</script>
</body>
</html>
