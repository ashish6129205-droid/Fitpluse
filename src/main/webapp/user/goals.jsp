<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - My Goals</title>
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
                    <a class="nav-link" href="${pageContext.request.contextPath}/user/dashboard">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/user/workouts">My Workouts</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/user/goals">My Goals</a>
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
    <h2>My Goals</h2>

    <div class="card mt-4 mb-4">
        <div class="card-header">Set a New Goal</div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/user/goals" method="post">
                <div class="row">
                    <div class="col-md-3 mb-3">
                        <label>Goal Type</label>
                        <input type="text" class="form-control" name="goalType" placeholder="e.g. Lose Weight" required>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label>Target Value</label>
                        <input type="number" step="0.1" class="form-control" name="targetValue" required>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label>Unit</label>
                        <input type="text" class="form-control" name="unit" placeholder="e.g. kg, km">
                    </div>
                    <div class="col-md-3 mb-3">
                        <label>Deadline</label>
                        <input type="date" class="form-control" name="deadline">
                    </div>
                </div>
                <button type="submit" class="btn btn-success">Add Goal</button>
            </form>
        </div>
    </div>

    <h4>Current Goals</h4>
    <c:choose>
        <c:when test="${empty goals}">
            <p>No goals set yet.</p>
        </c:when>
        <c:otherwise>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Type</th>
                        <th>Target</th>
                        <th>Current</th>
                        <th>Deadline</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="g" items="${goals}">
                        <tr>
                            <td>${g.goalType}</td>
                            <td>${g.targetValue} ${g.unit}</td>
                            <td>${g.currentValue} ${g.unit}</td>
                            <td>${g.deadline}</td>
                            <td>
                                <span class="badge ${g.completed ? 'bg-success' : 'bg-warning text-dark'}">${g.completed ? 'Completed' : 'In Progress'}</span>
                            </td>
                            <td>
                                <c:if test="${not g.completed}">
                                    <form action="${pageContext.request.contextPath}/user/goals" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="complete">
                                        <input type="hidden" name="id" value="${g.id}">
                                        <button type="submit" class="btn btn-sm btn-primary">Mark Complete</button>
                                    </form>
                                </c:if>
                                <form action="${pageContext.request.contextPath}/user/goals" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${g.id}">
                                    <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Delete this goal?');">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
