<%-- 
    Document   : viewAllRoomsForDashboard
    Created on : Jun 18, 2025, 1:21:53 AM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Room Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f9fafb;
        }

        .main-content {
            margin-left: 250px; /* width of sidebar */
            padding: 30px;
            transition: margin-left 0.3s ease;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 25px;
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
        }

        .pagination li a:hover {
            background-color: #007bff;
            color: white;
        }

        @media screen and (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 20px;
            }

            form {
                flex-direction: column;
                align-items: center;
            }

            table, thead, tbody, th, td, tr {
                display: block;
            }

            thead {
                display: none;
            }

            tr {
                margin-bottom: 15px;
                background: #fff;
                padding: 12px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            }

            td {
                padding-left: 50%;
                position: relative;
                border: none;
                border-bottom: 1px solid #eee;
                text-align: left;
            }

            td::before {
                content: attr(data-label);
                position: absolute;
                left: 12px;
                top: 12px;
                font-weight: bold;
                color: #555;
            }
        }
    </style>
</head>
<body>
    <%@include file="../navbarDashboard/navbarDashboard.jsp" %>
    <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>

    <div class="main-content">
        <h2>Room List</h2>

        <form method="get" action="ViewAllRoomsForDashboard">
            <input type="search" name="search" placeholder="Enter keyword...">
            <button type="submit"><i class="fa-solid fa-search"></i> Search</button>
        </form>

        <table>
            <thead>
                <tr>
                    <th>No.</th>
                    <th>Room Number</th>
                    <th>Floor</th>
                    <th>Type</th>
                    <th>Price (VND)</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="room" items="${list}" varStatus="i">
                    <tr>
                        <td data-label="No.">${(thisPage - 1) * 10 + i.index + 1}</td>
                        <td data-label="Room Number">${room.roomNumber}</td>
                        <td data-label="Floor">${room.floorNumber}</td>
                        <td data-label="Type">${room.roomType}</td>
                        <td data-label="Price">${room.price}</td>
                        <td data-label="Status">${room.status}</td>
                        <td data-label="Actions">
                            <a href="AdminView?id=${room.roomId}" title="View"><i class="fa-solid fa-eye"></i></a>
                            <a href="AdminEdit?id=${room.roomId}" title="Edit"><i class="fa-solid fa-pen-to-square"></i></a>
                            <a href="AdminDelete?id=${room.roomId}" title="Delete"><i class="fa-solid fa-trash"></i></a>
                            <a href="Decentralization?id=${room.roomId}" title="Manage Access"><i class="fa-solid fa-gear"></i></a>
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
</body>
</html>
