<%-- 
    Document   : voucherDashBoard
    Created on : May 19, 2025, 9:03:49 PM
    Author     : CE180441_Dương Đinh Thế Vinh
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Kho Voucher</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f2f4f7;
                color: #222;
                margin: 0;
                padding: 20px;
            }

            .title {
                font-size: 30px;
                font-weight: 700;
                margin-bottom: 20px;
                color: #1f2d3d;
            }

            a {
                text-decoration: none;
            }

            .btn {
                display: inline-block;
                padding: 8px 16px;
                margin: 4px 0;
                border-radius: 6px;
                font-size: 14px;
                border: none;
                cursor: pointer;
                font-weight: 500;
                transition: background-color 0.2s;
                min-width: 70px;
                text-align: center;
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
                background-color: #e74c3c;
                color: #fff;
            }

            .btn-delete:hover {
                background-color: #c0392b;
            }

            .voucher-list {
                margin-top: 20px;
                overflow-x: auto;
            }

            .voucher-table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
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

            .voucher-table th:nth-child(4),
            .voucher-table td:nth-child(4),
            .voucher-table th:nth-child(5),
            .voucher-table td:nth-child(5) {
                text-align: center;
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

            form {
                display: inline;
            }

            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0,0,0,0.5);
            }

            .modal-content {
                background-color: #fff;
                margin: 10% auto;
                padding: 20px;
                width: 50%;
                border-radius: 10px;
                position: relative;
            }

            .close {
                position: absolute;
                top: 10px;
                right: 15px;
                font-size: 24px;
                cursor: pointer;
            }
        </style>



    </head>
    <body>
        <h1 class="title">Voucher Management</h1>
        <a href="AddVoucher" class="btn btn-add">Add Voucher</a> <br>

        <div class="voucher-list">
            <table class="voucher-table">
                <!-- Table Header -->
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Voucher Code</th>
                        <th>Expiry</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>         
                </thead>

                <!-- Table Rows -->
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

    </body>
</html>
