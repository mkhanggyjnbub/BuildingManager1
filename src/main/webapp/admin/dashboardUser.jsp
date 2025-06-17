<%-- 
    Document   : dashBoardUser
    Created on : May 3, 2025, 2:04:23 PM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 30px;
            color: #002b5c;
        }

        h2 {
            text-align: center;
            color: #002b5c;
            margin-bottom: 20px;
        }

        form {
            text-align: center;
            margin-bottom: 25px;
        }

        input[type="search"] {
            width: 300px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        button {
            padding: 10px 15px;
            background-color: #002b5c;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-left: 5px;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #004080;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 14px 12px;
            text-align: center;
            border-bottom: 1px solid #e0e0e0;
        }

        th {
            background-color: #002b5c;
            color: white;
            font-weight: bold;
            text-transform: uppercase;
            font-size: 13px;
        }

        td {
            font-size: 14px;
            color: #333;
        }

        tr:hover {
            background-color: #f0f8ff;
        }

        a {
            color: #002b5c;
            margin: 0 6px;
            font-size: 16px;
            transition: transform 0.2s ease, color 0.2s ease;
        }

        a:hover {
            color: #004080;
            transform: scale(1.2);
        }

        nav {
            text-align: center;
            margin-top: 25px;
        }

        .pagination {
            list-style-type: none;
            padding: 0;
            display: inline-flex;
            gap: 6px;
        }

        .pagination li a {
            display: inline-block;
            padding: 8px 14px;
            border-radius: 5px;
            background-color: #002b5c;
            color: white;
            text-decoration: none;
            transition: background-color 0.2s;
        }

        .pagination li a:hover {
            background-color: #004080;
        }
    </style>
</head>

<body>

    <h2>User Management Dashboard</h2>

    <form method="get" action="DashboardUser">
        <input type="search" name="search" placeholder="Enter keyword...">
        <button type="submit"><i class='bx bx-search-alt-2'></i></button>
    </form>

    <table>
        <thead>
            <tr>
                <th>No.</th>
                <th>Username</th>
                <th>Email</th>
                <th>Role</th>
                <th>Actions</th>
            </tr>   
        </thead>
        <tbody>
            <c:forEach var="user"  items="${list}"  varStatus="i"> 
                <tr>
                    <td>${(thisPage - 1) * 10 + i.index + 1}</td>
                    <td>${user.userName}</td>
                    <td>${user.email}</td>
                    <td>${user.role.roleName}</td>
                    <td>
                        <a href="AdminView?id=${user.userId}" title="View"><i class="fa-solid fa-eye"></i></a>
                        <a href="AdminEdit?id=${user.userId}" title="Edit"><i class="fa-solid fa-pencil"></i></a>
                        <a href="AdminDelete?id=${user.userId}" title="Delete"><i class="fa-solid fa-user-slash"></i></a> 
                        <a href="Decentralization?id=${user.userId}" title="Manage Role"><i class="fa-solid fa-gear"></i></a>  
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <nav aria-label="Page navigation">
        <ul class="pagination">
            <c:forEach begin="1" end="${finalPage}" var="i">
                <li><a href="DashboardUser?Page=${i}">${i}</a></li>
            </c:forEach>
        </ul>
    </nav>

</body>
</html>
