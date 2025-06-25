<%-- 
    Document   : viewServicesDashboard
    Created on : 17-Jun-2025, 23:44:45
    Author     : dodan
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>List of Services</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f9fafb;
        }

        .main-content {
            margin-left: 250px;
            padding: 30px;
            transition: margin-left 0.3s ease;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 25px;
        }

        .action-bar {
            display: flex;
            justify-content: space-between;
            margin-bottom: 25px;
        }

        .btn-action {
            background-color: #007bff;
            color: white;
            padding: 10px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }

        .btn-action:hover {
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
            font-size: 14px;
        }

        img {
            max-height: 50px;
            border-radius: 4px;
        }

        .btn {
            padding: 6px 12px;
            font-size: 13px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin: 2px 0;
        }

        .btn-update {
            background-color: #f1c40f;
            color: #000;
        }

        .btn-update:hover {
            background-color: #d4ac0d;
        }

        .btn-delete {
            background-color: #e74c3c;
            color: #fff;
        }

        .btn-delete:hover {
            background-color: #c0392b;
        }

        .status-active {
            color: green;
            font-weight: bold;
        }

        .status-inactive {
            color: red;
            font-weight: bold;
        }

        @media screen and (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 20px;
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
<%@ include file="../navbarDashboard/navbarDashboard.jsp" %>
<%@ include file="../sidebarDashboard/sidebarDashboard.jsp" %>

<div class="main-content">
    <h2>List of Services</h2>

    <div class="action-bar">
        <a href="javascript:history.back()" class="btn-action"><i class="fa fa-arrow-left"></i> Back</a>
        <a href="AddServiceDashboard" class="btn-action"><i class="fa fa-plus"></i> Add Service</a>
    </div>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Service Name</th>
                <th>Type</th>
                <th>Price</th>
                <th>Image</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="s" items="${listS}">
                <tr>
                    <td data-label="ID">${s.serviceId}</td>
                    <td data-label="Service Name">${s.serviceName}</td>
                    <td data-label="Type">${s.unitType}</td>
                    <td data-label="Price">${s.price}</td>
                    <td data-label="Image"><img src="${s.imageURL}" alt="Service Image"></td>
                    <td data-label="Status">
                        <c:choose>
                            <c:when test="${s.isActive}">
                                <span class="status-active">✔ Active</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-inactive">✘ Inactive</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td data-label="Action">
                        <form action="ViewServiceDetailDashboard" method="get" style="display:inline;">
                            <input type="hidden" name="id" value="${s.serviceId}" />
                            <button type="submit" class="btn btn-update">👁️ View</button>
                        </form>
                        <form action="EditServiceDashboard" method="get" style="display:inline;">
                            <input type="hidden" name="id" value="${s.serviceId}" />
                            <button type="submit" class="btn btn-update">✏️ Edit</button>
                        </form>
                        <form action="DeleteServiceDashboard" method="get" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this service?');">
                            <input type="hidden" name="id" value="${s.serviceId}" />
                            <button type="submit" class="btn btn-delete">🗑️ Delete</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>

