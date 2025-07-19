<%-- 
    Document   : signUp
    Created on : Apr 30, 2025, 4:21:41 PM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Sign Up</title>
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

            .signup-container {
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

            .signup-container h2 {
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
            input[type="password"],
            input[type="email"],
            input[type="date"] {
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

            .login-link {
                text-align: center;
                margin-top: 18px;
                font-size: 14px;
            }

            .login-link a {
                color: #007bff;
                text-decoration: none;
                font-weight: 500;
            }

            .login-link a:hover {
                text-decoration: underline;
            }

            .error-message {
                color: red;
                font-size: 13px;
                margin-top: -10px;
                margin-bottom: 10px;
                display: none;
            }
        </style>
    </head>
    <body>
        <div class="signup-container">
            <h2>Sign Up</h2>

            <c:if test="${not empty message}">
                <div style="color: green; margin-bottom: 15px;">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div style="color: red; margin-bottom: 15px;">${error}</div>
            </c:if>

            <form id="signupForm" action="SignUp" method="post" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="tk">Username</label>
                    <input id="tk" name="tk" type="text" required minlength="6">
                    <div class="error-message" id="tkError">Username must not exceed 50 characters</div>
                    <c:if test="${not empty usernameError}">
                        <div class="error-message" style="display:block;">${usernameError}</div>
                    </c:if>
                </div>

                <div class="form-group">
                    <label for="pas">Password</label>
                    <input id="pas" name="pas" type="password" required minlength="8">
                    <div class="error-message" id="pasError">Password must not exceed 100 characters</div>
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input id="email" name="email" type="email"
                           title="Please enter a valid Gmail address"
                           required>
                    <div class="error-message" id="emailError">Email must end with @gmail.com</div>
                    <c:if test="${not empty emailError}">
                        <div class="error-message" style="display:block;">${emailError}</div>
                    </c:if>
                </div>

                <div class="form-group">
                    <label for="dob">Day of Birth</label>
                    <input id="dob" name="dob" type="date" required>
                    <div class="error-message" id="dobError">You must be at least 18 years old</div>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input id="phone" name="phone" type="text" required
                           title="Please enter a valid phone number (9–11 digits)">
                    <div class="error-message" id="phoneError">Phone must be 9–11 digits</div>
                </div>

                <div class="form-group">
                    <label for="cccd">Citizen ID Number</label>
                    <input id="cccd" name="cccd" type="text" required
                           title="Citizen ID must be exactly 12 digits">
                    <div class="error-message" id="cccdError">Citizen ID must be exactly 12 digits</div>
                </div>
                <div style="font-size: 13px; color: #555; margin-top: -10px; margin-bottom: 15px;">
                    <strong>Note:</strong> You must enter the correct Citizen ID. It will be used to verify your identity when checking in. If the ID is incorrect, you may lose your payment.
                </div>


                <c:if test="${otpSent eq true}">
                    <div class="form-group">
                        <label for="otp">Enter OTP sent to your email</label>
                        <input type="text" id="otp" name="otp" required>
                    </div>
                    <input type="submit" name="verify" value="Verify OTP"/>
                </c:if>

                <c:if test="${otpSent ne true}">
                    <input name="sub" type="submit" value="Sign Up"/>
                </c:if>
            </form>

            <div class="login-link">
                <p>Already have an account? <a href="Login">Log In</a></p>
            </div>
        </div>

        <script>
            function validateForm() {
                const username = document.getElementById("tk").value.trim();
                const email = document.getElementById("email").value.trim();
                const dob = document.getElementById("dob").value;
                const password = document.getElementById("pas").value.trim();
                const phone = document.getElementById("phone").value.trim();
                const cccd = document.getElementById("cccd").value.trim(); // Chỉ xuất hiện 1 lần ở đây

                let valid = true;

                document.getElementById("tkError").style.display = "none";
                document.getElementById("emailError").style.display = "none";
                document.getElementById("dobError").style.display = "none";
                document.getElementById("pasError").style.display = "none";
                document.getElementById("phoneError").style.display = "none";
                document.getElementById("cccdError").style.display = "none";

                if (username.length > 50) {
                    document.getElementById("tkError").style.display = "block";
                    valid = false;
                }

                const gmailRegex = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;
                if (!gmailRegex.test(email)) {
                    document.getElementById("emailError").style.display = "block";
                    valid = false;
                }

                if (password.length > 100) {
                    document.getElementById("pasError").style.display = "block";
                    valid = false;
                }

                if (dob) {
                    const dobDate = new Date(dob);
                    const today = new Date();
                    let age = today.getFullYear() - dobDate.getFullYear();
                    const m = today.getMonth() - dobDate.getMonth();
                    if (m < 0 || (m === 0 && today.getDate() < dobDate.getDate())) {
                        age--;
                    }
                    if (age < 18) {
                        document.getElementById("dobError").style.display = "block";
                        valid = false;
                    }
                }

                const cccdRegex = /^\d{12}$/;
                if (!cccdRegex.test(cccd)) {
                    document.getElementById("cccdError").style.display = "block";
                    valid = false;
                }

                const phoneRegex = /^\d{9,11}$/;
                if (!phoneRegex.test(phone)) {
                    document.getElementById("phoneError").style.display = "block";
                    valid = false;
                }

                return valid;
            }

        </script>
    </body>
</html>
