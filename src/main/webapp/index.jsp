<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - Elevate Your Fitness Tracking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .hero-section {
            padding: 8rem 0 5rem;
            text-align: center;
        }
        .hero-badge {
            display: inline-flex;
            align-items: center;
            padding: 0.5rem 1rem;
            background: rgba(16, 185, 129, 0.1);
            border: 1px solid rgba(16, 185, 129, 0.2);
            color: #10b981;
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 600;
            margin-bottom: 2rem;
            box-shadow: 0 0 20px rgba(16, 185, 129, 0.15);
        }
        .hero-title {
            font-size: 4.5rem;
            font-weight: 800;
            letter-spacing: -0.05em;
            line-height: 1.1;
            margin-bottom: 1.5rem;
            background: linear-gradient(to right, #f8fafc, #94a3b8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .hero-subtitle {
            font-size: 1.25rem;
            color: var(--text-secondary);
            max-width: 600px;
            margin: 0 auto 3rem;
            line-height: 1.6;
        }
        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            background: rgba(255, 255, 255, 0.05);
            width: 80px;
            height: 80px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            margin-left: auto;
            margin-right: auto;
            border: 1px solid rgba(255,255,255,0.1);
        }
        @media (max-width: 768px) {
            .hero-section {
                padding: 5rem 0 3rem;
            }
            .hero-title {
                font-size: 3rem;
            }
            .hero-subtitle {
                font-size: 1.1rem;
            }
        }
    </style>
</head>
<body>

<!-- Floating Frosted Glass Navbar -->
<nav class="navbar navbar-expand-lg sticky-top">
    <div class="container-fluid px-4 py-2">
        <a class="navbar-brand" href="#">
            <span class="brand-dot"></span> FitPulse
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav gap-3">
                <li class="nav-item">
                    <a class="btn btn-outline-light px-4" href="${pageContext.request.contextPath}/login">Login</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero-section">
    <div class="container">
        <div class="hero-badge">
            ⚡ Intelligent Fitness Tracking & Analytics
        </div>
        <h1 class="hero-title">Level Up Your Fitness.<br>Track Every Rep.<br>Crush Every Goal.</h1>
        <p class="hero-subtitle">
            Experience the ultimate fitness platform powered by atomic JDBC transaction safety, active streak monitoring, and real-time Chart.js analytics.
        </p>
        <div class="d-flex justify-content-center gap-3">
            <a href="login" class="btn btn-primary">Login</a>
        </div>
    </div>
</section>

<!-- Feature Showcase Grid -->
<section class="container mb-5">
    <div style="background: rgba(255, 255, 255, 0.04); border: 1px solid rgba(255, 255, 255, 0.08); border-radius: 16px; padding: 2.5rem; text-align: center; margin: 2rem auto; max-width: 900px;">
        <h2 style="font-weight: bold; margin-bottom: 1rem; color: #fff;">Unified Fitness Tracking & Performance Analytics</h2>
        <p style="color: var(--text-secondary); margin-bottom: 2rem; font-size: 1.1rem; line-height: 1.6;">
            Experience atomic transactional safety, automated streak progression, dynamic Chart.js data visualization, and secure role-based access control — all engineered into one high-performance Java web platform.
        </p>
        <div style="display: flex; flex-wrap: wrap; justify-content: center; gap: 1rem;">
            <span style="background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); padding: 0.5rem 1rem; border-radius: 999px; font-weight: 500;">⚡ Atomic JDBC Transactions</span>
            <span style="background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); padding: 0.5rem 1rem; border-radius: 999px; font-weight: 500;">📊 Live Visual Analytics</span>
            <span style="background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); padding: 0.5rem 1rem; border-radius: 999px; font-weight: 500;">🏆 Dynamic Leaderboards</span>
            <span style="background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); padding: 0.5rem 1rem; border-radius: 999px; font-weight: 500;">🛡️ BCrypt & CSRF Protected</span>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="py-4 text-center mt-5" style="border-top: 1px solid var(--border-subtle);">
    <div class="container">
        <p class="text-secondary mb-1">&copy; 2026 FitPulse. All rights reserved.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
