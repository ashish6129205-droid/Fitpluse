<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid px-4">
        <a class="navbar-brand" href="#">
            <span class="brand-dot"></span> FitPulse
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.endsWith('/dashboard.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/user/dashboard">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.endsWith('/workouts.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/user/workouts">Workouts</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.endsWith('/progress.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/user/progress">Progress</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.endsWith('/goals.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/user/goals">Goals</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.endsWith('/challenges.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/user/challenges">Challenges</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.endsWith('/profile.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/user/profile">Profile</a>
                </li>
                <li class="nav-item ms-lg-3">
                    <a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
