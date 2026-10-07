<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - Leaderboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .podium-card { text-align: center; padding: 2rem; border-radius: 1rem; color: #fff; box-shadow: 0 8px 32px rgba(0,0,0,0.4); margin-bottom: 2rem; }
        .gold { background: linear-gradient(135deg, #fbbf24, #d97706); transform: scale(1.1); z-index: 10; border: 2px solid #fde68a;}
        .silver { background: linear-gradient(135deg, #94a3b8, #475569); border: 2px solid #cbd5e1; }
        .bronze { background: linear-gradient(135deg, #d97706, #92400e); border: 2px solid #fcd34d; }
        .rank-circle { width: 50px; height: 50px; border-radius: 50%; background: rgba(255,255,255,0.2); display: flex; align-items: center; justify-content: center; font-size: 1.5rem; font-weight: bold; margin: 0 auto 1rem; }
        .user-highlight { background-color: rgba(16, 185, 129, 0.2) !important; font-weight: bold; border-left: 4px solid var(--accent-emerald); }
    </style>
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="container">
    <div class="welcome-banner mb-4">
        <div>
            <h2>Global Leaderboard</h2>
            <div class="welcome-subtitle">Compete, climb the ranks, and crush your goals.</div>
        </div>
    </div>

    <c:choose>
        <c:when test="${empty leaderboard}">
            <div class="empty-state">
                <div class="empty-icon">🏆</div>
                <h4>No data yet</h4>
                <p>Be the first to log a workout and take the #1 spot!</p>
            </div>
        </c:when>
        <c:otherwise>
            <!-- Podium -->
            <div class="row d-flex align-items-end justify-content-center mb-5 mt-4">
                <!-- Rank 2 (Silver) -->
                <c:if test="${leaderboard.size() >= 2}">
                    <div class="col-4 col-md-3">
                        <div class="podium-card silver">
                            <div class="rank-circle">2</div>
                            <h5 class="text-truncate">${leaderboard.get(1).userName}</h5>
                            <div class="fw-bold">${leaderboard.get(1).totalCalories} kcal</div>
                        </div>
                    </div>
                </c:if>

                <!-- Rank 1 (Gold) -->
                <c:if test="${leaderboard.size() >= 1}">
                    <div class="col-4 col-md-4">
                        <div class="podium-card gold">
                            <div class="rank-circle">1</div>
                            <h4 class="text-truncate">${leaderboard.get(0).userName}</h4>
                            <div class="fw-bold fs-5">${leaderboard.get(0).totalCalories} kcal</div>
                            <div class="small">${leaderboard.get(0).completedChallenges} Challenges</div>
                        </div>
                    </div>
                </c:if>

                <!-- Rank 3 (Bronze) -->
                <c:if test="${leaderboard.size() >= 3}">
                    <div class="col-4 col-md-3">
                        <div class="podium-card bronze">
                            <div class="rank-circle">3</div>
                            <h5 class="text-truncate">${leaderboard.get(2).userName}</h5>
                            <div class="fw-bold">${leaderboard.get(2).totalCalories} kcal</div>
                        </div>
                    </div>
                </c:if>
            </div>

            <!-- Rest of the ranking -->
            <div class="table-wrapper">
                <table class="table table-responsive-stack">
                    <thead>
                        <tr>
                            <th>Rank</th>
                            <th>Athlete</th>
                            <th>Total Calories Burned</th>
                            <th>Challenges Completed</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${leaderboard}" varStatus="status">
                            <c:set var="isCurrentUser" value="${u.userId == sessionScope.loggedUser.id}" />
                            <tr class="${isCurrentUser ? 'user-highlight' : ''}">
                                <td data-label="Rank" class="fw-bold text-secondary">#${status.index + 1}</td>
                                <td data-label="Athlete">${u.userName} ${isCurrentUser ? '<span class="badge bg-success ms-2">You</span>' : ''}</td>
                                <td data-label="Total Calories Burned" class="text-info">${u.totalCalories} kcal</td>
                                <td data-label="Challenges Completed">${u.completedChallenges}</td>
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
