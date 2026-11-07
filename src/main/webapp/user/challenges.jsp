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
    <style>
        .challenge-icon-wrapper {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: rgba(22, 125, 90, 0.1);
            color: var(--accent-primary);
        }
        .challenge-card {
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .challenge-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
        }
    </style>
</head>
<body>

<div class="app-container">
    <jsp:include page="navbar.jsp" />

    <main class="main-content">
        <header class="top-header d-none d-lg-flex">
            <h1 class="header-title">Challenges</h1>
            <div class="header-user">
                <a href="${pageContext.request.contextPath}/user/profile" class="text-secondary" style="text-decoration: none;">
                    <div style="width: 40px; height: 40px; border-radius: 50%; background-color: var(--bg-secondary); display: flex; align-items: center; justify-content: center; color: var(--accent-primary);">
                        <i data-lucide="user"></i>
                    </div>
                </a>
            </div>
        </header>

        <div class="content-wrapper">
            <div class="mb-4">
                <h2 class="mb-1">Available Challenges</h2>
                <p class="text-secondary mb-0">Push your limits and compete with the community.</p>
            </div>

            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success d-flex align-items-center gap-2">
                    <i data-lucide="check-circle" style="width:18px;height:18px;"></i>
                    ${sessionScope.successMessage}
                </div>
                <c:remove var="successMessage" scope="session" />
            </c:if>
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger d-flex align-items-center gap-2">
                    <i data-lucide="alert-circle" style="width:18px;height:18px;"></i>
                    ${sessionScope.errorMessage}
                </div>
                <c:remove var="errorMessage" scope="session" />
            </c:if>

            <div class="row mb-5">
                <c:choose>
                    <c:when test="${empty activeChallenges}">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body py-5">
                                    <div class="empty-state border-0 bg-transparent m-0 py-4">
                                        <i data-lucide="award" class="empty-icon"></i>
                                        <h4>No active challenges</h4>
                                        <p>Check back later or ask an admin to create new fitness challenges.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="c" items="${activeChallenges}">
                            <div class="col-md-6 col-xl-4 mb-4">
                                <div class="card h-100 challenge-card border" style="display: flex; flex-direction: column; height: 100%;">
                                    <div class="card-body d-flex flex-column p-4">
                                        <div class="d-flex justify-content-between align-items-start mb-3">
                                            <div class="challenge-icon-wrapper">
                                                <i data-lucide="zap" style="width: 24px; height: 24px;"></i>
                                            </div>
                                            <span class="badge bg-secondary text-primary border d-flex align-items-center gap-1">
                                                <i data-lucide="users" style="width:12px;height:12px;"></i> ${c.participantCount} joined
                                            </span>
                                        </div>

                                        <h5 class="fw-bold mb-2">${c.title}</h5>
                                        <p class="text-secondary small mb-4 flex-grow-1 line-clamp-3" style="display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden;">${c.description}</p>

                                        <div class="bg-secondary rounded p-3 mb-4">
                                            <div class="d-flex justify-content-between mb-2">
                                                <span class="text-secondary small fw-medium">Target</span>
                                                <span class="text-primary small fw-bold">${c.targetValue} ${c.unit}</span>
                                            </div>
                                            <div class="d-flex justify-content-between">
                                                <span class="text-secondary small fw-medium">Ends</span>
                                                <span class="text-primary small fw-bold">${c.endDate}</span>
                                            </div>
                                        </div>

                                        <c:choose>
                                            <c:when test="${joinedIds.contains(c.id)}">
                                                <button class="btn btn-outline-success w-100 disabled mt-auto" style="opacity: 1; cursor: default;">
                                                    <i data-lucide="check" style="width:16px;height:16px;margin-right:4px;"></i> Joined / Active
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <form action="${pageContext.request.contextPath}/user/challenges" method="post" class="w-100 m-0 mt-auto">
                                                    <input type="hidden" name="_csrf" value="${csrfToken}" />
                                                    <input type="hidden" name="action" value="join">
                                                    <input type="hidden" name="challengeId" value="${c.id}">
                                                    <button type="submit" class="btn btn-primary w-100">Join Challenge</button>
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

            <div class="mb-4">
                <h4 class="fw-bold mb-0">My Challenge History</h4>
            </div>

            <div class="card">
                <div class="card-body p-0">
                    <c:choose>
                        <c:when test="${empty history}">
                            <div class="empty-state border-0 bg-transparent m-4 py-5">
                                <i data-lucide="history" class="empty-icon" style="width:48px;height:48px;opacity:0.3;"></i>
                                <h5>No history yet</h5>
                                <p class="text-secondary">You haven't joined any challenges.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-hover table-responsive-stack mb-0 mt-3">
                                    <thead>
                                        <tr>
                                            <th>Challenge</th>
                                            <th>Joined Date</th>
                                            <th>Progress</th>
                                            <th class="text-end">Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="h" items="${history}">
                                            <tr>
                                                <td data-label="Challenge" class="fw-medium text-primary">${h.challengeTitle}</td>
                                                <td data-label="Joined Date" class="text-secondary">${h.joinedAt}</td>
                                                <td data-label="Progress" class="fw-medium">${h.progressValue}</td>
                                                <td data-label="Status" class="text-end">
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
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
