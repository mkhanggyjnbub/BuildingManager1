<%-- 
    Document   : addVoucher
    Created on : May 14, 2025, 3:48:15 PM
    Author     : CE180441_Dương Đinh Thế Vinh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Voucher</title>
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
            font-family: 'Segoe UI', sans-serif;
            background-color: var(--background);
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

        h1 {
            text-align: center;
            font-size: 28px;
            margin-bottom: 1.5rem;
            color: var(--primary);
        }

        form {
            max-width: 700px;
            background-color: var(--white);
            margin: 0 auto;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: var(--shadow);
        }

        .form-group {
            margin-bottom: 1.2rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }

        input, select, textarea {
            width: 100%;
            padding: 0.75rem;
            font-size: 1rem;
            border: 1px solid var(--gray);
            border-radius: 8px;
        }

        textarea {
            resize: none;
            height: 80px;
        }

        .button-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
        }

        button, .cancel-btn {
            flex: 1;
            padding: 0.75rem;
            font-size: 1rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 500;
            text-align: center;
        }

        button {
            background-color: #007bff;
            color: #fff;
        }

        button:hover {
            background-color: #0056b3;
        }

        .cancel-btn {
            background-color: #ccc;
            color: #333;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .cancel-btn:hover {
            background-color: #aaa;
        }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const startInput = document.getElementById('startDate');
            const endInput = document.getElementById('endDate');

            function pad(n) {
                return n.toString().padStart(2, '0');
            }

            function getFormattedDateTimeLocal(date) {
                return date.getFullYear() + '-' +
                    pad(date.getMonth() + 1) + '-' +
                    pad(date.getDate()) + 'T' +
                    pad(date.getHours()) + ':' +
                    pad(date.getMinutes());
            }

            const now = new Date();
            const nowFormatted = getFormattedDateTimeLocal(now);
            startInput.min = endInput.min = nowFormatted;
            startInput.value = endInput.value = nowFormatted;

            startInput.addEventListener('change', function () {
                const startValue = startInput.value;
                endInput.min = startValue;
                if (endInput.value < startValue) {
                    endInput.value = startValue;
                }
            });
        });

        function validateMax(input) {
            if (parseInt(input.value) > 1000) {
                input.value = 1000;
            }
        }

        function validateMaxOrder(input) {
            if (parseInt(input.value) > 10000000) {
                input.value = 10000000;
            }
        }
    </script>
</head>
<body>
<%@include file="../navbarDashboard/navbarDashboard.jsp" %>
<%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>
<div class="main-content">
    <form action="AddVoucher" method="post">
        <h1>Add New Voucher</h1>

        <div class="form-group">
            <label for="code">Voucher code</label>
            <input type="text" id="code" name="code" maxlength="50" required>
        </div>

        <div class="form-group">
            <label for="quantity">Quantity</label>
            <input type="number" id="quantity" name="quantity" min="1" max="1000" required oninput="validateMax(this)">
        </div>

        <div class="form-group">
            <label for="discountPercent">Discount %</label>
            <input type="number" step="0.1" min="1" max="100" name="discountPercent" required>
        </div>

        <div class="form-group">
            <label for="minOrderAmount">Minimum Order Amount</label>
            <input type="number" id="minOrderAmount" name="minOrderAmount" min="1" max="10000000" step="1" required oninput="validateMaxOrder(this)">
        </div>

        <div class="form-group">
            <label for="startDate">Start Date</label>
            <input type="datetime-local" id="startDate" name="startDate" required>
        </div>

        <div class="form-group">
            <label for="endDate">End Date</label>
            <input type="datetime-local" id="endDate" name="endDate" required>
        </div>

        <div class="form-group">
            <label for="description">Description</label>
            <textarea id="description" name="description" maxlength="200"></textarea>
        </div>

        <div class="form-group">
            <label for="isActive">Status</label>
            <select id="isActive" name="isActive">
                <option value="false">Inactive</option>
                <option value="true">Active</option>
            </select>
        </div>

        <div class="button-group">
            <button type="submit">Add Voucher</button>
            <a href="VouchersDashBoard" class="cancel-btn">Cancel</a>
        </div>
    </form>
</div>
</body>
</html>
