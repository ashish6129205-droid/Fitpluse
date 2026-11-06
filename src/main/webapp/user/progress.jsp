<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>FitPulse - Progress Tracking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

<div class="app-container">
    <jsp:include page="navbar.jsp" />

    <main class="main-content">
        <header class="top-header d-none d-lg-flex">
            <h1 class="header-title">Progress Analytics</h1>
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
                <h2 class="mb-1">Track Progress</h2>
                <p class="text-secondary mb-0">Log body measurements and visualize your transformation.</p>
            </div>

            <div class="row">
                <div class="col-lg-4 mb-4">
                    <div class="card h-100">
                        <div class="card-header border-bottom-0 pb-0 pt-4">
                            <h5 class="fw-bold mb-0">Log Measurement</h5>
                        </div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/user/progress" method="post">
                                <input type="hidden" name="_csrf" value="${csrfToken}" />

                                <div class="mb-3">
                                    <label class="form-label">Date</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i data-lucide="calendar" style="width:16px;height:16px;"></i></span>
                                        <input type="date" class="form-control" name="entryDate" required>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Weight</label>
                                    <div class="input-group">
                                        <input type="number" step="0.1" class="form-control" name="weightKg" placeholder="0.0">
                                        <span class="input-group-text">kg</span>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Waist</label>
                                    <div class="input-group">
                                        <input type="number" step="0.1" class="form-control" name="waistCm" placeholder="0.0">
                                        <span class="input-group-text">cm</span>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Chest</label>
                                    <div class="input-group">
                                        <input type="number" step="0.1" class="form-control" name="chestCm" placeholder="0.0">
                                        <span class="input-group-text">cm</span>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label">Arms</label>
                                    <div class="input-group">
                                        <input type="number" step="0.1" class="form-control" name="armsCm" placeholder="0.0">
                                        <span class="input-group-text">cm</span>
                                    </div>
                                </div>

                                <button type="submit" class="btn btn-primary w-100"><i data-lucide="save" style="width:18px;height:18px;"></i> Save Progress</button>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="col-lg-8">
                    <c:choose>
                        <c:when test="${empty progressEntries}">
                            <div class="card h-100">
                                <div class="card-body d-flex align-items-center justify-content-center">
                                    <div class="empty-state border-0 bg-transparent w-100 py-5 m-0">
                                        <i data-lucide="line-chart" class="empty-icon"></i>
                                        <h4>No measurements logged</h4>
                                        <p>Log your first measurement to start generating insights.</p>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="card mb-4">
                                <div class="card-header border-bottom-0 pb-0 pt-4">
                                    <h5 class="fw-bold mb-0">Weight Trend</h5>
                                </div>
                                <div class="card-body">
                                    <div class="chart-container" style="position: relative; height: 300px;">
                                        <canvas id="weightChart"></canvas>
                                    </div>
                                </div>
                            </div>

                            <div class="card">
                                <div class="card-header border-bottom-0 pb-0 pt-4">
                                    <h5 class="fw-bold mb-0">Historical Data</h5>
                                </div>
                                <div class="card-body p-0 mt-3">
                                    <div class="table-responsive">
                                        <table class="table table-hover table-responsive-stack mb-0">
                                            <thead>
                                                <tr>
                                                    <th>Date</th>
                                                    <th>Weight</th>
                                                    <th>Waist</th>
                                                    <th>Chest</th>
                                                    <th>Arms</th>
                                                    <th class="text-end">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="p" items="${progressEntries}">
                                                    <tr>
                                                        <td data-label="Date" class="fw-medium">${p.entryDate}</td>
                                                        <td data-label="Weight" class="text-primary fw-medium">${p.weightKg != null ? p.weightKg += ' kg' : '-'}</td>
                                                        <td data-label="Waist">${p.waistCm != null ? p.waistCm += ' cm' : '-'}</td>
                                                        <td data-label="Chest">${p.chestCm != null ? p.chestCm += ' cm' : '-'}</td>
                                                        <td data-label="Arms">${p.armsCm != null ? p.armsCm += ' cm' : '-'}</td>
                                                        <td data-label="Action" class="text-end">
                                                            <form action="${pageContext.request.contextPath}/user/progress" method="post" style="display:inline;">
                                                                <input type="hidden" name="_csrf" value="${csrfToken}" />
                                                                <input type="hidden" name="action" value="delete">
                                                                <input type="hidden" name="id" value="${p.id}">
                                                                <button type="submit" class="btn btn-sm btn-outline-danger py-1 px-2" onclick="return confirm('Delete this entry?');" title="Delete">
                                                                    <i data-lucide="trash-2" style="width:14px;height:14px;"></i>
                                                                </button>
                                                            </form>
                                                        </td>
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
            </div>
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
<c:if test="${not empty progressEntries}">
    const primaryColor = '#167D5A';
    const textColor = '#64716B';
    const gridColor = '#E5EBE7';

    const ctx = document.getElementById('weightChart').getContext('2d');
    const labels = [
        <c:forEach var="p" items="${progressEntries}" varStatus="status">
            '${p.entryDate}'${!status.last ? ',' : ''}
        </c:forEach>
    ];
    // Reverse arrays so oldest date is first on the left
    labels.reverse();

    const data = [
        <c:forEach var="p" items="${progressEntries}" varStatus="status">
            ${p.weightKg != null ? p.weightKg : 'null'}${!status.last ? ',' : ''}
        </c:forEach>
    ];
    data.reverse();

    new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: 'Weight (kg)',
                data: data,
                borderColor: primaryColor,
                backgroundColor: 'rgba(22, 125, 90, 0.1)',
                borderWidth: 3,
                tension: 0.3,
                spanGaps: true,
                fill: true,
                pointBackgroundColor: '#FFFFFF',
                pointBorderColor: primaryColor,
                pointBorderWidth: 2,
                pointRadius: 4,
                pointHoverRadius: 6
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: false,
                    grid: { color: gridColor, drawBorder: false },
                    ticks: { color: textColor, font: { family: "'Inter', sans-serif" } }
                },
                x: {
                    grid: { display: false, drawBorder: false },
                    ticks: { color: textColor, font: { family: "'Inter', sans-serif" } }
                }
            },
            plugins: {
                legend: { display: false },
                tooltip: {
                    backgroundColor: '#17231F',
                    titleColor: '#FFFFFF',
                    bodyColor: '#FFFFFF',
                    padding: 10,
                    cornerRadius: 8,
                    displayColors: false,
                    titleFont: { family: "'Inter', sans-serif", weight: '600' },
                    bodyFont: { family: "'Inter', sans-serif" }
                }
            }
        }
    });
</c:if>
</script>
</body>
</html>
