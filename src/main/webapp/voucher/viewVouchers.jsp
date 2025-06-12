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
        <link rel="stylesheet" href="css/style.css" />
    </head>
    <body>
        <h1 class="title">Kho Voucher</h1>       

        <div class="voucher-list">

            <c:forEach var="v" items="${vouchers}">
                <c:set var="isSaved" value="false" />

                <c:forEach var="saved" items="${voucherCustomer}">
                    <c:if test="${v.voucherId == saved.voucherId}">
                        <c:set var="isSaved" value="true" />
                    </c:if>
                </c:forEach>

                <div class="voucher-card
                     ${v.typeId == 1 ? 'room-voucher' : (v.typeId == 2 ? 'food-voucher' : '')}
                     ${isSaved ? 'saved' : ''}">

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

                        <c:choose>
                            <%-- Nếu đã lưu voucher --%>
                            <c:when test="${isSaved}">
                                <p class="saved-label">Đã nhận</p>
                            </c:when>

                            <%-- Nếu voucher đã hết số lượng --%>
                            <c:when test="${v.quantity == 0}">
                                <p class="saved-label out-of-stock">Đã hết</p>
                            </c:when>

                            <%-- Nếu chưa lưu và còn số lượng --%>
                            <c:otherwise>
                                <form action="ViewVouchers" method="post">
                                    <input type="hidden" name="voucherId" value="${v.voucherId}" />
                                    <input type="hidden" name="customerId" value="${sessionScope.customerId}" />
                                    <button class="save-btn">Lưu</button>
                                </form>

                                <c:if test="${not empty message}">
                                    <div class="alert-message">
                                        ${message}
                                    </div>
                                </c:if>
                            </c:otherwise>
                        </c:choose>                      
                    </div>
                </div>
            </c:forEach>



        </div>
    </body>
</html>