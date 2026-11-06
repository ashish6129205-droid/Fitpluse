<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            background-color: var(--bg-primary);
            padding: 2rem 1rem;
        }
        .auth-card {
            width: 100%;
            max-width: 480px;
            padding: 3rem 2.5rem;
            animation: slideUpFade 0.5s cubic-bezier(0.16, 1, 0.3, 1);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-lg);
        }
        @keyframes slideUpFade {
            0% { opacity: 0; transform: translateY(20px); }
            100% { opacity: 1; transform: translateY(0); }
        }
        .auth-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        .auth-brand {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            font-family: var(--font-heading);
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--text-primary);
            text-decoration: none;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>

<div class="card auth-card">
    <div class="auth-header">
        <a href="${pageContext.request.contextPath}/" class="auth-brand">
            <i data-lucide="activity" class="brand-icon"></i> FitPulse
        </a>
        <h3 class="fw-bold mb-1">Create an Account</h3>
        <p class="text-secondary small">Join FitPulse and start your fitness journey</p>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger text-center">
            ${errorMessage}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="post">
        <input type="hidden" name="_csrf" value="${csrfToken}" />

        <div class="mb-3">
            <label for="name" class="form-label">Full Name</label>
            <div class="input-group">
                <span class="input-group-text"><i data-lucide="user" style="width: 18px; height: 18px;"></i></span>
                <input type="text" class="form-control" id="name" name="name" required placeholder="John Doe">
            </div>
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Email Address</label>
            <div class="input-group">
                <span class="input-group-text"><i data-lucide="mail" style="width: 18px; height: 18px;"></i></span>
                <input type="email" class="form-control" id="email" name="email" required placeholder="you@example.com">
            </div>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <div class="input-group">
                <span class="input-group-text"><i data-lucide="lock" style="width: 18px; height: 18px;"></i></span>
                <input type="password" class="form-control" id="password" name="password" required placeholder="••••••••">
            </div>
            <div class="form-text text-secondary mt-1" style="font-size: 0.75rem;">Must be at least 8 characters long.</div>
        </div>

        <div class="mb-4">
            <label for="confirmPassword" class="form-label">Confirm Password</label>
            <div class="input-group">
                <span class="input-group-text"><i data-lucide="lock" style="width: 18px; height: 18px;"></i></span>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required placeholder="••••••••">
            </div>
        </div>

        <button type="submit" class="btn btn-primary w-100 py-2 mb-4 fs-6">Sign Up</button>
    </form>

    <div class="text-center">
        <span class="text-secondary small">Already have an account?</span>
        <a href="${pageContext.request.contextPath}/login" class="small fw-bold ms-1 text-decoration-none">Sign In</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    lucide.createIcons();
</script>
</body>
</html>
