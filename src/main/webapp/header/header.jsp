<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
    * {
        box-sizing: border-box;
    }

    html, body {
        margin: 0;
        padding: 0;
        overflow-x: hidden;
    }

    header {
        background: linear-gradient(to right, #3f1d1d, #7a3e3e);
        color: #fff;
        padding: 1rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        position: fixed;
        width: 100%;
        z-index: 3;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        border-radius: 6px 6px 0 0;
    }

    .logo {
        font-size: 1.5rem;
        font-weight: bold;
        color: white;
        display: flex;
        align-items: center;
        flex: 1 1 auto;
        min-width: 0;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    nav {
        display: flex;
        gap: 1.5rem;
        flex: 2 1 auto;
        flex-wrap: wrap;
        justify-content: flex-end;
        align-items: center;
    }

    nav a {
        color: #fff;
        text-decoration: none;
        font-weight: bold;
        position: relative;
        white-space: nowrap;
    }

    nav a::after {
        content: '';
        position: absolute;
        width: 0%;
        height: 2px;
        bottom: -2px;
        left: 0;
        background-color: white;
        transition: width 0.3s ease;
    }

    nav a:hover::after {
        width: 100%;
    }

    #menu-toggle {
        display: none;
        font-size: 1.8rem;
        background: none;
        border: none;
        color: white;
        cursor: pointer;
    }

    @media (max-width: 768px) {
        nav {
            display: none;
            flex-direction: column;
            width: 100%;
            background: linear-gradient(to right, #3f1d1d, #7a3e3e);
        }

        nav a {
            padding: 1rem;
            border-top: 1px solid rgba(255, 255, 255, 0.2);
        }

        #menu-toggle {
            display: block;
        }

        nav.show {
            display: flex;
        }
    }

    /* Dropdown menu */
    .customer-service {
        position: relative;
    }

    .customer-btn {
        background: none;
        border: none;
        font-weight: bold;
        color: #fff;
        cursor: pointer;
        padding: 0;
        margin: 0;
        font-size: 1rem;
        position: relative;
    }

    .customer-btn::after {
        content: '';
        position: absolute;
        width: 0%;
        height: 2px;
        bottom: -2px;
        left: 0;
        background-color: white;
        transition: width 0.3s ease;
    }

    .customer-btn:hover::after {
        width: 100%;
    }

    .customer-service-content {
        display: none;
        position: absolute;
        background-color: #fff;
        min-width: 220px;
        box-shadow: 0px 8px 16px rgba(0,0,0,0.15);
        z-index: 10;
        right: 0;
        border-radius: 6px;
        padding: 8px 0;
    }

    .customer-service-content a {
        color: #333;
        padding: 10px 16px;
        text-decoration: none;
        display: block;
        font-size: 14px;
    }

    .customer-service-content a:hover {
        background-color: #f7f7f7;
    }

    .customer-service.show .customer-service-content {
        display: block;
    }
</style>

<header>
    <div class="logo">HotelManager</div>
    <nav id="nav-menu">
        <a href="Index">Home</a>
        <a href="ViewRooms">Rooms</a>
        <a href="#">Contact</a>

        <c:if test="${not empty customerId}">   
            <a href="UserVouchers">User Voucher</a>
        </c:if>
        <a href="ViewNews">News</a>

        <c:choose>
            <c:when test="${empty accountType}">
                <a href="Login">Login</a>
            </c:when>
            <c:when test="${accountType eq 'option1'}">
                <c:choose>
                    <c:when test="${role == 1}">
                        <a href="Dashboard">Go To Dashboard</a>
                        <a href="?id=${adminId}">${userName}</a>
                    </c:when>
                    <c:when test="${role == 2}">
                        <a href="?id=${managerId}">${userName}</a>
                    </c:when>
                    <c:when test="${role == 3}">
                        <a href="?id=${staffId}">${userName}</a>
                    </c:when>
                    <c:when test="${role == 4}">
                        <a href="?id=${consumablesId}">${userName}</a>
                    </c:when>
                    <c:when test="${role == 5}">
                        <a href="?id=${equipmentId}">${userName}</a>
                    </c:when>
                    <c:when test="${role == 6}">
                        <a href="?id=${cusstomerId}">${userName}</a>
                    </c:when>
                </c:choose> 
            </c:when>
            <c:otherwise>
                <div class="customer-service" id="customerMenu">
                    <button class="customer-btn">${userName}</button>
                    <div class="customer-service-content">
                        <a href="ViewCustomerProfile?id=${customerId}">🔹 My Account</a>
                        <a href="ViewServicesCart">🔹 Order Services</a>
                        <a href="ViewBookingHistory">🔹 Booking History</a>
                        <a href="Logout">🔹 Logout</a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </nav>
    <button id="menu-toggle">☰</button>
</header>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const toggle = document.getElementById("menu-toggle");
        const nav = document.getElementById("nav-menu");
        toggle.addEventListener("click", function () {
            nav.classList.toggle("show");
        });

        // Dropdown toggle khi click vào tên user
        const customerMenu = document.getElementById("customerMenu");
        const customerBtn = customerMenu?.querySelector(".customer-btn");

        if (customerBtn) {
            customerBtn.addEventListener("click", function (e) {
                e.stopPropagation();
                customerMenu.classList.toggle("show");
            });

            // Click ra ngoài thì đóng menu
            document.addEventListener("click", function (e) {
                if (!customerMenu.contains(e.target)) {
                    customerMenu.classList.remove("show");
                }
            });
        }
    });
</script>
