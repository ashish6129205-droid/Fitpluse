<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - My Workouts</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="container mt-4">
    <h2>Manage Workouts</h2>

    <c:if test="${not empty sessionScope.successMessage}">
        <div class="alert alert-success mt-3">${sessionScope.successMessage}</div>
        <c:remove var="successMessage" scope="session" />
    </c:if>

    <div class="card mt-4 mb-4">
        <div class="card-header">Log a New Workout</div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/user/workouts" method="post">
                <div class="row">
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Date</label>
                        <input type="date" class="form-control" name="workoutDate" required>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Type</label>
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
                        <label class="form-label">Intensity</label>
                        <select class="form-select" name="intensity">
                            <option value="Low">Low</option>
                            <option value="Medium" selected>Medium</option>
                            <option value="High">High</option>
                        </select>
                    </div>
                    <div class="col-md-2 mb-3">
                        <label class="form-label">Duration (min)</label>
                        <input type="number" class="form-control" name="durationMin" required>
                    </div>
                    <div class="col-md-2 mb-3">
                        <label class="form-label">Calories</label>
                        <input type="number" class="form-control" name="calories" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 mb-3">
                        <label class="form-label">Notes</label>
                        <textarea class="form-control" name="notes" rows="2"></textarea>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary">Log Workout</button>
            </form>
        </div>
    </div>

    <h4>Your Workouts</h4>
    <c:choose>
        <c:when test="${empty workouts}">
            <div class="empty-state">
                <div class="empty-icon">👟</div>
                <h4>No workouts logged yet.</h4>
                <p>Start moving and record your first session today!</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="table-wrapper">
                <table class="table table-striped table-responsive-stack">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Type</th>
                            <th>Intensity</th>
                            <th>Duration</th>
                            <th>Calories</th>
                            <th>Notes</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="w" items="${workouts}">
                            <tr>
                                <td data-label="Date">${w.workoutDate}</td>
                                <td data-label="Type"><span class="badge bg-primary">${w.workoutType}</span></td>
                                <td data-label="Intensity"><span class="badge ${w.intensity eq 'High' ? 'bg-danger' : (w.intensity eq 'Medium' ? 'bg-warning' : 'bg-success')}">${w.intensity}</span></td>
                                <td data-label="Duration">${w.durationMin} min</td>
                                <td data-label="Calories">${w.calories} kcal</td>
                                <td data-label="Notes"><c:out value="${w.notes}"/></td>
                                <td data-label="Action">
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
            </div>
        </c:otherwise>
    </c:choose>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
