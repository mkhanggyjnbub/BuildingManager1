<%-- 
    Document   : viewBookingDetail
    Created on : Jul 22, 2025, 3:02:47 PM
    Author     : Dương Đinh Thế Vinh CE180441
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Detail</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 40px;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            h2 {
                color: #333;
                margin-bottom: 30px;
            }

            .booking-card {
                background-color: #fff;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                padding: 30px 40px;
                width: 100%;
                max-width: 600px;
            }

            .booking-card ul {
                list-style: none;
                padding: 0;
            }

            .booking-card li {
                padding: 10px 0;
                border-bottom: 1px solid #e0e0e0;
            }

            .booking-card li:last-child {
                border-bottom: none;
            }

            .booking-card strong {
                display: inline-block;
                width: 180px;
                color: #555;
            }

            .back-btn {
                margin-top: 30px;
                padding: 10px 20px;
                background-color: #0066cc;
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                cursor: pointer;
                text-decoration: none;
            }

            .back-btn:hover {
                background-color: #004b99;
            }
        </style>
    </head>
    <body>
        <h2>📄 Booking Detail</h2>

        <c:choose>
            <c:when test="${not empty bookingDetail}">
                <div class="booking-card">
                    <ul>
                        <li><strong>Booking ID:</strong> ${bookingDetail.bookingId}</li>
                        <li><strong>Room Number:</strong> ${bookingDetail.rooms != null && bookingDetail.rooms.roomNumber != null ? bookingDetail.rooms.roomNumber : 'Not yet'}</li>
                        <li><strong>Customer Name:</strong> ${bookingDetail.customers != null && bookingDetail.customers.fullName != null ? bookingDetail.customers.fullName : 'Not yet'}</li>
                        <li><strong>Start Date:</strong> ${bookingDetail.startDate != null ? bookingDetail.startDate : 'Not yet'}</li>
                        <li><strong>End Date:</strong> ${bookingDetail.endDate != null ? bookingDetail.endDate : 'Not yet'}</li>
                        <li><strong>Room Type:</strong> ${bookingDetail.roomType}</li>
                            <c:choose>
                                <c:when test="${bookingDetail.userName == null}">
                                <li><strong>Confirmed By:</strong> Not yet</li>
                                </c:when>
                                <c:otherwise>
                                <li><strong>Confirmed By:</strong> ${bookingDetail.userName.userName}</li>
                                </c:otherwise>
                            </c:choose>
                        <li><strong>Request Time:</strong> ${bookingDetail.requestTime != null ? bookingDetail.requestTime : 'Not yet'}</li>
                        <li><strong>Confirmation Time:</strong> ${bookingDetail.confirmationTime != null ? bookingDetail.confirmationTime : 'Not yet'}</li>
                    </ul>
                </div>
            </c:when>
        </c:choose>

      <a href="BookingConfirmation?highlightId=${bookingDetail.bookingId}">
    <button>🔙 Back to List</button>
    </body>
</html>
