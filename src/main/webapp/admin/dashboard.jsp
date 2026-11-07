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
<jsp:include page="navbar.jsp" />

<div class="container mt-4">
    <h2>Admin Dashboard</h2>

    <div class="row mt-4">
        <div class="col-md-12">
            <h4 class="mb-3">Live System Activity Logs (Multithreaded)</h4>
            <div class="table-wrapper mb-5">
                <table class="table table-striped table-responsive-stack">
                    <thead>
                        <tr>
                            <th>Timestamp</th>
                            <th>Thread</th>
                            <th>Action</th>
                            <th>User Email</th>
                            <th>Details</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="log" items="${activityLogs}">
                            <tr>
                                <td data-label="Timestamp" class="text-secondary" style="font-size: 0.85rem;">${log.createdAt}</td>
                                <td data-label="Thread"><span class="badge bg-primary">${log.threadName}</span></td>
                                <td data-label="Action"><span class="badge bg-success">${log.action}</span></td>
                                <td data-label="User Email">${log.userEmail}</td>
                                <td data-label="Details" class="text-secondary">${log.details}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <h4 class="mb-3">System Overview</h4>
    <ul class="nav nav-tabs mt-2" id="adminTabs" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active bg-transparent border-0" id="users-tab" data-bs-toggle="tab" data-bs-target="#users" type="button" role="tab" aria-controls="users" aria-selected="true" style="color: var(--accent-emerald);">Users</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link bg-transparent border-0" id="workouts-tab" data-bs-toggle="tab" data-bs-target="#workouts" type="button" role="tab" aria-controls="workouts" aria-selected="false" style="color: var(--text-secondary);">All Workouts</button>
        </li>
    </ul>

    <div class="tab-content mt-3" id="adminTabsContent">
        <div class="tab-pane fade show active" id="users" role="tabpanel" aria-labelledby="users-tab">
            <div class="table-wrapper">
                <table class="table table-striped table-responsive-stack">
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
                                <td data-label="ID">${u.id}</td>
                                <td data-label="Name">${u.name}</td>
                                <td data-label="Email">${u.email}</td>
                                <td data-label="Role">
                                    <span class="badge ${u.role eq 'ADMIN' ? 'bg-success' : 'bg-primary'}">${u.role}</span>
                                </td>
                                <td data-label="Status">
                                    <span class="badge ${u.active ? 'bg-success' : 'bg-danger'}">${u.active ? 'Active' : 'Inactive'}</span>
                                </td>
                                <td data-label="Joined">${u.createdAt}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="tab-pane fade" id="workouts" role="tabpanel" aria-labelledby="workouts-tab">
            <div class="table-wrapper">
                <table class="table table-striped table-responsive-stack">
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
                                <td data-label="ID">${w.id}</td>
                                <td data-label="User">${w.userName}</td>
                                <td data-label="Date">${w.workoutDate}</td>
                                <td data-label="Type">${w.workoutType}</td>
                                <td data-label="Duration">${w.durationMin} min</td>
                                <td data-label="Calories">${w.calories} kcal</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
