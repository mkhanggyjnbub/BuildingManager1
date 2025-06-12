<%-- 
    Document   : errolPage
    Created on : 06-May-2025, 00:42:29
    Author     : dodan
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Lỗi</title>
    <style> 
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            padding: 20px;
        }
        .error-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .error-message {
            font-size: 18px;
            font-weight: bold;
            color: #d9534f; /* Màu đỏ cho thông báo lỗi */
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h2 class="error-message">${errorMessage}</h2>
        <p>Vui lòng quay lại trang trước hoặc thử lại sau.</p>
    </div>
</body>
</html>
