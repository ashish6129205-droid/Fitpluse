<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - Reset Password</title>
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
            <i data-lucide="shield-check" style="width: 28px; height: 28px;"></i>
        </div>
        <h3 class="fw-bold mb-1">New Password</h3>
        <p class="text-secondary small">Secure your account with a new password.</p>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger text-center">
            ${errorMessage}
        </div>
    </c:if>

    <c:if test="${not empty sessionScope.successMessage}">
        <div class="alert alert-success text-center">
            ${sessionScope.successMessage}
        </div>
        <c:remove var="successMessage" scope="session" />
    </c:if>

    <form action="${pageContext.request.contextPath}/reset-password" method="post">
        <input type="hidden" name="_csrf" value="${csrfToken}" />

        <div class="mb-3">
            <label for="password" class="form-label">New Password</label>
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

        <button type="submit" class="btn btn-primary w-100 py-2 mb-4 fs-6">Update Password</button>
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
