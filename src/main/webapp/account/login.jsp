<%-- 
    Document   : login
    Created on : Apr 15, 2025, 9:53:01 AM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Login Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
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

            .login-container {
                background: #fff;
                padding: 40px 30px;
                border-radius: 14px;
                box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
                width: 380px;
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

            .login-container h2 {
                text-align: center;
                margin-bottom: 25px;
                color: #333;
                font-weight: 700;
                font-size: 26px;
            }

            .form-group {
                margin-bottom: 18px;
                position: relative;
            }

            label {
                display: block;
                margin-bottom: 8px;
                color: #444;
                font-weight: 500;
            }

            .form-group i {
                position: absolute;
                top: 40px;
                left: 12px;
                color: #888;
            }

            input[type="text"],
            input[type="password"],
            select {
                width: 100%;
                padding: 12px 12px 12px 40px;
                border: 1px solid #ccc;
                border-radius: 10px;
                font-size: 15px;
                height: 45px;
                box-sizing: border-box;
                transition: border-color 0.3s, box-shadow 0.3s;
                background-color: #fff;
                appearance: none;
            }

            input[type="text"]:focus,
            input[type="password"]:focus,
            select:focus {
                border-color: #007bff;
                box-shadow: 0 0 6px rgba(0, 123, 255, 0.3);
                outline: none;
            }

            /* Custom arrow cho select */
            select {
                background-image: url("data:image/svg+xml;charset=UTF-8,<svg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 20 20'><path fill='gray' d='M5.5 7l4.5 4.5L14.5 7'/></svg>");
                background-repeat: no-repeat;
                background-position: right 12px center;
                background-size: 14px;
                padding-right: 35px;
            }

            input[type="submit"] {
                width: 100%;
                background-color: #007bff;
                border: none;
                color: white;
                padding: 12px;
                border-radius: 10px;
                cursor: pointer;
                font-size: 16px;
                font-weight: 600;
                margin-top: 5px;
                transition: background-color 0.3s ease;
            }

            input[type="submit"]:hover {
                background-color: #0056b3;
            }

            .forgot-link {
                display: block;
                text-align: right;
                font-size: 14px;
                margin-top: 5px;
                text-decoration: none;
                color: #007bff;
            }

            .forgot-link:hover {
                text-decoration: underline;
            }

            .signup-link {
                text-align: center;
                margin-top: 18px;
                font-size: 14px;
            }

            .signup-link a {
                color: #007bff;
                text-decoration: none;
                font-weight: 500;
            }

            .signup-link a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <h2><i class="fa-solid fa-right-to-bracket"></i> Login</h2>
            <form action="Login" method="post">

                <!-- Account Type -->
                <div class="form-group">
                    <label for="accountType">Account Type</label>
                    <i class="fa-solid fa-users"></i>
                    <select id="accountType" name="accountType" required>
                        <option value="">-- Select Account Type --</option>
                        <option value="option1">Admin, Manager, Staff</option>
                        <option value="option2">User</option>
                    </select>
                </div>

                <!-- Username -->
                <div class="form-group">
                    <label for="tk">Username</label>
                    <i class="fa-solid fa-user"></i>
                    <input id="tk" name="tk" type="text" placeholder="Enter username" required>
                </div>

                <!-- Password -->
                <div class="form-group">
                    <label for="pas">Password</label>
                    <i class="fa-solid fa-lock"></i>
                    <input id="pas" name="pas" type="password" placeholder="Enter password" required>
                </div>

                <a href="ForgotPassword" class="forgot-link">Forgot Password?</a>
                <input name="sub" type="submit" value="Log In"/>
            </form>

            <div class="signup-link">
                <p>Don't have an account? <a href="SignUp">Sign Up</a></p>
            </div>
        </div>
    </body>
</html>