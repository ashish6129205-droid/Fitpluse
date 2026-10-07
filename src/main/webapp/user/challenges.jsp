<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - Challenges</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="container mt-4">
    <h2>Active Challenges</h2>

    <div class="row mt-4">
        <c:choose>
            <c:when test="${empty activeChallenges}">
                <p>No active challenges at the moment.</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="c" items="${activeChallenges}">
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <div class="card-header bg-success text-white">${c.title}</div>
                            <div class="card-body">
                                <p class="card-text">${c.description}</p>
                                <p><strong>Target:</strong> ${c.targetValue} ${c.unit}</p>
                                <p><strong>Ends:</strong> ${c.endDate}</p>
                                <!-- Joining logic is a stretch goal, showing view only for now -->
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
