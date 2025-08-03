<%-- 
    Document   : viewNews
    Created on : 15-Jun-2025, 20:35:09
    Author     : dodan
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="UTF-8">
    <title>News</title>
   <style>
    /* Thiết lập font và màu nền tổng thể */
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(to right, #f9f9f9, #eef2f3);
        margin: 0;
        padding: 0;
    }

    .view-news-page {
        max-width: 1300px;
        margin: 0 auto;
        padding: 30px 20px;
        animation: fadeIn 0.6s ease-in-out;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    h1 {
        text-align: center;
        color: #2c3e50;
        font-size: 32px;
        font-weight: bold;
        margin-bottom: 35px;
        position: relative;
    }

    h1::after {
        content: "";
        display: block;
        width: 60px;
        height: 4px;
        background: #007bff;
        margin: 10px auto 0;
        border-radius: 2px;
    }

    /* Nút quay lại */
    .back-button {
        display: inline-block;
        padding: 10px 18px;
        background: #007bff;
        color: white;
        text-decoration: none;
        border-radius: 8px;
        margin-bottom: 20px;
        font-size: 15px;
        font-weight: 500;
        transition: all 0.3s ease;
    }

    .back-button:hover {
        background: #0056b3;
        transform: scale(1.05);
    }

    /* Container tin tức */
    .news-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 25px;
    }

    .news-link {
        text-decoration: none;
        color: inherit;
    }

    /* Card tin tức */
    .news-card {
        background: white;
        border-radius: 12px;
        box-shadow: 0 6px 15px rgba(0, 0, 0, 0.08);
        overflow: hidden;
        display: flex;
        flex-direction: column;
        height: 100%;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .news-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
    }

    .news-card img {
        width: 100%;
        height: 200px;
        object-fit: cover;
        transition: transform 0.4s ease;
    }

    .news-card:hover img {
        transform: scale(1.05);
    }

    .news-title {
        font-size: 20px;
        font-weight: bold;
        padding: 12px 18px 5px;
        color: #222;
        line-height: 1.3;
    }

    .news-summary {
        flex-grow: 1;
        padding: 0 18px 12px;
        color: #555;
        font-size: 15px;
        line-height: 1.4;
    }

    .news-view, .news-meta {
        padding: 8px 18px;
        font-size: 14px;
        color: #666;
    }

    .news-view {
        border-top: 1px solid #eee;
    }

    .news-meta {
        border-top: 1px solid #eee;
        background: #f9fafc;
    }

    /* Responsive cho mobile */
    @media (max-width: 600px) {
        h1 {
            font-size: 26px;
        }
        .news-card img {
            height: 160px;
        }
        .news-title {
            font-size: 18px;
        }
    }
</style>

</head>

    <head>
        <meta charset="UTF-8">
        <title>News</title>
        
    </head>
    <body>
        <%@include file="../header/header.jsp"%> 
        <div class="view-news-page">
            <br><br><br>
            <a href="javascript:history.back()" class="back-button">← Back</a>

            <h1>Latest News</h1>

            <c:if test="${not empty message}">
                <script>
                alert("${message}");
                window.location.href = "<c:url value='/Index' />";
                </script>
            </c:if>

            <c:if test="${not empty newsList}">
                <div class="news-container">
                    <c:forEach items="${newsList}" var="news"> 
                        <a href="ViewNewsDetail?id=${news.newsID}" class="news-link">
                            <div class="news-card">
                                <img src="${news.imageURL}" alt="Ảnh tin tức">
                                <div class="news-title">${news.title}</div>
                                <div class="news-summary">${news.summary}</div>
                                <div class="news-view">👁️ ${news.viewcount} Viewcount</div>
                                <div class="news-meta">🗓️ Posted Date: ${news.datePosted}</div>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </c:if>
        </div>
        <%@include file="../footer/footer.jsp" %>
    </body>
</html>