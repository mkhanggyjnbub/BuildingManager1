<%-- 
    Document   : admin
    Created on : Apr 30, 2025, 10:00:42 PM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
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

            /* Navbar */
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

            /* Sidebar */
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

            .toggle-btn i {
                font-size: 18px;
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

            /* Main content */
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

            /* Responsive tweaks */
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
        </style>
    </head>
    <body>

        <!-- Navbar -->
        <div class="navbar">
            <h1>Admin Dashboard</h1>
            <a href="ViewAllCustomersDashboard" class="customer-link">
                <i class="fa-solid fa-user"></i> Customer
            </a>
        </div>

        <!--<a href="Index">Quay về trang chủ</a>-->

        <!-- Sidebar -->
        <div class="sidebar" id="sidebar">
            <div class="toggle-btn" onclick="toggleSidebar()">
                <i class="fa-solid fa-bars"></i>
              



                <!-- Navbar -->
                <div class="navbar">
                    <h1>Admin Dashboard</h1>
<!--                    <a href="ViewAllCustomersDashboard" class="customer-link">
                        <i class="fa-solid fa-user"></i> Customer
                    </a>-->
                </div>
                <ul class="menu">
                    <li><a href="Index"><i class="fa-solid fa-house"></i><span>Home</span></a></li>
                    <li><a href="DashboardUser"><i class="fa-solid fa-user"></i><span>Users</span></a></li>
                    <li><a href="VouchersDashBoard"><i class="fa-solid fa-ticket"></i><span>Vouchers</span></a></li>
                    <li><a href="ViewNewsDashboard"><i class="fa-solid fa-newspaper"></i><span>News</span></a></li>
                    <li><a href="BookingConfirmation"><i class="fa-solid fa-calendar-check"></i><span>Bookings</span></a></li>
                    <li><a href="ViewAmenitiesDashboard"><i class="fa-solid fa-bath"></i><span>Amenities</span></a></li>
                    <li><a href="ViewAllCustomersDashboard"><i class="fa-solid fa-users"></i><span>Customers</span></a></li>
                    <li><a href="Logout"><i class="fa-solid fa-right-from-bracket"></i><span>Logout</span></a></li>
                </ul>
            </div>

            <!-- Main Content -->
            <div class="content">
                <h2>Welcome to the Admin Dashboard</h2>
            </div>
            <!-- Sidebar -->
            <div class="sidebar" id="sidebar">
                <div class="toggle-btn" onclick="toggleSidebar()">☰</div>
                <ul class="menu">
                    <li><a href="Index"><i class="fa-solid fa-house"></i><span>Home</span></a></li>
                    <li><a href="DashboardUser"><i class="fa-solid fa-user"></i><span>Users</span></a></li>
                    <li><a href="VouchersDashBoard"><i class="fa-solid fa-ticket"></i><span>Vouchers</span></a></li>
                    <li><a href="ViewNewsDashboard"><i class="fa-solid fa-newspaper"></i><span>News</span></a></li>
                    </li>
                    <li>  <a href="ViewAllRoomsForDashboard">List Rooms</a>
                    </li>
                    <li>         <a href="ViewServicesDashboard">Services</a>
                    </li>
                    <li>         <a href="BookingConfirmation">List Bookings</a>
                    </li>
                    <li>         <a href="ViewAmenitiesDashboard">List Amenities</a>
                    </li>
                    <li>         <a href="ViewAllCustomersDashboard">List Customers</a>
                    </li>
                                        <li><a href="Logout"><i class="fa-solid fa-right-from-bracket"></i><span>Logout</span></a></li>

                </ul>
            </div>

            <script>
                function toggleSidebar() {
                    document.getElementById('sidebar').classList.toggle('open');
                }
            </script>

    </body>
</html>

