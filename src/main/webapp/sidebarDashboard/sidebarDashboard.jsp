<%-- 
    Document   : sidebarDashboard
    Created on : Jun 22, 2025, 9:52:42 PM
    Author     : KHANH
--%>

<style>
:root {
    --navy: #4a6fa5;
    --navy-dark: #3a5c88;
    --white: #ffffff;
    --hover-bg: #355880;
    --transition: 0.3s ease;
    --shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
}

/* Sidebar container */
.sidebar {
    position: fixed;
    top: 60px;
    left: 0;
    height: calc(100% - 60px);
    width: 60px;
    background-color: var(--navy);
    overflow-x: hidden;
    box-shadow: var(--shadow);
    transition: width var(--transition), transform var(--transition);
    transform: translateX(0);
    z-index: 998;
    font-family: 'Segoe UI', sans-serif;
}

/* Sidebar expanded */
.sidebar.open {
    width: 220px;
}

/* Toggle button */
.toggle-btn {
    background-color: var(--navy-dark);
    color: var(--white);
    font-size: 20px;
    cursor: pointer;
    height: 50px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    transition: background-color 0.2s ease;
    animation: fadeIn 0.4s ease forwards;
}

.toggle-btn:hover {
    background-color: var(--hover-bg);
}

/* Sidebar menu */
.menu {
    list-style: none;
    padding: 0;
    margin: 0;
}

.menu li {
    opacity: 0;
    transform: translateY(10px);
    animation: fadeSlideIn 0.3s ease forwards;
    animation-delay: calc(var(--i) * 0.05s);
}

.menu li a {
    display: flex;
    align-items: center;
    padding: 14px 20px;
    text-decoration: none;
    color: var(--white);
    font-size: 16px;
    white-space: nowrap;
    transition: background-color var(--transition), padding-left 0.3s;
}

.menu li a i {
    margin-right: 14px;
    font-size: 18px;
    width: 20px;
    min-width: 20px;
    text-align: center;
    transition: transform 0.3s ease;
}

.menu li a span {
    display: inline-block;
    opacity: 0;
    transform: translateX(-10px);
    transition: opacity 0.3s ease, transform 0.3s ease;
}

/* Show labels when sidebar is open */
.sidebar.open .menu li a span {
    opacity: 1;
    transform: translateX(0);
}

/* Hover effect */
.menu li a:hover {
    background-color: var(--hover-bg);
    padding-left: 28px;
}

.menu li a:hover i {
    transform: scale(1.2);
}

/* Responsive */
@media screen and (max-width: 768px) {
    .sidebar {
        width: 0;
        transform: translateX(-100%);
    }

    .sidebar.open {
        width: 180px;
        transform: translateX(0);
    }
}

/* Main content shift when sidebar open */
.content, .main-content {
    margin-left: 60px;
    transition: margin-left var(--transition);
}

.sidebar.open ~ .content,
.sidebar.open ~ .main-content {
    margin-left: 220px;
}

/* Animations */
@keyframes fadeSlideIn {
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes fadeIn {
    from { opacity: 0; transform: scale(0.95); }
    to { opacity: 1; transform: scale(1); }
}
</style>

<!-- Sidebar HTML -->
<div class="sidebar" id="sidebar">
    <div class="toggle-btn" onclick="toggleSidebar()">
        <i class="fa-solid fa-bars"></i>
    </div>
    <ul class="menu">
        <li style="--i:0"><a href="Index"><i class="fa-solid fa-house"></i><span>Home</span></a></li>
        <li style="--i:1"><a href="DashboardUser"><i class="fa-solid fa-user"></i><span>Users</span></a></li>
        <li style="--i:2"><a href="VouchersDashBoard"><i class="fa-solid fa-ticket"></i><span>Vouchers</span></a></li>
        <li style="--i:3"><a href="ViewNewsDashboard"><i class="fa-solid fa-newspaper"></i><span>News</span></a></li>
        <li style="--i:4"><a href="BookingConfirmation"><i class="fa-solid fa-calendar-check"></i><span>Bookings</span></a></li>
        <li style="--i:5"><a href="ViewAllRoomsForDashboard"><i class="fa-solid fa-bed"></i><span>List Rooms</span></a></li>
        <li style="--i:6"><a href="ViewServicesDashboard"><i class="fa-solid fa-concierge-bell"></i><span>Services</span></a></li>
        <li style="--i:7"><a href="ViewAmenitiesDashboard"><i class="fa-solid fa-bath"></i><span>Amenities</span></a></li>
        <li style="--i:8"><a href="ViewAllCustomersDashboard"><i class="fa-solid fa-users"></i><span>Customers</span></a></li>
        <li style="--i:9"><a href="ViewAllCheckInOutDashboard"><i class="fa-solid fa-door-open"></i><span>Check-InOut</span></a></li>
        <li style="--i:10"><a href="ViewAllReportsForDashboard"><i class="fa-solid fa-flag"></i><span>Report</span></a></li>
        <li style="--i:11"><a href="Logout"><i class="fa-solid fa-right-from-bracket"></i><span>Logout</span></a></li>
    </ul>
</div>

<script>
    function toggleSidebar() {
        const sidebar = document.getElementById("sidebar");
        sidebar.classList.toggle("open");
    }
</script>
