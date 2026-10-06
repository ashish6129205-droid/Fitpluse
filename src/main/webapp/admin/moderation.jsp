<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>FitPulse - Content Moderation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">FitPulse Admin</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">Manage Users</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/moderation">Content Moderation</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h2>Content Moderation (Workouts)</h2>
    <table class="table table-bordered mt-4">
        <thead>
            <tr>
                <th>ID</th>
                <th>User</th>
                <th>Date</th>
                <th>Type</th>
                <th>Notes</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="w" items="${workouts}">
                <tr>
                    <td>${w.id}</td>
                    <td>${w.userName}</td>
                    <td>${w.workoutDate}</td>
                    <td>${w.workoutType}</td>
                    <td>${w.notes}</td>
                    <td>
                        <span class="badge ${w.status eq 'APPROVED' ? 'bg-success' : (w.status eq 'REJECTED' ? 'bg-danger' : 'bg-warning')}">${w.status}</span>
                    </td>
                    <td>
                        <form action="${pageContext.request.contextPath}/admin/moderation" method="post" style="display:inline;">
                            <input type="hidden" name="workoutId" value="${w.id}">
                            <input type="hidden" name="status" value="APPROVED">
                            <button type="submit" class="btn btn-sm btn-success" ${w.status eq 'APPROVED' ? 'disabled' : ''}>Approve</button>
                        </form>
                        <form action="${pageContext.request.contextPath}/admin/moderation" method="post" style="display:inline;">
                            <input type="hidden" name="workoutId" value="${w.id}">
                            <input type="hidden" name="status" value="REJECTED">
                            <button type="submit" class="btn btn-sm btn-danger" ${w.status eq 'REJECTED' ? 'disabled' : ''}>Reject</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
