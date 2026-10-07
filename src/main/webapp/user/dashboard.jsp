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
        <div class="date-badge">
            <jsp:useBean id="now" class="java.util.Date"/>
            <fmt:formatDate value="${now}" pattern="MMM d, yyyy" />
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
            <h4 class="mb-4">Recent Activity</h4>
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
</body>
</html>
