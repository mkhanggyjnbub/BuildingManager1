<%-- 
    Document   : bookingConfirmation
    Created on : Jun 18, 2025, 1:00:51 AM
    Author     : Dương Đinh Thế Vinh CE180441
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
            color: #333;
            font-size: 16px;
        }
        .content-wrapper {
            padding: 20px;
            transition: margin 0.3s ease, transform 0.3s ease;
        }
        #sidebar.open ~ .content-wrapper { margin-left: 200px; transform: scale(0.95); }
        #navbar.open ~ .content-wrapper { margin-top: 60px; }

        h1 {
            text-align: center;
            color: #001F54;
            margin-bottom: 20px;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 20px;
        }

        form {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 10px;
            margin-bottom: 20px;
            font-size: 14px;
        }

        input, select, button {
            padding: 8px 12px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        button {
            border: none;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button[type="submit"] {
            background-color: #1E90FF;
            color: #fff;
        }
        button[type="submit"]:hover {
            background-color: #187bcd;
        }

        .table-responsive { overflow-x: auto; -webkit-overflow-scrolling: touch; }

        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            border-radius: 10px;
            overflow: hidden;
            font-size: 14px;
        }

        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #e0e0e0;
        }
        th {
            background: #001F54;
            color: #fff;
            font-weight: 600;
        }

        .waiting { background-color: #f1c40f; color: #fff; }
        .confirmed {
            background-color: #2ecc71;
            color: #fff;
            padding: 5px 10px;
            border-radius: 6px;
        }
        .cancel {
            background: #e74c3c;
            color: #fff;
        }
        .cancel:hover { background: #c0392b; }

        .highlight-row {
            background-color: #fffacc;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .load-more-wrapper { text-align: center; margin-top: 20px; }
        .load-more-wrapper button {
            background: #1E90FF;
            color: white;
            border-radius: 6px;
            padding: 8px 16px;
        }
        .load-more-wrapper button:hover { background: #187bcd; }

        /* Popup */
        .popup-overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.5); display: none;
            justify-content: center; align-items: center; z-index: 9999;
        }
        .popup-box {
            background: #fff;
            padding: 20px 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
            text-align: center;
            font-size: 16px;
            max-width: 400px;
            width: 90%;
        }
        .popup-box button {
            background-color: #1E90FF;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            color: white;
        }
        .popup-box button:hover { background-color: #187bcd; }

        @media(max-width:768px){
            form{ flex-direction:column; }
            th,td{ font-size:13px; }
        }
        @media(max-width:600px){
            thead{ display:none; }
            tr,td{ display:block; width:100%; }
            td{ padding-left:50%; position:relative; text-align:right; }
            td::before{
                content:attr(data-label);
                position:absolute; left:15px; width:45%;
                font-weight:bold; text-align:left;
            }
        }
    </style>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const rows = document.querySelectorAll('tbody tr');
            const btn = document.getElementById('loadMoreBtn');
            const initial = 10;
            rows.forEach((row, idx) => { if (idx >= initial) row.classList.add('hidden-row'); });
            if (rows.length <= initial) btn.style.display = 'none';
            btn.addEventListener('click', () => {
                rows.forEach(row => row.classList.remove('hidden-row'));
                btn.style.display = 'none';
            });
        });

        function openCancelModal(id){ document.getElementById("cancelModal-"+id).style.display="flex"; }
        function closeCancelModal(id){ document.getElementById("cancelModal-"+id).style.display="none"; }
        function confirmReason(id){
            const reason = document.getElementById("notesTextarea-"+id).value.trim();
            if (!reason) { alert("Please enter a reason for cancellation."); return; }
            document.getElementById("notesInput-"+id).value = reason;
            document.getElementById("cancelForm-"+id).submit();
        }

        function showNoResultsPopup(){ document.getElementById("noResultsPopup").style.display="flex"; }
        function closePopup(){ document.getElementById("noResultsPopup").style.display="none"; }
        function removeNumbers(input){ input.value = input.value.replace(/[0-9]/g, ''); }
        function openConfirmationPopup(id){ document.getElementById("popup-confirm-"+id).style.display="flex"; }
        function closePopupConfirm(id){ document.getElementById("popup-confirm-"+id).style.display="none"; }

        window.onload = function () {
            const url = new URL(window.location);
            if (url.searchParams.has("highlightId")) {
                url.searchParams.delete("highlightId");
                window.history.replaceState({}, document.title, url.pathname);
            }
        };
    </script>
</head>
<body>
<%@ include file="../navbarDashboard/navbarDashboard.jsp" %>
<%@ include file="../sidebarDashboard/sidebarDashboard.jsp" %>

<div class="content-wrapper">
    <c:if test="${sessionScope.bookingConfirmed}">
        <script>window.onload = () => alert('Booking confirmed!');</script>
        <c:remove var="bookingConfirmed" scope="session"/>
    </c:if>

    <h1>Booking Confirmation List</h1>

    <c:if test="${noRoomTypeAlert}">
        <script>alert("❌ There are no more rooms of this type available during the selected period!");</script>
    </c:if>

    <c:if test="${searched and noResult}">
        <script>window.onload = showNoResultsPopup;</script>
    </c:if>

    <form action="BookingConfirmation" method="post">
        Room Type: <input type="text" name="roomType" maxlength="30" oninput="removeNumbers(this)" />
        Full Name: <input type="text" name="fullName" maxlength="30" oninput="removeNumbers(this)" />
        Start Date: <input type="date" name="startDate" value="${startDate}" />
        End Date: <input type="date" name="endDate" value="${endDate}" />
        Status:
        <select name="status">
            <option value="">-- All --</option>
            <option value="Waiting for processing" ${status=='Waiting for processing'?'selected':''}>Waiting</option>
            <option value="Confirmed" ${status=='Confirmed'?'selected':''}>Confirmed</option>
        </select>
        <button type="submit">Search</button>
    </form>

    <c:set var="highlightId" value="${param.highlightId}" />

    <div class="table-responsive">
        <table>
            <thead>
            <tr>
                <th>Room Type</th>
                <th>Full Name</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Detail</th>
                <th>Status</th>
                <th>Cancel</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="booking" items="${booking}">
                <tr class="${highlightId == booking.bookingId ? 'highlight-row' : ''}">
                    <td data-label="Room Type">${booking.roomType}</td>
                    <td data-label="Full Name">${booking.customers.fullName}</td>
                    <td data-label="Start Date">${booking.formattedStartDate}</td>
                    <td data-label="End Date">${booking.formattedEndDate}</td>
                    <td data-label="Detail">
                        <a href="ViewBookingDetail?bookingId=${booking.bookingId}">
                            <button class="waiting">View Detail</button>
                        </a>
                    </td>
                    <td data-label="Status">
                        <c:if test="${booking.status eq 'Waiting for processing'}">
                            <button class="waiting" onclick="openConfirmationPopup(${booking.bookingId})">Waiting</button>
                        </c:if>
                        <c:if test="${booking.status eq 'Confirmed'}">
                            <span class="confirmed">Confirmed</span>
                        </c:if>
                    </td>
                    <td data-label="Cancel">
                        <form id="cancelForm-${booking.bookingId}" action="BookingCancel" method="post">
                            <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                            <input type="hidden" name="notes" id="notesInput-${booking.bookingId}" />
                            <button type="button" class="cancel" onclick="openCancelModal('${booking.bookingId}')">Cancel</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="load-more-wrapper">
        <button id="loadMoreBtn">See more</button>
    </div>

    <div id="noResultsPopup" class="popup-overlay">
        <div class="popup-box">
            <p>🔍 No matching results found!</p>
            <button onclick="closePopup()">OK</button>
        </div>
    </div>
</div>
</body>
</html>
