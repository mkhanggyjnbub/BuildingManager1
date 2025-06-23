<%-- 
    Document   : bookingConfirmation
    Created on : Jun 18, 2025, 1:00:51 AM
    Author     : Dương Đinh Thế Vinh CE180441
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking List</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f0f2f5;
                margin: 0;
                padding: 20px;
                color: #333;
            }

            h1 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 30px;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            form {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 10px;

            }

            input[type="text"],
            input[type="date"],
            select {
                padding: 8px 12px;
                border-radius: 8px;
                border: 1px solid #ccc;
                font-size: 14px;
                background-color: #fff;
            }

            button {
                padding: 8px 16px;
                border-radius: 8px;
                font-weight: bold;
                border: none;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            button[type="submit"] {
                background-color: #3498db;
                color: white;
            }

            button[type="submit"]:hover {
                background-color: #2980b9;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: white;
                box-shadow: 0 4px 10px rgba(0,0,0,0.05);
                border-radius: 10px;
                overflow: hidden;
            }

            table th,
            table td {
                padding: 14px 12px;
                text-align: center;
                border-bottom: 1px solid #e0e0e0;
            }

            table th {
                background-color: #000080;
                color: white;
                font-weight: 600;
            }

            table tr:last-child td {
                border-bottom: none;
            }

            .waiting {
                background-color: #f1c40f;
                color: white;
            }

            .confirmed {
                background-color: #2ecc71;
                color: white;
            }

            .cancel {
                background-color: #e74c3c;
                color: white;
            }

            .cancel:hover {
                background-color: #c0392b;
            }

            .icon-button {
                background: transparent;
                border: none;
                cursor: pointer;
                font-size: 1.2rem;
                color: #555;
                transition: color 0.2s ease;
            }

            .icon-button:hover {
                color: #2c3e50;
            }

            .cancel-modal {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.5);
                display: none;
                justify-content: center;
                align-items: center;
                z-index: 999;
            }

            .modal-content {
                background: #fff;
                padding: 20px;
                border-radius: 10px;
                width: 350px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            }

            .modal-content textarea {
                border-radius: 6px;
                border: 1px solid #ccc;
                resize: none;
                font-size: 14px;
            }

            .modal-actions {
                margin-top: 15px;
                display: flex;
                justify-content: flex-end;
                gap: 10px;
            }

            .modal-actions button {
                padding: 8px 14px;
                border-radius: 6px;
                font-size: 14px;
            }

            .modal-actions button:first-child {
                background-color: #e74c3c;
                color: white;
            }

            .modal-actions button:last-child {
                background-color: #bdc3c7;
                color: white;
            }

            @media screen and (max-width: 768px) {
                form {
                    flex-direction: column;
                    align-items: center;
                }

                table th, table td {
                    font-size: 13px;
                    padding: 10px;
                }
            }
        </style>

        <script>
            function openCancelModal(bookingId) {
                const modal = document.getElementById("cancelModal-" + bookingId);
                if (modal) {
                    modal.style.display = "flex";
                } else {
                    console.error("Modal not found for ID: " + bookingId);
                }
            }

            function closeCancelModal(bookingId) {
                const modal = document.getElementById("cancelModal-" + bookingId);
                if (modal) {
                    modal.style.display = "none";
                }
            }

            function confirmReason(bookingId) {
                const reason = document.getElementById("notesTextarea-" + bookingId).value.trim();
                if (!reason) {
                    alert("Please enter a reason for cancellation.");
                    return;
                }

                document.getElementById("notesInput-" + bookingId).value = reason;
                document.getElementById("cancelForm-" + bookingId).submit();
            }
        </script>


    </head>
    <body>

        <h1>booking confirmation list</h1>

        <form action="BookingConfirmation" method="post" style="margin-bottom: 20px;">
            Room Number: <input type="text" name="roomNumber" value="${param.roomNumber}">
            Full Name: <input type="text" name="fullName" value="${param.fullName}">
            Start Date: <input type="date" name="startDate" value="${param.startDate}">
            End Date: <input type="date" name="endDate" value="${param.endDate}">

            Status:
            <select name="status">
                <option value="">-- All --</option>
                <option value="Waiting for processing" ${status == 'Waiting for processing' ? 'selected' : ''}>Waiting for processing</option>
                <option value="Confirmed" ${status == 'Confirmed' ? 'selected' : ''}>Confirmed</option>
            </select>

            <button type="submit">Search</button>
        </form>
        <table border="1">
            <tr>

                <th>Room Number</th>
                <th>User Name</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Status</th>
                <th>Cancel Booking</th>


            </tr>

            <tbody>
                <c:forEach var="booking" items="${booking}">    
                    <tr>

                        <%--<td>${booking.bookingId}</td> --%>
                        <td>${booking.rooms.roomNumber}</td>
                        <td>${booking.customers.fullName}</td>
                        <td>${booking.formattedStartDate}</td>
                        <td>${booking.formattedEndDate}</td>

                        <td>
                            <c:choose>
                                <c:when test="${booking.status == 'Waiting for processing'}">
                                    <form action="BookingConfirmation" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to confirm this booking?');">
                                        <input type="hidden" name="actionType" value="confirmBooking" />
                                        <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                                        <button type="submit" class="waiting">Waiting</button>
                                    </form>

                                </c:when>

                                <c:when test="${booking.status == 'Confirmed'}">
                                    <button type="button" class="confirmed" disabled>Confirmed</button>
                                </c:when>
                            </c:choose>
                        </td>

                        <td>
                            <!-- Form cancel -->
                            <form id="cancelForm-${booking.bookingId}" action="BookingCancel" method="post">
                                <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                                <input type="hidden" name="notes" id="notesInput-${booking.bookingId}" />

                                <!-- Nút Cancel duy nhất -->
                                <button type="button" class="cancel" onclick="openCancelModal(${booking.bookingId})">Cancel</button>
                            </form>

                            <!-- Modal nhập lý do -->
                            <div id="cancelModal-${booking.bookingId}" class="cancel-modal" style="display: none;">
                                <div class="modal-content">
                                    <label for="notesTextarea-${booking.bookingId}">Reason for cancellation:</label>
                                    <textarea id="notesTextarea-${booking.bookingId}" placeholder="Enter reason..." rows="4" style="width: 100%;"></textarea>
                                    <div class="modal-actions">
                                        <button type="button" onclick="confirmReason(${booking.bookingId})">OK</button>
                                        <button type="button" onclick="closeCancelModal(${booking.bookingId})">Close</button>
                                    </div>
                                </div>
                            </div>
                        </td>


                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
