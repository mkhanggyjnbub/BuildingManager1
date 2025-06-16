<%-- 
    Document   : viewNewsDetail
    Created on : 15-Jun-2025, 21:13:20
    Author     : dodan
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Tin Tức</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #f9f9f9, #e0ecf9);
            color: #333;
        }

        .container {
            max-width: 900px;
            margin: 50px auto;
            background-color: #ffffff;
            padding: 30px 40px;
            border-radius: 16px;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.3s ease;
        }

        .container:hover {
            box-shadow: 0 16px 36px rgba(0, 0, 0, 0.15);
        }

        .news-title {
            font-size: 32px;
            color: #2d3e50;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .news-meta {
            font-size: 14px;
            color: #777;
            margin-bottom: 25px;
        }

        .news-meta span {
            display: inline-block;
            margin-right: 20px;
            color: #555;
        }

        .news-image {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 12px;
            margin: 20px 0;
            transition: transform 0.3s ease;
        }

        .news-image:hover {
            transform: scale(1.02);
        }

        .news-summary {
            font-size: 18px;
            font-style: italic;
            color: #5a5a5a;
            background-color: #f0f5ff;
            padding: 15px 20px;
            border-left: 6px solid #3a7bd5;
            border-radius: 6px;
            margin: 20px 0;
        }

        .news-content {
            font-size: 17px;
            line-height: 1.8;
            color: #333;
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            .news-title {
                font-size: 24px;
            }

            .news-content {
                font-size: 16px;
            }

            .news-image {
                height: auto;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="news-title">${news.title}</div>

        <div class="news-meta">
            <span>🕒 Ngày đăng: <strong>${news.datePosted}</strong></span>
            <span>👤 Người đăng: <strong>${news.userId}</strong></span>
            <span>👁️ Lượt xem: <strong>${news.viewcount}</strong></span>
        </div>

        <img class="news-image" src="${news.imageURL}" alt="Ảnh tin tức">

        <div class="news-summary"><strong>Tóm tắt:</strong> ${news.summary}</div>

        <div class="news-content">
            <strong>Nội dung:</strong><br><br>
            ${news.content}
        </div>
    </div>
</body>
</html>
