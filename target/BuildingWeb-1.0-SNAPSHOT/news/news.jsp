<%-- 
    Document   : news
    Created on : 05-May-2025, 12:36:47
    Author     : dodan
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Tin Tức</title>
        <style>
            body {
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background: linear-gradient(135deg, #8869E3, #AF6EDA);
            }

            h1 {
                text-align: center;
                padding: 20px;
                color: #333;
            }

            .news-container {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 20px;
                padding: 20px;
                max-width: 1200px;
                margin: auto;
            }

            .news-card {
                background-color: #fff; /* Nền trắng */
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                padding: 15px;
                display: flex;
                flex-direction: column;
                overflow: hidden;
                transition: transform 0.2s ease, box-shadow 0.2s ease;
            }

            .news-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
            }


            .news-card img {
                max-width: 100%;
                height: auto;
                border-radius: 8px;
                object-fit: cover;
            }

            .news-title {
                font-size: 20px;
                font-weight: bold;
                color: #0077cc;
                margin: 10px 0 5px;
            }

            .news-summary {
                font-size: 14px;
                color: #444;
                margin-bottom: 10px;
            }

            .news-content {
                font-size: 13px;
                color: #666;
                flex-grow: 1;
            }

            .news-meta {
                font-size: 12px;
                color: #999;
                margin-top: 10px;
            }

            @media (max-width: 600px) {
                .news-title {
                    font-size: 18px;
                }
            }
        </style>
    </head>
    <body>
        <h1>Tin Tức Mới Nhất</h1>
        <div class="news-container">
            <c:forEach items="${newsList}" var="news"> 
                <a href="NewsDetails?id=${news.newsID}">
                    <div class="news-card">
                        <img src="${news.imageURL}" alt="Ảnh tin tức">
                        <div class="news-title">${news.title}</div>
                        <div class="news-summary">${news.summary}</div>
                        <div class="news-view">${news.viewcount}</div>
                        <div class="news-meta">
                            Ngày đăng: ${news.datePosted} | Người đăng: ${news.userId} | Toà nhà: ${news.buildingID}
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>
    </body>
</html>
