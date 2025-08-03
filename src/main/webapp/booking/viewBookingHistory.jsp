<%-- 
    Document   : viewBookingHistory
    Created on : 1 Jul 2025, 13:47:19
    Author     : dodan
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Booking History</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f6f6f6;
                margin: 0;
                padding: 20px;
            }

            .filter-tabs {
                display: flex;
                justify-content: center;
                gap: 16px;
                margin-bottom: 30px;
                flex-wrap: wrap;
            }

            .filter-tabs a {
                padding: 10px 18px;
                text-decoration: none;
                border-radius: 20px;
                background-color: #e0e0e0;
                color: #333;
                font-weight: 500;
                transition: all 0.2s ease-in-out;
            }

            .filter-tabs a.active {
                background-color: #ee4d2d;
                color: white;
                font-weight: bold;
            }

            .booking-grid-layout {
                width: 50%;
                aspect-ratio: 5 / 2;
                display: grid;
                grid-template-columns: repeat(5, 1fr);
                grid-template-rows: repeat(5, 1fr);
                gap: 8px;
                background-color: white;
                border-radius: 16px;
                padding: 16px;
                margin: 32px auto;
                box-sizing: border-box;
                overflow: hidden;

                /* Làm nổi khối */
                box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .booking-grid-layout:hover {
                transform: translateY(-4px);
                box-shadow: 0 12px 30px rgba(0, 0, 0, 0.2);
            }

            .div1 {
                grid-column: span 4;
            }
            .div3 {
                grid-column-start: 5;
            }
            .div5 {
                grid-column: span 2;
                grid-row: 2 / span 4;
            }
            .div8 {
                grid-column: 3;
                grid-row: 5;
            }
            .div9 {
                grid-column: 4;
                grid-row: 5;
            }
            .div11 {
                grid-column: 3 / span 2;
                grid-row: 2 / span 3;
            }
            .div12 {
                grid-column: 5;
                grid-row: 2;
            }
            .div13 {
                grid-column: 5;
                grid-row: 3;
            }
            .div14 {
                grid-column: 5;
                grid-row: 4;
            }
            .div15 {
                grid-column: 5;
                grid-row: 5;
            }

            .status-box {
                padding: 6px 12px;
                border-radius: 10px;
                text-align: center;
                font-weight: bold;
                text-transform: capitalize;
            }

            .status-waiting {
                background-color: #e6e6e6;
            }
            .status-confirmed {
                background-color: #ffcb74;
            }
            .status-checkedin {
                background-color: #adeff9;
            }
            .status-checkedout {
                background-color: #d6d6d6;
            }
            .status-canceled {
                background-color: #959696;
            }

            .booking-button {
                padding: 8px 12px;
                background-color: #0984e3;
                color: white;
                text-align: center;
                border-radius: 6px;
                font-size: 14px;
                text-decoration: none;
                display: inline-block;
                transition: background-color 0.2s ease;
            }

            .booking-button:hover {
                background-color: #74b9ff;
            }

            /* Viền dọc giữa ảnh và phần note */
            .div5 {
                border-right: 1px solid #e0e0e0;
                padding-right: 12px;
            }

            /* Viền dọc giữa phần note + thời gian và phần nút */
            .div11, .div8, .div9 {
                border-right: 1px solid #e0e0e0;
                padding-right: 12px;
            }

            /* Viền dưới tiêu đề */
            .div1 {
                border-bottom: 1px solid #e0e0e0;
                padding-bottom: 8px;
            }

            /* Viền dưới trạng thái */
            .div3 {
                border-bottom: 1px solid #e0e0e0;
                padding-bottom: 8px;
            }

            .booking-button.disabled {
                background-color: #cccccc;
                color: #666666;
                cursor: not-allowed;
                pointer-events: none;
            }

        </style>

    </head>
    <body>
        <%@include file="../header/header.jsp" %>
        <br><br><br><br>

        <c:set var="currentStatus" value="${param.status}" />
        <c:if test="${empty currentStatus}">
            <c:set var="currentStatus" value="all" />
        </c:if>

        <div class="filter-tabs">
            <a href="${pageContext.request.contextPath}/ViewBookingHistory?status=all" class="${currentStatus == 'all' ? 'active' : ''}">All</a>
            <a href="${pageContext.request.contextPath}/ViewBookingHistory?status=Waiting for processing" class="${currentStatus == 'Waiting for processing' ? 'active' : ''}">Waiting for Confirmation</a>
            <a href="${pageContext.request.contextPath}/ViewBookingHistory?status=Confirmed" class="${currentStatus == 'Confirmed' ? 'active' : ''}">Confirmed</a>
            <a href="${pageContext.request.contextPath}/ViewBookingHistory?status=Checked in" class="${currentStatus == 'Checked in' ? 'active' : ''}">Checked In</a>
            <a href="${pageContext.request.contextPath}/ViewBookingHistory?status=Checked out" class="${currentStatus == 'Checked out' ? 'active' : ''}">Checked Out</a>
            <a href="${pageContext.request.contextPath}/ViewBookingHistory?status=Canceled" class="${currentStatus == 'Canceled' ? 'active' : ''}">Canceled</a>
        </div>

        <c:forEach var="b" items="${bookings}">
            <c:if test="${currentStatus == 'all' || b.status == currentStatus}">
                <div class="booking-grid-layout">

                    <!-- div1: Tên khách sạn -->
                    <div class="div1">
                        <h2>Big Resort</h2>
                        <h4>Room: ${b.rooms.roomNumber}</h4>
                    </div>

                    <!-- div3: Trạng thái -->
                    <div class="div3">
                        <div class="status-box
                             ${b.status == 'Waiting for processing' ? 'status-waiting' : ''}
                             ${b.status == 'Confirmed' ? 'status-confirmed' : ''}
                             ${b.status == 'Checked in' ? 'status-checkedin' : ''}
                             ${b.status == 'Checked out' ? 'status-checkedout' : ''}
                             ${b.status == 'Canceled' ? 'status-canceled' : ''}">
                            ${b.status}
                        </div>
                    </div>

                    <!-- div5: Ảnh phòng -->
                    <div class="div5">
                        <img src="${b.rooms.imageUrl}" alt="Room Image" style="width:100%; height:100%; object-fit: cover; border-radius: 8px;">
                    </div>

                    <!-- div11: Note -->
                    <div class="div11">
                        <p><strong>Note:</strong> ${b.notes}</p>
                    </div>

                    <!-- div8: StartDate -->
                    <div class="div8">
                        <p><strong>Start:</strong> 
                        <h3>${b.startDate}</h3>
                        </p>
                    </div>

                    <div class="div9">
                        <p><strong>End:</strong> 
                        <h3>${b.endDate}</h3>
                        </p>
                    </div>

                    <!-- div12: Đánh giá -->
                    <div class="div12">
                        <a class="booking-button" href="ViewRoomDetail?id=${b.roomId}">Rating</a>
                    </div>

                    <!-- div13: Hủy đặt nếu đúng trạng thái -->
                    <div class="div13">
                        <c:choose>
                            <c:when test="${b.status == 'Waiting for processing' || b.status == 'Confirmed'}">
                                <button class="booking-button cancel-btn" 
                                        data-startdate="${b.startDate}" 
                                        data-bookingid="${b.bookingId}">
                                    Cancel
                                </button>
                            </c:when>

                            <c:otherwise>
                                <button class="booking-button disabled">Cancel</button>
                            </c:otherwise>
                        </c:choose>
                    </div>



                    <!-- div14: Đặt lại -->
                    <div class="div14">
                        <a class="booking-button" href="ViewRoomDetail?id=${b.roomId}">Book Again</a>
                    </div>

                    <!-- div15: Xem chi tiết -->
                    <div class="div15">
                        <a class="booking-button" href="#">View Details</a>
                    </div>

                </div>
            </c:if>
        </c:forEach>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Bắt tất cả các nút có class "cancel-btn"
                const cancelButtons = document.querySelectorAll(".cancel-btn");

                cancelButtons.forEach(button => {
                    button.addEventListener("click", function () {
                        const startDate = this.getAttribute("data-startdate");
                        const bookingId = this.getAttribute("data-bookingid");

                        // Gọi hàm xử lý
                        showCancelPopup(startDate, bookingId);
                    });
                });
            });

            function showCancelPopup(startDate, bookingId) {
                if (!bookingId) {
                    alert("Booking ID not found.");
                    return;
                }

                const message = checkCancellationTime(startDate);
                if (confirm(message)) {
                    window.location.href = "CancelBookingForCustomer?bookingId=" + bookingId;
                }
            }



            function checkCancellationTime(startDateString) {
                const startDate = new Date(startDateString);
                startDate.setHours(12, 0, 0, 0); // set to 12:00 noon on StartDate

                const now = new Date();
                const diffMs = startDate - now;
                const diffHours = diffMs / (1000 * 60 * 60);

                if (diffHours >= 24) {
                    return "Do you want to cancel your booking? You will get back 30% of your booking fee.";
                } else {
                    return "Your cancellation is late. If you cancel now, you will lose 30% of your booking fee. Do you still want to proceed?";
                }
            }

        </script>

    </body>
</html>
