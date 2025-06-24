<%-- 
    Document   : bookingConfirmation
    Created on : Jun 18, 2025, 1:00:51 AM
    Author     : Dương Đinh Thế Vinh CE180441
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
</html>
