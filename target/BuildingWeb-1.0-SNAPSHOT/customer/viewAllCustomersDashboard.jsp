<%-- 
    Document   : viewCustomersDashboard
    Created on : Jun 18, 2025, 12:24:31 AM
    Author     : KHANH
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer List</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f0f4f8;
            margin: 0;
            padding: 0;
            color: #333;
            animation: fadeInBody 0.6s ease-in-out;
        }

        @keyframes fadeInBody {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .main-content {
            margin-left: 60px;
            padding: 80px 30px 40px;
            transition: margin-left 0.3s ease;
            animation: slideInMain 0.6s ease forwards;
            opacity: 0;
        }

        .sidebar.open ~ .main-content {
            margin-left: 220px;
        }

        @keyframes slideInMain {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            text-align: center;
            color: #002b5c;
            margin-bottom: 30px;
            font-size: 30px;
            font-weight: 600;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 8px 20px rgba(0, 43, 92, 0.1);
        }

        th, td {
            padding: 16px 12px;
            text-align: center;
            font-size: 15px;
            border-bottom: 1px solid #e6e6e6;
        }

        th {
            background-color: #002b5c;
            color: white;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 13px;
        }

        tr:hover {
            background-color: #eef6fb;
        }

        .actions a {
            margin: 0 6px;
            font-size: 16px;
            color: #002b5c;
            transition: 0.3s ease;
        }

        .actions a:hover {
            color: #004080;
            transform: scale(1.15);
        }

        @media (max-width: 768px) {
            table, thead, tbody, th, td, tr {
                display: block;
            }

            tr {
                margin-bottom: 15px;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.05);
            }

            td {
                text-align: right;
                padding-left: 50%;
                position: relative;
            }

            td::before {
                content: attr(data-label);
                position: absolute;
                left: 15px;
                font-weight: bold;
                color: #002b5c;
                text-align: left;
            }

            th {
                display: none;
            }
        }
    </style>
</head>
<body>

<%@ include file="../navbarDashboard/navbarDashboard.jsp" %>
<%@ include file="../sidebarDashboard/sidebarDashboard.jsp" %>

<div class="main-content">
    <h2>Customer List</h2>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Gender</th>
                <th>Join Date</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="c" items="${customers}">
                <tr>
                    <td data-label="ID">${c.customerId}</td>
                    <td data-label="Username">${c.userName}</td>
                    <td data-label="Full Name">${c.fullName}</td>
                    <td data-label="Email">${c.email}</td>
                    <td data-label="Phone">${c.phone}</td>
                    <td data-label="Gender">${c.gender}</td>
                    <td data-label="Join Date">${c.joinDate}</td>
                    <td data-label="Actions" class="actions">
                        <a class="fa-solid fa-eye" title="View Details" href="ViewCustomerDetailDashboard?id=${c.customerId}"></a>
                        <a class="fa-solid fa-pencil" title="Edit" href="EditCustomerDashboard?id=${c.customerId}"></a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>
