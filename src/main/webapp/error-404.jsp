<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - Page Not Found</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #080c16;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            font-family: var(--font-main);
        }
        .error-card {
            background-color: rgba(22, 30, 49, 0.75);
            backdrop-filter: blur(12px);
            border: 1px solid var(--border-subtle);
            border-radius: 1rem;
            padding: 3rem 2rem;
            text-align: center;
            max-width: 500px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.5);
            color: var(--text-primary);
        }
        .error-code {
            font-size: 5rem;
            font-weight: 700;
            color: var(--accent-cyan);
            margin-bottom: 0.5rem;
            text-shadow: 0 0 15px rgba(6, 182, 212, 0.4);
        }
        .error-message {
            font-size: 1.1rem;
            color: var(--text-secondary);
            margin-bottom: 2rem;
        }
    </style>
</head>
<body>
    <div class="error-card">
        <div class="error-code">404</div>
        <h3 class="mb-3">Page Not Found</h3>
        <p class="error-message">The page you are looking for does not exist or has been moved.</p>
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Return to Safe Zone / Dashboard</a>
    </div>
</body>
</html>
