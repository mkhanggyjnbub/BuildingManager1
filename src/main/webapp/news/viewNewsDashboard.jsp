<%-- 
    Document   : viewNewsDashboard
    Created on : 15-Jun-2025, 20:44:24
    Author     : dodan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách tin tức</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 30px;
            color: #333;
        }

        h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
            font-size: 32px;
        }

        a button {
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 15px;
            transition: background-color 0.3s ease;
            margin-bottom: 20px;
        }

        a button:hover {
            background-color: #2980b9;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            border-radius: 10px;
            overflow: hidden;
        }

        thead {
            background-color: #e8f0fe;
        }

        th, td {
            padding: 12px 14px;
            text-align: center;
            border-bottom: 1px solid #ddd;
            vertical-align: middle;
        }

        tbody tr:hover {
            background-color: #f6f9fc;
        }

        img {
            max-height: 50px;
            border-radius: 4px;
        }

        .btn {
            padding: 6px 12px;
            font-size: 14px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin: 2px 0;
        }

        .btn-update {
            background-color: #f1c40f;
            color: #000;
        }

        .btn-update:hover {
            background-color: #d4ac0d;
        }

        .btn-delete {
            background-color: #e74c3c;
            color: #fff;
        }

        .btn-delete:hover {
            background-color: #c0392b;
        }

        form {
            display: inline;
        }

        @media (max-width: 768px) {
            th, td {
                font-size: 13px;
                padding: 8px;
            }

            a button {
                font-size: 14px;
                padding: 8px 16px;
            }
        }
    </style>
</head>
<body>
    <h1>Tin Tức Mới Nhất</h1>

    <a href="AddNewsDashboard">
        <button type="button">➕ Thêm Tin Mới</button>
    </a>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Tiêu đề</th>
                <th>Tóm tắt</th>
                <th>Ảnh</th>
                <th>Ngày đăng</th>
                <th>Trạng thái</th>
                <th>Người đăng</th>
                <th>Toà nhà</th>
                <th>Lượt xem</th>
                <th>Nội dung</th>
                <th>Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${newsList}" var="news"> 
                <tr>
                    <td>${news.newsID}</td>
                    <td>${news.title}</td>
                    <td>${news.summary}</td>
                    <td><img src="${news.imageURL}" alt="Ảnh tin tức"></td>
                    <td>${news.datePosted}</td>
                    <td>
                        <c:choose>
                            <c:when test="${news.isPublished}"><span style="color: green;">✔ Đã đăng</span></c:when>
                            <c:otherwise><span style="color: red;">✘ Chưa đăng</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td>${news.userId}</td>
                    <td>${news.buildingID}</td>
                    <td>${news.viewcount}</td>
                    <td>${news.content}</td>
                    <td>
                        <form action="EditNewsDashboard" method="get">
                            <input type="hidden" name="id" value="${news.newsID}" />
                            <button type="submit" class="btn btn-update">✏️ Sửa</button>
                        </form>
                        <form action="DeleteNewsDashboard" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn xóa tin này không?');">
                            <input type="hidden" name="id" value="${news.newsID}" />
                            <button type="submit" class="btn btn-delete">🗑️ Xoá</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
