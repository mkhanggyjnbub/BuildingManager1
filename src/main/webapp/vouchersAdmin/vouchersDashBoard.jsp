<%-- 
    Document   : voucherDashBoard
    Created on : May 19, 2025, 9:03:49 PM
    Author     : CE180441_Dương Đinh Thế Vinh
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Voucher Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root {
            --primary: #002b5c;
            --primary-light: #004080;
            --background: #f4f6f9;
            --white: #ffffff;
            --gray: #e0e0e0;
            --text: #333;
            --shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
        }

        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: var(--background);
            color: var(--text);
            animation: fadeInBody 0.5s ease-in-out;
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

        h1.title {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 20px;
            color: var(--primary);
        }

        .top-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .btn {
            display: inline-block;
            padding: 10px 18px;
            border-radius: 6px;
            font-size: 14px;
            border: none;
            cursor: pointer;
            font-weight: 500;
            transition: 0.3s ease;
            text-align: center;
            text-decoration: none;
        }

        .btn-add {
            background-color: #007bff;
            color: #fff;
        }

        .btn-add:hover {
            background-color: #0069d9;
        }

        .btn-view {
            background-color: #3498db;
            color: #fff;
        }

        .btn-view:hover {
            background-color: #2d88c6;
        }

        .btn-edit {
            background-color: #f39c12;
            color: #fff;
        }

        .btn-edit:hover {
            background-color: #d68910;
        }

        .btn-delete {
            background-color: #f5d0d0;
            color: #8c2f2f;
        }

        .btn-delete:hover {
            background-color: #e4b0b0;
        }

        .btn-back {
            background-color: #bdc3c7;
            color: #fff;
        }

        .btn-back:hover {
            background-color: #95a5a6;
        }

        .voucher-table {
            width: 100%;
            border-collapse: collapse;
            background-color: var(--white);
            border-radius: 10px;
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        .voucher-table th, .voucher-table td {
            padding: 14px 18px;
            text-align: left;
            border-bottom: 1px solid #e1e4e8;
        }

        .voucher-table thead {
            background-color: #e9ecef;
        }

        .voucher-table th {
            font-weight: 600;
            color: #333;
        }

        .voucher-table tr:hover {
            background-color: #f5f8fa;
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
        }

        .status {
            padding: 4px 10px;
            border-radius: 12px;
            font-weight: 500;
            font-size: 13px;
            display: inline-block;
        }

        .status.active {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .status.inactive {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
<%@include file="../navbarDashboard/navbarDashboard.jsp" %>
<%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>
<div class="main-content">
    <h1 class="title">Voucher Management</h1>
    <div class="top-actions">
        <a href="Dashboard" class="btn btn-back">← Back to Dashboard</a>
        <a href="AddVoucher" class="btn btn-add">Add Voucher</a>
    </div>

    <div class="voucher-list">
        <table class="voucher-table">
            <thead>
                <tr>
                    <th>No.</th>
                    <th>Voucher Code</th>
                    <th>Expiry</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="v" items="${vouchers}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${v.code}</td>
                        <td>${v.formattedEndDate}</td>
                        <td>
                            <span class="status ${v.isActive ? 'active' : 'inactive'}">
                                ${v.isActive ? 'Active' : 'Inactive'}
                            </span>
                        </td>
                        <td>
                            <div class="action-buttons">
                                <a href="AdminViewVoucher?voucherId=${v.voucherId}" class="btn btn-view">View</a>
                                <a href="EditVoucher?voucherId=${v.voucherId}" class="btn btn-edit">Edit</a>
                                <form action="DeleteVoucher" method="get" onsubmit="return confirm('Are you sure you want to delete this voucher?')">
                                    <input type="hidden" name="id" value="${v.voucherId}" />
                                    <button type="submit" class="btn btn-delete">Delete</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
