<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Include Lucide Icons -->
<script src="https://unpkg.com/lucide@latest"></script>

<!-- Mobile Header -->
<div class="mobile-header d-lg-none">
    <a href="${pageContext.request.contextPath}/user/dashboard" class="sidebar-brand">
        <i data-lucide="activity" class="brand-icon"></i> FitPulse
    </a>
    <div class="header-user">
        <a href="${pageContext.request.contextPath}/user/profile" class="text-secondary" style="text-decoration: none;">
            <i data-lucide="user"></i>
        </a>
    </div>
</div>

<!-- Desktop Sidebar -->
<nav class="sidebar d-none d-lg-flex">
    <div class="sidebar-header">
        <a href="${pageContext.request.contextPath}/user/dashboard" class="sidebar-brand">
            <i data-lucide="activity" class="brand-icon"></i> FitPulse
        </a>
    </div>
    <div class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/user/dashboard" class="nav-item ${pageContext.request.requestURI.endsWith('/dashboard.jsp') ? 'active' : ''}">
            <i data-lucide="layout-dashboard"></i> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/user/workouts" class="nav-item ${pageContext.request.requestURI.endsWith('/workouts.jsp') ? 'active' : ''}">
            <i data-lucide="dumbbell"></i> Workouts
        </a>
        <a href="${pageContext.request.contextPath}/user/progress" class="nav-item ${pageContext.request.requestURI.endsWith('/progress.jsp') ? 'active' : ''}">
            <i data-lucide="trending-up"></i> Progress
        </a>
        <a href="${pageContext.request.contextPath}/user/goals" class="nav-item ${pageContext.request.requestURI.endsWith('/goals.jsp') ? 'active' : ''}">
            <i data-lucide="target"></i> Goals
        </a>
        <a href="${pageContext.request.contextPath}/user/challenges" class="nav-item ${pageContext.request.requestURI.endsWith('/challenges.jsp') ? 'active' : ''}">
            <i data-lucide="award"></i> Challenges
        </a>
        <a href="${pageContext.request.contextPath}/user/community" class="nav-item ${pageContext.request.requestURI.endsWith('/community.jsp') ? 'active' : ''}">
            <i data-lucide="users"></i> Community
        </a>
        <a href="${pageContext.request.contextPath}/user/leaderboard" class="nav-item ${pageContext.request.requestURI.endsWith('/leaderboard.jsp') ? 'active' : ''}">
            <i data-lucide="bar-chart-2"></i> Leaderboard
        </a>
    </div>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout" class="nav-item text-danger">
            <i data-lucide="log-out"></i> Logout
        </a>
    </div>
</nav>

<!-- Mobile Bottom Navigation -->
<nav class="mobile-bottom-nav d-lg-none">
    <a href="${pageContext.request.contextPath}/user/dashboard" class="mobile-nav-item ${pageContext.request.requestURI.endsWith('/dashboard.jsp') ? 'active' : ''}">
        <i data-lucide="layout-dashboard"></i>
        <span>Home</span>
    </a>
    <a href="${pageContext.request.contextPath}/user/workouts" class="mobile-nav-item ${pageContext.request.requestURI.endsWith('/workouts.jsp') ? 'active' : ''}">
        <i data-lucide="dumbbell"></i>
        <span>Workouts</span>
    </a>
    <a href="${pageContext.request.contextPath}/user/progress" class="mobile-nav-item ${pageContext.request.requestURI.endsWith('/progress.jsp') ? 'active' : ''}">
        <i data-lucide="trending-up"></i>
        <span>Progress</span>
    </a>
    <a href="${pageContext.request.contextPath}/user/challenges" class="mobile-nav-item ${pageContext.request.requestURI.endsWith('/challenges.jsp') ? 'active' : ''}">
        <i data-lucide="award"></i>
        <span>Challenges</span>
    </a>
    <a href="${pageContext.request.contextPath}/user/more-menu" class="mobile-nav-item" data-bs-toggle="offcanvas" data-bs-target="#mobileMenuOffcanvas">
        <i data-lucide="menu"></i>
        <span>More</span>
    </a>
</nav>

<!-- Mobile Offcanvas Menu (More) -->
<div class="offcanvas offcanvas-bottom d-lg-none" tabindex="-1" id="mobileMenuOffcanvas" aria-labelledby="mobileMenuOffcanvasLabel" style="border-top-left-radius: 1rem; border-top-right-radius: 1rem; background-color: var(--bg-card);">
    <div class="offcanvas-header border-bottom">
        <h5 class="offcanvas-title font-heading fw-bold" id="mobileMenuOffcanvasLabel">Menu</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body p-0">
        <div class="list-group list-group-flush">
            <a href="${pageContext.request.contextPath}/user/goals" class="list-group-item list-group-item-action py-3 d-flex align-items-center gap-3 border-0">
                <i data-lucide="target" class="text-secondary"></i> <span class="fw-medium text-primary">Goals</span>
            </a>
            <a href="${pageContext.request.contextPath}/user/community" class="list-group-item list-group-item-action py-3 d-flex align-items-center gap-3 border-0">
                <i data-lucide="users" class="text-secondary"></i> <span class="fw-medium text-primary">Community</span>
            </a>
            <a href="${pageContext.request.contextPath}/user/leaderboard" class="list-group-item list-group-item-action py-3 d-flex align-items-center gap-3 border-0">
                <i data-lucide="bar-chart-2" class="text-secondary"></i> <span class="fw-medium text-primary">Leaderboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/user/profile" class="list-group-item list-group-item-action py-3 d-flex align-items-center gap-3 border-0">
                <i data-lucide="user" class="text-secondary"></i> <span class="fw-medium text-primary">Profile</span>
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="list-group-item list-group-item-action py-3 d-flex align-items-center gap-3 border-0 text-danger mt-2 border-top">
                <i data-lucide="log-out"></i> <span class="fw-medium">Logout</span>
            </a>
        </div>
    </div>
</div>

<script>
  document.addEventListener("DOMContentLoaded", function() {
    lucide.createIcons();
  });
</script>
