<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>FitPulse - My Workouts</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="#">FitPulse</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/user/dashboard">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/user/workouts">My Workouts</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
                </li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user/goals">My Goals</a></li><li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user/challenges">Challenges</a></li></ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h2>Manage Workouts</h2>

    <div class="card mt-4 mb-4">
        <div class="card-header">Log a New Workout</div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/user/workouts" method="post">
                <div class="row">
                    <div class="col-md-3 mb-3">
                        <label>Date</label>
                        <input type="date" class="form-control" name="workoutDate" required>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label>Type</label>
                        <select class="form-select" name="workoutType" required>
                            <option value="Running">Running</option>
                            <option value="Cycling">Cycling</option>
                            <option value="Weightlifting">Weightlifting</option>
                            <option value="Yoga">Yoga</option>
                            <option value="Swimming">Swimming</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                    <div class="col-md-2 mb-3">
                        <label>Duration (min)</label>
                        <input type="number" class="form-control" name="durationMin" required>
                    </div>
                    <div class="col-md-2 mb-3">
                        <label>Calories</label>
                        <input type="number" class="form-control" name="calories" required>
                    </div>
                    <div class="col-md-2 mb-3">
                        <label>Steps</label>
                        <input type="number" class="form-control" name="steps">
                    </div>
                </div>
                <div class="mb-3">
                    <label>Notes</label>
                    <textarea class="form-control" name="notes" rows="2"></textarea>
                </div>
                <button type="submit" class="btn btn-success">Log Workout</button>
            </form>
        </div>
    </div>

    <h4>Your Workouts</h4>
    <c:choose>
        <c:when test="${empty workouts}">
            <p>No workouts logged yet.</p>
        </c:when>
        <c:otherwise>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Type</th>
                        <th>Duration</th>
                        <th>Calories</th>
                        <th>Steps</th>
                        <th>Notes</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="w" items="${workouts}">
                        <tr>
                            <td>${w.workoutDate}</td>
                            <td>${w.workoutType}</td>
                            <td>${w.durationMin}</td>
                            <td>${w.calories}</td>
                            <td>${w.steps}</td>
                            <td>${w.notes}</td>
                            <td>
                                <form action="${pageContext.request.contextPath}/user/workouts" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${w.id}">
                                    <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Delete this workout?');">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
