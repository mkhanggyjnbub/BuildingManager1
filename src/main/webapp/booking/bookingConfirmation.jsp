<%-- 
    Document   : bookingConfirmation
    Created on : Jun 18, 2025, 1:00:51 AM
    Author     : Dương Đinh Thế Vinh
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
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                document.querySelectorAll("input[name='statusSwitch']").forEach(function (checkbox) {
                    checkbox.addEventListener('change', function () {
                        const form = this.closest('form');
                        const hiddenStatus = form.querySelector('input[name="status"]');
                        const action = this.checked ? 'booking confirmation' : 'transfer to processing';

                        if (confirm("You definitely want to " + action + "?")) {
                            // Cập nhật giá trị status
                            hiddenStatus.value = this.checked ? 'true' : 'false';
                            form.submit();
                        } else {
                            // Nếu không xác nhận thì trả lại checkbox như cũ
                            this.checked = !this.checked;
                        }
                    });
                });
            });

        </script>
    </head>
    <body>

        <h1>booking confirmation list</h1>

        <table>
            <tr>
                <th>BookingId</th>
                <th>RoomNumber</th>
                <th>UserName</th>
                <th>Check-in Date</th>
                <th>check-out Date</th>
                <th>Status</th>
                <th>Cancel Booking</th>
            </tr>

            <c:forEach var="booking" items="${booking}">
                <tr>
                    <td>${booking.bookingId}</td>
                    <td>${booking.roomNumber}</td>
                    <td>${booking.userName}</td>
                    <td>${booking.startDate}</td>
                    <td>${booking.endDate}</td>


                    <td>
                        <span style="margin-right:10px;">
                            <c:choose>
                                <c:when test="${booking.status == true}">
                                    Confirmed
                                </c:when>
                                <c:otherwise>
                                    Processing
                                </c:otherwise>
                            </c:choose>
                        </span>

                        <form action="BookingConfirmation" method="post" style="display:inline;">
                            <input type="hidden" name="bookingId" value="${booking.bookingId}" />

                            <input type="hidden" name="status" value="${booking.status}" />
                            <label class="switch">
                                <input type="checkbox" ${booking.status ? 'checked' : ''} name="statusSwitch">
                                <span class="slider"></span>
                            </label>
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
