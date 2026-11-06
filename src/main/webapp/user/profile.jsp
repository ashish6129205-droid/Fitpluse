<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - User Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .profile-avatar-large {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: rgba(22, 125, 90, 0.1);
            color: var(--accent-primary);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
            border: 4px solid var(--bg-card);
            box-shadow: var(--shadow-md);
        }
    </style>
</head>
<body>

<div class="app-container">
    <jsp:include page="navbar.jsp" />

    <main class="main-content">
        <header class="top-header d-none d-lg-flex">
            <h1 class="header-title">Profile</h1>
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
                <h2 class="mb-1">My Profile</h2>
                <p class="text-secondary mb-0">Manage your personal information and fitness preferences.</p>
            </div>

            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success d-flex align-items-center gap-2">
                    <i data-lucide="check-circle" style="width:18px;height:18px;"></i>
                    ${sessionScope.successMessage}
                </div>
                <c:remove var="successMessage" scope="session" />
            </c:if>

            <div class="row">
                <div class="col-lg-4 mb-4">
                    <div class="card h-100 border text-center pt-5 pb-4 px-4">
                        <div class="card-body d-flex flex-column h-100">
                            <div class="d-flex justify-content-center">
                                <div class="profile-avatar-large">
                                    <i data-lucide="user" style="width:48px;height:48px;"></i>
                                </div>
                            </div>
                            <h4 class="fw-bold mb-1">${sessionScope.loggedUser.name}</h4>
                            <p class="text-secondary mb-4">${sessionScope.loggedUser.email}</p>

                            <div class="d-flex justify-content-center gap-4 mt-auto border-top pt-4">
                                <div>
                                    <div class="text-secondary small fw-medium mb-1">Age</div>
                                    <div class="fw-bold text-primary fs-5">${sessionScope.loggedUser.age != 0 ? sessionScope.loggedUser.age : '-'}</div>
                                </div>
                                <div>
                                    <div class="text-secondary small fw-medium mb-1">Height</div>
                                    <div class="fw-bold text-primary fs-5">${sessionScope.loggedUser.heightCm != 0 ? sessionScope.loggedUser.heightCm += ' cm' : '-'}</div>
                                </div>
                                <div>
                                    <div class="text-secondary small fw-medium mb-1">Weight</div>
                                    <div class="fw-bold text-primary fs-5">${sessionScope.loggedUser.weightKg != 0 ? sessionScope.loggedUser.weightKg += ' kg' : '-'}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-8">
                    <div class="card border">
                        <div class="card-header border-bottom-0 pb-0 pt-4">
                            <h5 class="fw-bold mb-0">Update Details</h5>
                        </div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/user/profile" method="post">
                                <input type="hidden" name="_csrf" value="${csrfToken}" />

                                <h6 class="text-secondary fw-bold text-uppercase mb-3" style="font-size: 0.75rem; letter-spacing: 0.05em;">Basic Information</h6>
                                <div class="row mb-4">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Full Name</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i data-lucide="user" style="width:16px;height:16px;"></i></span>
                                            <input type="text" class="form-control" name="name" value="${sessionScope.loggedUser.name}" style="border: 1px solid #cbd5e1 !important; border-radius: 8px; background-color: #ffffff !important;" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Email Address <span class="text-secondary fw-normal">(Read Only)</span></label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-light"><i data-lucide="mail" style="width:16px;height:16px;" class="text-muted"></i></span>
                                            <input type="email" class="form-control bg-light text-muted" value="${sessionScope.loggedUser.email}" readonly>
                                        </div>
                                    </div>
                                </div>

                                <h6 class="text-secondary fw-bold text-uppercase mb-3 mt-2" style="font-size: 0.75rem; letter-spacing: 0.05em;">Physical Attributes</h6>
                                <div class="row mb-4">
                                    <div class="col-md-4 mb-3">
                                        <label class="form-label">Age</label>
                                        <div class="input-group">
                                            <input type="number" class="form-control" name="age" value="${sessionScope.loggedUser.age != 0 ? sessionScope.loggedUser.age : ''}" style="border: 1px solid #cbd5e1 !important; border-radius: 8px; background-color: #ffffff !important;" placeholder="Years">
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="form-label">Height</label>
                                        <div class="input-group">
                                            <input type="number" step="0.1" class="form-control" name="heightCm" value="${sessionScope.loggedUser.heightCm != 0 ? sessionScope.loggedUser.heightCm : ''}" style="border: 1px solid #cbd5e1 !important; border-radius: 8px; background-color: #ffffff !important;" placeholder="0.0">
                                            <span class="input-group-text">cm</span>
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="form-label">Weight</label>
                                        <div class="input-group">
                                            <input type="number" step="0.1" class="form-control" name="weightKg" value="${sessionScope.loggedUser.weightKg != 0 ? sessionScope.loggedUser.weightKg : ''}" style="border: 1px solid #cbd5e1 !important; border-radius: 8px; background-color: #ffffff !important;" placeholder="0.0">
                                            <span class="input-group-text">kg</span>
                                        </div>
                                    </div>
                                </div>

                                <h6 class="text-secondary fw-bold text-uppercase mb-3 mt-2" style="font-size: 0.75rem; letter-spacing: 0.05em;">Preferences</h6>
                                <div class="mb-4">
                                    <label class="form-label">Primary Fitness Goal</label>
                                    <textarea class="form-control" name="fitnessGoal" rows="3" style="border: 1px solid #cbd5e1 !important; border-radius: 8px; background-color: #ffffff !important;" placeholder="Describe what you want to achieve...">${sessionScope.loggedUser.fitnessGoal}</textarea>
                                </div>

                                <div class="d-flex justify-content-end mt-4 pt-3 border-top">
                                    <button type="submit" class="btn btn-primary px-4 py-2"><i data-lucide="save" style="width:18px;height:18px;"></i> Save Changes</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
