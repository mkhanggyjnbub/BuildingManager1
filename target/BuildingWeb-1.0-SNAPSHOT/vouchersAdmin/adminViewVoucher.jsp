<%-- 
    Document   : viewVoucher
    Created on : May 21, 2025, 2:26:02 PM
    Author     : CE180441_Dương Đinh Thế Vinh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Chi tiết Voucher</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f9f9f9;
                padding: 30px;
            }
            .voucher-details {
                background-color: #fff;
                padding: 24px;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                max-width: 600px;
                margin: 0 auto;
            }
            .voucher-details h2 {
                margin-bottom: 20px;
                color: #333;
            }
            .detail-row {
                margin-bottom: 10px;
            }
            .detail-label {
                font-weight: bold;
                color: #555;
            }
            .back-btn {
                display: inline-block;
                margin-top: 20px;
                padding: 8px 16px;
                background-color: #3498db;
                color: white;
                text-decoration: none;
                border-radius: 6px;
            }
            .back-btn:hover {
                background-color: #2980b9;
            }
        </style>
    </head>
    <body>
        <div class="voucher-details">
            <h2>Chi tiết Voucher</h2>

            <div class="detail-row"><span class="detail-label">Voucher ID:</span> ${voucher.voucherId}</div>
            <div class="detail-row"><span class="detail-label">Code:</span> ${voucher.code}</div>

            <div class="detail-row"><span class="detail-label">Discount Percent:</span> ${voucher.discountPercent}%</div>

            <div class="detail-row"><span class="detail-label">Min Order Amount:</span> ${voucher.minOrderAmount}đ</div>
            <div class="detail-row"><span class="detail-label">Start Date:</span> <fmt:formatDate value="${voucher.startDate}" pattern="dd/MM/yyyy" /></div>
            <div class="detail-row"><span class="detail-label">End Date:</span> <fmt:formatDate value="${voucher.endDate}" pattern="dd/MM/yyyy" /></div>
            <div class="detail-row"><span class="detail-label">Description:</span> ${voucher.description}</div>
            <div class="detail-row"><span class="detail-label">Quantity:</span> ${voucher.quantity}</div>
            <div class="detail-row"><span class="detail-label">IsActive:</span> ${voucher.isActive}</div>



            <a href="VouchersDashBoard" class="back-btn">← Quay lại</a>

        </div>
    </body>
</html>
