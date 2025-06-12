<%-- 
    Document   : newsAdminR
    Created on : 07-May-2025, 11:02:03
    Author     : dodan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách tin tức</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
                margin: 20px;
                color: #333;
            }

            h1 {
                text-align: center;
                color: #2c3e50;
            }

            a button, .btn {
                padding: 6px 12px;
                border: none;
                color: white;
                cursor: pointer;
                border-radius: 4px;
                transition: background-color 0.2s ease;
            }

            a button {
                background-color: #3498db;
            }

            a button:hover {
                background-color: #2980b9;
            }

            .btn-update {
                background-color: #f1c40f; /* vàng đất nhạt */
                color: #000;
            }

            .btn-update:hover {
                background-color: #d4ac0d;
            }

            .btn-delete {
                background-color: #e74c3c; /* đỏ */
            }

            .btn-delete:hover {
                background-color: #c0392b;
            }

            table {
                width: 100%;
                background-color: white;
                border-collapse: collapse;
                margin-top: 20px;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            }

            thead {
                background-color: #ecf0f1;
            }

            th, td {
                padding: 10px;
                text-align: center;
                border: 1px solid #ddd;
                vertical-align: middle;
            }

            img {
                max-height: 50px;
                border-radius: 4px;
            }

            form {
                margin: 0 2px;
                display: inline;
            }
        </style>

    </head>
    <body>
        <h1>Tin Tức Mới Nhất</h1>

        <a href="NewsAdminC">
            <button type="button">Create</button>
        </a>

        <table border="1" cellspacing="0" cellpadding="8" style="width: 100%; background-color: #fff; border-collapse: collapse;">
            <thead style="background-color: #f2f2f2;">
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Summary</th>
                    <th>Image</th>
                    <th>Date Posted</th>
                    <th>Published</th>
                    <th>User ID</th>
                    <th>Building ID</th>
                    <th>View Count</th>
                    <th>Content</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${newsList}" var="news"> 
                    <tr>
                        <td>${news.newsID}</td>
                        <td>${news.title}</td>
                        <td>${news.summary}</td>
                        <td><img src="${news.imageURL}" alt="Ảnh" style="max-height: 50px;"></td>
                        <td>${news.datePosted}</td>
                        <td><c:if test="${news.isPublished}">Yes</c:if><c:if test="${!news.isPublished}">No</c:if></td>
                        <td>${news.userId}</td>
                        <td>${news.buildingID}</td>
                        <td>${news.viewcount}</td>
                        <td>${news.content}</td>
                        <td>
                            <form action="NewsAdminU" method="get">
                                <input type="hidden" name="id" value="${news.newsID}" />
                                <button type="submit" class="btn btn-update">Update</button>
                            </form>
                            <form action="NewsAdminD" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn xóa?');">
                                <input type="hidden" name="id" value="${news.newsID}" />
                                <button type="submit" class="btn btn-delete">Delete</button>
                            </form>

                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
