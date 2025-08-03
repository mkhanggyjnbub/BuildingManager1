<%-- 
    Document   : createStaff
    Created on : 3 Aug 2025, 22:56:01
    Author     : dodan
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Create Staff Account</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f2f2f2;
                margin: 0;
                padding: 40px;
            }

            .form-container {
                background: white;
                padding: 30px;
                width: 420px;
                margin: 0 auto;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            h2 {
                text-align: center;
                margin-bottom: 25px;
                color: #333;
            }

            label {
                font-weight: bold;
            }

            input[type="text"],
            input[type="password"] {
                width: 100%;
                padding: 10px;
                margin-top: 6px;
                margin-bottom: 18px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }

            input[type="submit"] {
                width: 100%;
                padding: 10px;
                background-color: #4CAF50;
                border: none;
                border-radius: 5px;
                color: white;
                font-size: 16px;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: #45a049;
            }

            .error {
                color: red;
                text-align: center;
                margin-bottom: 15px;
            }
        </style>

        <script>
            function validateForm() {
                const email = document.getElementById("email").value.trim();
                const phone = document.getElementById("phone").value.trim();
                const userName = document.getElementById("userName").value.trim();
                const password = document.getElementById("password").value.trim();
                const identity = document.getElementById("identityNumber").value.trim();

                const emailRegex = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;
                const phoneRegex = /^[0-9]{10,12}$/;
                const userNameValid = userName.length >= 6 && userName.length <= 50;
                const passwordValid = password.length >= 8;
                const identityRegex = /^[0-9]{12}$/;

                let errors = [];

                if (!emailRegex.test(email)) {
                    errors.push("Invalid email format. Must be a valid @gmail.com address.");
                }
                if (!phoneRegex.test(phone)) {
                    errors.push("Phone must be 10 to 12 digits.");
                }
                if (!userNameValid) {
                    errors.push("Username must be between 6 and 50 characters.");
                }
                if (!passwordValid) {
                    errors.push("Password must be at least 8 characters.");
                }
                if (!identityRegex.test(identity)) {
                    errors.push("Identity Number must be exactly 12 digits.");
                }

                if (errors.length > 0) {
                    alert(errors.join("\n"));
                    return false;
                }
                return true;
            }
        </script>
    </head>
    <body>
        <%@include file="../navbarDashboard/navbarDashboard.jsp" %>
        <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>
        
        <div class="form-container">
            <h2>Create Staff Account</h2>

            <c:if test="${not empty error}">
                <div class="error">
                    <c:out value="${error}" escapeXml="false" />
                </div>
            </c:if>

            <form action="CreateStaff" method="post" onsubmit="return validateForm();">
                <label for="userName">Username:</label>
                <input type="text" id="userName" name="userName" required minlength="6" maxlength="50">

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required minlength="8">

                <label for="email">Email:</label>
                <input type="text" id="email" name="email" required>

                <label for="identityNumber">Identity Number:</label>
                <input type="text" id="identityNumber" name="identityNumber" required maxlength="12">

                <label for="phone">Phone:</label>
                <input type="text" id="phone" name="phone" required maxlength="12">

                <input type="submit" value="Create Account">
            </form>
        </div>
    </body>
</html>
