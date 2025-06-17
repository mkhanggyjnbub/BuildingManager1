<%-- 
    Document   : editNewsDashboard
    Created on : 15-Jun-2025, 20:49:16
    Author     : dodan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update News</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f6f9;
                margin: 0;
                padding: 0;
            }

            .container {
                max-width: 600px;
                margin: 40px auto;
                background-color: #ffffff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }

            h1 {
                text-align: center;
                color: #333333;
                margin-bottom: 30px;
            }

            label {
                display: block;
                margin-bottom: 6px;
                font-weight: bold;
                color: #444;
            }

            input[type="text"],
            input[type="number"],
            textarea {
                width: 100%;
                padding: 10px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 14px;
            }

            textarea {
                resize: vertical;
            }

            .checkbox-group {
                margin-bottom: 20px;
            }

            button {
                background-color: #28a745;
                color: white;
                padding: 12px 20px;
                font-size: 16px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                width: 100%;
                transition: background-color 0.3s ease;
            }

            button:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Update News</h1>
            <form action="${pageContext.request.contextPath}/EditNewsDashboard" method="post">
                <input type="hidden" name="newsID" value="${news.newsID}" />

                <label>Title:</label>
                <input type="text" name="title" value="${news.title}" required />

                <label>Summary:</label>
                <input type="text" name="summary" value="${news.summary}" required />

                <label>Image URL:</label>
                <input type="text" name="imageURL" value="${news.imageURL}" required />

                <label>Content:</label>
                <textarea name="content" rows="5" required>${news.content}</textarea>

                <label>Publish:</label>
                <div class="checkbox-group">
                    <input type="checkbox" name="isPublished" value="true" ${news.isPublished ? 'checked' : ''} /> Yes
                </div>

                <label>User ID:</label>
                <input type="number" name="userId" value="${news.userId}" required />

                <label>Building ID:</label>
                <input type="number" name="buildingID" value="${news.buildingID}" required />

                <label>Viewcount:</label>
                <input type="number" name="viewcount" value="${news.viewcount}" readonly />

                <button type="submit">Update</button>
            </form>
        </div>
    </body>
</html>
