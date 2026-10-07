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
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="#">FitPulse</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/user/dashboard">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/user/workouts">My Workouts</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/user/progress">Progress</a>
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
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Welcome back, ${sessionScope.loggedUser.name}!</h2>
        <div class="text-secondary">
            <jsp:useBean id="now" class="java.util.Date"/>
            <fmt:formatDate value="${now}" pattern="EEEE, MMMM d, yyyy" />
        </div>
    </div>

    <!-- Quick Action Bar -->
    <div class="row mb-4">
        <div class="col-12 d-flex gap-2 flex-wrap">
            <a href="${pageContext.request.contextPath}/user/workouts" class="btn btn-primary">+ Log Workout</a>
            <a href="${pageContext.request.contextPath}/user/progress" class="btn btn-outline-light">Track Progress</a>
            <a href="${pageContext.request.contextPath}/user/challenges" class="btn btn-outline-light">Explore Challenges</a>
        </div>
    </div>

    <!-- 4 Stat Summary Cards -->
    <div class="row mb-4">
        <div class="col-6 col-md-3 mb-3">
            <div class="card stat-card h-100">
                <h3>${totalWorkouts}</h3>
                <p>Workouts</p>
            </div>
        </div>
        <div class="col-6 col-md-3 mb-3">
            <div class="card stat-card h-100">
                <h3>${totalCalories}</h3>
                <p>Kcal Burned</p>
            </div>
        </div>
        <div class="col-6 col-md-3 mb-3">
            <div class="card stat-card h-100">
                <h3>${activeGoals}</h3>
                <p>Active Goals</p>
            </div>
        </div>
        <div class="col-6 col-md-3 mb-3">
            <div class="card stat-card h-100">
                <h3>${challengesJoined}</h3>
                <p>Challenges</p>
            </div>
        </div>
    </div>

    <div class="row mt-4">
        <div class="col-md-12">
            <h4 class="mb-3">Recent Workouts</h4>
            <c:choose>
                <c:when test="${empty recentWorkouts}">
                    <div class="empty-state">
                        <h4>No workouts logged yet.</h4>
                        <p>Get started by logging your first workout today!</p>
                        <a href="${pageContext.request.contextPath}/user/workouts" class="btn btn-success">Log Your First Workout</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="table table-striped table-responsive-stack">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Type</th>
                                <th>Duration (min)</th>
                                <th>Calories</th>
                                <th>Steps</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="w" items="${recentWorkouts}">
                                <tr>
                                    <td data-label="Date">${w.workoutDate}</td>
                                    <td data-label="Type"><span class="badge bg-primary">${w.workoutType}</span></td>
                                    <td data-label="Duration">${w.durationMin}</td>
                                    <td data-label="Calories">${w.calories}</td>
                                    <td data-label="Steps">${w.steps}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
