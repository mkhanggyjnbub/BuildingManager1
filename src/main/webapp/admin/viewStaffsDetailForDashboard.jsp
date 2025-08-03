<%-- 
    Document   : adminView
    Created on : May 4, 2025, 11:44:22 AM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Detail</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root {
            --primary: #002b5c;
            --primary-light: #004080;
            --background: #f4f6f9;
            --white: #ffffff;
            --gray: #e0e0e0;
            --text: #333;
            --shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
        }

        body {
            margin: 0;
            padding: 0;
            background-color: var(--background);
            font-family: 'Segoe UI', sans-serif;
            color: var(--text);
        }

        .main-content {
            margin-left: 60px;
            padding: 80px 30px 40px;
        }

        .card {
            max-width: 800px;
            margin: 0 auto;
            background-color: var(--white);
            border-radius: 20px;
            box-shadow: var(--shadow);
            padding: 30px;
            display: flex;
            gap: 30px;
            align-items: center;
            animation: fadeInCard 0.5s ease-in-out;
        }

        @keyframes fadeInCard {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .info {
            flex: 1;
        }

        .info h2 {
            margin: 0 0 10px;
            font-size: 24px;
            color: var(--primary);
        }

        .info-item {
            margin-bottom: 10px;
        }

        .label {
            font-weight: 600;
            color: var(--primary);
        }

        .value {
            font-weight: 500;
            margin-left: 5px;
        }

        .close-link {
            display: inline-block;
            margin-top: 20px;
            padding: 8px 16px;
            background-color: var(--primary);
            color: white;
            border-radius: 8px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .close-link:hover {
            background-color: var(--primary-light);
        }
        .status-dot {
    display: inline-block;
    width: 14px;
    height: 14px;
    border-radius: 50%;
    margin-left: 10px;
    box-shadow: 0 0 4px rgba(0,0,0,0.2);
}

.status-dot.active {
    background-color: green;
}

.status-dot.inactive {
    background-color: red;
}

    </style>
</head>
<body>
<%@include file="../navbarDashboard/navbarDashboard.jsp" %>
<%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>
<div class="main-content">
    <div class="card">
        <img class="avatar" src="${user.avatarUrl}" alt="Avatar">
        <div class="info">
            <h2>${user.userName}</h2>
            <div class="info-item"><span class="label">Họ tên:</span><span class="value">${user.fullName}</span></div>
            <div class="info-item"><span class="label">Email:</span><span class="value">${user.email}</span></div>
            <div class="info-item"><span class="label">SĐT:</span><span class="value">${user.phone}</span></div>
            <div class="info-item"><span class="label">Vai trò:</span><span class="value">${user.role.roleName}</span></div>
        <div class="info-item">
    <span class="label">Trạng thái:</span>
    <span class="status-dot ${user.status == 1 ? 'active' : 'inactive'}"></span>
</div>

            <div class="info-item"><span class="label">Ngày tạo:</span><span class="value">${user.creationDate}</span></div>
            <a href="ViewStaffsForDashboard" class="close-link">Đóng</a>
        </div>
    </div>
</div>
</body>
</html>