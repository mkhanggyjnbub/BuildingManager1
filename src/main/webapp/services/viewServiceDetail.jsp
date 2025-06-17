<%-- 
    Document   : viewServiceDetail
    Created on : 18-Jun-2025, 04:48:37
    Author     : dodan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Service Detail</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 900px;
            margin: 40px auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
            display: flex;
            gap: 30px;
        }

        .image-box {
            flex: 1;
        }

        .image-box img {
            width: 100%;
            border-radius: 10px;
            object-fit: cover;
            max-height: 400px;
        }

        .info-box {
            flex: 2;
            display: flex;
            flex-direction: column;
        }

        .info-box h2 {
            font-size: 28px;
            color: #006064;
            margin-bottom: 10px;
        }

        .info-box .type {
            font-size: 16px;
            color: #555;
            margin-bottom: 20px;
        }

        .info-box .description {
            font-size: 15px;
            line-height: 1.6;
            color: #444;
            margin-bottom: 20px;
        }

        .info-box .price {
            font-size: 20px;
            font-weight: bold;
            color: #2e7d32;
            margin-bottom: 20px;
        }

        .info-box .status {
            font-size: 15px;
            color: ${s.isActive ? '#2e7d32' : '#c62828'};
            margin-bottom: 30px;
        }

        .info-box a.order-btn {
            text-align: center;
            display: inline-block;
            padding: 14px 24px;
            background-color: #1976d2;
            color: white;
            text-decoration: none;
            font-size: 16px;
            border-radius: 8px;
            transition: background-color 0.3s ease;
            width: fit-content;
        }

        .info-box a.order-btn:hover {
            background-color: #0d47a1;
        }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="image-box">
            <img src="${s.imageURL}" alt="Ảnh dịch vụ">
        </div>
        <div class="info-box">
            <h2>${s.serviceName}</h2>
            <div class="type">🔧 Service Type: ${s.serviceType}</div>
            <div class="description">${s.description}</div>
            <div class="price">💰 Price: ${s.price} VNĐ</div>
            <a href="#" class="order-btn">Order Service</a>
        </div>
    </div>
</body>
</html>
