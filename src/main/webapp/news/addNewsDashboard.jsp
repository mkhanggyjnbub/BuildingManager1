<%-- 
    Document   : addNewsDashboard
    Created on : 15-Jun-2025, 20:49:04
    Author     : dodan
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create New News</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 650px;
            margin: 50px auto;
            background-color: #ffffff;
            padding: 40px 30px;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
            border-top: 6px solid #1a237e; /* Navy */
        }

        h1 {
            text-align: center;
            color: #1a237e;
            font-size: 28px;
            margin-bottom: 35px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: #333;
        }

        input[type="text"],
        input[type="number"],
        textarea {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
            background-color: #fdfdfd;
            transition: border 0.2s;
        }

        input:focus,
        textarea:focus {
            border-color: #1a237e;
            outline: none;
        }

        textarea {
            resize: vertical;
        }

        .radio-group {
            margin-bottom: 20px;
        }

        .radio-group label {
            font-weight: normal;
            margin-right: 20px;
            color: #444;
        }

        .radio-group input[type="radio"] {
            margin-right: 6px;
        }

        button {
            background-color: #1a237e;
            color: white;
            padding: 14px;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #0d154d;
        }

        @media (max-width: 768px) {
            .container {
                padding: 30px 20px;
            }
            h1 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📝 Create New News</h1>
        <form action="AddNewsDashboard" method="post">
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" required/>

            <label for="summary">Summary:</label>
            <input type="text" id="summary" name="summary" required/>

            <label for="imageURL">Image URL:</label>
            <input type="text" id="imageURL" name="imageURL" required/>

            <label for="content">Content:</label>
            <textarea id="content" name="content" rows="5" required></textarea>

            <label>Publish Now:</label>
            <div class="radio-group">
                <label><input type="radio" name="isPublished" value="true" checked/> Yes</label>
                <label><input type="radio" name="isPublished" value="false"/> No</label>
            </div>

            <label for="userId">User ID:</label>
            <input type="number" id="userId" name="userId" required/>

            <label for="buildingID">Building ID:</label>
            <input type="number" id="buildingID" name="buildingID" required/>

            <button type="submit">✅ Create News</button>
        </form>
    </div>
</body>
</html>
