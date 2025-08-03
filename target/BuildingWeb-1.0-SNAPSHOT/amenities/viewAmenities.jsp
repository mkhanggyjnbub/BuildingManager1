<%-- 
    Document   : viewAmenities
    Created on : Jun 15, 2025, 8:19:33 PM
    Author     : KHANH
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Amenities List</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

    <style>
        :root {
            --primary: #002b5c;
            --primary-dark: #004080;
            --danger: #e53935;
            --danger-dark: #b71c1c;
            --background: #f4f6f9;
            --white: #ffffff;
            --gray-light: #f9fafb;
            --gray-medium: #eaeaea;
            --text: #222;
            --shadow: 0 6px 16px rgba(0, 0, 0, 0.08);
            --radius: 12px;
            --transition: 0.3s ease;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Verdana, sans-serif;
            background-color: var(--background);
            color: var(--text);
            margin: 0;
            padding: 0;
        }

        .main-content {
            margin-left: 240px;
            padding: 40px;
            transition: margin-left 0.3s ease;
        }

        h2 {
            text-align: center;
            font-size: 30px;
            font-weight: 700;
            margin-bottom: 25px;
            color: var(--primary);
            letter-spacing: 1px;
        }

        .top-bar {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 20px;
        }

        .btn {
            background-color: var(--primary);
            color: var(--white);
            padding: 10px 20px;
            border-radius: var(--radius);
            font-weight: 600;
            text-decoration: none;
            box-shadow: var(--shadow);
            transition: background-color var(--transition), transform var(--transition);
            font-size: 14px;
        }

        .btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        th, td {
            padding: 14px 18px;
            text-align: center;
            font-size: 14px;
        }

        th {
            background-color: var(--primary-dark);
            color: white;
            font-weight: 600;
            text-transform: uppercase;
        }

        /* ✅ Đẩy riêng cột Description sang phải */
        th:nth-child(3),
        td:nth-child(3) {
            text-align: left;
            padding-left: 60px; /* ✅ Tăng khoảng cách */
        }

        tbody tr:nth-child(even) {
            background-color: var(--gray-light);
        }

        tbody tr:hover {
            background-color: var(--gray-medium);
        }

        .action-links a {
            padding: 6px 14px;
            border-radius: 6px;
            text-decoration: none;
            color: white;
            font-size: 13px;
            font-weight: 500;
            margin: 0 4px;
            transition: background-color var(--transition), transform var(--transition);
            display: inline-block;
        }

        .edit-btn {
            background-color: var(--primary);
        }

        .edit-btn:hover {
            background-color: var(--primary-dark);
            transform: scale(1.05);
        }

        .delete-btn {
            background-color: var(--danger);
        }

        .delete-btn:hover {
            background-color: var(--danger-dark);
            transform: scale(1.05);
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 20px;
                margin-left: 0;
            }

            h2 {
                font-size: 24px;
            }

            th, td {
                font-size: 130px;
                padding: 100px;
            }

            .btn {
                padding: 8px 16px;
            }
        }
    </style>
</head>
<body>

<%@ include file="../navbarDashboard/navbarDashboard.jsp" %>
<%@ include file="../sidebarDashboard/sidebarDashboard.jsp" %>

<div class="main-content">
    <h2>Amenities List</h2>

    <div class="top-bar">
        <a class="btn" href="AddAmenitiesDashboard"><i class="fa fa-plus"></i> Add Amenity</a>
    </div>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Amenity Name</th>
                <th>Description</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="a" items="${amenitiesList}">
                <tr>
                    <td>${a.amenityId}</td>
                    <td>${a.name}</td>
                    <td>${a.description}</td>
                    <td class="action-links">
                        <a class="edit-btn" href="EditAmenitiesDashboard?id=${a.amenityId}"><i class="fa fa-edit"></i> Edit</a>
                        <a class="delete-btn" href="DeleteAmenitiesDashboard?id=${a.amenityId}" onclick="return confirm('Are you sure you want to delete this amenity?');"><i class="fa fa-trash"></i> Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>
