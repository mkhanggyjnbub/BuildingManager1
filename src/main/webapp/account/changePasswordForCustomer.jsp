<%-- 
    Document   : changePasswordForCustomer
    Created on : 28 Jul 2025, 02:06:06
    Author     : dodan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Change Password</title>

        <!-- SweetAlert2 -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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

            .reset-container {
                background: #fff;
                padding: 40px 30px;
                border-radius: 12px;
                box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
                width: 400px;
                animation: fadeIn 0.5s ease;
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
            }

            input[type="submit"]:hover {
                background-color: #0056b3;
            }

            .error, .success {
                font-size: 14px;
                margin-bottom: 10px;
                text-align: center;
            }

            .error {
                color: red;
            }
            .success {
                color: green;
            }
        </style>
    </head>
    <body>
        <div class="reset-container">
            <h2>Change Password</h2>

            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>

            <form method="post" action="ChangePasswordForCustomer">
                <input type="hidden" name="customerId" value="${customerId}">
                <div class="form-group">
                    <label for="currentPassword">Current Password</label>
                    <input type="password" id="currentPassword" name="currentPassword">
                </div>
                <div class="form-group">
                    <label for="newPassword">New Password</label>
                    <input type="password" id="newPassword" name="newPassword" required minlength="8">
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Confirm New Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required minlength="8">
                </div>
                <input type="submit" value="Confirm Change">
            </form>
        </div>

        <c:if test="${not empty message}">
            <script>
                Swal.fire({
                    icon: 'success',
                    title: 'Success!',
                    text: `${message}`,
                    confirmButtonText: 'OK',
                    confirmButtonColor: '#007bff'
                }).then(() => {
                    window.location.href = 'Index';
                });
            </script>
        </c:if>
    </body>
</html
