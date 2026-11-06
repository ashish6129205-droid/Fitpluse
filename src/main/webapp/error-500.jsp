<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - System Error</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        body {
            background-color: var(--bg-primary);
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            margin: 0;
            font-family: var(--font-main);
        }
        .error-container {
            text-align: center;
            padding: 3rem 2rem;
            max-width: 500px;
        }
        .error-code {
            font-family: var(--font-heading);
            font-size: 6rem;
            font-weight: 800;
            color: var(--error);
            line-height: 1;
            margin-bottom: 1rem;
            letter-spacing: -0.05em;
        }
        .error-icon {
            color: var(--error);
            opacity: 0.15;
            margin-bottom: -40px;
            position: relative;
            z-index: -1;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <i data-lucide="alert-triangle" class="error-icon" style="width: 120px; height: 120px;"></i>
        <div class="error-code">500</div>
        <h3 class="fw-bold mb-3 text-primary">Something went wrong</h3>
        <p class="text-secondary mb-4 pb-2" style="font-size: 1.1rem; line-height: 1.6;">
            We encountered an unexpected server error. Our team has been notified. Please try again later.
        </p>
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary px-4 py-2 fs-6">
            <i data-lucide="arrow-left" style="width: 18px; height: 18px;" class="me-2"></i> Return to Dashboard
        </a>
    </div>

<script>
    lucide.createIcons();
</script>
</body>
</html>
