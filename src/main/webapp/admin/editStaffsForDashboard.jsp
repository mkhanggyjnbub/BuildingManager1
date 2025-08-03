<%-- 
    Document   : editUsers
    Created on : Aug 3, 2025, 10:22:01 PM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Edit User</title>
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

            .form-group {
                margin-bottom: 12px;
            }

            .label {
                font-weight: 600;
                color: var(--primary);
                display: block;
                margin-bottom: 4px;
            }

            .input {
                width: 100%;
                padding: 8px 10px;
                border-radius: 6px;
                border: 1px solid var(--gray);
                font-size: 15px;
            }

            .form-actions {
                margin-top: 20px;
                display: flex;
                gap: 10px;
            }

            .btn {
                padding: 10px 16px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-weight: 600;
                transition: background-color 0.3s ease;
            }

            .btn-update {
                background-color: var(--primary);
                color: white;
            }

            .btn-update:hover {
                background-color: var(--primary-light);
            }

            .btn-cancel {
                background-color: #ccc;
                color: black;
            }

            .btn-cancel:hover {
                background-color: #aaa;
            }
        </style>
    </head>
    <body>
        <%@include file="../navbarDashboard/navbarDashboard.jsp" %>
        <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>
        <div class="main-content">
            <form action="EditStaffsForDashboard" method="post">
                <input type="text" name="userId" value="${user.userId}">
                <div class="card">
                    <img class="avatar" src="${user.avatarUrl}" alt="Avatar">
                    <div class="info">
                        <h2>Chỉnh sửa thông tin</h2>

                        <div class="form-group">
                            <label class="label">Họ tên</label>
                            <input type="text" name="fullName" class="input" value="${user.fullName}" required>
                        </div>

                        <div class="form-group">
                            <label class="label">Email</label>
                            <input type="email" name="email" class="input" value="${user.email}" required>
                        </div>

                        <div class="form-group">
                            <label class="label">SĐT</label>
                            <input type="text" name="phone" class="input" value="${user.phone}" required>
                        </div>
                        <div class="form-group">
                            <label class="label">IdentityNumber</label>
                            <input type="text" name="identityNumber" class="input" value="${user.identityNumber}" required>
                        </div>


                        <div class="form-actions">
                            <button type="submit" class="btn btn-update">Cập nhật</button>
                            <a href="ViewStaffsForDashboard" class="btn btn-cancel">Quay lại</a>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </body>
</html>
