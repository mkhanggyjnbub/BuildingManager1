<%-- 
    Document   : listRoom
    Created on : May 6, 2025, 2:52:12 PM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script> 
        <script src="../js/listRooms.js"></script>
        <link rel="stylesheet" href="../css/listRooms.css"/>
    </head>

    <body>
        <!--<form action="listRooms" method="get">-->
        <div class="form-row">
            <!-- Vị trí -->
            <div class="form-group">
                <label for="location">Vị trí</label>
                <select onchange="search()" id="location" name="location">
                <option value="">-- Chọn vị trí --</option>
                    <option value="Cần Thơ">Cần Thơ</option>
                    <option value="Vũng Tàu">Vũng Tàu</option>
                </select>
            </div>

            <!-- Check-in -->
            <div class="form-group">
                <label for="checkin">Check-in</label>
                <input oninput="search()" type="date" id="checkIn" name="checkIn" >
            </div>

            <!-- Check-out -->
            <div class="form-group">
                <label for="checkout">Check-out</label>
                <input oninput="search()" type="date" id="checkOut" name="checkOut" >
            </div>

            <!-- Người lớn -->
            <div class="form-group">
                <label for="adults">Người lớn</label>
                <input oninput="search()" type="number" id="adults" name="adults" min="1" value="1">
            </div>

            <!-- Trẻ em -->
            <div class="form-group">
                <label for="children">Trẻ em</label>
                <input oninput="search()" type="number" id="children" name="children" min="0" value="0">
            </div>

        </div>
        <!--</form>-->
        <h1>Các Phòng Khách Sạn Nổi Bật</h1>
        <div class="product-grid" id="product" role="list">
            <c:forEach var="room" items="${list}">
                <article class="card" role="listitem" tabindex="0" aria-label="">
                    <img src="${room.imageUrl}" alt="Phòng Deluxe King sang trọng với giường lớn và trang trí tinh tế" />
                    <div class="card-content">
                        <h2 class="room-title">${room.roomType}</h2>
                        <p class="room-desc">${room.description}</p>
                        <div class="price">${room.price} / đêm</div>
                        <button class="btn-book" aria-label="Đặt Phòng Deluxe King">Đặt phòng</button>
                    </div>
                </article>
            </c:forEach>
        </div>
        <div>
            <button id="loadmore-btn" onclick="loadMore()">Xem Thêm ${finalRooms} Rooms nữa </button>
        </div>
    </body>
</html>
