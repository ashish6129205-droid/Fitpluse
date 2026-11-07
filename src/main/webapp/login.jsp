<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            background-color: var(--bg-primary);
        }
        .auth-card {
            width: 100%;
            max-width: 440px;
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
        <h3 class="fw-bold mb-1">Welcome Back</h3>
        <p class="text-secondary small">Sign in to continue to your dashboard</p>
    </div>

    <c:if test="${param.reset == 'success'}">
        <div class="alert alert-success text-center">
            Password updated! Please log in with your new password.
        </div>
    </c:if>

    <c:if test="${not empty sessionScope.successMessage}">
        <div class="alert alert-success text-center">
            ${sessionScope.successMessage}
        </div>
        <c:remove var="successMessage" scope="session" />
    </c:if>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger text-center">
            ${errorMessage}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <input type="hidden" name="_csrf" value="${csrfToken}" />

        <div class="mb-3">
            <label for="email" class="form-label">Email Address</label>
            <div class="input-group">
                <span class="input-group-text"><i data-lucide="mail" style="width: 18px; height: 18px;"></i></span>
                <input type="email" class="form-control" id="email" name="email" required placeholder="name@example.com">
            </div>
        </div>

        <div class="mb-4">
            <div class="d-flex justify-content-between align-items-center mb-2">
                <label for="password" class="form-label mb-0">Password</label>
            </div>
            <div class="input-group">
                <span class="input-group-text"><i data-lucide="lock" style="width: 18px; height: 18px;"></i></span>
                <input type="password" class="form-control" id="password" name="password" required placeholder="Enter your password">
            </div>
            <div class="text-end mt-2">
                <a href="${pageContext.request.contextPath}/forgot-password" class="small text-decoration-none fw-medium">Forgot Password?</a>
            </div>
        </div>

        <button type="submit" class="btn btn-primary w-100 py-2 mb-4 fs-6">Sign In</button>
    </form>

    <div class="text-center">
        <span class="text-secondary small">Don't have an account?</span>
        <a href="${pageContext.request.contextPath}/register" class="small fw-bold ms-1 text-decoration-none">Create Account</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    lucide.createIcons();
</script>
</body>
</html>
