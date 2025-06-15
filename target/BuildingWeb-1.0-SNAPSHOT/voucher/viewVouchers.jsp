<%-- 
    Document   : vouchers
    Created on : May 14, 2025, 11:36:39 PM
    Author     : CE180441_Dương Đinh Thế Vinh
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <title>Kho Voucher</title>

        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f5f7fa;
                padding: 20px;
                color: #333;
            }

            .title {
                font-size: 32px;
                font-weight: 600;
                text-align: center;
                color: #2b3e50;
                margin-bottom: 30px;
            }

            .voucher-list {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                justify-content: center;
            }

            .voucher-card {
                background-color: white;
                border-radius: 12px;
                box-shadow: 0 4px 10px rgba(0,0,0,0.08);
                width: 300px;
                padding: 20px;
                transition: transform 0.2s ease;
            }

            .voucher-card:hover {
                transform: translateY(-5px);
            }

            .voucher-content {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .voucher-info {
                flex: 1;
            }

            .voucher-code {
                font-size: 20px;
                font-weight: bold;
                color: #1a73e8;
                margin: 0;
            }

            .voucher-desc {
                font-size: 14px;
                color: #555;
                margin: 5px 0;
            }

            .voucher-time {
                font-size: 12px;
                color: #888;
            }

            .voucher-action {
                text-align: right;
                margin-left: 10px;
            }

            .voucher-discount .discount {
                font-size: 22px;
                color: #e53935;
                font-weight: bold;
            }

            .save-btn {
                background-color: #1a73e8;
                color: white;
                padding: 8px 12px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-size: 14px;
            }

            .save-btn:hover {
                background-color: #0f5ec9;
            }

            .status-label {
                font-size: 14px;
                font-weight: bold;
                padding: 6px 10px;
                border-radius: 8px;
                display: inline-block;
                margin-top: 8px;
            }

            .saved-label {
                background-color: #4caf50;
                color: white;
            }

            .out-label {
                background-color: #f44336;
                color: white;
            }

            .voucher-card.saved .save-btn {
                display: none;
            }

            .voucher-card.out-of-stock {
                opacity: 0.6;
                pointer-events: none;
            }

        </style>
    </head>
    <body>
        <h1 class="title">🎁 Kho Voucher</h1>
        <%-- 
        <c:if test="${not empty message}">
            <div class="alert">${message}</div>
        </c:if>
        --%>

        <div class="voucher-list">
            <c:forEach var="v" items="${vouchers}">
                <c:set var="isSaved" value="false" />

                <c:forEach var="saved" items="${voucherCustomer}">
                    <c:if test="${v.voucherId == saved.voucherId}">
                        <c:set var="isSaved" value="true" />
                    </c:if>
                </c:forEach>

                <div class="voucher-card ${isSaved ? 'saved' : ''} ${v.quantity == 0 ? 'out-of-stock' : ''}">
                    <div class="voucher-content">
                        <div class="voucher-info">
                            <h2 class="voucher-code">${v.code}</h2>
                            <p class="voucher-desc">Đơn tối thiểu: ${v.minOrderAmount} VNĐ</p>
                            <p class="voucher-desc">${v.description}</p>
                            <p class="voucher-time">HSD: ${v.endDate}</p>
                        </div>

                        <div class="voucher-action">
                            <div class="voucher-discount">
                                <c:if test="${v.discountPercent != 0}">
                                    <span class="discount">-${v.discountPercent}%</span>
                                </c:if>
                            </div>

                            <c:choose>
                                <c:when test="${isSaved}">
                                    <p class="saved-label">Đã nhận</p>
                                </c:when>
                                <c:when test="${v.quantity == 0}">
                                    <p class="status-label out-label">Đã hết</p>
                                </c:when>
                                <c:otherwise>
                                    <form action="ViewVouchers" method="post">
                                        <input type="hidden" name="voucherId" value="${v.voucherId}" />
                                        <button class="save-btn">Lưu voucher</button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>

        </div>
    </body>


</html>