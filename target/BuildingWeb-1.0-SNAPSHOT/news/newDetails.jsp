<%-- 
    Document   : newDetails
    Created on : 05-May-2025, 22:38:56
    Author     : dodan
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chi Tiết Tin Tức</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f4f4f4;
                padding: 20px;
            }
            .news-container {
                background: white;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .news-title {
                font-size: 24px;
                font-weight: bold;
            }
            .news-content {
                margin-top: 20px;
                font-size: 16px;
                line-height: 1.6;
            }
            .news-meta {
                margin-top: 20px;
                font-size: 14px;
                color: #555;
            }
        </style>
    </head>
    <body>
        <div class="news-detail">
            <h1>${news.title}</h1>
            <p><strong>Ngày đăng:</strong> ${news.datePosted}</p>
            <p><strong>Người đăng:</strong> ${news.userId}</p>
            <p><strong>Lượt xem:</strong> ${news.viewcount}</p>
            <img src="${news.imageURL}" alt="Ảnh tin tức">
            <p><strong>Tóm tắt:</strong> ${news.summary}</p>
            <div><strong>Nội dung:</strong></div>
            <div>${news.content}</div>
        </div>
    </body>
</html>
