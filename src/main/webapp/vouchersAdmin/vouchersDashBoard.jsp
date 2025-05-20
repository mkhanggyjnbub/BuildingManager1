<%-- 
    Document   : voucherDashBoard
    Created on : May 19, 2025, 9:03:49 PM
    Author     : CE180441_Dương Đinh Thế Vinh
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <style>
        .voucher-table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-family: 'Segoe UI', sans-serif;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .voucher-table th, .voucher-table td {
            padding: 16px;
            text-align: center;
            border-bottom: 1px solid #e0e0e0;
        }

        .voucher-table th {
            background-color: #f5f5f5;
            font-weight: bold;
        }

        .voucher-table tr:hover {
            background-color: #f9f9f9;
        }

        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.2s ease;
            text-decoration: none;
            color: white;
            margin: 0 4px;
        }

        .btn-view {
            background-color: #3498db;
        }

        .btn-view:hover {
            background-color: #2980b9;
        }

        .btn-add {
            background-color: #27ae60;
        }

        .btn-add:hover {
            background-color: #1e8449;
        }

        .btn-edit {
            background-color: #f1c40f;
            color: black;
        }

        .btn-edit:hover {
            background-color: #d4ac0d;
        }

        .btn-delete {
            background-color: #e74c3c;
        }

        .btn-delete:hover {
            background-color: #c0392b;
        }

        .voucher-table form {
            display: inline;
        }
    </style>

    <head>
        <title>Kho Voucher</title>
        <link rel="stylesheet" href="css/style.css" />
    </head>
    <body>
        <h1 class="title">Quản lý Voucher</h1>
        <a href="AddVoucher" class="btn btn-add"> Thêm Voucher </a> <br>
        <a href="Vouchers" class="btn btn-add"> Voucher </a> <br>



        <div class="voucher-list">
            <table class="voucher-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Voucher Code</th>
                        <th>Hạn sử dụng</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="v" items="${vouchers}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${v.code}</td>
                            <td>${v.endDate}</td>
                            <td>
                                <a href="ViewVoucher?voucherId=${v.voucherId}" class="btn btn-view">xem</a>
                                <a href="EditVoucher?voucherId=${v.voucherId}" class="btn btn-edit">sửa</a>
                                <form action="DeleteVoucher" method="get" onsubmit="return confirm('Bạn có chắc muốn xóa voucher này?')">
                                    <input type="hidden" name="id" value="${v.voucherId}" />
                                    <button type="submit" class="btn btn-delete">xóa</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

    </body>
</html>
