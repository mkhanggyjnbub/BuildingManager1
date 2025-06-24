<%-- 
    Document   : viewVoucher
    Created on : May 21, 2025, 2:26:02 PM
    Author     : CE180441_Dương Đinh Thế Vinh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Voucher Details</title>
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
            background-color: var(--background);
            font-family: 'Segoe UI', sans-serif;
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

        .voucher-details {
            background-color: var(--white);
            border-radius: 16px;
            padding: 2rem;
            width: 100%;
            max-width: 800px;
            margin: 0 auto;
            box-shadow: var(--shadow);
        }

        h2 {
            text-align: center;
            font-size: 1.8rem;
            margin-bottom: 2rem;
            color: var(--primary);
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            padding: 0.75rem 0;
            border-bottom: 1px solid var(--gray);
        }

        .detail-label {
            font-weight: 600;
            color: var(--primary);
            flex: 1;
        }

        .detail-value {
            flex: 2;
            text-align: right;
            color: var(--text);
        }

        .back-btn {
            display: inline-block;
            margin-top: 2rem;
            padding: 0.75rem 1.5rem;
            background-color: var(--primary);
            color: #fff;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: background 0.3s ease;
        }

        .back-btn:hover {
            background-color: var(--primary-light);
        }
    </style>
</head>
<body>
    <%@include file="../navbarDashboard/navbarDashboard.jsp" %>
    <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>
    <div class="main-content">
        <div class="voucher-details">
            <h2>Voucher Details</h2>

            <div class="detail-row">
                <span class="detail-label">Voucher ID:</span>
                <span class="detail-value">${voucher.voucherId}</span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Voucher code:</span>
                <span class="detail-value">${voucher.code}</span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Discount (%):</span>
                <span class="detail-value">${voucher.formattedDiscountPercent}%</span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Minimum application:</span>
                <span class="detail-value">
                    <fmt:formatNumber value="${voucher.minOrderAmount}" type="number" groupingUsed="true" />đ
                </span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Start date:</span>
                <span class="detail-value">${voucher.formattedStartDate}</span>
            </div>

            <div class="detail-row">
                <span class="detail-label">End date:</span>
                <span class="detail-value">${voucher.formattedEndDate}</span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Describe:</span>
                <span class="detail-value">${voucher.description}</span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Quantity:</span>
                <span class="detail-value">${voucher.quantity}</span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Status:</span>
                <span class="detail-value">
                    <c:choose>
                        <c:when test="${voucher.isActive}">Active</c:when>
                        <c:otherwise>Inactive</c:otherwise>
                    </c:choose>
                </span>
            </div>

            <a href="VouchersDashBoard" class="back-btn">← Back</a>
        </div>
    </div>
</body>
</html>
