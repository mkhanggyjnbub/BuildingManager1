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
                background-color: #f5f6f8;
                color: #333;
                margin: 0;
                padding: 20px;
            }

            .title {
                font-size: 28px;
                font-weight: 600;
                margin-bottom: 20px;
                color: #2c3e50;
            }

            a {
                text-decoration: none;
            }

            .btn {
                display: inline-block;
                padding: 8px 14px;
                margin: 4px 0;
                border-radius: 6px;
                font-size: 14px;
                border: none;
                cursor: pointer;
                transition: background-color 0.2s;
            }

            .btn-add {
                background-color: #e0e0e0;
                color: #333;
            }

            .btn-add:hover {
                background-color: #d5d5d5;
            }

            .btn-view {
                background-color: #dce6f1;
                color: #2c3e50;
            }

            .btn-view:hover {
                background-color: #c8d9ec;
            }

            .btn-edit {
                background-color: #fdf5e6;
                color: #7c6e4f;
            }

            .btn-edit:hover {
                background-color: #f2e9d3;
            }

            .btn-delete {
                background-color: #f5d0d0;
                color: #8c2f2f;
                border: none;
            }

            .btn-delete:hover {
                background-color: #e7bebe;
            }

            .voucher-list {
                margin-top: 20px;
                overflow-x: auto;
            }

            .voucher-table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 1px 4px rgba(0,0,0,0.1);
                overflow: hidden;
            }

            .voucher-table th, .voucher-table td {
                padding: 12px 16px;
                text-align: left;
                border-bottom: 1px solid #e0e0e0;
            }

            .voucher-table thead {
                background-color: #f0f0f0;
            }

            .voucher-table th {
                font-weight: 600;
                color: #444;
            }

            .voucher-table tr:hover {
                background-color: #f9f9f9;
            }

            form {
                display: inline;
            }

            .action-buttons {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 10px;
            }
            .btn {
                min-width: 60px;
                text-align: center;
            }

            .voucher-table th:nth-child(4),
            .voucher-table td:nth-child(4) {
                text-align: center;
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
                <thead>
                    <tr>
                        <th>Numerical order</th>
                        <th>Voucher Code</th>
                        <th>Expiry</th>
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
