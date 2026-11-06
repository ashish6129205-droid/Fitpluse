<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - My Goals</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .goal-progress {
            height: 8px;
            background-color: var(--bg-secondary);
            border-radius: 9999px;
            overflow: hidden;
            margin-top: 0.5rem;
            margin-bottom: 0.5rem;
        }
        .goal-progress-bar {
            height: 100%;
            background-color: var(--accent-primary);
            border-radius: 9999px;
            transition: width 1s ease-in-out;
        }
        .goal-progress-bar.completed {
            background-color: var(--success);
        }
    </style>
</head>
<body>

<div class="app-container">
    <jsp:include page="navbar.jsp" />

    <main class="main-content">
        <header class="top-header d-none d-lg-flex">
            <h1 class="header-title">Goals</h1>
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
                    <h2 class="mb-1">My Goals</h2>
                    <p class="text-secondary mb-0">Set targets and track your achievements.</p>
                </div>
                <button type="button" class="btn btn-primary shadow-sm" data-bs-toggle="modal" data-bs-target="#newGoalModal">
                    <i data-lucide="plus" style="width:18px;height:18px;"></i> New Goal
                </button>
            </div>

            <!-- Goal Statistics Summary (Optional Enhancement based on data) -->
            <c:if test="${not empty goals}">
                <c:set var="totalGoals" value="${0}" />
                <c:set var="completedGoals" value="${0}" />
                <c:forEach var="g" items="${goals}">
                    <c:set var="totalGoals" value="${totalGoals + 1}" />
                    <c:if test="${g.completed}"><c:set var="completedGoals" value="${completedGoals + 1}" /></c:if>
                </c:forEach>

                <div class="row mb-4">
                    <div class="col-md-6 mb-3 mb-md-0">
                        <div class="card bg-primary h-100 border-0 shadow-sm" style="background: linear-gradient(135deg, rgba(22, 125, 90, 0.05) 0%, rgba(168, 217, 108, 0.1) 100%);">
                            <div class="card-body p-4 d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="text-primary fw-bold mb-1">Active Targets</h5>
                                    <h2 class="mb-0">${totalGoals - completedGoals}</h2>
                                </div>
                                <div style="width: 50px; height: 50px; border-radius: 50%; background-color: rgba(255,255,255,0.8); display: flex; align-items: center; justify-content: center; color: var(--accent-primary);">
                                    <i data-lucide="target" style="width: 24px; height: 24px;"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card bg-success h-100 border-0 shadow-sm" style="background: linear-gradient(135deg, rgba(22, 134, 83, 0.05) 0%, rgba(168, 217, 108, 0.1) 100%);">
                            <div class="card-body p-4 d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="text-success fw-bold mb-1">Completed</h5>
                                    <h2 class="mb-0">${completedGoals}</h2>
                                </div>
                                <div style="width: 50px; height: 50px; border-radius: 50%; background-color: rgba(255,255,255,0.8); display: flex; align-items: center; justify-content: center; color: var(--success);">
                                    <i data-lucide="award" style="width: 24px; height: 24px;"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <c:choose>
                <c:when test="${empty goals}">
                    <div class="card">
                        <div class="card-body d-flex align-items-center justify-content-center">
                            <div class="empty-state border-0 bg-transparent w-100 py-5 m-0">
                                <i data-lucide="target" class="empty-icon"></i>
                                <h4>No goals set yet</h4>
                                <p>Set a target to stay focused and motivated on your fitness journey.</p>
                                <button type="button" class="btn btn-primary mt-2" data-bs-toggle="modal" data-bs-target="#newGoalModal">
                                    Create Your First Goal
                                </button>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row">
                        <c:forEach var="g" items="${goals}">
                            <div class="col-md-6 col-xl-4 mb-4">
                                <div class="card h-100 ${g.completed ? 'border-success' : ''}" style="${g.completed ? 'background-color: rgba(22, 134, 83, 0.02);' : ''}">
                                    <div class="card-header border-bottom-0 pb-0 pt-4 d-flex justify-content-between align-items-start bg-transparent">
                                        <h5 class="fw-bold mb-0 text-truncate pe-2" title="${g.goalType}">${g.goalType}</h5>
                                        <span class="badge ${g.completed ? 'bg-success' : 'bg-primary'}">${g.completed ? 'Completed' : 'Active'}</span>
                                    </div>
                                    <div class="card-body d-flex flex-column">

                                        <c:set var="percent" value="${(g.currentValue / g.targetValue) * 100}" />
                                        <c:if test="${percent > 100}"><c:set var="percent" value="100" /></c:if>
                                        <c:if test="${g.targetValue < g.currentValue}"> <!-- E.g. Weight loss -->
                                             <c:set var="percent" value="${(1 - ((g.currentValue - g.targetValue) / g.currentValue)) * 100}" />
                                             <c:if test="${percent < 0}"><c:set var="percent" value="0" /></c:if>
                                        </c:if>

                                        <div class="mb-3">
                                            <div class="d-flex justify-content-between text-secondary small fw-medium mb-1">
                                                <span>Progress</span>
                                                <span><fmt:formatNumber value="${percent}" maxFractionDigits="0"/>%</span>
                                            </div>
                                            <div class="goal-progress">
                                                <div class="goal-progress-bar ${g.completed ? 'completed' : ''}" style="width: ${percent}%;"></div>
                                            </div>
                                            <div class="d-flex justify-content-between text-secondary small mt-1">
                                                <span>${g.currentValue} ${g.unit}</span>
                                                <span>${g.targetValue} ${g.unit}</span>
                                            </div>
                                        </div>

                                        <div class="mt-auto d-flex justify-content-between align-items-center pt-3 border-top">
                                            <div class="text-secondary small d-flex align-items-center gap-1">
                                                <i data-lucide="clock" style="width:14px;height:14px;"></i>
                                                <c:choose>
                                                    <c:when test="${not empty g.deadline}">
                                                        Due ${g.deadline}
                                                    </c:when>
                                                    <c:otherwise>
                                                        No deadline
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <div class="d-flex gap-2">
                                                <c:if test="${not g.completed}">
                                                    <form action="${pageContext.request.contextPath}/user/goals" method="post" class="m-0">
                                                        <input type="hidden" name="_csrf" value="${csrfToken}" />
                                                        <input type="hidden" name="action" value="complete">
                                                        <input type="hidden" name="id" value="${g.id}">
                                                        <button type="submit" class="btn btn-sm btn-outline-success py-1 px-2" title="Mark Complete">
                                                            <i data-lucide="check" style="width:16px;height:16px;"></i>
                                                        </button>
                                                    </form>
                                                </c:if>
                                                <form action="${pageContext.request.contextPath}/user/goals" method="post" class="m-0">
                                                    <input type="hidden" name="_csrf" value="${csrfToken}" />
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="id" value="${g.id}">
                                                    <button type="submit" class="btn btn-sm btn-outline-danger py-1 px-2" onclick="return confirm('Delete this goal?');" title="Delete">
                                                        <i data-lucide="trash-2" style="width:16px;height:16px;"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
</div>

<!-- Modal for New Goal -->
<div class="modal fade" id="newGoalModal" tabindex="-1" aria-labelledby="newGoalModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="background-color: var(--bg-card); border: 1px solid var(--border-color); border-radius: var(--radius-xl);">
            <div class="modal-header border-bottom pb-3 pt-4 px-4">
                <h5 class="modal-title font-heading fw-bold text-primary" id="newGoalModalLabel">Set a New Goal</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/user/goals" method="post">
                <input type="hidden" name="_csrf" value="${csrfToken}" />
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label">Goal Title</label>
                        <input type="text" class="form-control" name="goalType" placeholder="e.g. Lose Weight, Run 10k" required>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Target Value</label>
                            <input type="number" step="0.1" class="form-control" name="targetValue" placeholder="e.g. 75.0" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Unit</label>
                            <input type="text" class="form-control" name="unit" placeholder="e.g. kg, km, kcal">
                        </div>
                    </div>
                    <div class="mb-2">
                        <label class="form-label">Deadline (Optional)</label>
                        <div class="input-group">
                            <span class="input-group-text"><i data-lucide="calendar" style="width:16px;height:16px;"></i></span>
                            <input type="date" class="form-control" name="deadline">
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-top-0 pt-0 px-4 pb-4">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary px-4">Create Goal</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
