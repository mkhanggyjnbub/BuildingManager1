<%-- 
    Document   : viewCustomerDetail
    Created on : Jun 18, 2025, 12:53:34 AM
    Author     : KHANH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Details</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f0f4f8;
            padding: 40px;
            color: #333;
        }

        h2 {
            color: #002b5c;
            text-align: center;
            margin-bottom: 30px;
            font-size: 30px;
            font-weight: 600;
            border-bottom: 2px solid #002b5c;
            padding-bottom: 12px;
        }

        .container {
            max-width: 800px;
            margin: auto;
            background-color: #fff;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0,43,92,0.1);
        }

        .info {
            margin-bottom: 14px;
            font-size: 16px;
            line-height: 1.5;
        }

        .info strong {
            width: 220px;
            display: inline-block;
            color: #002b5c;
        }

        img {
            border-radius: 8px;
            margin-top: 12px;
            border: 2px solid #002b5c;
        }

        .back-button {
            display: inline-block;
            margin-top: 35px;
            padding: 12px 24px;
            background-color: #002b5c;
            color: #fff;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 600;
            font-size: 15px;
            transition: background-color 0.3s ease;
        }

        .back-button:hover {
            background-color: #004080;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Customer Details</h2>

    <c:if test="${not empty customer}">
        <div class="info"><strong>Customer ID:</strong> ${customer.customerId}</div>
        <div class="info"><strong>Username:</strong> ${customer.userName}</div>
        <div class="info"><strong>Full Name:</strong> ${customer.fullName}</div>
        <div class="info"><strong>Email:</strong> ${customer.email}</div>
        <div class="info"><strong>Phone Number:</strong> ${customer.phone}</div>
        <div class="info"><strong>Gender:</strong> ${customer.gender}</div>
        <div class="info"><strong>Address:</strong> ${customer.address}</div>
        <div class="info"><strong>Date of Birth:</strong> ${customer.dateOfBirth}</div>
        <div class="info"><strong>Status:</strong> ${customer.status}</div>
        <div class="info"><strong>Account Created:</strong> ${customer.creationDate}</div>
        <div class="info"><strong>Last Login:</strong> ${customer.lastLogin}</div>
        <div class="info"><strong>ID/Passport Number:</strong> ${customer.identityNumber}</div>
        <div class="info"><strong>Join Date:</strong> ${customer.joinDate}</div>

        <c:if test="${not empty customer.avatarUrl}">
            <div class="info">
                <strong>Avatar:</strong><br>
                <img src="${customer.avatarUrl}" alt="Avatar" width="120" height="120">
            </div>
        </c:if>
    </c:if>

    <a class="back-button" onclick="history.back()">← Back</a>
</div>

</body>
</html>
