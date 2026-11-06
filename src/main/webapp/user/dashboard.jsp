<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .badge-workout {
            font-size: 0.7rem;
            padding: 0.4em 0.8em;
            background-color: var(--bg-secondary);
            color: var(--text-primary);
            border: 1px solid var(--border-color);
        }
    </style>
</head>
<body>

<div class="app-container">
    <jsp:include page="navbar.jsp" />

    <main class="main-content">
        <header class="top-header d-none d-lg-flex">
            <h1 class="header-title">Overview</h1>
            <div class="header-user">
                <span class="text-secondary fw-medium">Welcome back, <span class="text-primary fw-bold">${sessionScope.loggedUser.name}</span></span>
                <div style="width: 40px; height: 40px; border-radius: 50%; background-color: var(--bg-secondary); display: flex; align-items: center; justify-content: center; color: var(--accent-primary);">
                    <i data-lucide="user"></i>
                </div>
            </div>
        </header>

        <div class="content-wrapper">
            <!-- Welcome Banner -->
            <div class="card bg-primary mb-4 border-0 shadow-sm" style="background: linear-gradient(135deg, rgba(22, 125, 90, 0.05) 0%, rgba(168, 217, 108, 0.1) 100%);">
                <div class="card-body p-4 d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3">
                    <div>
                        <h2 class="mb-1">Ready to crush your goals?</h2>
                        <p class="text-secondary mb-0">Track your progress, log workouts, and stay consistent.</p>
                    </div>
                    <div class="d-inline-flex align-items-center gap-2 px-3 py-2 bg-card rounded-pill border shadow-sm bg-white">
                        <i data-lucide="calendar" class="text-secondary" style="width:16px;height:16px;"></i>
                        <span class="fw-medium text-primary" style="font-size: 0.9rem;">
                            <%
                                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("EEEE, MMMM d");
                                out.print(sdf.format(new java.util.Date()));
                            %>
                        </span>
                    </div>
                </div>
            </div>

            <!-- Quick Action Bar -->
            <div class="d-flex flex-wrap gap-2 mb-4">
                <a href="${pageContext.request.contextPath}/user/workouts" class="btn btn-primary"><i data-lucide="plus" style="width:18px;height:18px;"></i> Log Workout</a>
                <a href="${pageContext.request.contextPath}/user/progress" class="btn btn-outline-primary"><i data-lucide="trending-up" style="width:18px;height:18px;"></i> Track Progress</a>
                <a href="${pageContext.request.contextPath}/user/challenges" class="btn btn-outline-primary"><i data-lucide="award" style="width:18px;height:18px;"></i> Explore Challenges</a>
            </div>

            <!-- 4 Stat Summary Cards -->
            <div class="row mb-4">
                <div class="col-sm-6 col-xl-3 mb-3 mb-xl-0">
                    <div class="card stat-card primary h-100">
                        <div class="d-flex justify-content-between align-items-start">
                            <div class="stat-icon"><i data-lucide="activity"></i></div>
                            <span class="badge bg-secondary">Total</span>
                        </div>
                        <h3 class="mt-2">${totalWorkouts}</h3>
                        <p>Workouts Logged</p>
                    </div>
                </div>
                <div class="col-sm-6 col-xl-3 mb-3 mb-xl-0">
                    <div class="card stat-card warning h-100">
                        <div class="d-flex justify-content-between align-items-start">
                            <div class="stat-icon"><i data-lucide="flame"></i></div>
                            <span class="badge bg-secondary">Active</span>
                        </div>
                        <h3 class="mt-2">${totalCalories}</h3>
                        <p>Kcal Burned</p>
                    </div>
                </div>
                <div class="col-sm-6 col-xl-3 mb-3 mb-xl-0">
                    <div class="card stat-card success h-100">
                        <div class="d-flex justify-content-between align-items-start">
                            <div class="stat-icon"><i data-lucide="zap"></i></div>
                            <span class="badge bg-secondary">Current</span>
                        </div>
                        <h3 class="mt-2">${currentStreak}</h3>
                        <p>Day Streak</p>
                    </div>
                </div>
                <div class="col-sm-6 col-xl-3">
                    <div class="card stat-card info h-100">
                        <div class="d-flex justify-content-between align-items-start">
                            <div class="stat-icon"><i data-lucide="target"></i></div>
                            <span class="badge bg-secondary">Progress</span>
                        </div>
                        <h3 class="mt-2">${goalCompletionPercent}%</h3>
                        <p>Goal Completion</p>
                    </div>
                </div>
            </div>

            <!-- Analytics Section -->
            <div class="row mb-4">
                <div class="col-xl-8 mb-4 mb-xl-0">
                    <div class="card h-100">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <span>Calorie Burn Trend</span>
                            <i data-lucide="trending-up" class="text-secondary" style="width:18px;height:18px;"></i>
                        </div>
                        <div class="card-body">
                            <div class="chart-container" style="position: relative; height: 300px;">
                                <canvas id="weeklyCalorieChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-4">
                    <div class="card h-100">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <span>Activity Distribution</span>
                            <i class="text-secondary" data-lucide="pie-chart" style="width:18px;height:18px;"></i>
                        </div>
                        <div class="card-body d-flex flex-column justify-content-center">
                            <div class="chart-container" style="position: relative; height: 250px;">
                                <canvas id="workoutDistributionChart"></canvas>
                            </div>
                            <div class="mt-3">
                                <c:choose>
                                    <c:when test="${empty weeklyVolumeMap}">
                                        <p class="text-center text-secondary small mb-0">No data available.</p>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="d-flex flex-wrap justify-content-center gap-2">
                                            <c:forEach var="entry" items="${weeklyVolumeMap}">
                                                <span class="badge badge-workout">${entry.key}: ${entry.value} min</span>
                                            </c:forEach>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Activity Table -->
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center border-bottom-0 pb-0 pt-4">
                    <h5 class="mb-0 fw-bold">Recent Activity</h5>
                    <a href="${pageContext.request.contextPath}/user/export-workouts" class="btn btn-outline-secondary btn-sm"><i data-lucide="download" style="width:14px;height:14px;"></i> Export</a>
                </div>
                <div class="card-body p-0 mt-3">
                    <c:choose>
                        <c:when test="${empty recentWorkouts}">
                            <div class="empty-state m-4">
                                <i data-lucide="clipboard-list" class="empty-icon"></i>
                                <h4>No workouts logged yet</h4>
                                <p>Consistency is key. Get started by logging your first workout!</p>
                                <a href="${pageContext.request.contextPath}/user/workouts" class="btn btn-primary">Log Your First Workout</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-hover table-responsive-stack mb-0">
                                    <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Type</th>
                                            <th>Duration</th>
                                            <th>Calories</th>
                                            <th>Intensity</th>
                                            <th class="text-end">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="w" items="${recentWorkouts}">
                                            <tr>
                                                <td data-label="Date" class="fw-medium">${w.workoutDate}</td>
                                                <td data-label="Type"><span class="badge bg-secondary text-primary border"><i data-lucide="activity" style="width:10px;height:10px;margin-right:4px;"></i>${w.workoutType}</span></td>
                                                <td data-label="Duration">${w.durationMin} min</td>
                                                <td data-label="Calories" class="fw-medium text-primary">${w.calories} kcal</td>
                                                <td data-label="Intensity">
                                                    <c:choose>
                                                        <c:when test="${w.intensity == 'High'}"><span class="badge bg-danger">High</span></c:when>
                                                        <c:when test="${w.intensity == 'Medium'}"><span class="badge bg-warning">Medium</span></c:when>
                                                        <c:when test="${w.intensity == 'Low'}"><span class="badge bg-success">Low</span></c:when>
                                                        <c:otherwise><span class="badge bg-secondary">-</span></c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td data-label="Action" class="text-end">
                                                    <a href="${pageContext.request.contextPath}/user/workouts" class="btn btn-secondary btn-sm py-1 px-2 text-decoration-none">View</a>
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
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Light Theme Chart.js Colors
    const primaryColor = '#167D5A';
    const primaryLight = 'rgba(22, 125, 90, 0.2)';
    const textColor = '#64716B';
    const gridColor = '#E5EBE7';

    // Calorie Trend Line Chart
    const ctx = document.getElementById("weeklyCalorieChart").getContext("2d");
    const labelsStr = "${calLabels}";
    const labels = labelsStr ? labelsStr.split("','") : [];
    const valuesStr = "${calValues}";
    const values = valuesStr ? valuesStr.split(",") : [];

    const gradientFill = ctx.createLinearGradient(0, 0, 0, 300);
    gradientFill.addColorStop(0, primaryLight);
    gradientFill.addColorStop(1, "rgba(22, 125, 90, 0.0)");

    new Chart(ctx, {
        type: "line",
        data: {
            labels: labels,
            datasets: [{
                label: "Calories Burned",
                data: values,
                backgroundColor: gradientFill,
                borderColor: primaryColor,
                borderWidth: 3,
                tension: 0.4,
                fill: true,
                pointBackgroundColor: "#FFFFFF",
                pointBorderColor: primaryColor,
                pointBorderWidth: 2,
                pointRadius: 4,
                pointHoverRadius: 6,
                pointHoverBackgroundColor: primaryColor,
                pointHoverBorderColor: "#FFFFFF"
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            animation: { duration: 1000, easing: 'easeOutQuart' },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: { color: gridColor, drawBorder: false },
                    ticks: { color: textColor, font: { family: "'Inter', sans-serif" } }
                },
                x: {
                    grid: { display: false, drawBorder: false },
                    ticks: { color: textColor, font: { family: "'Inter', sans-serif" } }
                }
            },
            plugins: {
                legend: { display: false },
                tooltip: {
                    backgroundColor: '#17231F',
                    titleColor: '#FFFFFF',
                    bodyColor: '#FFFFFF',
                    padding: 10,
                    cornerRadius: 8,
                    displayColors: false,
                    titleFont: { family: "'Inter', sans-serif", weight: '600' },
                    bodyFont: { family: "'Inter', sans-serif" }
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
                    "#167D5A", // Primary
                    "#A8D96C", // Secondary accent
                    "#D99A32", // Warning
                    "#3578C8", // Info
                    "#64716B"  // Text secondary
                ],
                borderWidth: 2,
                borderColor: "#FFFFFF",
                hoverOffset: 4
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            cutout: '75%',
            plugins: {
                legend: {
                    display: false // We use custom HTML badges for legend
                },
                tooltip: {
                    backgroundColor: '#17231F',
                    padding: 10,
                    cornerRadius: 8,
                    titleFont: { family: "'Inter', sans-serif" },
                    bodyFont: { family: "'Inter', sans-serif" }
                }
            }
        }
    });
</script>
</body>
</html>
