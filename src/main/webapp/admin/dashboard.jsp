<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">FitPulse</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
                </li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/users">Manage Users</a></li><li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/moderation">Content Moderation</a></li></ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h2>Admin Dashboard</h2>

    <ul class="nav nav-tabs mt-4" id="adminTabs" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="users-tab" data-bs-toggle="tab" data-bs-target="#users" type="button" role="tab" aria-controls="users" aria-selected="true">Users</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="workouts-tab" data-bs-toggle="tab" data-bs-target="#workouts" type="button" role="tab" aria-controls="workouts" aria-selected="false">All Workouts</button>
        </li>
    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/users">Manage Users</a></li><li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/moderation">Content Moderation</a></li></ul>
    <div class="tab-content mt-3" id="adminTabsContent">
        <div class="tab-pane fade show active" id="users" role="tabpanel" aria-labelledby="users-tab">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Joined</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${users}">
                        <tr>
                            <td>${u.id}</td>
                            <td>${u.name}</td>
                            <td>${u.email}</td>
                            <td>${u.role}</td>
                            <td>
                                <span class="badge ${u.active ? 'bg-success' : 'bg-danger'}">${u.active ? 'Active' : 'Inactive'}</span>
                            </td>
                            <td>${u.createdAt}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <div class="tab-pane fade" id="workouts" role="tabpanel" aria-labelledby="workouts-tab">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>User</th>
                        <th>Date</th>
                        <th>Type</th>
                        <th>Duration</th>
                        <th>Calories</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="w" items="${recentWorkouts}">
                        <tr>
                            <td>${w.id}</td>
                            <td>${w.userName}</td>
                            <td>${w.workoutDate}</td>
                            <td>${w.workoutType}</td>
                            <td>${w.durationMin}</td>
                            <td>${w.calories}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
