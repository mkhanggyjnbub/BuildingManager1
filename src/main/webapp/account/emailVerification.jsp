<%-- 
    Document   : emailVerification
    Created on : 15 Jul 2025, 03:08:25
    Author     : dodan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Email Verification</title>
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

            .verify-container {
                background: #fff;
                padding: 40px 30px;
                border-radius: 12px;
                box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
                width: 360px;
                animation: fadeIn 0.6s ease;
                text-align: center;
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
                margin-bottom: 25px;
                color: #333;
                font-weight: 600;
            }

            .form-group {
                margin-bottom: 20px;
                text-align: left;
            }

            label {
                display: block;
                margin-bottom: 8px;
                color: #555;
                font-weight: 500;
            }

            input[type="text"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 8px;
                font-size: 15px;
                transition: border-color 0.3s;
            }

            input[type="text"]:focus {
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

            .message {
                margin-bottom: 15px;
                font-size: 14px;
            }

            .message.success {
                color: green;
            }
            .message.error {
                color: red;
            }

            #countdown {
                margin-top: 10px;
                color: red;
                font-weight: bold;
                font-size: 15px;
            }

            #resendContainer {
                display: none;
                margin-top: 15px;
            }
        </style>
    </head>
    <body>
        <div class="verify-container">
            <h2>Xác thực Email</h2>

            <c:if test="${not empty message}">
                <div class="message success">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="message error">${error}</div>
            </c:if>

            <form action="EmailVerification" method="post">
                <div class="form-group">
                    <label for="otp">Nhập mã OTP</label>
                    <input type="text" id="otp" name="otp" required>
                </div>
                <input type="submit" value="Xác minh">
            </form>

            <div class="message" id="countdown" style="text-align: center; font-weight: bold;"></div>
            <div id="resendContainer" style="display: none; text-align: center; margin-top: 15px;">
                <form action="ResendOTP" method="post">
                    <input type="submit" value="Gửi lại OTP">
                </form>
            </div>
        </div>

        <script>
            let remainingTime = 300; // 5 phút = 300 giây
            const countdownElement = document.getElementById("countdown");
            const resendContainer = document.getElementById("resendContainer");

            const timer = setInterval(function () {
                if (remainingTime > 0) {
                    countdownElement.textContent = "OTP sẽ hết hạn sau: " + remainingTime + " giây";
                    remainingTime--;
                } else {
                    clearInterval(timer);
                    countdownElement.textContent = "OTP đã hết hạn. Vui lòng gửi lại!";
                    resendContainer.style.display = "block";
                }
            }, 1000);
        </script>

    </body>
</html>
