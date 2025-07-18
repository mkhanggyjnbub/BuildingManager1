<%-- 
    Document   : resetPassword
    Created on : 16 Jul 2025, 02:00:34
    Author     : dodan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Reset Password</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background: linear-gradient(to right, #74ebd5, #ACB6E5);
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            .container {
                width: 400px;
                background: #fff;
                padding: 40px 30px;
                border-radius: 12px;
                box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
                animation: fadeIn 0.5s ease;
                box-sizing: border-box;
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
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-bottom: 8px;
                color: #555;
            }

            input[type="password"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 8px;
                font-size: 15px;
                box-sizing: border-box;
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
                font-weight: bold;
                margin-top: 15px; /* Dời xuống 15px */
            }

            input[type="submit"]:hover {
                background-color: #0056b3;
            }

            .error {
                color: red;
                font-size: 14px;
                margin-bottom: 10px;
                text-align: center;
            }

            .success {
                color: green;
                font-size: 14px;
                margin-bottom: 10px;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Reset Password</h2>

            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>

            <c:if test="${not empty message}">
                <script>
                    alert("${message}");
                    window.location.href = "Login";
                </script>
            </c:if>

            <form action="ResetPassword" method="post">
                <input type="hidden" name="username" value="${param.username}" />

                <div class="form-group">
                    <label>New Password:</label>
                    <input type="password" name="newPassword" required />
                </div>

                <div class="form-group">
                    <label>Confirm Password:</label>
                    <input type="password" name="confirmPassword" required />
                </div>

                <input type="submit" value="Reset Password" />
            </form>

        </div>
    </body>
</html>
