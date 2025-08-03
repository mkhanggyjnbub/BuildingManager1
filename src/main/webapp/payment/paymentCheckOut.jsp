<%-- 
    Document   : paymentCheckOut
    Created on : 4 Aug 2025, 04:06:21
    Author     : dodan
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
    <head>
        <meta charset="UTF-8">
        <title>Payment Checkout</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f4f6f8;
                margin: 0;
                padding: 0;
            }

            .checkout-container {
                max-width: 600px;
                margin: 60px auto;
                background-color: #ffffff;
                padding: 30px 40px;
                border-radius: 12px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
            }

            h2 {
                text-align: center;
                color: #333;
                margin-bottom: 30px;
            }

            p {
                font-size: 16px;
                margin: 10px 0;
                color: #555;
            }

            strong {
                color: #222;
            }

            form {
                margin-top: 30px;
                text-align: center;
            }

            button {
                background-color: #28a745;
                color: white;
                border: none;
                padding: 12px 30px;
                font-size: 16px;
                border-radius: 6px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            button:hover {
                background-color: #218838;
            }

            .error-message {
                color: red;
                text-align: center;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>
        <%@include file="../navbarDashboard/navbarDashboard.jsp" %>

        <div class="checkout-container">
            <h2>Payment Checkout</h2>

            <p><strong>Booking ID:</strong> ${booking.bookingId}</p>
            <p><strong>Extra Charge Total:</strong> ${price} VND</p>

            <c:if test="${invoice != null && invoice.invoiceId != 0}">
                <p><strong>Paid Amount:</strong> ${invoice.paidAmount} VND</p>
                <p><strong>Total Amount:</strong> ${invoice.totalAmount} VND</p>

                <c:set var="remainingAmount" value="${invoice.totalAmount - invoice.paidAmount}" />
                <c:set var="totalPayable" value="${price + remainingAmount}" />

                <p><strong>Total Amount Payable:</strong> ${totalPayable} VND</p>

                <form action="PaymentCheckOut" method="post">
                    <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                    <input type="hidden" name="totalPayable" value="${totalPayable}" />
                    <button type="submit">Payment</button>
                </form>
            </c:if>

            <c:if test="${invoice == null || invoice.invoiceId == 0}">
                <p class="error-message">No invoice found for this booking.</p>
            </c:if>
        </div>
    </body>
</html>




