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

<div class="app-container">
    <jsp:include page="navbar.jsp" />

    <main class="main-content">
        <header class="top-header d-none d-lg-flex">
            <h1 class="header-title">Workouts</h1>
            <div class="header-user">
                <a href="${pageContext.request.contextPath}/user/profile" class="text-secondary" style="text-decoration: none;">
                    <div style="width: 40px; height: 40px; border-radius: 50%; background-color: var(--bg-secondary); display: flex; align-items: center; justify-content: center; color: var(--accent-primary);">
                        <i data-lucide="user"></i>
                    </div>
                </a>
            </div>
        </header>

        <div class="content-wrapper">
            <div class="d-flex flex-column flex-sm-row justify-content-between align-items-sm-center mb-4 gap-3">
                <div>
                    <h2 class="mb-1">Manage Workouts</h2>
                    <p class="text-secondary mb-0">Log new sessions and view your history.</p>
                </div>
                <a href="${pageContext.request.contextPath}/user/export-workouts" class="btn btn-outline-primary shadow-sm"><i data-lucide="download" style="width:16px;height:16px;"></i> Export History</a>
            </div>

            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success d-flex align-items-center gap-2">
                    <i data-lucide="check-circle" style="width:18px;height:18px;"></i>
                    ${sessionScope.successMessage}
                </div>
                <c:remove var="successMessage" scope="session" />
            </c:if>

            <div class="card mb-5">
                <div class="card-header border-bottom-0 pb-0 pt-4">
                    <h5 class="fw-bold mb-0">Log a New Workout</h5>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/user/workouts" method="post">
                        <input type="hidden" name="_csrf" value="${csrfToken}" />
                        <div class="row g-3">
                            <div class="col-md-6 col-lg-3">
                                <label class="form-label">Date</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i data-lucide="calendar" style="width:16px;height:16px;"></i></span>
                                    <input type="date" class="form-control" name="workoutDate" required>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-3">
                                <label class="form-label">Type</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i data-lucide="activity" style="width:16px;height:16px;"></i></span>
                                    <select class="form-select" name="workoutType" required>
                                        <option value="Running">Running</option>
                                        <option value="Cycling">Cycling</option>
                                        <option value="Weightlifting">Weightlifting</option>
                                        <option value="Yoga">Yoga</option>
                                        <option value="Swimming">Swimming</option>
                                        <option value="Other">Other</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4 col-lg-2">
                                <label class="form-label">Intensity</label>
                                <select class="form-select" name="intensity">
                                    <option value="Low">Low</option>
                                    <option value="Medium" selected>Medium</option>
                                    <option value="High">High</option>
                                </select>
                            </div>
                            <div class="col-md-4 col-lg-2">
                                <label class="form-label">Duration</label>
                                <div class="input-group">
                                    <input type="number" class="form-control" name="durationMin" placeholder="0" required>
                                    <span class="input-group-text">min</span>
                                </div>
                            </div>
                            <div class="col-md-4 col-lg-2">
                                <label class="form-label">Calories</label>
                                <div class="input-group">
                                    <input type="number" class="form-control" name="calories" placeholder="0" required>
                                    <span class="input-group-text">kcal</span>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12 mb-3">
                                <label class="form-label">Notes (Optional)</label>
                                <textarea class="form-control" name="notes" rows="2" placeholder="How did it feel?"></textarea>
                            </div>
                        </div>
                        <div class="d-flex justify-content-end mt-2">
                            <button type="submit" class="btn btn-primary px-4">Log Workout</button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="card">
                <div class="card-header border-bottom-0 pb-0 pt-4">
                    <h5 class="fw-bold mb-0">Workout History</h5>
                </div>
                <div class="card-body p-0 mt-3">
                    <c:choose>
                        <c:when test="${empty workouts}">
                            <div class="empty-state m-4">
                                <i data-lucide="dumbbell" class="empty-icon"></i>
                                <h4>No workouts logged yet</h4>
                                <p>Start moving and record your first session today!</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-hover table-responsive-stack mb-0">
                                    <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Type</th>
                                            <th>Intensity</th>
                                            <th>Duration</th>
                                            <th>Calories</th>
                                            <th>Notes</th>
                                            <th class="text-end">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="w" items="${workouts}">
                                            <tr>
                                                <td data-label="Date" class="fw-medium">${w.workoutDate}</td>
                                                <td data-label="Type"><span class="badge bg-secondary text-primary border"><i data-lucide="activity" style="width:10px;height:10px;margin-right:4px;"></i>${w.workoutType}</span></td>
                                                <td data-label="Intensity">
                                                    <span class="badge ${w.intensity eq 'High' ? 'bg-danger' : (w.intensity eq 'Medium' ? 'bg-warning' : 'bg-success')}">${w.intensity}</span>
                                                </td>
                                                <td data-label="Duration">${w.durationMin} min</td>
                                                <td data-label="Calories" class="fw-medium text-primary">${w.calories} kcal</td>
                                                <td data-label="Notes" class="text-secondary small text-truncate" style="max-width: 200px;"><c:out value="${w.notes}"/></td>
                                                <td data-label="Action" class="text-end">
                                                    <form action="${pageContext.request.contextPath}/user/workouts" method="post" style="display:inline;">
                                                        <input type="hidden" name="_csrf" value="${csrfToken}" />
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="id" value="${w.id}">
                                                        <button type="submit" class="btn btn-sm btn-outline-danger py-1 px-2" onclick="return confirm('Are you sure you want to delete this workout?');" title="Delete">
                                                            <i data-lucide="trash-2" style="width:14px;height:14px;"></i>
                                                        </button>
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
            </div>
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
