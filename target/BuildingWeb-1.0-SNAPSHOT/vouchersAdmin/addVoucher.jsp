<%-- 
    Document   : addVoucher
    Created on : May 16, 2025, 3:48:15 PM
    Author     : CE180441_Dương Đinh Thế Vinh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Voucher Mới</title>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

    <!-- Giao diện chung -->
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f8;
        }

        .main-content {
            margin-left: 60px;
            padding: 80px 20px;
            transition: margin-left 0.3s ease;
        }

        .sidebar.open ~ .main-content {
            margin-left: 220px;
        }

        form {
            background-color: #fff;
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
            max-width: 600px;
            width: 100%;
            margin: auto;
        }

        h1 {
            font-size: 22px;
            margin-bottom: 20px;
            color: #002b5c;
            text-align: center;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px 16px;
            margin-bottom: 16px;
        }

        label {
            font-size: 13px;
            font-weight: 600;
            color: #002b5c;
            align-self: center;
        }

        input[type="text"],
        input[type="number"],
        input[type="date"],
        textarea {
            font-size: 13px;
            padding: 8px 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            width: 100%;
        }

        textarea {
            resize: vertical;
            min-height: 60px;
            width: 100%;
            margin-top: 4px;
            margin-bottom: 12px;
        }

        input:focus,
        textarea:focus {
            outline: none;
            border-color: #007bff;
        }

        .button-group {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 10px;
        }

        button[type="submit"] {
            padding: 8px 16px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 13px;
            cursor: pointer;
        }

        button[type="submit"]:hover {
            background-color: #0056b3;
        }

        .cancel-btn {
            padding: 8px 16px;
            font-size: 13px;
            color: #555;
            border: 1px solid #ccc;
            border-radius: 6px;
            text-decoration: none;
        }

        .cancel-btn:hover {
            background-color: #eee;
        }
    </style>
</head>
<body>

<%@ include file="../navbarDashboard/navbarDashboard.jsp" %>
<%@ include file="../sidebarDashboard/sidebarDashboard.jsp" %>

<div class="main-content">
    <form action="AddVoucher" method="post">
        <h1><i class="fa-solid fa-ticket"></i> Thêm Voucher Mới</h1>

        <div class="form-grid">
            <label><i class="fa-solid fa-barcode"></i> Mã voucher:</label>
            <input type="text" name="code" required/>

            <label><i class="fa-solid fa-layer-group"></i> Số lượng:</label>
            <input type="number" name="quantity" required/>

            <label><i class="fa-solid fa-percent"></i> Giảm %:</label>
            <input type="number" name="discountPercent"/>

            <label><i class="fa-solid fa-money-bill-wave"></i> Đơn tối thiểu:</label>
            <input type="number" name="minOrderAmount" required/>

            <label><i class="fa-solid fa-calendar-plus"></i> Ngày bắt đầu:</label>
            <input type="date" name="startDate" required/>

            <label><i class="fa-solid fa-calendar-minus"></i> Ngày kết thúc:</label>
            <input type="date" name="endDate" required/>
        </div>

        <label><i class="fa-solid fa-file-lines"></i> Mô tả:</label>
        <textarea name="description"></textarea>

        <label><i class="fa-solid fa-toggle-on"></i> Trạng thái: hoạt động</label>
        <input type="checkbox" name="isActive"
               <c:if test="${voucher.isActive}">checked</c:if> />

        <div class="button-group">
            <button type="submit"><i class="fa-solid fa-plus"></i> Thêm voucher</button>
            <a href="VouchersDashBoard" class="cancel-btn"><i class="fa-solid fa-xmark"></i> Hủy</a>
        </div>
    </form>
</div>

</body>
</html>
