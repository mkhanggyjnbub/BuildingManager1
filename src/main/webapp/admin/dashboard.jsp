<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <!-- Chart.js Script -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            :root {
                --navy: #4a6fa5;
                --navy-dark: #3a5c88;
                --white: #ffffff;
                --light-bg: #f4f6f9;
                --hover-bg: #3a5c88;
                --transition: 0.3s ease;
            }

            * {
                box-sizing: border-box;
            }

            body {
                margin: 0;
                font-family: 'Segoe UI', sans-serif;
                background-color: var(--light-bg);
                color: var(--navy);
            }

            .navbar {
                background-color: var(--navy);
                color: var(--white);
                padding: 0 30px;
                display: flex;
                align-items: center;
                height: 60px;
                justify-content: space-between;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }

            .navbar h1 {
                font-size: 22px;
                margin: 0;
            }

            .customer-link {
                color: var(--white);
                text-decoration: none;
                font-size: 16px;
                display: flex;
                align-items: center;
                gap: 6px;
                transition: var(--transition);
            }

            .customer-link:hover {
                opacity: 0.85;
            }

            .sidebar {
                position: fixed;
                top: 60px;
                left: 0;
                height: calc(100% - 60px);
                width: 60px;
                background-color: var(--navy);
                transition: width var(--transition);
                overflow-x: hidden;
                box-shadow: 2px 0 8px rgba(0,0,0,0.05);
                z-index: 999;
            }

            .sidebar.open {
                width: 220px;
            }

            .toggle-btn {
                background-color: var(--navy-dark);
                color: var(--white);
                font-size: 20px;
                cursor: pointer;
                height: 50px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-bottom: 1px solid rgba(255,255,255,0.1);
            }

            .menu {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .menu li a {
                display: flex;
                align-items: center;
                padding: 14px 20px;
                text-decoration: none;
                color: var(--white);
                font-size: 16px;
                white-space: nowrap;
                transition: background-color var(--transition);
            }

            .menu li a i {
                margin-right: 14px;
                font-size: 18px;
                width: 20px;
                min-width: 20px;
                text-align: center;
            }

            .menu li a span {
                display: none;
                transition: opacity var(--transition);
            }

            .sidebar.open .menu li a span {
                display: inline;
            }

            .menu li a:hover {
                background-color: var(--hover-bg);
            }

            .content {
                margin-left: 60px;
                padding: 40px;
                transition: margin-left var(--transition);
            }

            .sidebar.open ~ .content {
                margin-left: 220px;
            }

            .content h2 {
                font-size: 28px;
                margin-bottom: 10px;
            }

            .content p {
                font-size: 16px;
                color: #333;
            }

            @media screen and (max-width: 768px) {
                .navbar h1 {
                    font-size: 18px;
                }

                .customer-link {
                    font-size: 14px;
                }

                .content {
                    padding: 20px;
                }
            }



            .chart-container {
                position: relative;
                width: 100%;
                max-width: 1000px;
                height: 350px; /* ↓ giảm từ 500px xuống 350px */
                margin: 0 auto;
            }

        </style>
    </head>
    <body>

        <!-- Navbar -->
        <%@include file="../navbarDashboard/navbarDashboard.jsp" %>

        <!-- Sidebar -->
        <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>
        <!-- Main Content -->
        <div class="content">
            <h2>Welcome to the Admin Dashboard</h2>
            <p>Use the sidebar to manage users, bookings, amenities, and more.</p>
      
            <!-- ====== ROOM TYPE CHART ====== -->
            <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 30px;">
                <h3 style="margin: 0;">Room Types Most Booked</h3>
                <form method="get" action="Dashboard">
                    <label for="period">Select Booking Period:</label>
                    <select name="period" id="period" onchange="this.form.submit()">
                        <option value="week" ${period == 'week' ? 'selected' : ''}>This Week</option>
                        <option value="month" ${period == 'month' ? 'selected' : ''}>This Month</option>
                        <option value="year" ${period == 'year' ? 'selected' : ''}>This Year</option>
                    </select>
                </form>
            </div>
            <div class="chart-container" style="height: 350px; margin-bottom: 50px;">
                <canvas id="roomTypeChart"></canvas>
            </div>

            <!-- ====== REVENUE CHART ====== -->
            <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 30px;">
                <h3 style="margin: 0;">Revenue Statistics</h3>
                <form method="get" action="Dashboard">
                    <label for="revenuePeriod">Select Revenue Period:</label>
                    <select name="revenuePeriod" id="revenuePeriod" onchange="this.form.submit()">
                        <option value="day" ${revenuePeriod == 'day' ? 'selected' : ''}>Last 7 Days</option>
                        <option value="month" ${revenuePeriod == 'month' ? 'selected' : ''}>This Year (by Month)</option>
                        <option value="year" ${revenuePeriod == 'year' ? 'selected' : ''}>All Years</option>
                    </select>
                </form>
            </div>
            <div class="chart-container" style="height: 350px;">
                <canvas id="revenueChart"></canvas>
            </div>



            <script>
                // Room Type Chart
                const roomTypeCtx = document.getElementById('roomTypeChart').getContext('2d');
                const roomTypeChart = new Chart(roomTypeCtx, {
                type: 'bar',
                        data: {
                        labels: [
                <c:forEach var="row" items="${topRoomTypes}">'${row[0]}',</c:forEach>
                        ],
                                datasets: [{
                                label: 'Number of Bookings',
                                        data: [<c:forEach var="row" items="${topRoomTypes}">${row[1]},</c:forEach>],
                                        backgroundColor: 'rgba(75, 192, 192, 0.7)',
                                        borderWidth: 1
                                }]
                        },
                        options: {
                        responsive: true,
                                maintainAspectRatio: false,
                                plugins: {
                                legend: { labels: { font: { size: 14 } } }
                                },
                                scales: {
                                x: { ticks: { font: { size: 13 } } },
                                        y: {
                                        beginAtZero: true,
                                                ticks: { stepSize: 1, font: { size: 13 } }
                                        }
                                }
                        }
                });
                // Revenue Chart
                const revenueCtx = document.getElementById('revenueChart').getContext('2d');
                const revenueChart = new Chart(revenueCtx, {
                type: 'bar',
                        data: {
                        labels: [
                <c:forEach var="row" items="${revenueStats}">'${row[0]}',</c:forEach>
                        ],
                                datasets: [{
                                label: 'Total Revenue (VND)',
                                        data: [<c:forEach var="row" items="${revenueStats}">${row[1]},</c:forEach>],
                                        backgroundColor: 'rgba(255, 159, 64, 0.7)',
                                        borderWidth: 1
                                }]
                        },
                        options: {
                        responsive: true,
                                maintainAspectRatio: false,
                                plugins: {
                                legend: { labels: { font: { size: 14 } } }
                                },
                                scales: {
                                x: { ticks: { font: { size: 13 } } },
                                        y: {
                                        beginAtZero: true,
                                                ticks: {
                                                font: { size: 13 },
                                                        callback: function(value) {
                                                        return value.toLocaleString(); // format VND
                                                        }
                                                }
                                        }
                                }
                        }
                });
            </script>

        </div>
        <script>
            function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('open');
            }
        </script>

    </body>
</html>
