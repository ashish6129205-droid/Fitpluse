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
    <style>
        .community-card {
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .community-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
        }
        .author-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--bg-secondary);
            color: var(--accent-primary);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
        }
    </style>
</head>
<body>

<div class="app-container">
    <jsp:include page="navbar.jsp" />

    <main class="main-content">
        <header class="top-header d-none d-lg-flex">
            <h1 class="header-title">Community</h1>
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
                    <h2 class="mb-1">Community Tips</h2>
                    <p class="text-secondary mb-0">Learn from and inspire the FitPulse community.</p>
                </div>
                <button type="button" class="btn btn-primary shadow-sm" data-bs-toggle="modal" data-bs-target="#submitTipModal">
                    <i data-lucide="edit-3" style="width:18px;height:18px;"></i> Share a Tip
                </button>
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

            <div class="row">
                <c:choose>
                    <c:when test="${empty approvedContent}">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body py-5">
                                    <div class="empty-state border-0 bg-transparent m-0 py-4">
                                        <i data-lucide="message-square" class="empty-icon"></i>
                                        <h4>No community tips yet</h4>
                                        <p>Be the first to share your fitness wisdom with the community!</p>
                                        <button type="button" class="btn btn-primary mt-2" data-bs-toggle="modal" data-bs-target="#submitTipModal">
                                            Share a Fitness Tip
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="content" items="${approvedContent}">
                            <div class="col-md-6 col-lg-4 mb-4">
                                <div class="card h-100 community-card border">
                                    <div class="card-body p-4 d-flex flex-column">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <span class="badge bg-secondary text-primary border px-2 py-1"><i data-lucide="lightbulb" style="width:12px;height:12px;margin-right:4px;"></i> Tip</span>
                                            <small class="text-secondary fw-medium"><fmt:formatDate value="${content.createdAt}" pattern="MMM d, yyyy" /></small>
                                        </div>

                                        <h5 class="fw-bold mb-3 text-primary"><c:out value="${content.title}" /></h5>
                                        <p class="text-secondary flex-grow-1" style="font-size: 0.95rem; line-height: 1.6;"><c:out value="${content.content}" /></p>

                                        <div class="mt-4 pt-3 border-top d-flex align-items-center gap-3">
                                            <div class="author-avatar">
                                                <c:out value="${content.authorName.substring(0,1).toUpperCase()}" />
                                            </div>
                                            <div>
                                                <div class="small fw-bold text-primary"><c:out value="${content.authorName}" /></div>
                                                <div class="small text-secondary" style="font-size: 0.75rem;">FitPulse Athlete</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>
</div>

<!-- Modal for Submitting Tip -->
<div class="modal fade" id="submitTipModal" tabindex="-1" aria-labelledby="submitTipModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="background-color: var(--bg-card); border: 1px solid var(--border-color); border-radius: var(--radius-xl);">
            <div class="modal-header border-bottom pb-3 pt-4 px-4">
                <h5 class="modal-title font-heading fw-bold text-primary d-flex align-items-center gap-2" id="submitTipModalLabel">
                    <i data-lucide="edit-3"></i> Share a Fitness Tip
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/user/community" method="post">
                <input type="hidden" name="_csrf" value="${csrfToken}" />
                <div class="modal-body p-4">
                    <div class="alert alert-info d-flex align-items-start gap-2 mb-4">
                        <i data-lucide="info" style="width:18px;height:18px;margin-top:2px;"></i>
                        <div>Submitted tips will appear in the feed after Admin review.</div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Title</label>
                        <input type="text" class="form-control" name="title" placeholder="e.g. Best way to recover after a run" required>
                    </div>
                    <div class="mb-2">
                        <label class="form-label">Content</label>
                        <textarea class="form-control" name="content" rows="5" placeholder="Share your knowledge with the community..." required></textarea>
                    </div>
                </div>
                <div class="modal-footer border-top-0 pt-0 px-4 pb-4">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary px-4">Submit for Review</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
