<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- Thêm dòng này -->
    <title>Room Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f9fafb;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: auto;
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
            flex-wrap: wrap;
        }

        input[type="search"] {
            padding: 10px;
            width: 300px;
            max-width: 100%;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        button[type="submit"], .create-link {
            padding: 10px 16px;
            border: none;
            background-color: #007bff;
            color: white;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button[type="submit"]:hover, .create-link:hover {
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

        .create-link {
            text-decoration: none;
            background-color: #007BFF;
            color: white;
            padding: 10px 30px;
            margin: 0 auto 20px;
            border-radius: 6px;
            font-weight: bold;
            display: inline-block;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .create-link:hover {
            background-color: #0056b3;
            transform: scale(1.05);
        }

        /* Responsive table */
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

            form {
                flex-direction: column;
                align-items: center;
            }

            input[type="search"], button[type="submit"] {
                width: 100%;
                max-width: 300px;
            }

            .create-link {
                display: block;
                width: fit-content;
                margin: 10px auto;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <%@include file="../navbarDashboard/navbarDashboard.jsp" %>
        <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>
        <h2>Room List</h2>

        <form method="get" action="ViewAllRoomsForDashboard">            
            <input type="search" id="numberOnlyInput" name="search" placeholder="Enter Room Number...">
            <button type="submit">Search</button>
        </form>

        <a href="CreateRoomForDashboard" class="create-link">Create</a>

        <table>
            <thead>
                <tr>
                    <th>STT</th>
                    <th>RoomNumber</th>
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
                        <td data-label="Mã Phòng">${room.roomNumber}</td>
                        <td data-label="Tầng">${room.floorNumber}</td>
                        <td data-label="Loại Phòng">${room.roomType}</td>
                        <td data-label="Giá">${room.price} / VND</td>
                        <td data-label="Trạng Thái">${room.status}</td>
                        <td data-label="Thao Tác">
<!--                            <a href="AdminView?id=${room.roomId}" title="Xem"><i class="fa-solid fa-eye"></i></a>-->
                            <a href="EditRoomForDashboard?id=${room.roomId}" title="Sửa"><i class="fa-solid fa-pencil"></i></a>
                            <!--<a href="AdminDelete?id=${room.roomId}" title="Xóa"><i class="fa-solid fa-circle-user"></i></a>--> 
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
    </div>

    <script>
        const input = document.getElementById('numberOnlyInput');

        input.addEventListener('input', function () {
            // Xoá mọi ký tự không phải số
            this.value = this.value.replace(/\D/g, '');

            // Giới hạn tối đa 4 chữ số
            if (this.value.length > 4) {
                this.value = this.value.slice(0, 4);
            }
        });
    // Lặp qua tất cả các ô có label "Giá"
    document.querySelectorAll('td[data-label="Giá"]').forEach(function (td) {
        let text = td.textContent.trim();
        let numberPart = text.split(' ')[0]; // Lấy phần số (bỏ " / VND")
        let formatted = Number(numberPart).toLocaleString('vi-VN'); // Format dạng 1.000.000
        td.textContent = formatted + " / VND"; // Gán lại vào ô
    });

    </script>
</body>
</html>
