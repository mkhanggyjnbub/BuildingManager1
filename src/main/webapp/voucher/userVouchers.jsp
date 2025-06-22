<%-- 
    Document   : userVouchers
    Created on : Jun 16, 2025, 1:08:27 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Voucher đã lưu</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f7f7f7;
            margin: 0;
            padding: 20px;
            text-align: center;
        }

        h1 {
            color: #333;
            margin-bottom: 30px;
        }

        .voucher-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
        }

        .voucher-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 20px;
            width: 300px;
            text-align: left;
            transition: transform 0.3s ease;
        }

        .voucher-card:hover {
            transform: scale(1.03);
        }

        .voucher-card h3 {
            color: #e91e63;
            margin: 0 0 10px;
        }

        .voucher-card p {
            margin: 5px 0;
            color: #555;
        }

        .back-link {
            display: inline-block;
            margin-top: 30px;
            text-decoration: none;
            color: #2196f3;
            font-weight: bold;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .empty-message {
            font-size: 18px;
            color: #777;
            margin-top: 50px;
        }
    </style>
    </head>
    <body>
        <h1>🎁 Your voucher(s)</h1>

    <c:choose>
        <c:when test="${empty savedVouchers}">
            <p>You have not saved any vouchers yet.</p>
        </c:when>
        <c:otherwise>
            <div class="voucher-list">
                <c:forEach var="v" items="${savedVouchers}">
                    <div class="voucher-card">
                        <h3>${v.code}</h3>                        
                        <p>Reduce ${v.discountPercent}%</p>
                        <p>Minimum application: ${v.minOrderAmount} VNĐ</p>
                        <p>${v.description}</p>
                        <p>Expiry: ${v.endDate}</p>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

    <a href="ViewVouchers">← Return to voucher warehouse</a>
</body>
</html>
