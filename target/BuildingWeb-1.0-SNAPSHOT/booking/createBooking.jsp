<%-- 
    Document   : createBooking
    Created on : Jul 15, 2025, 2:40:07 AM
    Author     : Dương Đinh Thế Vinh CE180441
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Make reservation</title>

        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background: #f7f9fc;
                margin: 0;
                padding: 20px;
            }

            h2, h3 {

                color: #2c3e50;
            }

            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background: white;
                padding: 30px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.3);
                border-radius: 10px;
                min-width: 300px;
                animation: fadeIn 0.3s ease-in-out;
            }

            .modal button {
                margin: 10px 0;
                padding: 10px 20px;
                background: #3498db;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .modal button:hover {
                background: #2980b9;
            }

            form {
                margin-top: 20px;
                text-align: center;
            }

            form label {
                display: block;
                margin-top: 10px;
                font-weight: bold;
            }

            form input {
                padding: 8px;
                width: 70%;
                margin: 5px auto;
                display: block;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .search-box {
                margin: 30px auto;
                padding: 20px;
                background: #ecf0f1;
                width: 80%;
                border-radius: 10px;
            }

            .search-form {
                display: flex;
                flex-wrap: wrap;
                gap: 16px;
                align-items: center;
                margin: 20px 0;
            }

            .search-form label {
                font-weight: bold;
                margin-right: 6px;
            }

            .search-form input {
                padding: 6px 20px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .search-form button {
                padding: 6px 12px;
                background-color: #3498db;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                margin-top: 32px;
            }

            .search-form button:hover {
                background-color: #2980b9;
            }


            table {
                width: 90%;
                margin: 0 auto;
                border-collapse: collapse;
                margin-top: 20px;
            }

            table th, table td {
                border: 1px solid #ccc;
                padding: 12px;
                text-align: center;
            }

            table thead {
                background: #2980b9;
                color: white;
            }

            table tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            table tr:hover {
                background-color: #dfe6e9;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }


            .dashboard-layout {
                display: flex;
            }

            /* Nội dung ban đầu lệch 60px */
            .main-content {
                margin-left: 60px;
                padding: 20px;
                flex: 1;
                transition: margin-left 0.3s ease;
            }

            /* Khi sidebar mở rộng */
            .sidebar.open ~ .main-content {
                margin-left: 220px;
            }


            .booking-btn {
                background-color: #00b894;
                color: white;
                padding: 10px 18px;
                font-weight: 600;
                font-size: 15px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.2s ease;
                box-shadow: 0 4px 6px rgba(0, 184, 148, 0.2);
            }

            .booking-btn:hover {
                background-color: #019875;
                transform: translateY(-2px);
            }

            .booking-btn:active {
                transform: translateY(1px);
                background-color: #017a60;
            }


        </style>
    </head>    

    <body <c:if test="${empty customer}">onload="showAccountChoicePopup()"</c:if>>
        <%@ include file="../navbarDashboard/navbarDashboard.jsp" %>

        <div class="dashboard-layout">
            <%@ include file="../sidebarDashboard/sidebarDashboard.jsp" %>

            <div class="main-content" id="main-content">

                <!-- Modal chọn loại tài khoản -->
                <div id="accountModal" class="modal">
                    <h3>Does the customer have an account yet?</h3>
                    <button onclick="showExistingForm()">✅ Already have an account</button>
                    <button onclick="showGuestForm()">❌ No account yet</button>
                </div>

                <!-- Form khách đã có tài khoản -->
                <div id="existingForm" class="modal">
                    <h3>Customer Verification</h3>
                    <form method="post" action="CheckExistingCustomer">
                        <label>Full name:</label>
                        <input type="text" name="fullName" required>
                        <label>Phone number:</label>
                        <input type="text" name="phone" required>
                        <button type="submit">Confirm</button>
                    </form>
                </div>

                <!-- Form khách chưa có tài khoản -->
                <div id="guestForm" class="modal">
                    <h3>New Guest Registration</h3>
                    <form method="post" action="CreateGuestCustomer">
                        <label>Full name:</label>
                        <input type="text" name="fullName" required>
                        <label>Phone number:</label>
                        <input type="text" name="phone" required>
                        <label for="identityNumber">Identity Number:</label>
                        <input type="text" name="identityNumber" id="identityNumber" required>

                        <label>Email (can be left blank):</label>
                        <input type="email" name="email">
                        <button type="submit">Create temporary account</button>
                    </form>
                </div>



                <c:if test="${not empty customer}">
                    <h2>Customer: ${customer.fullName}</h2>
                    <p><strong>Phone: </strong> ${customer.phone}</p>
                    <c:if test="${not empty customer.identityNumber}">
                        <p><strong>Identity Number:</strong> ${customer.identityNumber}</p>
                    </c:if>


                    <c:if test="${!customer.registered}">
                        <p style="color: #ff9900;"><em>Temporary account</em></p>
                    </c:if>

                    <form method="get" action="CheckExistingCustomer">
                        <input type="hidden" name="action" value="logoutCustomer" />
                        <button type="submit" style="background-color: crimson; color: white; padding: 8px 16px; border: none; border-radius: 4px; display: flex">
                            Exit
                        </button>
                    </form>


                    <!-- Tìm phòng -->
                    <div class="search-box">
                        <form method="post" action="CreateBooking" class="search-form">
                            <label>Check in:
                                <input type="date" id="startDate" name="startDate"
                                       value="${startDate}" required />
                            </label>
                            <label>Check out:
                                <input type="date" id="endDate" name="endDate"
                                       value="${endDate}" required />
                            </label>
                            <label>Adult:
                                <input type="number" name="adults" id="adults" value="${adults}" min="1" required />
                            </label>
                            <label>Children:
                                <input type="number" name="children" id="children" value="${children}" min="0" required />
                            </label>

                            <input type="hidden" name="action" value="searchRoom" />
                            <button type="submit">Find available rooms</button>
                        </form>
                    </div>


                    <!-- Danh sách phòng -->
                    <c:if test="${not empty rooms}">
                        <h3>List of available room types</h3>
                        <table>
                            <thead>
                                <tr>
                                    <th>Room</th>
                                    <th>Type</th>
                                    <th>Price</th>
                                    <th>Max Occupancy</th>
                                    <th>Booking</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="room" items="${rooms}">
                                    <tr>
                                        <td>${room.roomNumber}</td>
                                        <td>${room.roomType}</td>
                                        <td>${room.price} VNĐ</td>
                                        <td>${room.maxOccupancy} People</td> 
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty bookingId}">
                                                    <form method="post" action="CreateBooking">
                                                        <input type="hidden" name="action" value="upgradeRoom" />
                                                        <input type="hidden" name="originalBookingId" value="${originalBookingId}" />
                                                        <input type="hidden" name="roomId" value="${room.roomId}" />
                                                        <input type="hidden" name="startDate" value="${startDate}" />
                                                        <input type="hidden" name="endDate" value="${endDate}" />
                                                        <input type="hidden" name="adults" value="${adults}" />
                                                        <input type="hidden" name="children" value="${children}" />
                                                        <button type="submit" style="background-color: orange; color: white;">Upgrade</button>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                                                    <form method="post" action="CreateBooking">
                                                        <input type="hidden" name="action" value="bookRoom" />
                                                        <input type="hidden" name="roomId" value="${room.roomId}" />
                                                        <input type="hidden" name="startDate" value="${startDate}" />
                                                        <input type="hidden" name="endDate" value="${endDate}" />
                                                        <input type="hidden" name="adults" value="${adults}" />
                                                        <input type="hidden" name="children" value="${children}" />
                                                        <button type="submit">Booking</button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>


                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </c:if>

            </div>
            <script>
                function showAccountChoicePopup() {
                    document.getElementById('accountModal').style.display = 'block';
                }

                function showExistingForm() {
                    document.getElementById('accountModal').style.display = 'none';
                    document.getElementById('existingForm').style.display = 'block';
                }

                function showGuestForm() {
                    document.getElementById('accountModal').style.display = 'none';
                    document.getElementById('guestForm').style.display = 'block';
                }

                document.addEventListener("DOMContentLoaded", function () {
                    const startInput = document.getElementById("startDate");
                    const endInput = document.getElementById("endDate");
                    const adultsInput = document.getElementById("adults");
                    const childrenInput = document.getElementById("children");

                    const today = new Date();
                    const yyyy = today.getFullYear();
                    const mm = String(today.getMonth() + 1).padStart(2, '0');
                    const dd = String(today.getDate()).padStart(2, '0');
                    const todayStr = `${yyyy}-${mm}-${dd}`;

                            if (startInput && endInput) {

                                let selectedStart = startInput.value;
                                if (!selectedStart || selectedStart < todayStr) {
                                    selectedStart = todayStr;
                                    startInput.value = todayStr;
                                }
                                startInput.setAttribute("min", todayStr);

                                // áp dụng selectedStart làm min cho endDate
                                endInput.setAttribute("min", selectedStart);
                                if (!endInput.value || endInput.value < selectedStart) {
                                    endInput.value = selectedStart;
                                }

                                // cập nhật endDate
                                startInput.addEventListener("change", function () {
                                    const newStart = this.value;
                                    endInput.setAttribute("min", newStart);
                                    if (!endInput.value || endInput.value < newStart) {
                                        endInput.value = newStart;
                                    }
                                });
                            }

                            // xác thực người số người
                            function validateNumberInput(input, min) {
                                input.addEventListener("input", function () {
                                    this.value = this.value.replace(/[^0-9]/g, '');
                                    if (this.value !== '' && parseInt(this.value) < min) {
                                        this.value = min;
                                    }
                                });
                                input.addEventListener("keydown", function (e) {
                                    const invalidKeys = ['e', 'E', '+', '-', '.'];
                                    if (invalidKeys.includes(e.key)) {
                                        e.preventDefault();
                                    }
                                });
                            }

                            validateNumberInput(adultsInput, 1);
                            validateNumberInput(childrenInput, 0);
                        });


                        function toggleSidebar() {
                            const sidebar = document.getElementById("sidebar");
                            const mainContent = document.getElementById("main-content");

                            sidebar.classList.toggle("open");

                            if (sidebar.classList.contains("open")) {
                                mainContent.style.marginLeft = "220px";
                            } else {
                                mainContent.style.marginLeft = "60px";
                            }
                        }

            </script>




            <c:if test="${bookingSuccess}">
                <script>alert("✅ Booking successful!");</script>
            </c:if>
            <c:if test="${bookingError}">
                <script>alert("❌ data entry request");</script>
            </c:if>

            <c:if test="${notFound}">
                <script>
                    alert("❌ Customer not found. Please check your Name and Phone Number again.");
                </script>
            </c:if>

            <c:if test="${not empty sessionScope.duplicateError}">
                <script>
                    alert("${sessionScope.duplicateError}");
                </script>
                <c:remove var="duplicateError" scope="session"/>
            </c:if>

    </body>

</html>
