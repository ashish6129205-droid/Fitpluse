<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>FitPulse - User Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="#">FitPulse</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/user/dashboard">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/user/workouts">My Workouts</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
                </li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user/progress">Progress</a></li><li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user/goals">My Goals</a></li><li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user/challenges">Challenges</a></li></ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h2>Welcome, ${sessionScope.loggedUser.name}!</h2>

    <div class="row mt-4">
        <div class="col-md-12">
            <h4>Recent Workouts</h4>
            <c:choose>
                <c:when test="${empty recentWorkouts}">
                    <p>No recent workouts found. <a href="${pageContext.request.contextPath}/user/workouts">Log one now!</a></p>
                </c:when>
                <c:otherwise>
                    <table class="table table-striped">
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
                                    <td>${w.workoutDate}</td>
                                    <td>${w.workoutType}</td>
                                    <td>${w.durationMin}</td>
                                    <td>${w.calories}</td>
                                    <td>${w.steps}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</body>
</html>
