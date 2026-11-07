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
                <h3>${activeGoals}</h3>
                <p>Active Goals</p>
            </div>
        </div>
        <div class="col-6 col-lg-3 mb-4">
            <div class="card stat-card primary">
                <h3>${challengesJoined}</h3>
                <p>Challenges</p>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
    <div class="row mb-5">
        <div class="col-12">
            <div class="card p-4" style="position: relative; height: 280px; width: 100%;">
                <h5 class="mb-3">Weekly Calorie Burn & Activity Trends</h5>
                <canvas id="weeklyCalorieChart"></canvas>
            </div>
        </div>
    </div>

            <div class="d-flex justify-content-between align-items-center mb-4 mt-5">
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
                    <div class="table-responsive">
                        <table class="table table-striped table-responsive-stack">
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Activity</th>
                                    <th>Duration</th>
                                    <th>Calories</th>
                                    <th>Steps</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="w" items="${recentWorkouts}">
                                    <tr>
                                        <td data-label="Date">${w.workoutDate}</td>
                                        <td data-label="Activity"><span class="badge bg-primary">${w.workoutType}</span></td>
                                        <td data-label="Duration">${w.durationMin} min</td>
                                        <td data-label="Calories">${w.calories} kcal</td>
                                        <td data-label="Steps">${w.steps != null && w.steps > 0 ? w.steps : '-'}</td>
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
    const ctx = document.getElementById("weeklyCalorieChart").getContext("2d");
    const labelsStr = "${calLabels}";
    const labels = labelsStr ? labelsStr.split("','") : [];
    const valuesStr = "${calValues}";
    const values = valuesStr ? valuesStr.split(",") : [];

    const gradient = ctx.createLinearGradient(0, 0, 0, 400);
    gradient.addColorStop(0, 'rgba(16, 185, 129, 0.5)');
    gradient.addColorStop(1, 'rgba(16, 185, 129, 0.0)');

    new Chart(ctx, {
        type: "line",
        data: {
            labels: labels.length > 0 ? labels : ['No Data'],
            datasets: [{
                label: "Calories Burned",
                data: values.length > 0 ? values : [0],
                backgroundColor: gradient,
                borderColor: "rgba(16, 185, 129, 1)",
                borderWidth: 2,
                fill: true,
                tension: 0.4,
                pointBackgroundColor: "rgba(16, 185, 129, 1)",
                pointBorderColor: "#fff",
                pointHoverBackgroundColor: "#fff",
                pointHoverBorderColor: "rgba(16, 185, 129, 1)"
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    grid: { color: "rgba(255, 255, 255, 0.08)" },
                    ticks: { color: "#9ca3af" }
                },
                x: {
                    grid: { display: false },
                    ticks: { color: "#9ca3af" }
                }
            },
            plugins: {
                legend: { display: false },
                tooltip: {
                    backgroundColor: 'rgba(11, 15, 25, 0.9)',
                    titleColor: '#fff',
                    bodyColor: '#fff',
                    borderColor: 'rgba(16, 185, 129, 0.3)',
                    borderWidth: 1,
                    callbacks: {
                        label: function(context) {
                            return context.parsed.y + ' kcal';
                        }
                    }
                }
            }
        }
    });
</script>
</body>
</html>
