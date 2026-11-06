<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - Forgot Password</title>
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
    </style>
</head>
<body>

<div class="card auth-card">
    <div class="auth-header">
        <div class="mb-3 d-inline-flex align-items-center justify-content-center" style="width: 56px; height: 56px; background-color: rgba(22, 125, 90, 0.1); border-radius: 50%; color: var(--accent-primary);">
            <i data-lucide="key-round" style="width: 28px; height: 28px;"></i>
        </div>
        <h3 class="fw-bold mb-1">Reset Password</h3>
        <p class="text-secondary small">Enter your email address to receive a password reset link.</p>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger text-center">
            ${errorMessage}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/forgot-password" method="post">
        <input type="hidden" name="_csrf" value="${csrfToken}" />

        <div class="mb-4">
            <label for="email" class="form-label">Registered Email</label>
            <div class="input-group">
                <span class="input-group-text"><i data-lucide="mail" style="width: 18px; height: 18px;"></i></span>
                <input type="email" class="form-control" id="email" name="email" required placeholder="you@example.com">
            </div>
        </div>

        <button type="submit" class="btn btn-primary w-100 py-2 mb-4 fs-6">Send Reset Link</button>
    </form>

    <div class="text-center">
        <a href="${pageContext.request.contextPath}/login" class="small fw-bold text-decoration-none d-inline-flex align-items-center gap-1">
            <i data-lucide="arrow-left" style="width: 14px; height: 14px;"></i> Back to Login
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    lucide.createIcons();
</script>
</body>
</html>
