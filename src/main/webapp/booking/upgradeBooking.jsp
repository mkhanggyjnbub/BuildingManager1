<%-- 
    Document   : upgradeBooking
    Created on : 29 Jul 2025, 07:06:05
    Author     : dodan
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách phòng nâng cấp</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f9f9f9;
                padding: 40px;
            }

            h2 {
                text-align: center;
                color: #333;
                margin-bottom: 30px;
            }

            .filter-form {
                text-align: center;
                margin-bottom: 30px;
            }

            .filter-form label {
                font-weight: bold;
                margin-right: 10px;
            }

            .filter-form select {
                padding: 8px 12px;
                border-radius: 6px;
                border: 1px solid #ccc;
                font-size: 14px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
                overflow: hidden;
            }

            th, td {
                padding: 12px 16px;
                text-align: left;
            }

            th {
                background-color: #f2f2f2;
                color: #333;
                font-weight: 600;
            }

            td {
                border-bottom: 1px solid #eee;
            }

            tr:last-child td {
                border-bottom: none;
            }

            img {
                max-width: 100px;
                height: auto;
                border-radius: 6px;
                box-shadow: 0 0 4px rgba(0,0,0,0.1);
            }

            button {
                padding: 8px 14px;
                background-color: #007BFF;
                color: white;
                border: none;
                border-radius: 6px;
                font-size: 14px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            button:hover {
                background-color: #0056b3;
            }

            @media (max-width: 768px) {
                table, thead, tbody, th, td, tr {
                    display: block;
                }

                thead {
                    display: none;
                }

                tr {
                    margin-bottom: 20px;
                    border: 1px solid #ddd;
                    border-radius: 8px;
                    padding: 10px;
                    background-color: #fff;
                }

                td {
                    padding: 8px 12px;
                    text-align: right;
                    position: relative;
                }

                td::before {
                    content: attr(data-label);
                    position: absolute;
                    left: 12px;
                    top: 8px;
                    font-weight: bold;
                    color: #555;
                    text-align: left;
                }
            }
        </style>
    </head>
    <body>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const priceCells = document.querySelectorAll(".price-cell");

                priceCells.forEach(function (cell) {
                    const rawValue = parseInt(cell.textContent.trim());
                    if (!isNaN(rawValue)) {
                        const formatted = rawValue.toLocaleString('vi-VN'); // Dùng dấu chấm
                        cell.textContent = formatted + ' / VND';
                    }
                });
            });
        </script>

        <%@include file="../navbarDashboard/navbarDashboard.jsp" %>
        <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>

        <h2>Room list for upgrade</h2>

        <!-- Bộ lọc loại phòng -->
        <form method="get" action="UpgradeBooking" class="filter-form">
            <label for="roomType">Lọc theo loại phòng:</label>
            <select name="roomType" id="roomType" onchange="this.form.submit()">
                <option value="all" ${param.roomType == 'all' || param.roomType == null ? 'selected' : ''}>All</option>
                <option value="Standard Room For One" ${param.roomType == 'Standard Room For One' ? 'selected' : ''}>Standard Room For One</option>
                <option value="Standard Room For Two" ${param.roomType == 'Standard Room For Two' ? 'selected' : ''}>Standard Room For Two</option>
                <option value="Family Room For Three" ${param.roomType == 'Family Room For Three' ? 'selected' : ''}>Family Room For Three</option>
                <option value="Family Room For Four" ${param.roomType == 'Family Room For Four' ? 'selected' : ''}>Family Room For Four</option>
                <option value="Family Room For Five" ${param.roomType == 'Family Room For Five' ? 'selected' : ''}>Family Room For Five</option>
            </select>

            <input type="hidden" name="bookingId" value="${bookingId}" />
            <input type="hidden" name="startDate" value="${param.startDate}" />
            <input type="hidden" name="endDate" value="${param.endDate}" />
            <input type="hidden" name="currentPeople" value="${param.currentPeople}" />
        </form>

        <c:set var="foundRoom" value="false" />

        <!-- Danh sách phòng -->
        <table>
            <thead>
                <tr>
                    <th>Room Number</th>
                    <th>Room Type</th>
                    <th>Price</th>
                    <th>Max Occupancy</th>
                    <th>Image</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="room" items="${listR}">
                    <c:if test="${param.roomType == 'all' || empty param.roomType || room.roomType == param.roomType}">
                        <c:set var="foundRoom" value="true" />
                        <tr>
                            <td data-label="Room Number">${room.roomNumber}</td>
                            <td data-label="Room Type">${room.roomType}</td>
                            <td data-label="Price" class="price-cell">${room.price}</td>
                            <td data-label="Max Occupancy">${room.maxOccupancy}</td>
                            <td data-label="Image">
                                <img src="${room.imageUrl}" alt="Room Image" />
                            </td>
                            <td data-label="Action">
                                <form action="UpgradeBooking" method="post">
                                    <input type="hidden" name="roomId" value="${room.roomId}" />
                                    <input type="hidden" name="bookingId" value="${bookingId}" />
                                    <input type="hidden" name="roomType" value="${room.roomType}" />
                                    <button type="submit">Choose Room</button>
                                </form>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>

                <!-- Nếu không có phòng nào -->
                <c:if test="${!foundRoom}">
                    <tr>
                        <td colspan="6" style="text-align: center; padding: 20px; color: red;">
                            There are no rooms available for upgrade.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </body>
</html>