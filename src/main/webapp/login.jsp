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
        .demo-pills {
            display: flex;
            gap: 0.5rem;
            justify-content: center;
            margin-bottom: 2rem;
        }
        .demo-pill {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 9999px;
            padding: 0.4rem 1rem;
            font-size: 0.8rem;
            color: var(--text-secondary);
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .demo-pill:hover {
            background: rgba(16, 185, 129, 0.1);
            color: var(--accent-emerald);
            border-color: rgba(16, 185, 129, 0.3);
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
            <span class="brand-dot" style="display:inline-block; width:12px; height:12px; border-radius:50%; background:var(--accent-emerald); margin-right:8px; box-shadow:0 0 10px var(--accent-emerald);"></span>
            Welcome Back
        </h3>
        <p class="text-secondary small">Log in to track your progress</p>
    </div>

    <!-- Quick Demo Credentials Helper -->

    <c:if test="${not empty sessionScope.successMessage}">
        <div class="alert alert-success" style="background:rgba(16,185,129,0.1); border-color:rgba(16,185,129,0.2); color:#10b981;">
            ${sessionScope.successMessage}
        </div>
        <c:remove var="successMessage" scope="session" />
    </c:if>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger" style="background:rgba(239,68,68,0.1); border-color:rgba(239,68,68,0.2); color:#ef4444;">
            ${errorMessage}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <input type="hidden" name="_csrf" value="${csrfToken}" />

        <div class="mb-3">
            <label for="email" class="form-label">Email address</label>
            <div class="input-group">
                <span class="input-group-text">✉️</span>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
        </div>

        <div class="mb-4">
            <div class="d-flex justify-content-between align-items-center">
                <label for="password" class="form-label mb-0">Password</label>
            </div>
            <div class="input-group mt-1">
                <span class="input-group-text">🔒</span>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <div class="mt-2 text-end">
                <a href="${pageContext.request.contextPath}/forgot-password.jsp" class="small text-decoration-none">Forgot Password?</a>
            </div>
        </div>

        <button type="submit" class="btn btn-primary w-100 py-2 mb-3">Login to Dashboard</button>
    </form>

    <div class="text-center">
        <span class="text-secondary small">Don't have an account?</span>
        <a href="${pageContext.request.contextPath}/register" class="small fw-bold">Create Account</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
