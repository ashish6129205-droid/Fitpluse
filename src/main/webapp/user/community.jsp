<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - Community Feed</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="container">
    <div class="welcome-banner mb-4">
        <div>
            <h2>Community Tips</h2>
            <div class="welcome-subtitle">Learn from and inspire the FitPulse community.</div>
        </div>
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#submitTipModal">
            + Share a Fitness Tip
        </button>
    </div>

    <c:if test="${not empty sessionScope.successMessage}">
        <div class="alert alert-success mt-3">${sessionScope.successMessage}</div>
        <c:remove var="successMessage" scope="session" />
    </c:if>
    <c:if test="${not empty sessionScope.errorMessage}">
        <div class="alert alert-danger mt-3">${sessionScope.errorMessage}</div>
        <c:remove var="errorMessage" scope="session" />
    </c:if>

    <div class="row mt-4">
        <c:choose>
            <c:when test="${empty approvedContent}">
                <div class="col-12">
                    <div class="empty-state">
                        <div class="empty-icon">🌟</div>
                        <h4>No community tips yet</h4>
                        <p>Be the first to share your fitness wisdom with the community!</p>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="content" items="${approvedContent}">
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="card h-100" style="background-color: var(--card-slate); border: 1px solid var(--border-subtle);">
                            <div class="card-header border-0 d-flex justify-content-between align-items-center pb-0 pt-4">
                                <span class="badge bg-primary text-uppercase" style="font-size: 0.7rem;">Community Tip</span>
                                <small class="text-secondary"><fmt:formatDate value="${content.createdAt}" pattern="MMM d, yyyy" /></small>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title text-primary font-weight-bold mb-3"><c:out value="${content.title}" /></h5>
                                <p class="card-text text-secondary" style="font-size: 0.95rem; line-height: 1.6;"><c:out value="${content.content}" /></p>
                            </div>
                            <div class="card-footer border-0 bg-transparent text-secondary pt-0 pb-4" style="font-size: 0.85rem;">
                                <strong>By:</strong> <c:out value="${content.authorName}" />
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Modal for Submitting Tip -->
<div class="modal fade" id="submitTipModal" tabindex="-1" aria-labelledby="submitTipModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="background-color: var(--bg-obsidian); border: 1px solid var(--border-subtle);">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title text-primary" id="submitTipModalLabel">Share a Fitness Tip</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/user/community" method="post">
                <div class="modal-body">
                    <div class="alert alert-info" style="background: rgba(6, 182, 212, 0.1); border: 1px solid var(--accent-cyan); color: var(--accent-cyan);">
                        Submitted tips will appear after Admin review.
                    </div>
                    <div class="mb-3">
                        <label class="form-label text-secondary">Title</label>
                        <input type="text" class="form-control text-primary" style="background-color: var(--card-slate); border-color: var(--border-subtle);" name="title" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label text-secondary">Content</label>
                        <textarea class="form-control text-primary" style="background-color: var(--card-slate); border-color: var(--border-subtle);" name="content" rows="4" required></textarea>
                    </div>
                </div>
                <div class="modal-footer border-0 pt-0">
                    <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Submit for Review</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
