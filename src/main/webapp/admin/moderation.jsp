<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - Content Moderation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="container mt-4">
    <h2>Content Moderation (Workouts)</h2>
    <div class="table-wrapper"><table class="table table-striped table-responsive-stack">
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
    </table></div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
