<%-- 
    Document   : vouchers
    Created on : May 14, 2025, 11:36:39 PM
    Author     : CE180441_Dương Đinh Thế Vinh
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <title>Kho Voucher</title>
        <link rel="stylesheet" href="css/style.css" />
    </head>
    <body>
        <h1 class="title">Kho Voucher</h1>       

        <div class="voucher-list">

            <c:forEach var="v" items="${vouchers}">
                <div class="voucher-card">
                    

                    <div class="voucher-left">
                        <p class="voucher-code">${v.code}</p>
                        <p class="voucher-desc">${v.description}</p>
                        <p class="voucher-time">HSD: ${v.endDate}</p>
                    </div>
                    <div class="voucher-right">
                        <p class="voucher-discount">
                            <c:choose>
                                <c:when test="${v.discountPercent != 0}">
                                    -${v.discountPercent}%
                                </c:when>
                                <c:otherwise>
                                    -${v.discountAmount}đ
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <button class="save-btn">Lưu</button>
                    </div>
                </div>
            </c:forEach>
        </div>
    </body>
</html>