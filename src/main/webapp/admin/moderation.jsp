<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - Content Moderation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="container mt-4">
    <h2>Community Tips Moderation</h2>
    <p class="text-secondary">Review pending submissions from the community before they appear on the public feed.</p>

    <c:if test="${not empty sessionScope.successMessage}">
        <div class="alert alert-success mt-3">${sessionScope.successMessage}</div>
        <c:remove var="successMessage" scope="session" />
    </c:if>
    <c:if test="${not empty sessionScope.errorMessage}">
        <div class="alert alert-danger mt-3">${sessionScope.errorMessage}</div>
        <c:remove var="errorMessage" scope="session" />
    </c:if>

    <div class="row mt-4">
        <div class="col-12">
            <c:choose>
                <c:when test="${empty pendingContent}">
                    <div class="empty-state">
                        <div class="empty-icon">✅</div>
                        <h4>All caught up!</h4>
                        <p>There are no pending submissions to review.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-wrapper">
                        <table class="table table-striped table-responsive-stack">
                            <thead>
                                <tr>
                                    <th>Title</th>
                                    <th>Author</th>
                                    <th>Excerpt</th>
                                    <th>Submitted On</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="c" items="${pendingContent}">
                                    <tr>
                                        <td data-label="Title" class="fw-bold"><c:out value="${c.title}" /></td>
                                        <td data-label="Author"><span class="badge bg-primary"><c:out value="${c.authorName}" /></span></td>
                                        <td data-label="Excerpt" class="text-secondary">
                                            <c:choose>
                                                <c:when test="${c.content.length() > 50}">
                                                    <c:out value="${c.content.substring(0, 50)}..." />
                                                </c:when>
                                                <c:otherwise>
                                                    <c:out value="${c.content}" />
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td data-label="Submitted On">
                                            <fmt:formatDate value="${c.createdAt}" pattern="MMM d, yyyy" />
                                        </td>
                                        <td data-label="Action">
                                            <div class="d-flex gap-2">
                                                <form action="${pageContext.request.contextPath}/admin/moderation" method="post" class="m-0">
                                                    <input type="hidden" name="contentId" value="${c.id}">
                                                    <input type="hidden" name="status" value="APPROVED">
                                                    <button type="submit" class="btn btn-sm btn-success" style="background-color: var(--accent-emerald); border-color: var(--accent-emerald);">Approve</button>
                                                </form>
                                                <form action="${pageContext.request.contextPath}/admin/moderation" method="post" class="m-0">
                                                    <input type="hidden" name="contentId" value="${c.id}">
                                                    <input type="hidden" name="status" value="REJECTED">
                                                    <button type="submit" class="btn btn-sm btn-danger" style="background-color: var(--danger); border-color: var(--danger);">Reject</button>
                                                </form>
                                            </div>
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
