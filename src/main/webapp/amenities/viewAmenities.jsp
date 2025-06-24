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
            --navy: #4a6fa5;
            --navy-dark: #3a5c88;
            --white: #ffffff;
            --light-bg: #f4f6f9;
            --hover-bg: #3a5c88;
            --transition: 0.3s ease;
            --primary-color: #0a2f5c;
            --primary-hover: #0c3f7c;
            --edit-color: #007bff;
            --edit-hover: #0056b3;
            --delete-color: #dc3545;
            --delete-hover: #a71d2a;
            --background: #f8fbff;
            --table-bg: #ffffff;
            --shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light-bg);
            color: var(--navy);
        }

        .main-content {
            margin-left: 60px;
            padding: 40px;
            transition: margin-left var(--transition);
        }

        .sidebar.open ~ .main-content {
            margin-left: 220px;
        }

        /* Amenities Table */
        h2 {
            color: var(--primary-color);
            margin-bottom: 30px;
            font-size: 28px;
        }

        .top-bar {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 20px;
        }

        .btn {
            background-color: var(--primary-color);
            color: #fff;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: background-color 0.3s ease;
            box-shadow: var(--shadow);
        }

        .btn:hover {
            background-color: var(--primary-hover);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: var(--table-bg);
            border-radius: 10px;
            overflow: hidden;
            box-shadow: var(--shadow);
        }

        th, td {
            padding: 14px 18px;
            text-align: center;
            border-bottom: 1px solid #e1e9f0;
        }

        th {
            background-color: var(--primary-color);
            color: white;
            text-transform: uppercase;
            font-size: 14px;
            letter-spacing: 0.5px;
        }

        tr:nth-child(even) {
            background-color: #f4f7fa;
        }

        tr:hover {
            background-color: #e3eefc;
        }

        .action-links a {
            margin: 0 6px;
            padding: 7px 12px;
            border-radius: 5px;
            text-decoration: none;
            color: white;
            font-size: 13px;
            font-weight: 600;
            display: inline-block;
        }

        .edit-btn {
            background-color: var(--edit-color);
        }

        .edit-btn:hover {
            background-color: var(--edit-hover);
        }

        .delete-btn {
            background-color: var(--delete-color);
        }

        .delete-btn:hover {
            background-color: var(--delete-hover);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .main-content {
                padding: 20px;
            }

            th, td {
                padding: 10px;
                font-size: 14px;
            }

            .btn {
                padding: 8px 16px;
            }

            .action-links a {
                margin: 2px 3px;
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
            <a class="btn" href="AddAmenitiesDashboard">+ Add Amenity</a>
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
                            <a class="edit-btn" href="EditAmenitiesDashboard?id=${a.amenityId}">Edit</a>
                            <a class="delete-btn" href="DeleteAmenitiesDashboard?id=${a.amenityId}" onclick="return confirm('Are you sure you want to delete this amenity?');">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <script>
        function toggleSidebar() {
            document.getElementById("sidebar").classList.toggle("open");
        }
    </script>

</body>
</html>
