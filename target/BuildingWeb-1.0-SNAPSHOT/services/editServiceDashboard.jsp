<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Service Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            display: flex;
        }

        .main-content {
            flex-grow: 1;
            margin-left: 220px;
            padding: 40px 30px;
            box-sizing: border-box;
        }

        .container {
            max-width: 900px;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333333;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 6px;
            color: #444;
        }

        input[type="text"],
        input[type="number"],
        input[type="file"],
        textarea {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
            min-height: 80px;
        }

        .checkbox-group label {
            font-weight: normal;
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

        .image-upload-toggle {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 14px;
            font-weight: 600;
            color: #333;
        }

        .image-upload-toggle label {
            display: flex;
            align-items: center;
            gap: 6px;
            cursor: pointer;
        }

        .disabled-input {
            opacity: 0.5;
            pointer-events: none;
        }

        .custom-file-upload {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
        }

        .custom-file-upload input[type="file"] {
            display: none;
        }

        .file-label {
            background-color: #007bff;
            color: white;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s;
        }

        .file-label:hover {
            background-color: #0056b3;
        }

        #file-name {
            font-size: 14px;
            color: #444;
        }

        button {
            background-color: #007bff;
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
            background-color: #0056b3;
        }

        .back-button {
            background-color: #1a73e8;
            color: white;
            padding: 8px 12px;
            border-radius: 5px;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 20px;
        }

        .back-button:hover {
            background-color: #0c53b0;
        }
    </style>
</head>
<body>

    <%@ include file="../navbarDashboard/navbarDashboard.jsp" %>
    <%@ include file="../sidebarDashboard/sidebarDashboard.jsp" %>

    <div class="main-content">
        <div class="container">
            <a href="javascript:history.back()" class="back-button">← Back</a>
            <h1>Update Service</h1>
            <form action="${pageContext.request.contextPath}/EditServiceDashboard" method="post" onsubmit="return validateForm();" enctype="multipart/form-data">
                <input type="hidden" name="serviceId" value="${s.serviceId}" />

                <div class="form-group">
                    <label>Service Name:</label>
                    <input type="text" name="name" value="${s.serviceName}" maxlength="100" required 
                           pattern="^[A-Za-z0-9\s]+$"
                           data-tooltip="Must not contain special characters. Max 100 characters." />
                    <div class="tooltip"></div>
                </div>

                <div class="form-group">
                    <label>Unit Type:</label>
                    <input type="text" name="unitType" value="${s.unitType}" maxlength="50" required 
                           pattern="^[\\w\\d\\s]+$"
                           data-tooltip="Letters, digits, and spaces only. Max 50 characters." />
                    <div class="tooltip"></div>
                </div>

                <div class="form-group">
                    <label>Description:</label>
                    <textarea name="description" rows="4" minlength="10" maxlength="1000" required
                              data-tooltip="Must be between 10 and 1000 characters.">${s.description}</textarea>
                    <div class="tooltip"></div>
                </div>

                <div class="form-group">
                    <label>Price (VND):</label>
                    <input type="text" name="price" id="price" required
                           inputmode="numeric"
                           value="${s.price}"
                           data-tooltip="Only numbers. Between 1,000 and 1,000,000,000. Must be divisible by 1,000." />
                    <div class="tooltip"></div>
                </div>

                <div class="form-group">
                    <label>Choose Image Upload Method:</label>
                    <div class="image-upload-toggle">
                        <label><input type="radio" name="imageUploadMethod" value="file" checked onchange="toggleImageUpload()"> 📁 Upload File</label>
                        <label><input type="radio" name="imageUploadMethod" value="url" onchange="toggleImageUpload()"> 🔗 Enter URL</label>
                    </div>

                    <div id="uploadFileGroup" class="custom-file-upload">
                        <label for="imageFile" class="file-label">📂 Choose File</label>
                        <input type="file" name="imageFile" id="imageFile" accept="image/*">
                        <span id="file-name">No file chosen</span>
                    </div>

                    <div id="uploadUrlGroup" class="disabled-input">
                        <input type="text" id="imageURL" name="imageURL" value="${s.imageURL}" placeholder="https://example.com/your-image.jpg" maxlength="255"
                               pattern="https?://.+" data-tooltip="Must be a valid image URL." disabled />
                    </div>
                </div>

                <div class="form-group">
                    <label>Status:</label>
                    <div class="checkbox-group">
                        <label><input type="radio" name="isActive" value="true" ${s.isActive ? 'checked' : ''} /> Active</label><br>
                        <label><input type="radio" name="isActive" value="false" ${!s.isActive ? 'checked' : ''} /> Deactivated</label>
                    </div>
                </div>

                <button type="submit">Update Service</button>
            </form>
        </div>
    </div>

    <script>
        function validateForm() {
            const name = document.getElementsByName("name")[0].value.trim();
            const unitType = document.getElementsByName("unitType")[0].value.trim();
            const desc = document.getElementsByName("description")[0].value.trim();
            const priceStr = document.getElementById("price").value.replaceAll(".", "");
            const imageURL = document.getElementById("imageURL").value.trim();

            const price = parseInt(priceStr);
            if (isNaN(price) || price < 1000 || price > 1000000000 || price % 1000 !== 0) {
                alert("Price must be between 1,000 and 1,000,000,000 divisible by 1,000.");
                return false;
            }
            document.getElementById("price").value = priceStr;

            const method = document.querySelector('input[name="imageUploadMethod"]:checked').value;
            if (method === "url" && !/^https?:\/\/.+/.test(imageURL)) {
                alert("Image URL must be valid.");
                return false;
            }

            return true;
        }

        document.getElementById("price").addEventListener("input", function (e) {
            let val = e.target.value.replace(/\D/g, "");
            val = val.replace(/\B(?=(\d{3})+(?!\d))/g, ".");
            e.target.value = val;
        });

        document.getElementById("imageFile").addEventListener("change", function () {
            const fileName = this.files[0] ? this.files[0].name : "No file chosen";
            document.getElementById("file-name").textContent = fileName;
        });

        function toggleImageUpload() {
            const method = document.querySelector('input[name="imageUploadMethod"]:checked').value;
            document.getElementById("uploadFileGroup").classList.toggle("disabled-input", method !== "file");
            document.getElementById("uploadUrlGroup").classList.toggle("disabled-input", method !== "url");
            document.getElementById("imageFile").disabled = method !== "file";
            document.getElementById("imageURL").disabled = method !== "url";
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

        window.addEventListener("DOMContentLoaded", toggleImageUpload);
    </script>
</body>
</html>
