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
        <link rel="stylesheet" href="css/style.css" />
    </head>
    <body>
        <h1 class="title">Kho Voucher</h1>
        <a href="/AddVoucher" class="add-btn"> Thêm Voucher </a> <br>
      
        

        <div class="voucher-list">



            <c:forEach var="v" items="${vouchers}">
                <div class="voucher-card">
                    <form action="DeleteVoucher" method="get" style="display:inline;">
                        <input type="hidden" name="id" value="${v.voucherId}" />
                        <button type="submit" class="delete-btn">Xóa</button>
                    </form>
                    <a href="EditVoucher?voucherId=${v.voucherId}">Sửa</a>    

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
                       
                    </div>
                </div>
            </c:forEach>
        </div>
    </body>
</html>
