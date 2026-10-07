<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - Progress</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="#">
            <span class="brand-dot"></span> FitPulse
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/user/dashboard">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/user/workouts">My Workouts</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/user/progress">Progress</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/user/goals">My Goals</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/user/challenges">Challenges</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h2>Track Progress</h2>

    <div class="row mt-4">
        <div class="col-md-4">
            <div class="card mb-4">
                <div class="card-header">Log New Measurement</div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/user/progress" method="post">
                        <div class="mb-3">
                            <label>Date</label>
                            <input type="date" class="form-control" name="entryDate" required>
                        </div>
                        <div class="mb-3">
                            <label>Weight (kg)</label>
                            <input type="number" step="0.1" class="form-control" name="weightKg">
                        </div>
                        <div class="mb-3">
                            <label>Waist (cm)</label>
                            <input type="number" step="0.1" class="form-control" name="waistCm">
                        </div>
                        <div class="mb-3">
                            <label>Chest (cm)</label>
                            <input type="number" step="0.1" class="form-control" name="chestCm">
                        </div>
                        <div class="mb-3">
                            <label>Arms (cm)</label>
                            <input type="number" step="0.1" class="form-control" name="armsCm">
                        </div>
                        <button type="submit" class="btn btn-success w-100">Save Progress</button>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-md-8">
            <h4>History</h4>
            <c:choose>
                <c:when test="${empty progressEntries}">
                    <p>No progress logged yet.</p>
                </c:when>
                <c:otherwise>
                    <canvas id="weightChart" width="400" height="200" class="mb-4"></canvas>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Weight (kg)</th>
                                <th>Waist (cm)</th>
                                <th>Chest (cm)</th>
                                <th>Arms (cm)</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${progressEntries}">
                                <tr>
                                    <td>${p.entryDate}</td>
                                    <td>${p.weightKg != null ? p.weightKg : '-'}</td>
                                    <td>${p.waistCm != null ? p.waistCm : '-'}</td>
                                    <td>${p.chestCm != null ? p.chestCm : '-'}</td>
                                    <td>${p.armsCm != null ? p.armsCm : '-'}</td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/user/progress" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${p.id}">
                                            <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Delete this entry?');">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script>
<c:if test="${not empty progressEntries}">
    const ctx = document.getElementById('weightChart').getContext('2d');
    const labels = [
        <c:forEach var="p" items="${progressEntries}" varStatus="status">
            '${p.entryDate}'${!status.last ? ',' : ''}
        </c:forEach>
    ];
    const data = [
        <c:forEach var="p" items="${progressEntries}" varStatus="status">
            ${p.weightKg != null ? p.weightKg : 'null'}${!status.last ? ',' : ''}
        </c:forEach>
    ];

    new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: 'Weight (kg)',
                data: data,
                borderColor: 'rgb(75, 192, 192)',
                tension: 0.1,
                spanGaps: true
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: false
                }
            }
        }
    });
</c:if>
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
