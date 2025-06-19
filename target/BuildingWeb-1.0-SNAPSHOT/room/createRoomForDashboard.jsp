<%-- 
    Document   : createRoomForDashboard
    Created on : Jun 19, 2025, 12:16:48 PM
    Author     : Ki?u Hoàng M?nh Khang - ce180749 
--%>

<%@page contentType="text/html" pageEncoding="windows-1252"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Create Room</title>
        <style>
            .form-container {
                max-width: 600px;
                margin: 30px auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 12px;
            }
            .form-group {
                margin-bottom: 15px;
            }
            label {
                font-weight: bold;
            }
            input[type="text"],
            input[type="number"],
            textarea,
            select {
                width: 100%;
                padding: 8px;
                margin-top: 4px;
                border-radius: 6px;
                border: 1px solid #ccc;
            }
            .controls {
                display: flex;
                gap: 5px;
                align-items: center;
            }
            .controls button {
                padding: 6px 12px;
            }
        </style>

        <script>
            function adjustValue(id, delta, max = Infinity) {
                const input = document.getElementById(id);
                let val = parseInt(input.value || "0", 10);
                val = Math.max(0, Math.min(val + delta, max));
                input.value = val;
            }
        </script>
    </head>
    <body>

        <div class="form-container">
            <h2>Create Room (Admin Dashboard)</h2>
            <form action="CreateRoomServlet" method="post">

                <!-- Floor Number: 1 - 10 -->
                <div class="form-group">
                    <label for="floorNumber">Floor Number</label>
                    <select id="floorNumber" name="floorNumber" required>
                        <c:forEach begin="1" end="10" var="i">
                            <option value="${i}">${i}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Room Number: 01 - 99 -->
                <div class="form-group">
                    <label for="roomNumber">Room Number</label>
                    <select id="roomNumber" name="roomNumber" required>
                        <c:forEach begin="1" end="99" var="i">
                            <c:set var="formatted" value="${fn:substring('00' + i, fn:length('' + i), fn:length('' + i) + 2)}"/>
                            <option value="${formatted}">${formatted}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Room Type -->
                <div class="form-group">
                    <label for="roomType">Room Type</label>
                    <select id="roomType" name="roomType" required>
                        <option value="${type}"></option>
                        <option value="${type}">${type}</option>
                        <option value="${type}">${type}</option>
                    </select>
                </div>

                <!-- Bed Type -->
                <div class="form-group">
                    <label for="bedType">Bed Type</label>
                    <select id="bedType" name="bedType" required>
                            <option value="${bed}">${bed}</option>
                    </select>
                </div>

                <!-- Price -->
                <div class="form-group">
                    <label for="price">Price</label>
                    <div class="controls">
                        <button type="button" onclick="adjustValue('price', -1000)">-1000</button>
                        <input type="number" id="price" name="price" required>
                        <button type="button" onclick="adjustValue('price', 1000)">+1000</button>
                    </div>
                </div>

                <!-- Max Occupancy -->
                <div class="form-group">
                    <label for="maxOccupancy">Max Occupancy</label>
                    <div class="controls">
                        <button type="button" onclick="adjustValue('maxOccupancy', -1, 6)">-</button>
                        <input type="number" id="maxOccupancy" name="maxOccupancy" min="1" max="6" required>
                        <button type="button" onclick="adjustValue('maxOccupancy', 1, 6)">+</button>
                    </div>
                </div>

                <!-- Description -->
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" rows="3" required></textarea>
                </div>

                <!-- Image URL -->
                <div class="form-group">
                    <label for="imageUrl">Image URL</label>
                    <input type="text" id="imageUrl" name="imageUrl" required>
                </div>

                <!-- Status -->
                <div class="form-group">
                    <label for="status">Status</label>
                    <select id="status" name="status" required>
                        <option value="Active">Active</option>
                        <option value="Inactive">Inactive</option>
                    </select>
                </div>

                <!-- Building ID -->
                <div class="form-group">
                    <label for="buildingId">Building ID</label>
                    <input type="number" id="buildingId" name="buildingId" required>
                </div>

                <div class="form-group">
                    <button type="submit">Create Room</button>
                </div>
            </form>
        </div>

    </body>
</html>

