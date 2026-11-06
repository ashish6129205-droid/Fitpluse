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
                <li class="nav-item">
                    <a class="btn btn-primary px-4" href="${pageContext.request.contextPath}/register">Get Started Free</a>
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
            <a href="${pageContext.request.contextPath}/register" class="btn btn-primary btn-lg px-5 py-3 fs-5">Get Started Free</a>
            <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light btn-lg px-5 py-3 fs-5">Demo Login</a>
        </div>
    </div>
</section>

<!-- Feature Showcase Grid -->
<section class="container mb-5">
    <div class="row g-4">
        <!-- Feature 1 -->
        <div class="col-md-4">
            <div class="card h-100 text-center p-4">
                <div class="feature-icon">📊</div>
                <h4 class="mb-3">Visual Progress & Charts</h4>
                <p class="text-secondary">
                    Dive into dynamic Chart.js trends. Visualize your calorie burn and workout distribution effortlessly.
                </p>
            </div>
        </div>
        <!-- Feature 2 -->
        <div class="col-md-4">
            <div class="card h-100 text-center p-4">
                <div class="feature-icon">🏆</div>
                <h4 class="mb-3">Community Challenges</h4>
                <p class="text-secondary">
                    Compete on real-time global leaderboards backed by robust transactional safety.
                </p>
            </div>
        </div>
        <!-- Feature 3 -->
        <div class="col-md-4">
            <div class="card h-100 text-center p-4">
                <div class="feature-icon">🛡️</div>
                <h4 class="mb-3">Enterprise Security</h4>
                <p class="text-secondary">
                    Your data is safe with BCrypt salted encryption, strict CSRF protection, and HikariCP connection pooling.
                </p>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="py-4 text-center mt-5" style="border-top: 1px solid var(--border-subtle);">
    <div class="container">
        <p class="text-secondary mb-1">&copy; 2024 FitPulse. All rights reserved.</p>
        <p class="text-secondary small mb-0">Built with Jakarta EE, Neon PostgreSQL, and pure determination.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
