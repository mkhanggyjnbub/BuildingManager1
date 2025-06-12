<%-- 
    Document   : userInfo
    Created on : 08-May-2025, 14:40:40
    Author     : dodan
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f0f2f5;
                margin: 0;
                padding: 20px;
            }

            .user-info-container {
                max-width: 600px;
                margin: 0 auto;
            }

            h1 {
                text-align: center;
                color: #333;
                margin-bottom: 30px;
            }

            .user-card {
                background-color: #fff;
                border-radius: 12px;
                padding: 24px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                display: flex;
                align-items: center;
                gap: 20px;
            }

            .avatar {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                object-fit: cover;
                border: 3px solid #007BFF;
            }

            .info p {
                margin: 10px 0;
                color: #555;
                font-size: 16px;
            }

            .info strong {
                color: #333;
            }

            .status-indicator {
                display: inline-block;
                width: 10px;
                height: 10px;
                margin-right: 8px;
                border-radius: 50%;
                background-color: #28a745; /* xanh lá cây */
                box-shadow: 0 0 0 0 rgba(40, 167, 69, 0.7);
                animation: pulse 1.5s infinite;
                vertical-align: middle;
            }

            /* Hiệu ứng chớp nháy */
            @keyframes pulse {
                0% {
                    box-shadow: 0 0 0 0 rgba(40, 167, 69, 0.7);
                }
                70% {
                    box-shadow: 0 0 0 10px rgba(40, 167, 69, 0);
                }
                100% {
                    box-shadow: 0 0 0 0 rgba(40, 167, 69, 0);
                }
            }

        </style>
    </head>
    <body>
        <div class="user-info-container">
            <h1>Thông tin người dùng</h1>
            <div class="user-card">
                <img class="avatar" src="${userInfomation.avatarUrl}" alt="Avatar người dùng">
                <div class="info">
                    <p><strong>Họ tên:</strong> ${userInfomation.fullName}</p>
                    <p><strong>Tên đăng nhập:</strong> ${userInfomation.userName}</p>
                    <p><strong>Email:</strong> ${userInfomation.email}</p>
                    <p><strong>Số điện thoại:</strong> ${userInfomation.phone}</p>
                    <p>
                        <strong>Trạng thái: </strong>
                        <span class="status-indicator"></span>
                        ${userInfomation.accountStatus.statusName}
                    </p>
                        <a href="EditCustomerInfomation?id=${customerId}">Update</a>
                </div>
            </div>
        </div>
    </body>
</html>
