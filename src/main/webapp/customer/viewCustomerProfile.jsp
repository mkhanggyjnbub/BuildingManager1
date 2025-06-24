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
            <h1>User Information</h1>
            <div class="user-card">
                <img class="avatar" src="${userProfile.avatarUrl}" alt="Avatar người dùng">
                <div class="info">
                    <p><strong>Full Name:</strong> ${userProfile.fullName}</p>
                    <p><strong>UserName:</strong> ${userProfile.userName}</p>
                    <p><strong>Email:</strong> ${userProfile.email}</p>
                    <p><strong>Phone:</strong> ${userProfile.phone}</p>
                    <p><strong>Address:</strong> 
                        <c:choose>
                            <c:when test="${not empty userProfile.address}">
                                ${userProfile.address}
                            </c:when>
                            <c:otherwise>Not updated yet</c:otherwise>
                        </c:choose>
                    </p>
                    <p><strong>Gender:</strong> 
                        <c:choose>
                            <c:when test="${userProfile.gender == 'Male'}">Male</c:when>
                            <c:when test="${userProfile.gender == 'Female'}">Female</c:when>
                            <c:otherwise>Unknown</c:otherwise>
                        </c:choose>
                    </p>
                    <p><strong>Date of Birth:</strong> 
                        <c:choose>
                            <c:when test="${not empty userProfile.dateOfBirth}">
                                ${userProfile.dateOfBirth}
                            </c:when>
                            <c:otherwise>Not updated yet</c:otherwise>
                        </c:choose>
                    </p>
                    <p>
                        <strong>Status: </strong>
                        <span class="status-indicator ${userProfile.statusId == 1 ? 'active' : 'inactive'}"></span>
                        <c:choose>
                            <c:when test="${userProfile.statusId == 1}">
                                Active
                            </c:when>
                            <c:otherwise>
                                Inactive
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <p><strong>Last Login:</strong> 
                        <c:choose>
                            <c:when test="${not empty userProfile.lastLogin}">
                                ${fn:replace(userProfile.lastLogin, 'T', ' ')}
                            </c:when>
                            <c:otherwise>No data available</c:otherwise>
                        </c:choose>
                    </p>
                    <a href="EditCustomerProfile?id=${customerId}">Update</a>
                </div>
            </div>
        </div>
    </body>
</html>
