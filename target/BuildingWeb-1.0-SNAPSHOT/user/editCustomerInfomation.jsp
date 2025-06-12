<%-- 
    Document   : updateUserInfomation
    Created on : 16-May-2025, 23:40:49
    Author     : dodan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cập nhật thông tin người dùng</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            .form-container {
                background-color: #fff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                width: 400px;
            }

            h2 {
                text-align: center;
                margin-bottom: 20px;
                color: #333;
            }

            label {
                display: block;
                margin-bottom: 6px;
                font-weight: bold;
                color: #555;
            }

            input[type="text"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }

            input[type="submit"] {
                width: 100%;
                padding: 10px;
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 5px;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            input[type="submit"]:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>
        <br>
        <div class="form-container">
            <h2>Cập nhật thông tin</h2>
            <form action="EditCustomerInfomation" method="post">
                <input type="hidden" name="id" value="${customerId}" />

                <label>Họ và tên:</label>
                <input type="text" name="fullName" value="${userInfomation.fullName}" />

                <label>Số điện thoại:</label>
                <input type="text" name="phone" value="${userInfomation.phone}" />

                <button type="submit">Lưu cập nhật</button>
            </form>
        </div>
    </body>
</html>

