<%-- 
    Document   : bookingConfirmation
    Created on : Jun 18, 2025, 1:00:51 AM
    Author     : Dương Đinh Thế Vinh CE180441
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking List</title>
        <style>
            table {
                border-collapse: collapse;
                width: 80%;
                margin: auto;
            }
            th, td {
                border: 1px solid black;
                padding: 8px;
                text-align: center;
            }
            th {
                background-color: #f2f2f2;
            }
            h1 {
                text-align: center;
            }
            .switch {
                position: relative;
                display: inline-block;
                width: 50px;
                height: 25px;
            }
            .switch input {
                display:none;
            }
            .slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                transition: .4s;
                border-radius: 25px;
            }
            .slider:before {
                position: absolute;
                content: "";
                height: 20px;
                width: 20px;
                left: 3px;
                bottom: 3px;
                background-color: white;
                transition: .4s;
                border-radius: 50%;
            }
            input:checked + .slider {
                background-color: #4CAF50;
            }
            input:checked + .slider:before {
                transform: translateX(25px);
            }
        </style>


    </head>
    <body>

        <h1>booking confirmation list</h1>

        <table border="1">
            <tr>
                <th>BookingId</th>
                <th>RoomNumber</th>
                <th>UserName</th>
                <th>Check-in Date</th>
                <th>Check-out Date</th>
                <th>Status</th>
                <th>Cancel Booking</th>

            </tr>

            <c:forEach var="booking" items="${booking}">
                <tr>
                    <td>${booking.bookingId}</td>
                    <td>${booking.rooms.roomNumber}</td>
                    <td>${booking.customers.fullName}</td>
                    <td>${booking.startDate}</td>
                    <td>${booking.endDate}</td>
                    <td>
                        <form action="BookingConfirmation" method="post" style="display:inline;" 
                              onsubmit="return confirm('Bạn có chắc muốn xác nhận booking này?');">
                            <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                            <input type="hidden" name="status" value="Confirmed" />

                            <c:choose>
                                <c:when test="${booking.status == 'Waiting for processing'}">
                                    <form action="BookingConfirmation" method="post" style="display:inline;" 
                                          onsubmit="return confirm('Bạn có chắc muốn xác nhận booking này?');">
                                        <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                                        <input type="hidden" name="status" value="Confirmed" />
                                        <button type="submit" style="background-color: gold; color: black; border: none; padding: 5px 10px;">
                                            Waiting
                                        </button>
                                    </form>
                                </c:when>
                                <c:when test="${booking.status == 'Confirmed'}">
                                    <button type="button" style="background-color: limegreen; color: white; border: none; padding: 5px 10px;" disabled>
                                        Confirmed
                                    </button>
                                </c:when>
                            </c:choose>

                        </form>

                    </td>

                    <td>
                        <form action="DeleteBookingProcessing" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this booking?');">
                            <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                            <input type="hidden" name="roomId" value="${booking.roomId}" />
                            <button type="submit">Cancel</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>


    </body>
</html>
