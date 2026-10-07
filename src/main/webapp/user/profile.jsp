<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - User Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="container mt-4">
    <h2>My Profile</h2>

    <c:if test="${not empty sessionScope.successMessage}">
        <div class="alert alert-success mt-3">${sessionScope.successMessage}</div>
        <c:remove var="successMessage" scope="session" />
    </c:if>

    <div class="card mt-4">
        <div class="card-header">Update Profile Details</div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/user/profile" method="post">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Name</label>
                        <input type="text" class="form-control" name="name" value="${sessionScope.loggedUser.name}" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Email (Read Only)</label>
                        <input type="email" class="form-control text-muted" value="${sessionScope.loggedUser.email}" readonly>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Age</label>
                        <input type="number" class="form-control" name="age" value="${sessionScope.loggedUser.age}">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Height (cm)</label>
                        <input type="number" step="0.1" class="form-control" name="heightCm" value="${sessionScope.loggedUser.heightCm}">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Weight (kg)</label>
                        <input type="number" step="0.1" class="form-control" name="weightKg" value="${sessionScope.loggedUser.weightKg}">
                    </div>
                </div>
                <div class="mb-4">
                    <label class="form-label">Fitness Goal</label>
                    <textarea class="form-control" name="fitnessGoal" rows="2">${sessionScope.loggedUser.fitnessGoal}</textarea>
                </div>
                <button type="submit" class="btn btn-primary">Save Profile</button>
            </form>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
