<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - System Settings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="container mt-4">
    <h2>System Settings</h2>
    <div class="row mt-4">
        <div class="col-md-6">
            <div class="card mb-4 bg-dark text-white border-secondary">
                <div class="card-header bg-secondary border-secondary">
                    <h5 class="mb-0">Application Settings</h5>
                </div>
                <div class="card-body">
                    <div class="mb-3 d-flex justify-content-between align-items-center">
                        <label class="form-label mb-0">Allow New User Registrations</label>
                        <span class="badge ${registrationEnabled ? 'bg-success' : 'bg-danger'}">
                            ${registrationEnabled ? 'Enabled' : 'Disabled'}
                        </span>
                    </div>
                    <div class="mb-3 d-flex justify-content-between align-items-center">
                        <label class="form-label mb-0">System Maintenance Mode</label>
                        <span class="badge ${maintenanceMode ? 'bg-danger' : 'bg-secondary'}">
                            ${maintenanceMode ? 'Enabled' : 'Disabled'}
                        </span>
                    </div>
                    <div class="mb-3 d-flex justify-content-between align-items-center">
                        <label class="form-label mb-0">Default Inactivity Timeout</label>
                        <span class="text-info fw-bold">${sessionTimeout} Minutes</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card mb-4 bg-dark text-white border-secondary">
                <div class="card-header bg-secondary border-secondary">
                    <h5 class="mb-0">Database Pool Status (HikariCP)</h5>
                </div>
                <div class="card-body">
                    <div class="mb-3 d-flex justify-content-between align-items-center">
                        <label class="form-label mb-0">Max Pool Size</label>
                        <span class="text-warning fw-bold">${maxPoolSize}</span>
                    </div>
                    <div class="mb-3 d-flex justify-content-between align-items-center">
                        <label class="form-label mb-0">Minimum Idle</label>
                        <span class="text-warning fw-bold">${minimumIdle}</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
