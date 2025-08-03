<%-- 
    Document   : updateRoomOption
    Created on : Jul 23, 2025, 2:30:33 AM
    Author     : KHANH
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Available Rooms for Upgrade</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f0f4f8;
            padding: 40px;
        }
        h2 {
            color: #002b5c;
            text-align: center;
        }
        table {
            margin: 0 auto;
            width: 70%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #002b5c;
            color: white;
        }
        tr:hover {
            background-color: #eef6fb;
        }
    </style>
</head>
<body>
    <h2>Available Rooms For Upgrade</h2>

    <c:if test="${empty availableRooms}">
        <p style="text-align:center; color: red;">No rooms available for upgrade.</p>
    </c:if>

    <c:if test="${not empty availableRooms}">
        <table>
            <thead>
                <tr>
                    <th>Room ID</th>
                    <th>Room Number</th>
                    <th>Room Type</th>
                    <th>Max Occupancy</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="room" items="${availableRooms}">
                    <tr>
                        <td>${room.roomId}</td>
                        <td>${room.roomNumber}</td>
                        <td>${room.roomType}</td>
                        <td>${room.maxOccupancy}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <div style="text-align:center; margin-top: 20px;">
        <a href="ViewAllCheckInOutDashboard"><button>Back</button></a>
    </div>
</body>
</html>
