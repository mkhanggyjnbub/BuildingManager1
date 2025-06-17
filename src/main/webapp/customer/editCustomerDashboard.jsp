<%-- 
    Document   : editCustomerDashboard
    Created on : Jun 18, 2025, 2:47:32 AM
    Author     : KHANH
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Customer</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f0f4f8;
            margin: 0;
            padding: 40px 0;
            color: #333;
        }

        h2 {
            text-align: center;
            color: #002b5c;
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 600;
            border-bottom: 2px solid #002b5c;
            width: fit-content;
            margin-left: auto;
            margin-right: auto;
            padding-bottom: 10px;
        }

        form {
            max-width: 600px;
            margin: auto;
            background-color: #ffffff;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 43, 92, 0.15);
        }

        label {
            font-weight: bold;
            color: #002b5c;
            display: block;
            margin-bottom: 6px;
            margin-top: 14px;
        }

        input[type="text"],
        input[type="email"],
        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }

        input[type="submit"], .button {
            padding: 12px 24px;
            background-color: #002b5c;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .button {
            margin-left: 10px;
        }

        input[type="submit"]:hover,
        .button:hover {
            background-color: #004080;
        }

        .form-actions {
            text-align: center;
            margin-top: 30px;
        }
    </style>
</head>
<body>

<h2>Edit Customer Information</h2>

<form method="post" action="EditCustomerDashboard">
    <input type="hidden" name="customerId" value="${customer.customerId}" />

    <label for="userName">Username:</label>
    <input type="text" id="userName" name="userName" value="${customer.userName}" required>

    <label for="fullName">Full Name:</label>
    <input type="text" id="fullName" name="fullName" value="${customer.fullName}" required>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" value="${customer.email}" required>

    <label for="phone">Phone Number:</label>
    <input type="text" id="phone" name="phone" value="${customer.phone}">

    <label for="address">Address:</label>
    <input type="text" id="address" name="address" value="${customer.address}">

    <label for="gender">Gender:</label>
    <select name="gender" id="gender">
        <option value="Male" ${customer.gender == 'Male' ? 'selected' : ''}>Male</option>
        <option value="Female" ${customer.gender == 'Female' ? 'selected' : ''}>Female</option>
        <option value="Other" ${customer.gender == 'Other' ? 'selected' : ''}>Other</option>
    </select>

    <label for="status">Status (e.g. Active / Inactive):</label>
    <input type="text" id="status" name="status" value="${customer.status}">

    <label for="identityNumber">ID/Passport Number:</label>
    <input type="text" id="identityNumber" name="identityNumber" value="${customer.identityNumber}">

    <label for="avatarUrl">Avatar URL:</label>
    <input type="text" id="avatarUrl" name="avatarUrl" value="${customer.avatarUrl}">

    <div class="form-actions">
        <input type="submit" value="Update Information">
        <a href="javascript:history.back()" class="button">← Go Back</a>
    </div>
</form>

</body>
</html>
