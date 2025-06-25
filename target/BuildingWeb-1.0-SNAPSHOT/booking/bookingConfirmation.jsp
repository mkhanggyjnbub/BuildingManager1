<%-- 
    Document   : bookingConfirmation
    Created on : Jun 18, 2025, 1:00:51 AM
    Author     : Dương Đinh Thế Vinh CE180441
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<<<<<<< HEAD
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Booking List</title>

  <!-- ICON LIB -->
  <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

  <%@include file="../navbarDashboard/navbarDashboard.jsp" %>
  <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>

  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background: #f0f2f5;
      margin: 0;
      padding: 80px 30px 40px;
      transition: margin-left 0.3s ease;
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
      margin-bottom: 20px;
    }

    input[type="text"], input[type="date"], select {
      padding: 8px 12px;
      border-radius: 8px;
      border: 1px solid #ccc;
      font-size: 14px;
      width: auto;
      background: #fff;
    }

    button[type="submit"] {
      padding: 8px 16px;
      border-radius: 8px;
      border: none;
      font-weight: bold;
      background: #3498db;
      color: #fff;
      cursor: pointer;
      transition: background-color .3s;
    }

    button[type="submit"]:hover {
      background: #2980b9;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background: #fff;
      box-shadow: 0 4px 10px rgba(0,0,0,0.05);
      border-radius: 10px;
      overflow: hidden;
    }

    th, td {
      padding: 14px 12px;
      text-align: center;
      border-bottom: 1px solid #e0e0e0;
    }

    th {
      background: #000080;
      color: #fff;
      font-weight: 600;
    }

    tr:last-child td { border-bottom: none; }

    .waiting { background: #f1c40f; color: #fff; }
    .confirmed { background: #2ecc71; color: #fff; }
    .cancel { background: #e74c3c; color: #fff; }
    .cancel:hover { background: #c0392b; }

    .cancel-modal {
      position: fixed; top:0; left:0;
      width:100%; height:100%;
      background: rgba(0,0,0,0.5);
      display:none; justify-content:center; align-items:center;
      z-index:999;
    }

    .modal-content {
      background:#fff; padding:20px; border-radius:10px;
      width:350px; box-shadow:0 4px 12px rgba(0,0,0,0.2);
    }

    .modal-actions {
      margin-top:15px; display:flex; justify-content:flex-end; gap:10px;
    }

    .modal-actions button {
      padding:8px 14px; border-radius:6px; font-size:14px; border:none;
    }

    .modal-actions button:first-child { background:#e74c3c; color:#fff; }
    .modal-actions button:last-child  { background:#bdc3c7; color:#fff; }

    .popup-overlay {
      position:fixed; top:0; left:0;
      width:100%; height:100%;
      background:rgba(0,0,0,0.5);
      display:none; justify-content:center; align-items:center;
      z-index:1000;
    }

    .popup-box {
      background:#fff; padding:20px 30px;
      border-radius:8px; text-align:center;
      font-size:16px; box-shadow:0 4px 12px rgba(0,0,0,0.3);
    }

    .popup-box button {
      margin-top:15px;
      padding:8px 16px; border:none;
      background:#3498db; color:#fff; border-radius:6px;
      cursor:pointer; transition: .3s;
    }

    .popup-box button:hover { background:#2980b9; }

    @media(max-width:768px){
      form { flex-direction: column; align-items: center; }
      th, td { font-size:13px; padding:10px; }
    }
  </style>
</head>

<body>
  <div class="main-content">
    <h1>Booking Confirmation List</h1>

    <form action="BookingConfirmation" method="post">
      Room Number:
      <input type="number" name="roomNumber" min="1" max="999"
             oninput="this.value=this.value.slice(0,3)" placeholder="1–999">
      Full Name:
      <input type="text" name="fullName" maxlength="30"
             pattern="[A-Za-zÀ-ỹ\s]+" title="Only letters" oninput="this.value=this.value.replace(/[0-9]/g,'')">
      Start Date: <input type="date" name="startDate" value="${param.startDate}">
      End Date: <input type="date" name="endDate" value="${param.endDate}">
      Status:
      <select name="status">
        <option value="">-- All --</option>
        <option value="Waiting for processing" ${status == 'Waiting for processing' ? 'selected' : ''}>Waiting</option>
        <option value="Confirmed" ${status == 'Confirmed' ? 'selected' : ''}>Confirmed</option>
      </select>
      <button type="submit">Search</button>
    </form>

    <c:if test="${not empty booking}">
      <table>
        <thead>
          <tr>
            <th>Room</th><th>Customer</th><th>Start Date</th><th>End Date</th>
            <th>Status</th><th>Cancel Booking</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="b" items="${booking}">
            <tr>
              <td>${b.rooms.roomNumber}</td>
              <td>${b.customers.fullName}</td>
              <td>${b.formattedStartDate}</td>
              <td>${b.formattedEndDate}</td>
              <td>
                <c:choose>
                  <c:when test="${b.status == 'Waiting for processing'}">
                    <form method="post" style="display:inline;" onsubmit="return confirm('Confirm this booking?');">
                      <input type="hidden" name="actionType" value="confirmBooking">
                      <input type="hidden" name="bookingId" value="${b.bookingId}">
                      <button type="submit" class="waiting">Waiting</button>
                    </form>
                  </c:when>
                  <c:when test="${b.status == 'Confirmed'}">
                    <button class="confirmed" disabled>Confirmed</button>
                  </c:when>
                </c:choose>
              </td>
              <td>
                <form id="cancelForm-${b.bookingId}" action="BookingCancel" method="post">
                  <input type="hidden" name="bookingId" value="${b.bookingId}">
                  <input type="hidden" name="notes" id="notes-${b.bookingId}">
                  <button type="button" class="cancel" onclick="openCancelModal(${b.bookingId})">Cancel</button>
                </form>
                <div id="cancelModal-${b.bookingId}" class="cancel-modal">
                  <div class="modal-content">
                    <label for="notesTextarea-${b.bookingId}">Reason:</label>
                    <textarea id="notesTextarea-${b.bookingId}" rows="4" style="width:100%;"></textarea>
                    <div class="modal-actions">
                      <button type="button" onclick="confirmReason(${b.bookingId})">OK</button>
                      <button type="button" onclick="closeCancelModal(${b.bookingId})">Close</button>
                    </div>
                  </div>
                </div>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </c:if>

    <c:if test="${empty booking}">
      <div id="noResultsPopup" class="popup-overlay" style="display: flex;">
        <div class="popup-box">
          <p><i class="fa fa-search"></i> No matching results found!</p>
          <button onclick="document.getElementById('noResultsPopup').style.display='none';">OK</button>
        </div>
      </div>
    </c:if>
  </div>

  <script>
    function openCancelModal(id){
      document.getElementById(`cancelModal-${id}`).style.display = 'flex';
    }
    function closeCancelModal(id){
      document.getElementById(`cancelModal-${id}`).style.display = 'none';
    }
    function confirmReason(id){
      const notes = document.getElementById(`notesTextarea-${id}`).value.trim();
      if(!notes){ alert('Enter cancellation reason'); return; }
      document.getElementById(`notes-${id}`).value = notes;
      document.getElementById(`cancelForm-${id}`).submit();
    }
  </script>
</body>
=======
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Booking List</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f0f2f5;
                margin: 0;
                padding: 0;
                color: #333;
            }
            .content-wrapper {
                padding: 20px;
                transition: margin 0.3s ease, transform 0.3s ease;
            }
            #sidebar.open ~ .content-wrapper {
                margin-left: 200px;
                transform: scale(0.95);
            }
            #navbar.open ~ .content-wrapper {
                margin-top: 60px;
            }
            h1 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 20px;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            form {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 10px;
                margin-bottom: 20px;
            }
            input, select, button {
                padding: 8px 12px;
                border-radius: 8px;
                border: 1px solid #ccc;
                font-size: 14px;
                background-color: #fff;
                box-sizing: border-box;
            }
            button {
                border: none;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            button[type="submit"] {
                background-color: #3498db;
                color: #fff;
            }
            button[type="submit"]:hover {
                background-color: #2980b9;
            }
            .table-responsive {
                overflow-x: auto;
                -webkit-overflow-scrolling: touch;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                background: #fff;
                box-shadow: 0 4px 10px rgba(0,0,0,0.05);
                border-radius: 10px;
                overflow: hidden;
            }
            th, td {
                padding: 12px;
                text-align: center;
                border-bottom: 1px solid #e0e0e0;
            }
            th {
                background: #000080;
                color: #fff;
                font-weight: 600;
            }
            tr.hidden-row {
                display: none;
            }
            /* Cancel modal styling */
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
                z-index: 10000;
            }
            .cancel-modal.active {
                display: flex;
            }
            .modal-content {
                background: #fff;
                padding: 20px;
                border-radius: 10px;
                width: 350px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            }
            .modal-content textarea {
                width: 100%;
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
            .modal-actions button:first-child {
                background-color: #e74c3c;
                color: #fff;
            }
            .modal-actions button:last-child {
                background-color: #bdc3c7;
                color: #fff;
            }
            .waiting {
                background-color: #f1c40f;
                color: #fff;
            }
            .confirmed {
                background-color: #2ecc71;
                color: #fff;
            }
            .cancel {
                background: #e74c3c;
                color: #fff;
            }
            .cancel:hover {
                background: #c0392b;
            }
            @media(max-width:768px){
                form{
                    flex-direction:column;
                }
                th,td{
                    font-size:13px;
                }
            }
            @media(max-width:600px){
                .table-responsive table{
                    min-width:0;
                }
                thead{
                    display:none;
                }
                tr,td{
                    display:block;
                    width:100%;
                }
                td{
                    padding-left:50%;
                    position:relative;
                    text-align:right;
                }
                td::before{
                    content:attr(data-label);
                    position:absolute;
                    left:15px;
                    width:45%;
                    padding-right:10px;
                    white-space:nowrap;
                    font-weight:bold;
                    text-align:left;
                }
            }

            .load-more-wrapper {
                text-align: center;
                margin-top: 20px;
            }

        </style>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const rows = document.querySelectorAll('tbody tr');
                const btn = document.getElementById('loadMoreBtn');
                const initial = 10;
                rows.forEach((row, idx) => {
                    if (idx >= initial)
                        row.classList.add('hidden-row');
                });
                if (rows.length <= initial)
                    btn.style.display = 'none';
                btn.addEventListener('click', () => {
                    rows.forEach(row => row.classList.remove('hidden-row'));
                    btn.style.display = 'none';
                });
            });


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

            function showNoResultsPopup() {
                document.getElementById("noResultsPopup").style.display = "flex";
            }
            function closePopup() {
                document.getElementById("noResultsPopup").style.display = "none";
            }

            function removeNumbers(input) {
                input.value = input.value.replace(/[0-9]/g, ''); // Xóa toàn bộ chữ số
            }
        </script>
    </head>
    <body>
        <%@ include file="../navbarDashboard/navbarDashboard.jsp" %>
        <%@ include file="../sidebarDashboard/sidebarDashboard.jsp" %>
        <div class="content-wrapper">
            <c:if test="${sessionScope.bookingConfirmed}"><script>window.onload = () => alert('Booking confirmed!');</script><c:remove var="bookingConfirmed" scope="session"/></c:if>
                <h1>Booking Confirmation List</h1>
            <c:if test="${searched and noResult}"><script>window.onload = showNoResultsPopup;</script></c:if>
                <form action="BookingConfirmation" method="post">
                    Room Number: <input type="number" name="roomNumber" min="1" max="999" oninput="this.value=this.value.slice(0,3)" placeholder="Up to 3 digits" title="Only digits (1–999)" />
                    Full Name: <input type="text" name="fullName" maxlength="30" pattern="[A-Za-zÀ-ỹ\\s]+" title="Only letters" oninput="removeNumbers(this)" />
                    Start Date: <input type="date" name="startDate" value="${startDate}" />
                End Date: <input type="date" name="endDate" value="${endDate}" />
                Status: <select name="status"><option value="">-- All --</option><option value="Waiting for processing" ${status=='Waiting for processing'?'selected':''}>Waiting</option><option value="Confirmed" ${status=='Confirmed'?'selected':''}>Confirmed</option></select>
                <button type="submit">Search</button>
            </form>
            <div class="table-responsive">
                <table>
                    <thead><tr><th>Room Number</th><th>Full Name</th><th>Start Date</th><th>End Date</th><th>Status</th><th>Cancel</th></tr></thead>
                    <tbody>
                        <c:forEach var="booking" items="${booking}">
                            <tr>
                                <td data-label="Room Number">${booking.rooms.roomNumber}</td>
                                <td data-label="Full Name">${booking.customers.fullName}</td>
                                <td data-label="Start Date">${booking.formattedStartDate}</td>
                                <td data-label="End Date">${booking.formattedEndDate}</td>
                                <td data-label="Status">
                                    <c:choose>
                                        <c:when test="${booking.status=='Waiting for processing'}">
                                            <form action="BookingConfirmation" method="post" style="display:inline;" onsubmit="return confirm('Confirm this booking?');">
                                                <input type="hidden" name="actionType" value="confirmBooking" />
                                                <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                                                <button type="submit" class="waiting">Waiting</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise><button type="button" class="confirmed" disabled>Confirmed</button></c:otherwise>
                                    </c:choose>
                                </td>
                                <td data-label="Cancel" style="text-align:center;">
                                    <!-- Form cancel -->
                                    <form id="cancelForm-${booking.bookingId}" action="BookingCancel" method="post">
                                        <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                                        <input type="hidden" name="notes" id="notesInput-${booking.bookingId}" />

                                        <!-- Nút Cancel duy nhất -->
                                        <button type="button" class="cancel" onclick="openCancelModal('${booking.bookingId}')">Cancel</button>
                                    </form>

                                    <!-- Modal nhập lý do -->
                                    <div id="cancelModal-${booking.bookingId}" class="cancel-modal">
                                        <div class="modal-content">
                                            <label for="notesTextarea-${booking.bookingId}">Reason for cancellation:</label>
                                            <textarea id="notesTextarea-${booking.bookingId}" placeholder="Enter reason..." rows="4"></textarea>
                                            <div class="modal-actions">
                                                <button type="button" onclick="confirmReason('${booking.bookingId}')">OK</button>
                                                <button type="button" onclick="closeCancelModal('${booking.bookingId}')">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </td>

                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="load-more-wrapper">
                <button id="loadMoreBtn" style="padding:8px 16px;">Xem thêm</button>
            </div>

            <div id="noResultsPopup" class="popup-overlay" style="display:none;"><div class="popup-box"><p>🔍 No matching results found!</p><button onclick="closePopup()">OK</button></div></div>
        </div>
    </body>
>>>>>>> 27be073fdfe2619df0349f55bd4355968b60a514
</html>
