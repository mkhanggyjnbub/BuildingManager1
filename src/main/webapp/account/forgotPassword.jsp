<%-- 
    Document   : forgotPassword
    Created on : 15 Jul 2025, 14:52:36
    Author     : dodan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Forgot Password</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(to right, #74ebd5, #ACB6E5);
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            .forgot-container {
                background: #fff;
                padding: 40px 30px;
                border-radius: 12px;
                box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
                width: 400px;
                animation: fadeIn 0.6s ease;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            h2 {
                text-align: center;
                margin-bottom: 25px;
                color: #333;
                font-weight: 600;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-bottom: 8px;
                color: #555;
                font-weight: 500;
            }

            input[type="text"],
            input[type="email"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 8px;
                font-size: 15px;
                transition: border-color 0.3s;
            }

            input:focus {
                border-color: #007bff;
                outline: none;
            }

            input[type="submit"] {
                width: 100%;
                background-color: #007bff;
                border: none;
                color: white;
                padding: 12px;
                border-radius: 8px;
                cursor: pointer;
                font-size: 16px;
                font-weight: 600;
                transition: background-color 0.3s ease;
            }

            input[type="submit"]:hover {
                background-color: #0056b3;
            }

            .error-message {
                color: red;
                font-size: 13px;
                margin-top: -10px;
                margin-bottom: 10px;
            }

            .success-message {
                color: green;
                font-size: 13px;
                margin-bottom: 10px;
                text-align: center;
            }

            .back-login {
                text-align: center;
                margin-top: 15px;
                font-size: 14px;
            }

            .back-login a {
                color: #007bff;
                text-decoration: none;
            }

            .back-login a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="forgot-container">
            <h2>Forgot Password</h2>

            <c:if test="${not empty error}">
                <div class="error-message" style="text-align: center;">${error}</div>
            </c:if>
            <c:if test="${not empty message}">
                <div class="success-message">${message}</div>
            </c:if>

            <form action="ForgotPassword" method="post">
                <div class="form-group">
                    <label for="username">UserName</label>
                    <input type="text" name="username" id="username" required>
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" name="email" id="email" required>
                </div>

                <c:if test="${not empty usernameOrEmailError}">
                    <div class="error-message" style="text-align: center;">${usernameOrEmailError}</div>
                </c:if>

                <input type="submit" value="Send OTP">
            </form>

            <div class="back-login">
                <p><a href="Login">Back to Login</a></p>
            </div>
        </div>
    </body>
</html>
