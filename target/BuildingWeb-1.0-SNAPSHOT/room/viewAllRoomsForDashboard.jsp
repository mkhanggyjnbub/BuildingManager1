<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Room Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root {
            --primary: #002b5c;
            --primary-light: #004080;
            --background: #f4f6f9;
            --white: #ffffff;
            --gray: #e0e0e0;
            --text: #222;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--background);
            color: var(--text);
            margin: 0;
            padding: 0;
        }

        .main-content {
            margin-left: 250px;
            padding: 30px;
            transition: margin-left 0.3s ease;
        }

        h2 {
            text-align: center;
            color: var(--primary);
            margin-bottom: 25px;
            font-size: 30px;
            font-weight: 700;
            letter-spacing: 1px;
        }

        form {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-bottom: 25px;
        }

        input[type="search"] {
            padding: 10px;
            width: 300px;
            max-width: 90%;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        button[type="submit"] {
            padding: 10px 16px;
            border: none;
            background-color: var(--primary);
            color: white;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-size: 14px;
        }

        button[type="submit"]:hover {
            background-color: var(--primary-light);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }

        thead {
            background-color: var(--primary);
        }

        th {
            color: white;
            padding: 14px 18px;
            text-align: center;
            font-weight: 600;
            font-size: 15px;
        }

        td {
            padding: 14px 18px;
            text-align: center;
            border-bottom: 1px solid #e1e4e8;
            font-size: 14px;
        }

        td a {
            color: #007bff;
            margin: 0 6px;
            text-decoration: none;
        }

        td a:hover {
            color: #0056b3;
        }

        .pagination {
            display: flex;
            justify-content: center;
            list-style: none;
            padding: 0;
            margin-top: 30px;
            gap: 8px;
        }

        .pagination li a {
            display: block;
            padding: 8px 14px;
            background-color: #eaeaea;
            border-radius: 5px;
            color: #333;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
        }

        .pagination li a:hover {
            background-color: var(--primary);
            color: white;
        }

        .create-link {
            text-decoration: none;
            background-color: var(--primary);
            color: white;
            padding: 10px 30px;
            margin: 20px auto;
            border-radius: 6px;
            font-weight: bold;
            display: inline-block;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s ease, transform 0.2s ease;
            text-align: center;
            font-size: 14px;
        }

        .create-link:hover {
            background-color: var(--primary-light);
            transform: scale(1.05);
        }

        .a1 { display: flex; justify-content: space-around; margin-top: 26px; }

        .delete-btn {
            background-color: #e53935;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }
        .delete-btn:hover { background-color: #c62828; }

        .restore-btn {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }
        .restore-btn:hover { background-color: var(--primary-light); }

        @media screen and (max-width: 768px) {
            .main-content { margin-left: 0; padding: 20px; }
            form { flex-direction: column; align-items: center; }
            table, thead, tbody, th, td, tr { display: block; }
            thead { display: none; }
            tr { margin-bottom: 15px; background: #fff; padding: 12px; border-radius: 8px; }
            td { padding-left: 50%; position: relative; text-align: left; border: none; border-bottom: 1px solid #eee; }
            td::before { content: attr(data-label); position: absolute; left: 12px; top: 12px; font-weight: bold; color: #555; }
        }
    </style>
</head>
<body>
    <%@include file="../navbarDashboard/navbarDashboard.jsp" %>
    <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>
    

    <div class="main-content">
        <h2>Room List</h2>

        <form method="get" action="ViewAllRoomsForDashboard">
            <input type="search" id="numberOnlyInput" name="search" placeholder="Enter keyword...">
            <button type="submit"><i class="fa-solid fa-search"></i> Search</button>
        </form>

        <a href="CreateRoomForDashboard" class="create-link">Create</a>

        <table>
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Room Number</th>
                    <th>Floor</th>
                    <th>Room Type</th>
                    <th>Price</th>
                    <th>Status</th>
                    <th>Operation</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="room" items="${list}" varStatus="i">
                    <tr>
                        <td data-label="STT">${(thisPage - 1) * 10 + i.index + 1}</td>
                        <td data-label="Room Number">${room.roomNumber}</td>
                        <td data-label="Floor">${room.floorNumber}</td>
                        <td data-label="Room Type">${room.roomType}</td>
                        <td data-label="Price">${room.price} / VND</td>
                        <td data-label="Status">${room.status}</td>
                        <td data-label="Operation">
                            <div class="a1">
                                <a href="EditRoomForDashboard?id=${room.roomId}" title="Edit">
                                    <i class="fa-solid fa-pencil" style="font-size: 20px;"></i>
                                </a>

                                <c:choose>
                                    <c:when test="${room.status ne 'Hidden'}">
                                        <form action="DeleteRoomForDashboard" method="post" onsubmit="return confirmDelete()">
                                            <input type="hidden" name="roomId" value="${room.roomId}">
                                            <input type="hidden" name="status" value="notHidden">
                                            <button type="submit" class="delete-btn">Delete</button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <form action="DeleteRoomForDashboard" method="post">
                                            <input type="hidden" name="roomId" value="${room.roomId}">
                                            <input type="hidden" name="status" value="Hidden">
                                            <button type="submit" class="restore-btn">Restore</button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <nav aria-label="Pagination">
            <ul class="pagination">
                <c:forEach begin="1" end="${finalPage}" var="i">
                    <li><a href="ViewAllRoomsForDashboard?Page=${i}">${i}</a></li>
                </c:forEach>
            </ul>
        </nav>
    </div>

    <script>
        const input = document.getElementById('numberOnlyInput');
        input.addEventListener('input', function () {
            this.value = this.value.replace(/\D/g, '');
            if (this.value.length > 4) this.value = this.value.slice(0, 4);
        });

        document.querySelectorAll('td[data-label="Price"]').forEach(function (td) {
            let text = td.textContent.trim();
            let numberPart = text.split(' ')[0];
            td.textContent = Number(numberPart).toLocaleString('vi-VN') + " / VND";
        });

        function confirmDelete() {
            return confirm("Bạn có chắc chắn muốn xóa phòng này không?");
        }
    </script>
</body>
</html>
