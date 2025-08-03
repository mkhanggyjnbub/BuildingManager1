<%-- 
    Document   : checkInOut
    Created on : Jun 20, 2025, 2:43:01 PM
    Author     : KHANH
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Check-in / Check-out Management</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
        <style>
            :root {
                --navy: #4a6fa5;
                --white: #ffffff;
                --disabled-bg: #e2e3e5;
                --disabled-text: #383d41;
            }

            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f0f4f8;
                margin: 0;
                padding: 0;
                color: #333;
                animation: fadeInBody 0.6s ease-in-out;
            }

            @keyframes fadeInBody {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            .navbar {
                background-color: var(--navy);
                color: var(--white);
                padding: 0 30px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                height: 60px;
                border-top-left-radius: 10px;
                border-top-right-radius: 10px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            }

            .navbar h1, .navbar a {
                color: var(--white);
                font-size: 16px;
                font-weight: bold;
                text-decoration: none;
            }

            .main-content {
                margin-left: 60px;
                padding: 80px 30px 40px;
                animation: slideInMain 0.6s ease forwards;
                opacity: 0;
            }

            @keyframes slideInMain {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            h2 {
                text-align: center;
                color: #002b5c;
                margin-bottom: 30px;
                font-size: 30px;
                font-weight: 600;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 8px 20px rgba(0, 43, 92, 0.1);
            }

            th, td {
                padding: 16px 12px;
                text-align: center;
                font-size: 15px;
                border-bottom: 1px solid #e6e6e6;
            }

            th {
                background-color: #002b5c;
                color: white;
                text-transform: uppercase;
                font-size: 13px;
            }

            tr:hover {
                background-color: #eef6fb;
            }

            .status {
                display: inline-block;
                padding: 6px 12px;
                border-radius: 8px;
                font-weight: 600;
            }

            .status.waiting {
                background-color: #fff3cd;
                color: #856404;
            }

            .status.staying {
                background-color: #d4edda;
                color: #155724;
            }

            .status.checkedout {
                background-color: var(--disabled-bg);
                color: var(--disabled-text);
            }

            .btn-action {
                padding: 8px 14px;
                border: none;
                border-radius: 6px;
                font-weight: bold;
                font-size: 13px;
                cursor: pointer;
                transition: 0.3s ease;
                color: white;
            }

            .btn-checkin {
                background-color: #007bff;
            }

            .btn-checkin:hover {
                background-color: #0056b3;
            }

            .btn-checkout {
                background-color: #ffc107;
                color: black;
            }

            .btn-checkout:hover {
                background-color: #e0a800;
            }

            .btn-view {
                background-color: #17a2b8;
            }

            .btn-view:hover {
                background-color: #138496;
            }

            .btn-upgrade {
                background-color: #ffc107;
                color: black;
            }

            .btn-upgrade:hover {
                background-color: #e0a800;
            }

            .btn-disabled {
                background-color: var(--disabled-bg);
                color: var(--disabled-text);
                cursor: not-allowed;
            }

            .btn-icon {
                margin-right: 5px;
            }

            @media (max-width: 768px) {
                table, thead, tbody, th, td, tr {
                    display: block;
                }
                tr {
                    margin-bottom: 15px;
                    background: #fff;
                    border-radius: 8px;
                    box-shadow: 0 0 10px rgba(0,0,0,0.05);
                }
                td {
                    text-align: right;
                    padding-left: 50%;
                    position: relative;
                }
                td::before {
                    content: attr(data-label);
                    position: absolute;
                    left: 15px;
                    font-weight: bold;
                    color: #002b5c;
                }
                th {
                    display: none;
                }
            }
        </style>

        <script>
            function handleCheckout(button) {
                const bookingId = button.getAttribute("data-bookingid");
                const endDateStr = button.getAttribute("data-enddate");
                const checkoutDeadline = new Date(endDateStr + "T12:00:00");
                const now = new Date();

                if (now > checkoutDeadline) {
                    const confirmExtra = confirm("Check-out after 12pm may incur an additional charge.\nDo you want to add ExtraCharge?");
                    if (confirmExtra) {
                        // Nếu chọn thêm phụ thu
                        window.location.href = "AddExtraCharge?bookingId=" + bookingId + "&redirect=PaymentCheckOut";
                    } else {
                        // Không thêm phụ thu
                        window.location.href = "PaymentCheckOut?bookingId=" + bookingId;
                    }
                } else {
                    const confirmCheckout = confirm("Are you sure you want to Check-Out?");
                    if (confirmCheckout) {
                        // Check-out bình thường -> chuyển đến trang thanh toán
                        window.location.href = "PaymentCheckOut?bookingId=" + bookingId;
                    }
                }
            }
        </script>
    </head>

    <body>
        <%@ include file="../navbarDashboard/navbarDashboard.jsp" %>
        <%@ include file="../sidebarDashboard/sidebarDashboard.jsp" %>

        <div class="main-content">
            <h2><i class="fas fa-calendar-check"></i> Check-in / Check-out Management</h2>
            <table>
                <thead>
                    <tr>
                        <th>Full Name</th>
                        <th>Room Type</th>
                        <th>Status</th>
                        <th>Action</th>
                        <th>Upgrade</th>
                        <th>Detail</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="booking" items="${checkInList}">
                        <c:if test="${booking.status != 'Waiting' && booking.status != 'Waiting for processing'}">
                            <tr>
                                <td data-label="Customer">
                                    <c:choose>
                                        <c:when test="${booking.customers != null}">${booking.customers.fullName}</c:when>
                                        <c:otherwise>N/A</c:otherwise>
                                    </c:choose>
                                </td>
                                <td data-label="RoomType">
                                    <c:choose>
                                        <c:when test="${booking.roomType != null}">${booking.roomType}</c:when>
                                        <c:otherwise>N/A</c:otherwise>
                                    </c:choose>
                                </td>
                                <td data-label="Status">
                                    <c:choose>
                                        <c:when test="${booking.status == 'Confirmed'}">
                                            <span class="status waiting"><i class="fas fa-clock btn-icon"></i>Confirmed</span>
                                        </c:when>
                                        <c:when test="${booking.status == 'Checked in'}">
                                            <span class="status staying"><i class="fas fa-door-open btn-icon"></i>Checked In</span>
                                        </c:when>
                                        <c:when test="${booking.status == 'Checked out'}">
                                            <span class="status checkedout"><i class="fas fa-check btn-icon"></i>Checked Out</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td data-label="Action">
                                    <c:choose>
                                        <c:when test="${booking.status == 'Confirmed'}">
                                            <form action="ComfirmCheckIn" method="get">
                                                <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                                                <button class="btn-action btn-checkin">
                                                    <i class="fas fa-sign-in-alt btn-icon"></i>Check-In
                                                </button>
                                            </form>
                                        </c:when>
                                        <c:when test="${booking.status == 'Checked in'}">
                                            <form id="checkoutForm-${booking.bookingId}" action="ViewAllCheckInOutDashboard" method="post">
                                                <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                                                <input type="hidden" name="action" value="Checked out" />
                                                <button type="button"
                                                        class="btn-action btn-checkout"
                                                        data-bookingid="${booking.bookingId}"
                                                        data-enddate="${booking.endDate}"
                                                        onclick="handleCheckout(this)">
                                                    <i class="fas fa-sign-out-alt btn-icon"></i>Check-Out
                                                </button>
                                            </form>
                                        </c:when>
                                        <c:when test="${booking.status == 'Checked out'}">
                                            <button class="btn-action btn-disabled" disabled>
                                                <i class="fas fa-check btn-icon"></i>Checked-Out
                                            </button>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td data-label="Upgrade">
                                    <c:choose>
                                        <c:when test="${booking.status == 'Confirmed'}">
                                            <form action="UpgradeBooking" method="get">
                                                <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                                                <button class="btn-action btn-upgrade"><i class="fas fa-arrow-up btn-icon"></i>Upgrade Room</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="btn-action btn-disabled" disabled><i class="fas fa-arrow-up btn-icon"></i>Upgrade Room</button>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td data-label="Detail">
                                    <a href="CheckInOutDetail?bookingId=${booking.bookingId}">
                                        <button class="btn-action btn-view"><i class="fas fa-eye btn-icon"></i>View</button>
                                    </a>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>


