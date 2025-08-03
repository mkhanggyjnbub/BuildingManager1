<%-- 
    Document   : paymentCheckOut
    Created on : 4 Aug 2025, 04:06:21
    Author     : dodan
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Payment Checkout</title>
    </head>
    <body>
        <h2>Payment Checkout</h2>

        <p><strong>Booking ID:</strong> ${booking.bookingId}</p>
        <p><strong>Extra Charge Total:</strong> ${price} VND</p>

    <c:if test="${not empty invoice}">
        <p><strong>Paid Amount:</strong> ${invoice.paidAmount} VND</p>
        <p><strong>Total Amount:</strong> ${invoice.totalAmount} VND</p>
    </c:if>

    <c:if test="${empty invoice}">
        <p style="color: red;">No invoice found for this booking.</p>
    </c:if>
</body>
</html>

