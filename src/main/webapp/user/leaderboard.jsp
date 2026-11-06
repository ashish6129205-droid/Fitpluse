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
        .podium-container {
            display: flex;
            align-items: flex-end;
            justify-content: center;
            gap: 1rem;
            margin: 3rem 0;
            min-height: 250px;
        }
        .podium-card {
            text-align: center;
            padding: 1.5rem;
            border-radius: 1rem 1rem 0 0;
            box-shadow: var(--shadow-md);
            position: relative;
            width: 100%;
            max-width: 220px;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
        }
        .podium-card .avatar {
            width: 64px;
            height: 64px;
            border-radius: 50%;
            background-color: var(--bg-card);
            margin: 0 auto 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            font-weight: 700;
            box-shadow: var(--shadow-sm);
            position: absolute;
            top: -32px;
            left: 50%;
            transform: translateX(-50%);
        }

        /* Gold (1st) */
        .podium-gold {
            background: linear-gradient(180deg, #FDE68A 0%, #F59E0B 100%);
            height: 220px;
            border: 1px solid #FCD34D;
            z-index: 3;
            color: #78350F;
        }
        .podium-gold .avatar { color: #D97706; border: 3px solid #F59E0B; }
        .podium-gold .rank { color: #92400E; }

        /* Silver (2nd) */
        .podium-silver {
            background: linear-gradient(180deg, #E2E8F0 0%, #94A3B8 100%);
            height: 170px;
            border: 1px solid #CBD5E1;
            z-index: 2;
            color: #1E293B;
        }
        .podium-silver .avatar { color: #64748B; border: 3px solid #94A3B8; }
        .podium-silver .rank { color: #334155; }

        /* Bronze (3rd) */
        .podium-bronze {
            background: linear-gradient(180deg, #FDBA74 0%, #D97706 100%);
            height: 140px;
            border: 1px solid #F97316;
            z-index: 1;
            color: #7C2D12;
        }
        .podium-bronze .avatar { color: #B45309; border: 3px solid #D97706; }
        .podium-bronze .rank { color: #7C2D12; }

        .rank-number {
            font-size: 3rem;
            font-weight: 800;
            opacity: 0.3;
            line-height: 1;
            margin-bottom: 0.5rem;
            font-family: var(--font-heading);
        }

        .user-highlight {
            background-color: rgba(22, 125, 90, 0.05) !important;
            position: relative;
        }
        .user-highlight td {
            font-weight: 600;
        }
        .user-highlight::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 4px;
            background-color: var(--accent-primary);
        }

        @media (max-width: 767.98px) {
            .podium-container {
                align-items: center;
                flex-direction: column;
                gap: 3rem;
                margin: 4rem 0 2rem;
            }
            .podium-card {
                border-radius: 1rem;
                height: auto !important;
                padding-top: 3rem;
            }
            /* Change visual order for mobile to 1, 2, 3 instead of 2, 1, 3 */
            .col-gold { order: 1; }
            .col-silver { order: 2; }
            .col-bronze { order: 3; }
        }
    </style>
</head>
<body>

<div class="app-container">
    <jsp:include page="navbar.jsp" />

    <main class="main-content">
        <header class="top-header d-none d-lg-flex">
            <h1 class="header-title">Leaderboard</h1>
            <div class="header-user">
                <a href="${pageContext.request.contextPath}/user/profile" class="text-secondary" style="text-decoration: none;">
                    <div style="width: 40px; height: 40px; border-radius: 50%; background-color: var(--bg-secondary); display: flex; align-items: center; justify-content: center; color: var(--accent-primary);">
                        <i data-lucide="user"></i>
                    </div>
                </a>
            </div>
        </header>

        <div class="content-wrapper">
            <div class="mb-4 text-center text-lg-start">
                <h2 class="mb-1">Global Rankings</h2>
                <p class="text-secondary mb-0">Compete, climb the ranks, and crush your goals.</p>
            </div>

            <c:choose>
                <c:when test="${empty leaderboard}">
                    <div class="card">
                        <div class="card-body py-5">
                            <div class="empty-state border-0 bg-transparent m-0 py-4">
                                <i data-lucide="trophy" class="empty-icon text-warning opacity-50"></i>
                                <h4>No data yet</h4>
                                <p>Be the first to log a workout and take the #1 spot!</p>
                                <a href="${pageContext.request.contextPath}/user/workouts" class="btn btn-primary mt-2">Log a Workout</a>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Elegant Podium -->
                    <div class="row podium-container mx-0">
                        <!-- Rank 2 (Silver) -->
                        <c:if test="${leaderboard.size() >= 2}">
                            <div class="col-12 col-md-4 d-flex justify-content-center px-2 col-silver">
                                <div class="podium-card podium-silver">
                                    <div class="avatar"><c:out value="${leaderboard.get(1).userName.substring(0,1).toUpperCase()}" /></div>
                                    <div class="rank-number rank">2</div>
                                    <h5 class="fw-bold mb-1 text-truncate px-2"><c:out value="${leaderboard.get(1).userName}" /></h5>
                                    <div class="fw-bold fs-5 mb-1"><c:out value="${leaderboard.get(1).totalCalories}" /> <span class="small fw-medium">kcal</span></div>
                                </div>
                            </div>
                        </c:if>

                        <!-- Rank 1 (Gold) -->
                        <c:if test="${leaderboard.size() >= 1}">
                            <div class="col-12 col-md-4 d-flex justify-content-center px-2 col-gold">
                                <div class="podium-card podium-gold shadow-lg">
                                    <div class="avatar"><c:out value="${leaderboard.get(0).userName.substring(0,1).toUpperCase()}" /></div>
                                    <div class="rank-number rank">1</div>
                                    <h4 class="fw-bold mb-1 text-truncate px-2"><c:out value="${leaderboard.get(0).userName}" /></h4>
                                    <div class="fw-bold fs-4 mb-1"><c:out value="${leaderboard.get(0).totalCalories}" /> <span class="fs-6 fw-medium">kcal</span></div>
                                    <div class="small fw-medium opacity-75"><c:out value="${leaderboard.get(0).workoutCount}" /> workouts</div>
                                </div>
                            </div>
                        </c:if>

                        <!-- Rank 3 (Bronze) -->
                        <c:if test="${leaderboard.size() >= 3}">
                            <div class="col-12 col-md-4 d-flex justify-content-center px-2 col-bronze">
                                <div class="podium-card podium-bronze">
                                    <div class="avatar"><c:out value="${leaderboard.get(2).userName.substring(0,1).toUpperCase()}" /></div>
                                    <div class="rank-number rank">3</div>
                                    <h5 class="fw-bold mb-1 text-truncate px-2"><c:out value="${leaderboard.get(2).userName}" /></h5>
                                    <div class="fw-bold fs-5 mb-1"><c:out value="${leaderboard.get(2).totalCalories}" /> <span class="small fw-medium">kcal</span></div>
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <!-- Ranking Table -->
                    <div class="card mt-2">
                        <div class="card-header border-bottom-0 pb-0 pt-4">
                            <h5 class="fw-bold mb-0">Full Leaderboard</h5>
                        </div>
                        <div class="card-body p-0 mt-3">
                            <div class="table-responsive">
                                <table class="table table-hover table-responsive-stack mb-0">
                                    <thead>
                                        <tr>
                                            <th style="width: 80px;">Rank</th>
                                            <th>Athlete</th>
                                            <th>Total Calories Burned</th>
                                            <th class="text-end">Workouts Logged</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="u" items="${leaderboard}" varStatus="status">
                                            <c:set var="isCurrentUser" value="${u.userId == sessionScope.loggedUser.id}" />
                                            <tr class="${isCurrentUser ? 'user-highlight' : ''}">
                                                <td data-label="Rank" class="fw-bold text-secondary">
                                                    <c:choose>
                                                        <c:when test="${status.index == 0}"><span class="badge" style="background-color:#F59E0B;color:#fff;">#1</span></c:when>
                                                        <c:when test="${status.index == 1}"><span class="badge" style="background-color:#94A3B8;color:#fff;">#2</span></c:when>
                                                        <c:when test="${status.index == 2}"><span class="badge" style="background-color:#D97706;color:#fff;">#3</span></c:when>
                                                        <c:otherwise>#${status.index + 1}</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td data-label="Athlete" class="text-primary">
                                                    <div class="d-flex align-items-center gap-2">
                                                        <div style="width:24px;height:24px;border-radius:50%;background:var(--bg-secondary);display:flex;align-items:center;justify-content:center;font-size:0.7rem;font-weight:bold;color:var(--text-secondary);">
                                                            <c:out value="${u.userName.substring(0,1).toUpperCase()}" />
                                                        </div>
                                                        <c:out value="${u.userName}" />
                                                        <c:if test="${isCurrentUser}"><span class="badge bg-success ms-1 px-2 py-1" style="font-size:0.65rem;">You</span></c:if>
                                                    </div>
                                                </td>
                                                <td data-label="Total Calories Burned" class="fw-medium text-primary"><c:out value="${u.totalCalories}" /> kcal</td>
                                                <td data-label="Workouts Logged" class="text-end text-secondary"><c:out value="${u.workoutCount}" /></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
