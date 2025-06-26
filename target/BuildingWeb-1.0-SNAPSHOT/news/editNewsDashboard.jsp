<%-- 
    Document   : editNewsDashboard
    Created on : 15-Jun-2025, 20:49:16
    Author     : dodan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
  <title>Update News</title>

  <!-- Icon libraries -->
  <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

  <%@include file="../navbarDashboard/navbarDashboard.jsp" %>
  <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>

        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f6f9;
                margin: 0;
                padding: 80px 30px 40px;
            }
            .container {
                max-width: 700px;
                margin: 0 auto;
                background-color: #ffffff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                position: relative;
            }
            .back-button {
                position: absolute;
                top: -40px;
                left: 20px;
                background-color: #1a73e8;
                color: white;
                padding: 8px 12px;
                border-radius: 5px;
                font-size: 14px;
                text-decoration: none;
                display: inline-block;
            }
            .back-button:hover {
                background-color: #0c53b0;
            }
            h1 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 30px;
            }
            label {
                display: block;
                margin-bottom: 6px;
                font-weight: bold;
                color: #444;
            }
            input[type="text"],
            textarea,
            select {
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
            .file-upload-section label[for="imageFile"]::before {
                content: "\1F4C2 ";
            }
            .file-upload-section label[for="imageURL"]::before {
                content: "\1F517 ";
            }
            .disabled-input {
                opacity: 0.5;
                pointer-events: none;
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
            .tooltip {
                position: absolute;
                background-color: #333;
                color: #fff;
                padding: 6px 10px;
                border-radius: 5px;
                font-size: 13px;
                display: none;
                white-space: nowrap;
                z-index: 10;
                pointer-events: none;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <a href="javascript:history.back()" class="back-button"><i class='bx bx-arrow-back'></i> Back</a>
            <h1><i class='bx bx-edit'></i> Update News</h1>
            <form action="${pageContext.request.contextPath}/EditNewsDashboard" method="post" onsubmit="return validateForm();" enctype="multipart/form-data">
                <input type="hidden" name="newsID" value="${news.newsID}" />

                <label>Title:</label>
                <input type="text" name="title" value="${news.title}" maxlength="150" required data-tooltip="Required. Max 150 characters." />

                <label>Summary:</label>
                <input type="text" name="summary" value="${news.summary}" maxlength="500" required data-tooltip="Required. Max 500 characters." />

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
                    <input type="text" name="imageURL" id="imageURL" value="${news.imageURL}" maxlength="255" data-tooltip="Valid http/https link. Max 255 characters." pattern="https?://.+" disabled />
                </div>

                <label>Content:</label>
                <textarea name="content" rows="5" required data-tooltip="Minimum 20 characters.">${news.content}</textarea>

                <label>Publish:</label>
                <div class="checkbox-group">
                    <input type="checkbox" name="isPublished" value="true" ${news.isPublished ? 'checked' : ''} /> Yes
                </div>

                <input type="hidden" name="userId" value="${news.userId}" />

                <label>Building:</label>
                <select name="buildingID" required data-tooltip="Select the building this news belongs to.">
                    <option value="">-- Select Building --</option>
                    <c:forEach var="b" items="${listBuilding}">
                        <option value="${b.buildingId}" ${b.buildingId == news.buildingID ? "selected" : ""}>${b.buildingName}</option>
                    </c:forEach>
                </select>

                <input type="hidden" name="viewcount" value="${news.viewcount}" readonly />

                <button type="submit"><i class='bx bx-check'></i> Update</button>
            </form>
        </div>

        <script>
            function validateForm() {
                const title = document.getElementsByName("title")[0].value.trim();
                const summary = document.getElementsByName("summary")[0].value.trim();
                const imageURL = document.getElementsByName("imageURL")[0].value.trim();
                const content = document.getElementsByName("content")[0].value.trim();
                const buildingID = document.getElementsByName("buildingID")[0].value;
                const method = document.querySelector('input[name="imageUploadMethod"]:checked').value;

                if (title === "" || title.length > 150) {
                    alert("Title must not be empty and must be at most 150 characters.");
                    return false;
                }

                if (summary === "" || summary.length > 500) {
                    alert("Summary must not be empty and must be at most 500 characters.");
                    return false;
                }

                if (method === "url") {
                    if (imageURL === "" || imageURL.length > 255 || !/^https?:\/\/.+/.test(imageURL)) {
                        alert("Image URL must be a valid http or https link, and no more than 255 characters.");
                        return false;
                    }
                }

                if (content.length < 20) {
                    alert("Content must be at least 20 characters long.");
                    return false;
                }

                if (buildingID === "") {
                    alert("Please select a building.");
                    return false;
                }

                return true;
            }

            const tooltip = document.createElement('div');
            tooltip.className = 'tooltip';
            document.body.appendChild(tooltip);

            document.querySelectorAll('[data-tooltip]').forEach(el => {
                el.addEventListener('mouseenter', () => {
                    tooltip.textContent = el.getAttribute('data-tooltip');
                    tooltip.style.display = 'block';
                });
                el.addEventListener('mousemove', (e) => {
                    tooltip.style.left = e.pageX + 15 + 'px';
                    tooltip.style.top = e.pageY + 10 + 'px';
                });
                el.addEventListener('mouseleave', () => {
                    tooltip.style.display = 'none';
                });
            });

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

            window.addEventListener("DOMContentLoaded", () => {
                toggleImageUpload();
            });
        </script>
    </body>
</html>