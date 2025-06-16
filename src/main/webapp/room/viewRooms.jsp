<%-- 
    Document   : listRoom
    Created on : May 6, 2025, 2:52:12 PM
    Author     : Kiá»u HoÃ ng Máº¡nh Khang - ce180749 
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script> 
        <script src="../js/viewRooms.js"></script>
        <link rel="stylesheet" href="../css/viewRooms.css"/>
    </head>
    <body>


        <div class="SearchHeader">      
            <%@include file="../header/header.jsp" %>
        </div>
        <br>
        <br>
        <div class="form-row">
            <div class="form-group">
                <label for="location">Vị Trí­</label>
                <select onchange="search()" id="location" name="location">
                    <option value="">-- Chọn Vị Trí --</option>
                    <option value="Cần Thơ">Cần Thơ</option>
                    <option value="Vũng Tàu">Vũng Tàu</option>
                </select>
            </div>

            <div class="form-group">
                <label for="checkin">Check-in</label>
                <input oninput="search()" type="date" id="checkIn" name="checkIn" >
            </div>

            <div class="form-group">
                <label for="checkout">Check-out</label>
                <input oninput="search()" type="date" id="checkOut" name="checkOut" >
            </div>

            <div class="form-group">
                <label for="adults">Người Lớn</label>
                <input  oninput="search()" type="number" id="adults" name="adults" min="1" value="1">
            </div>

            <div class="form-group">
                <label for="children">Trẻ Em</label>
                <input  oninput="search()" type="number" id="children" name="children" min="0" value="0">
            </div>

        </div>

        <h1>Các Phòng Khách Sạn Nổi Bật</h1>
        <div class="product-grid" id="product" role="list">
            <c:forEach var="room" items="${list}">
                <a href="ViewRoomDetail?id=${room.roomId}"  style="text-decoration: none;">
                    <article class="card" role="listitem" tabindex="0" aria-label="">
                        <img src="${room.imageUrl}" alt="" />
                        <div class="card-content">
                            <h2 class="room-title">${room.roomType}</h2>
                            <p class="room-desc">${room.description}</p>
                            <div class="price">${room.price} / Room</div>
                            <button class="btn-book" aria-label="">Đặt Phòng</button>
                        </div>
                    </article>
                </a>
            </c:forEach>
        </div>
        <div>
            <button id="loadmore-btn" onclick="loadMore()">Xem Thêm ${finalRooms} Phòng</button>
        </div>
    </body>
</html>
