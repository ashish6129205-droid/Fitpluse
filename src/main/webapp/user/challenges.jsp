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

<div class="container">
    <h2>Available Challenges</h2>

    <c:if test="${not empty sessionScope.successMessage}">
        <div class="alert alert-success mt-3">${sessionScope.successMessage}</div>
        <c:remove var="successMessage" scope="session" />
    </c:if>
    <c:if test="${not empty sessionScope.errorMessage}">
        <div class="alert alert-danger mt-3">${sessionScope.errorMessage}</div>
        <c:remove var="errorMessage" scope="session" />
    </c:if>

    <div class="row mt-4 mb-5">
        <c:choose>
            <c:when test="${empty activeChallenges}">
                <div class="col-12">
                    <div class="empty-state">
                        <div class="empty-icon">🏆</div>
                        <h4>No active challenges right now</h4>
                        <p>Check back later or ask an admin to create new fitness challenges.</p>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="c" items="${activeChallenges}">
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="card h-100">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <span>${c.title}</span>
                                <span class="badge bg-primary">${c.participantCount} Participants</span>
                            </div>
                            <div class="card-body d-flex flex-column">
                                <p class="card-text text-secondary flex-grow-1">${c.description}</p>
                                <hr style="border-color: var(--border-subtle)">
                                <div class="d-flex justify-content-between mb-3 text-secondary" style="font-size: 0.9rem;">
                                    <span><strong>Target:</strong> ${c.targetValue} ${c.unit}</span>
                                    <span><strong>Ends:</strong> ${c.endDate}</span>
                                </div>

                                <c:choose>
                                    <c:when test="${joinedIds.contains(c.id)}">
                                        <div class="d-grid mt-auto">
                                            <button class="btn btn-outline-success" disabled>Joined / Active</button>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <form action="${pageContext.request.contextPath}/user/challenges" method="post" class="mt-auto d-grid">
                                            <input type="hidden" name="action" value="join">
                                            <input type="hidden" name="challengeId" value="${c.id}">
                                            <button type="submit" class="btn btn-primary">Join Challenge</button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <h4>My Challenge History</h4>
    <div class="row mt-3">
        <div class="col-12">
            <c:choose>
                <c:when test="${empty history}">
                    <div class="empty-state" style="padding: 2rem;">
                        <p class="mb-0">You haven't joined any challenges yet.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-wrapper">
                        <table class="table table-striped table-responsive-stack">
                            <thead>
                                <tr>
                                    <th>Challenge</th>
                                    <th>Joined At</th>
                                    <th>Progress</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="h" items="${history}">
                                    <tr>
                                        <td data-label="Challenge">${h.challengeTitle}</td>
                                        <td data-label="Joined At">${h.joinedAt}</td>
                                        <td data-label="Progress">${h.progressValue}</td>
                                        <td data-label="Status">
                                            <span class="badge ${h.completed ? 'bg-success' : 'bg-primary'}">
                                                ${h.completed ? 'Completed' : (h.status != null ? h.status : 'Active')}
                                            </span>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
