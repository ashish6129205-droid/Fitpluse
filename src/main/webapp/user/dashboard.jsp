<!-- UI Theme: Dark Glassmorphism & Dynamic Chart.js Analytics -->
<!-- Designed by: Aayush Kumar Jha (Reg No: 25SCSE1180796) -->
```[span_15](start_span)[span_15](end_span)
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - User Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #0f172a;
            color: #94a3b8;
        }
        h1, h2, h3, h4, h5, h6, .welcome-banner h2 {
            color: #ffffff !important;
        }
        .stat-card {
            background: rgba(255,255,255,0.02);
            border: 1px solid rgba(255,255,255,0.05);
            padding: 1.5rem;
            border-radius: 0.5rem;
        }
        .stat-card h3 {
            font-size: 2rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 0.5rem;
        }
        .stat-card p {
            color: #94a3b8;
            font-size: 0.85rem;
            text-transform: uppercase;
            margin-bottom: 0;
        }
        .stat-card.emerald { border-top: 4px solid #10b981; }
        .stat-card.cyan { border-top: 4px solid #0284c7; }
        .stat-card.amber { border-top: 4px solid #f59e0b; }
        .stat-card.primary { border-top: 4px solid #6366f1; }

        .btn-primary {
            background-color: #10b981;
            color: #ffffff;
            font-weight: bold;
            border: none;
            padding: 0.75rem 1.5rem;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #059669;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
        }
        .chart-container {
            height: 300px;
            max-height: 320px;
        }
    </style>
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="container">
    <div class="welcome-banner">
        <div>
            <h2>Welcome back, ${sessionScope.loggedUser.name}!</h2>
            <div class="welcome-subtitle">Let's crush your fitness goals today.</div>
        </div>
        <div class="date-badge me-2" style="background: rgba(245,158,11,0.1); color: var(--accent-amber); border-color: rgba(245,158,11,0.2);">🔥 ${currentStreak} Day Streak</div>
        <div class="date-badge">
            <jsp:useBean id="now" class="java.util.Date"/>
            <fmt:formatDate value="${now}" pattern="MMM d, yyyy" />
        </div>
    </div>

    <div class="row mb-4">
        <div class="col-12">
            <div class="card p-3 mb-0" style="background: rgba(255,255,255,0.02);">
                <h6 class="text-secondary mb-2">Weekly Volume (Last 7 Days)</h6>
                <div class="d-flex gap-2 flex-wrap">
                    <c:choose>
                        <c:when test="${empty weeklyVolumeMap}">
                            <span class="badge bg-secondary">No recent activity</span>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="entry" items="${weeklyVolumeMap}">
                                <span class="badge" style="background: var(--accent-cyan); color: #fff;">${entry.key}: ${entry.value} min</span>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Action Bar -->
    <div class="row mb-5">
        <div class="col-12 d-flex gap-3 flex-wrap">
            <a href="${pageContext.request.contextPath}/user/workouts" class="btn btn-primary">+ Log Workout</a>
            <a href="${pageContext.request.contextPath}/user/progress" class="btn btn-outline-light">Track Progress</a>
            <a href="${pageContext.request.contextPath}/user/challenges" class="btn btn-outline-light">Explore Challenges</a>
        </div>
    </div>

    <!-- 4 Stat Summary Cards -->
    <div class="row mb-5">
        <div class="col-6 col-lg-3 mb-4">
            <div class="card stat-card emerald">
                <h3>${totalWorkouts}</h3>
                <p>Workouts</p>
            </div>
        </div>
        <div class="col-6 col-lg-3 mb-4">
            <div class="card stat-card cyan">
                <h3>${totalCalories}</h3>
                <p>Kcal Burned</p>
            </div>
        </div>
        <div class="col-6 col-lg-3 mb-4">
            <div class="card stat-card amber">
                <h3>${currentStreak}</h3>
                <p>Active Streak 🔥</p>
            </div>
        </div>
        <div class="col-6 col-lg-3 mb-4">
            <div class="card stat-card primary">
                <h3>${goalCompletionPercent}%</h3>
                <p>Goal Completion</p>
            </div>
        </div>
    </div>

    <!-- Dual Interactive Chart.js Section -->
    <div class="row mb-5">
        <div class="col-12">
            <div class="card p-4">
                <h4 class="mb-4">Weekly Analytics</h4>
                <div class="row">
                    <div class="col-lg-8 mb-4 mb-lg-0">
                        <h5 class="mb-3">Calorie Burn Trend</h5>
                        <div class="chart-container" style="position: relative;">
                            <canvas id="weeklyCalorieChart"></canvas>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <h5 class="mb-3 text-center">Workout Distribution</h5>
                        <div class="chart-container" style="position: relative;">
                            <canvas id="workoutDistributionChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4>Recent Activity</h4>
                <a href="${pageContext.request.contextPath}/user/export-workouts" class="btn btn-outline-light btn-sm">Export to CSV</a>
            </div>
            <c:choose>
                <c:when test="${empty recentWorkouts}">
                    <div class="empty-state">
                        <div class="empty-icon">⚡</div>
                        <h4>No workouts logged yet</h4>
                        <p>Consistency is key. Get started by logging your first workout!</p>
                        <a href="${pageContext.request.contextPath}/user/workouts" class="btn btn-primary">+ Log Your First Workout</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-wrapper">
                        <table class="table table-striped table-responsive-stack">
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Type</th>
                                    <th>Duration</th>
                                    <th>Calories</th>
                                    <th>Intensity</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="w" items="${recentWorkouts}">
                                    <tr>
                                        <td data-label="Date">${w.workoutDate}</td>
                                        <td data-label="Type"><span class="badge bg-primary">${w.workoutType}</span></td>
                                        <td data-label="Duration">${w.durationMin} min</td>
                                        <td data-label="Calories">${w.calories} kcal</td>
                                        <td data-label="Intensity">
                                            <c:choose>
                                                <c:when test="${w.intensity == 'High'}"><span class="badge bg-danger">High</span></c:when>
                                                <c:when test="${w.intensity == 'Medium'}"><span class="badge" style="background:#f59e0b; color:#fff;">Medium</span></c:when>
                                                <c:when test="${w.intensity == 'Low'}"><span class="badge bg-success">Low</span></c:when>
                                                <c:otherwise><span class="badge bg-secondary">-</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td data-label="Action">
                                            <a href="${pageContext.request.contextPath}/user/workouts" class="btn btn-outline-light btn-sm px-2 py-1" style="font-size:0.75rem;">View</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Calorie Trend Line Chart
    const ctx = document.getElementById("weeklyCalorieChart").getContext("2d");
    const labelsStr = "${calLabels}";
    const labels = labelsStr ? labelsStr.split("','") : [];
    const valuesStr = "${calValues}";
    const values = valuesStr ? valuesStr.split(",") : [];

    // Create gradient fill
    const gradientFill = ctx.createLinearGradient(0, 0, 0, 300);
    gradientFill.addColorStop(0, "rgba(16, 185, 129, 0.4)");
    gradientFill.addColorStop(1, "rgba(16, 185, 129, 0.0)");

    new Chart(ctx, {
        type: "line",
        data: {
            labels: labels,
            datasets: [{
                label: "Calories Burned",
                data: values,
                backgroundColor: gradientFill,
                borderColor: "#10b981",
                borderWidth: 3,
                tension: 0.4, // Cubic curve
                fill: true,
                pointBackgroundColor: "#0a0f1d",
                pointBorderColor: "#10b981",
                pointBorderWidth: 2,
                pointRadius: 4,
                pointHoverRadius: 8,
                pointHoverBorderWidth: 3,
                pointHoverBackgroundColor: "#10b981",
                pointHoverBorderColor: "#ffffff"
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            animation: {
                duration: 1500,
                easing: 'easeOutQuart'
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: { color: "rgba(255, 255, 255, 0.05)" },
                    ticks: { color: "#94a3b8" }
                },
                x: {
                    grid: { display: false },
                    ticks: { color: "#94a3b8" }
                }
            },
            plugins: {
                legend: { display: false },
                tooltip: {
                    backgroundColor: 'rgba(15, 23, 42, 0.9)',
                    titleColor: '#f8fafc',
                    bodyColor: '#f8fafc',
                    borderColor: 'rgba(255, 255, 255, 0.1)',
                    borderWidth: 1
                }
            }
        }
    });

    // Workout Distribution Doughnut Chart
    const distCtx = document.getElementById("workoutDistributionChart").getContext("2d");
    const distLabelsStr = "${distLabels}";
    const distLabels = distLabelsStr ? distLabelsStr.split("','") : [];
    const distValuesStr = "${distValues}";
    const distValues = distValuesStr ? distValuesStr.split(",") : [];

    new Chart(distCtx, {
        type: "doughnut",
        data: {
            labels: distLabels,
            datasets: [{
                data: distValues,
                backgroundColor: [
                    "#10b981", // Emerald - Running
                    "#6366f1", // Indigo - Strength
                    "#f59e0b", // Amber - HIIT
                    "#06b6d4", // Cyan - Cycling
                    "#64748b"  // Slate - Other
                ],
                borderWidth: 0,
                hoverOffset: 4
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            cutout: '70%',
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        color: '#94a3b8',
                        padding: 15,
                        font: { size: 11 }
                    }
                },
                tooltip: {
                    backgroundColor: 'rgba(15, 23, 42, 0.9)'
                }
            }
        }
    });
</script>
</body>
</html>
