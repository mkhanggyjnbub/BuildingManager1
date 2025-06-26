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
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <%@include file="../navbarDashboard/navbarDashboard.jsp" %>
    <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 100px 30px 40px;
        }

        .container {
            max-width: 700px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 40px 30px;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
            border-top: 6px solid #1a237e;
            position: relative;
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
        textarea,
        select {
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
        textarea:focus,
        select:focus {
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

        .file-upload-section {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-bottom: 20px;
        }

        .file-label {
            background-color: #1a237e;
            color: white;
            padding: 10px 14px;
            border-radius: 5px;
            cursor: pointer;
            display: inline-block;
        }

        .disabled-input {
            opacity: 0.5;
            pointer-events: none;
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
    </style>
</head>
<body>
<div class="container">
    <a href="javascript:history.back()" class="back-button"><i class="fa fa-arrow-left"></i> Back</a>
    <h1><i class="fa fa-newspaper"></i> Create New News</h1>

    <c:if test="${not empty message}">
        <script>
            alert("${message}");
            window.location.href = "<c:url value='/Index' />";
        </script>
    </c:if>

    <c:if test="${not empty listBuilding}">
        <form action="AddNewsDashboard" method="post" onsubmit="return validateNewsForm();" enctype="multipart/form-data">
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" maxlength="150" required />

            <label for="summary">Summary:</label>
            <input type="text" id="summary" name="summary" maxlength="500" required />

            <label>Choose Image Upload Method:</label>
            <div class="file-upload-section">
                <label><input type="radio" name="imageUploadMethod" value="file" checked onchange="toggleImageUpload()"> 📁 Upload File</label>
                <label><input type="radio" name="imageUploadMethod" value="url" onchange="toggleImageUpload()"> 🔗 Enter URL</label>
            </div>

            <div id="uploadFileGroup">
                <label for="imageFile" class="file-label">📂 Choose File</label>
                <input type="file" name="imageFile" id="imageFile" accept="image/*">
            </div>

            <div id="uploadUrlGroup" class="disabled-input">
                <label for="imageURL" class="file-label">🔗 Image URL</label>
                <input type="text" id="imageURL" name="imageURL" maxlength="255" pattern="https?://.+" disabled />
            </div>

            <label for="content">Content:</label>
            <textarea id="content" name="content" rows="5" required></textarea>

            <label>Publish Now:</label>
            <div class="radio-group">
                <label><input type="radio" name="isPublished" value="true" checked /> Yes</label>
                <label><input type="radio" name="isPublished" value="false" /> No</label>
            </div>

            <label for="buildingID">Building:</label>
            <select id="buildingID" name="buildingID" required>
                <option value="">-- Select Building --</option>
                <c:forEach var="b" items="${listBuilding}">
                    <option value="${b.buildingId}">${b.buildingName}</option>
                </c:forEach>
            </select>

            <button type="submit"><i class="fa fa-check-circle"></i> Create News</button>
        </form>
    </c:if>
</div>

<script>
    function validateNewsForm() {
        const title = document.getElementById("title").value.trim();
        const summary = document.getElementById("summary").value.trim();
        const imageURL = document.getElementById("imageURL").value.trim();
        const content = document.getElementById("content").value.trim();
        const buildingID = document.getElementById("buildingID").value;

        if (title === "" || title.length > 150) {
            alert("Title must not be empty and must not exceed 150 characters.");
            return false;
        }
        if (summary === "" || summary.length > 500) {
            alert("Summary must not be empty and must not exceed 500 characters.");
            return false;
        }
        const method = document.querySelector('input[name="imageUploadMethod"]:checked').value;
        if (method === "url") {
            if (imageURL === "" || imageURL.length > 255 || !/^https?:\/\/.+/.test(imageURL)) {
                alert("Image URL must be a valid http or https link, and no more than 255 characters.");
                return false;
            }
        }
        if (content.length < 20) {
            alert("Content must contain at least 20 characters.");
            return false;
        }
        if (buildingID === "") {
            alert("Please select a building.");
            return false;
        }
        return true;
    }

    function toggleImageUpload() {
        const method = document.querySelector('input[name="imageUploadMethod"]:checked').value;
        const fileGroup = document.getElementById("uploadFileGroup");
        const urlGroup = document.getElementById("uploadUrlGroup");

        if (method === "file") {
            fileGroup.classList.remove("disabled-input");
            urlGroup.classList.add("disabled-input");
            document.getElementById("imageFile").disabled = false;
            document.getElementById("imageURL").disabled = true;
        } else {
            fileGroup.classList.add("disabled-input");
            urlGroup.classList.remove("disabled-input");
            document.getElementById("imageFile").disabled = true;
            document.getElementById("imageURL").disabled = false;
        }
    }

    window.addEventListener("DOMContentLoaded", toggleImageUpload);
</script>
</body>
</html>
