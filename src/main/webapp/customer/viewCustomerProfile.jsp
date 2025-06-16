<%-- 
    Document   : viewCustomerProfile
    Created on : 13-Jun-2025, 02:12:18
    Author     : dodan
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                <img class="avatar" src="${userProfile.avatarUrl}" alt="Avatar người dùng">
                <div class="info">
                    <p><strong>Họ tên:</strong> ${userProfile.fullName}</p>
                    <p><strong>Tên đăng nhập:</strong> ${userProfile.userName}</p>
                    <p><strong>Email:</strong> ${userProfile.email}</p>
                    <p><strong>Số điện thoại:</strong> ${userProfile.phone}</p>
                    <p><strong>Địa chỉ:</strong> 
                        <c:choose>
                            <c:when test="${not empty userProfile.address}">
                                ${userProfile.address}
                            </c:when>
                            <c:otherwise>Chưa cập nhật</c:otherwise>
                        </c:choose>
                    </p>
                    <p><strong>Giới tính:</strong> 
                        <c:choose>
                            <c:when test="${userProfile.gender == 'Nam'}">Nam</c:when>
                            <c:when test="${userProfile.gender == 'Nữ'}">Nữ</c:when>
                            <c:otherwise>Không xác định</c:otherwise>
                        </c:choose>
                    </p>
                    <p><strong>Ngày sinh:</strong> 
                        <c:choose>
                            <c:when test="${not empty userProfile.dateOfBirth}">
                                ${userProfile.dateOfBirth}
                            </c:when>
                            <c:otherwise>Chưa cập nhật</c:otherwise>
                        </c:choose>
                    </p>
                    <p>
                        <strong>Trạng thái: </strong>
                        <span class="status-indicator ${userProfile.statusId == 1 ? 'active' : 'inactive'}"></span>
                        <c:choose>
                            <c:when test="${userProfile.statusId == 1}">
                                Hoạt động
                            </c:when>
                            <c:otherwise>
                                Bị khóa
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <p><strong>Lần đăng nhập cuối:</strong> 
                        <c:choose>
                            <c:when test="${not empty userProfile.lastLogin}">
                                ${fn:replace(userProfile.lastLogin, 'T', ' ')}
                            </c:when>
                            <c:otherwise>Chưa có dữ liệu</c:otherwise>
                        </c:choose>
                    </p>
                    <a href="EditCustomerProfile?id=${customerId}">Update</a>
                </div>
            </div>
        </div>
    </body>
</html>
