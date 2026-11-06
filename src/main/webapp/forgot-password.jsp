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
    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }
        .login-card {
            width: 100%;
            max-width: 420px;
            padding: 2.5rem;
            animation: slideUpFade 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }
        @keyframes slideUpFade {
            0% { opacity: 0; transform: translateY(40px); }
            100% { opacity: 1; transform: translateY(0); }
        }
        .input-group-text {
            background: var(--bg-obsidian);
            border: 1px solid var(--border-subtle);
            border-right: none;
            color: var(--text-secondary);
        }
        .form-control {
            border-left: none;
        }
        .form-control:focus {
            box-shadow: none;
            border-color: var(--border-subtle);
        }
        .input-group:focus-within {
            box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.15);
            border-radius: 0.75rem;
        }
        .input-group:focus-within .input-group-text,
        .input-group:focus-within .form-control {
            border-color: var(--accent-emerald);
        }
    </style>
</head>
<body>

<div class="card login-card">
    <div class="text-center mb-4">
        <h3 class="fw-bold" style="color: var(--text-primary);">
            Reset Password
        </h3>
        <p class="text-secondary small">Enter your email to reset your password</p>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger" style="background:rgba(239,68,68,0.1); border-color:rgba(239,68,68,0.2); color:#ef4444;">
            ${errorMessage}
        </div>
    </c:if>

    <form action="forgot-password" method="post">
        <input type="hidden" name="_csrf" value="${csrfToken}" />

        <div class="mb-4">
            <label for="email" class="form-label">Registered Email</label>
            <div class="input-group">
                <span class="input-group-text">✉️</span>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
        </div>

        <button type="submit" class="btn btn-primary w-100 py-2 mb-3">Send Reset Link</button>
    </form>

    <div class="text-center">
        <a href="login" class="small text-decoration-none">Back to Login</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
