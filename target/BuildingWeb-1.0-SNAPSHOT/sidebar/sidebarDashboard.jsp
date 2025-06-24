<%-- 
    Document   : sidebarDashboard
    Created on : Jun 22, 2025, 9:29:07 PM
    Author     : KHANH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<div class="sidebar" id="sidebar">
    <div class="toggle-btn" onclick="toggleSidebar()">
        <i class="fa-solid fa-bars"></i>
    </div>
    <ul class="menu">
        <li><a href="Index"><i class="fa-solid fa-house"></i><span>Home</span></a></li>
        <li><a href="DashboardUser"><i class="fa-solid fa-user"></i><span>Users</span></a></li>
        <li><a href="VouchersDashBoard"><i class="fa-solid fa-ticket"></i><span>Vouchers</span></a></li>
        <li><a href="ViewNewsDashboard"><i class="fa-solid fa-newspaper"></i><span>News</span></a></li>
        <li><a href="BookingConfirmation"><i class="fa-solid fa-calendar-check"></i><span>Bookings</span></a></li>
        <li><a href="ViewAllRoomsForDashboard"><i class="fa-solid fa-bed"></i><span>List Rooms</span></a></li>
        <li><a href="ViewServicesDashboard"><i class="fa-solid fa-concierge-bell"></i><span>Services</span></a></li>
        <li><a href="ViewAmenitiesDashboard"><i class="fa-solid fa-bath"></i><span>Amenities</span></a></li>
        <li><a href="ViewAllCustomersDashboard"><i class="fa-solid fa-users"></i><span>Customers</span></a></li>
        <li><a href="ViewAllCheckInOutDashboard"><i class="fa-solid fa-door-open"></i><span>Check-InOut</span></a></li>
        <li><a href="ViewAllReportsForDashboard"><i class="fa-solid fa-flag"></i><span>Report</span></a></li>
        <li><a href="Logout"><i class="fa-solid fa-right-from-bracket"></i><span>Logout</span></a></li>
    </ul>
</div>
<script>
    
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

.sidebar.open ~ .content {
    margin-left: 220px;
}

</script>