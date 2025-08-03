<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>User Profile</title>

        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="sha512-..." crossorigin="anonymous" referrerpolicy="no-referrer" />

        <style>
            * {
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', sans-serif;
                background: linear-gradient(to right, #f8fbff, #e9f0f5);
                margin: 0;
                padding: 0;
            }

            .container {
                max-width: 1000px;
                margin: 60px auto;
                padding: 20px;
            }

            .profile-card {
                display: flex;
                flex-direction: column;
                background-color: #ffffff;
                border-radius: 20px;
                box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
                overflow: hidden;
                transition: transform 0.3s;
            }

            .profile-card:hover {
                transform: translateY(-4px);
            }

            .profile-header {
                background-color: #1a73e8;
                padding: 40px 30px;
                color: #fff;
                text-align: center;
            }

            .profile-header h1 {
                margin: 0;
                font-size: 28px;
            }

            .profile-content {
                display: flex;
                flex-wrap: wrap;
                padding: 30px;
                gap: 30px;
            }

            .profile-avatar {
                flex: 0 0 160px;
                text-align: center;
            }

            .profile-avatar img {
                width: 140px;
                height: 140px;
                object-fit: cover;
                border-radius: 50%;
                border: 4px solid #1a73e8;
            }

            .profile-info {
                flex: 1;
            }

            .profile-info p {
                font-size: 16px;
                color: #333;
                margin: 12px 0;
            }

            .profile-info strong {
                color: #444;
                width: 140px;
                display: inline-block;
            }

            .status-indicator {
                width: 12px;
                height: 12px;
                background-color: #28a745;
                display: inline-block;
                border-radius: 50%;
                margin-right: 8px;
                animation: pulse 1.5s infinite;
            }

            @keyframes pulse {
                0% {
                    box-shadow: 0 0 0 0 rgba(40, 167, 69, 0.5);
                }
                70% {
                    box-shadow: 0 0 0 10px rgba(40, 167, 69, 0);
                }
                100% {
                    box-shadow: 0 0 0 0 rgba(40, 167, 69, 0);
                }
            }

            .btn {
                display: inline-block;
                padding: 8px 16px;
                border-radius: 6px;
                font-size: 14px;
                font-weight: 500;
                text-decoration: none;
                margin-top: 15px;
                transition: all 0.3s ease;
            }

            .btn-update {
                background-color: #1a73e8;
                color: white;
            }

            .btn-update:hover {
                background-color: #155ec4;
            }

            .btn-change-pass {
                color: #1a73e8;
                font-weight: 500;
                margin-left: 10px;
            }

            .btn-change-pass i {
                margin-left: 4px;
            }

            .back-button {
                position: absolute;
                top: 20px;
                left: 30px;
                background-color: #1a73e8;
                color: white;
                padding: 8px 14px;
                border-radius: 5px;
                text-decoration: none;
                font-size: 14px;
            }

            .back-button:hover {
                background-color: #0c53b0;
            }

            .error-message {
                color: red;
                text-align: center;
                font-size: 18px;
                font-weight: bold;
                margin: 20px 0;
            }

            @media (max-width: 768px) {
                .profile-content {
                    flex-direction: column;
                    align-items: center;
                }

                .profile-info strong {
                    width: 100px;
                }

                .back-button {
                    top: 10px;
                    left: 10px;
                }
            }
        </style>
    </head>
    <body>

        <%@include file="../header/header.jsp" %>

        <a href="javascript:history.back()" class="back-button"><i class="fa fa-arrow-left"></i> Back</a>

        <div class="container">
            <c:if test="${not empty message}">
                <div class="error-message">${message}</div>
            </c:if>

            <c:if test="${not empty userProfile}">
                <div class="profile-card">
                    <div class="profile-header">
                        <h1>Customer Profile</h1>
                    </div>

                    <div class="profile-content">
                        <div class="profile-avatar">
                            <img src="${userProfile.avatarUrl}" alt="Avatar">
                        </div>
                        <div class="profile-info">
                            <p><strong>Full Name:</strong> ${userProfile.fullName}</p>
                            <p><strong>Username:</strong> ${userProfile.userName}</p>
                            <p>
                                <strong>Password:</strong> ********
                                <a href="ChangePasswordForCustomer?id=${customerId}" class="btn-change-pass">
                                    Change <i class="fa-solid fa-pen-to-square"></i>
                                </a>
                            </p>
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
                            <p><strong>Status:</strong>
                                <span class="status-indicator"></span> ${userProfile.status}
                            </p>
                            <p><strong>Last Login:</strong>
                                <c:choose>
                                    <c:when test="${not empty userProfile.lastLogin}">
                                        ${fn:replace(userProfile.lastLogin, 'T', ' ')}
                                    </c:when>
                                    <c:otherwise>No data available</c:otherwise>
                                </c:choose>
                            </p>

                            <a href="EditCustomerProfile?id=${customerId}" class="btn btn-update">Update Profile</a>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>

    </body>
</html>
