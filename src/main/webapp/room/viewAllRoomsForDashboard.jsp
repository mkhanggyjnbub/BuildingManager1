<%-- 
    Document   : viewAllRoomsForDashboard
    Created on : Jun 18, 2025, 1:21:53 AM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Room Dashboard</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
       body {
    font-family: 'Segoe UI', sans-serif;
    background-color: #f9fafb;
    margin: 0;
    padding: 20px;
}

h2 {
    text-align: center;
    color: #333;
    margin-bottom: 20px;
}

form {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin-bottom: 20px;
}

input[type="search"] {
    padding: 10px;
    width: 300px;
    max-width: 90%;
    border: 1px solid #ccc;
    border-radius: 6px;
}

button[type="submit"] {
    padding: 10px 16px;
    border: none;
    background-color: #007bff;
    color: white;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

button[type="submit"]:hover {
    background-color: #0056b3;
}

table {
    width: 100%;
    border-collapse: collapse;
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 4px 8px rgba(0,0,0,0.05);
}

thead {
    background-color: #007bff;
    color: white;
}

th, td {
    padding: 14px;
    text-align: center;
    border-bottom: 1px solid #eaeaea;
}

td a {
    color: #007bff;
    margin: 0 6px;
    text-decoration: none;
    transition: color 0.2s ease;
}

td a:hover {
    color: #0056b3;
}

.pagination {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    list-style: none;
    padding: 0;
    margin-top: 20px;
    gap: 5px;
}

.pagination li a {
    display: block;
    padding: 8px 14px;
    background-color: #eaeaea;
    border-radius: 5px;
    color: #333;
    text-decoration: none;
    transition: all 0.2s ease;
}

.pagination li a:hover {
    background-color: #007bff;
    color: white;
}

/* ============ Responsive ============ */
@media screen and (max-width: 768px) {
    table, thead, tbody, th, td, tr {
        display: block;
    }

    thead {
        display: none;
    }

    tr {
        background: white;
        margin-bottom: 15px;
        padding: 12px;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    }

    td {
        text-align: left;
        padding-left: 50%;
        position: relative;
        border: none;
        border-bottom: 1px solid #f0f0f0;
    }

    td::before {
        content: attr(data-label);
        position: absolute;
        left: 12px;
        top: 12px;
        font-weight: bold;
        color: #555;
    }

    td:last-child {
        border-bottom: none;
    }
}

        </style>
    </head>
    <body>

        <form method="get" action="ViewAllRoomsForDashboard">            
            <input type="search" name="search" placeholder="Nhập Từ Khóa...">
            <button type="submit">Tìm kiếm</button>
        </form>

        <h2>Danh Sách Phòng</h2>
        <a href="CreatRoomForDashboard"></a>
        <table>
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Mã Phòng</th>
                    <th>Tầng</th>
                    <th>Loại Phòng</th>
                    <th>Giá</th>
                    <th>Trạng Thái</th>
                    <th>Thao Tác</th>
                </tr>   
            </thead>
            <tbody>
                <c:forEach var="room"  items="${list}"  varStatus="i"> 
                    <tr>
                        <td data-label="STT">${(thisPage - 1) * 10 + i.index + 1}</td>
                        <td data-label="Mã Phòng">${room.roomNumber}</td>
                        <td data-label="Tầng">${room.floorNumber}</td>
                        <td data-label="Loại Phòng">${room.roomType}</td>
                        <td data-label="Giá">${room.price} / VND</td>
                        <td data-label="Trạng Thái">${room.status}</td>
                        <td data-label="Thao Tác">
                            <a href="AdminView?id=${room.roomId}" title="Xem"><i class="fa-solid fa-eye"></i></a>
                            <a href="AdminEdit?id=${room.roomId}" title="Sửa"><i class="fa-solid fa-pencil"></i></a>
                            <a href="AdminDelete?id=${room.roomId}" title="Xóa"><i class="fa-solid fa-circle-user"></i></a> 
                            <a href="Decentralization?id=${room.roomId}" title="Phân quyền"><i class="fa-solid fa-gear"></i></a>
                        </td>

                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <nav aria-label="Page navigation">
            <ul class="pagination">
                <c:forEach begin="1" end="${finalPage}" var="i">
                    <li><a href="ViewAllRoomsForDashboard?Page=${i}">${i}</a></li>
                    </c:forEach>
            </ul>
        </nav>

    </body>
</html>
