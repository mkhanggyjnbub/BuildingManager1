<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Add New Service</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
        <style>
            :root {
                --navy: #4a6fa5;
                --navy-dark: #3a5c88;
                --white: #ffffff;
                --gray: #f0f2f5;
                --blue: #3498db;
                --blue-dark: #2980b9;
                --transition: 0.3s ease;
            }

            body {
                margin: 0;
                font-family: 'Segoe UI', sans-serif;
                background-color: var(--gray);
                display: flex;
            }

            .main-content {
                flex-grow: 1;
                margin-left: 220px;
                padding: 40px 30px;
                display: flex
                    ;
                justify-content: space-around;
                align-items: flex-start;
                min-height: 100vh;
                box-sizing: border-box;
                flex-direction:row-reverse;

                flex-wrap: nowrap;
                align-content: stretch;
            }

            .content-wrapper {
                width: 100%;
                max-width: 800px;
                background-color: var(--white);
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            }

            h2 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 30px;
                font-size: 28px;
            }
            label {
                display: block;
                font-weight: bold;
                margin-bottom: 6px;
                color: #333;
            }

            input[type="text"],
            input[type="number"],
            textarea,
            select {
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

            .btn-submit {
                display: block;
                width: 100%;
                padding: 12px;
                font-size: 16px;
                border: none;
                border-radius: 6px;
                background-color: var(--blue);
                color: white;
                cursor: pointer;
                transition: background-color var(--transition);
            }

            .btn-submit:hover {
                background-color: var(--blue-dark);
            }

            .btn-back {
                background-color: var(--blue);
                color: var(--white);
                padding: 8px 14px;
                border-radius: 6px;
                text-decoration: none;
                display: inline-block;
                margin-bottom: 20px;
            }

            .btn-back:hover {
                background-color: var(--blue-dark);
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
                background-color: var(--navy);
                color: white;
                padding: 8px 12px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 14px;
            }

            .file-label:hover {
                background-color: var(--navy-dark);
            }

            .disabled-input {
                opacity: 0.5;
                pointer-events: none;
            }

            @media screen and (max-width: 768px) {
                .main-content {
                    margin-left: 0;
                    padding: 20px;
                    flex-direction: column;
                    align-items: stretch;
                }

                .content-wrapper {
                    padding: 20px;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="../navbarDashboard/navbarDashboard.jsp" %>
        <%@ include file="../sidebarDashboard/sidebarDashboard.jsp" %>

        <div class="main-content">
            <div class="content-wrapper">
                <a href="javascript:history.back()" class="btn-back"><i class="fa fa-arrow-left"></i> Back</a>
                <h2>Add New Service</h2>
                <form action="AddServiceDashboard" method="post" onsubmit="return validateForm();" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="serviceName">Service Name</label>
                        <input type="text" id="serviceName" name="name" maxlength="100" pattern="^[A-Za-z0-9\s]+$" required>
                    </div>

                    <div class="form-group">
                        <label for="unitType">Unit Type</label>
                        <select id="unitSelect" onchange="toggleUnitInput(this.value)">
                            <option value="1 item">1 item</option>
                            <option value="1 time">1 time</option>
                            <option value="1 turn">1 turn</option>
                            <option value="other">Other...</option>
                        </select>
                        <div id="customUnitWrapper" style="margin-top: 10px; display: none;">
                            <input type="text" id="customUnitInput" placeholder="Type your own..." maxlength="50" pattern="^[\\w\\d\\s]+$" oninput="updateUnitType()">
                        </div>
                        <input type="hidden" id="unitType" name="unitType" required>
                    </div>

                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea id="description" name="description" minlength="10" maxlength="1000" required></textarea>
                    </div>

                    <div class="form-group">
                        <label for="price">Price (VND)</label>
                        <input type="text" id="price" name="price" required inputmode="numeric">
                    </div>

                    <div class="form-group">
                        <label>Image Upload</label>
                        <div>
                            <label><input type="radio" name="imageUploadMethod" value="file" checked onchange="toggleImageUpload()"> 📁 Upload File</label>
                            <label style="margin-left: 20px;"><input type="radio" name="imageUploadMethod" value="url" onchange="toggleImageUpload()"> 🔗 Enter URL</label>
                        </div>
                        <div id="uploadFileGroup" class="custom-file-upload">
                            <label for="imageFile" class="file-label">Choose File</label>
                            <input type="file" name="imageFile" id="imageFile" accept="image/*">
                            <span id="file-name">No file chosen</span>
                        </div>
                        <div id="uploadUrlGroup" class="disabled-input">
                            <input type="text" id="imageURL" name="imageURL" placeholder="https://example.com/your-image.jpg" maxlength="255">
                        </div>
                    </div>

                    <button type="submit" class="btn-submit">➕ Add Service</button>
                </form>
            </div>
        </div>

        <script>
            function toggleUnitInput(value) {
                const customWrapper = document.getElementById("customUnitWrapper");
                const unitHidden = document.getElementById("unitType");
                if (value === "other") {
                    customWrapper.style.display = "block";
                    unitHidden.value = "";
                } else {
                    customWrapper.style.display = "none";
                    unitHidden.value = value;
                }
            }

            function updateUnitType() {
                const customInput = document.getElementById("customUnitInput");
                const unitHidden = document.getElementById("unitType");
                unitHidden.value = customInput.value.trim();
            }

            function toggleImageUpload() {
                const method = document.querySelector('input[name="imageUploadMethod"]:checked').value;
                const fileGroup = document.getElementById("uploadFileGroup");
                const urlGroup = document.getElementById("uploadUrlGroup");
                document.getElementById("imageFile").disabled = method !== "file";
                document.getElementById("imageURL").disabled = method !== "url";
                fileGroup.classList.toggle("disabled-input", method !== "file");
                urlGroup.classList.toggle("disabled-input", method !== "url");
            }

            function validateForm() {
                const priceInput = document.getElementById("price");
                const rawPrice = priceInput.value.replaceAll(".", "");
                const price = parseInt(rawPrice);
                if (isNaN(price) || price < 10000 || price > 10000000) {
                    alert("Price must be between 10,000 and 10,000,000 VND.");
                    return false;
                }
                priceInput.value = rawPrice;
                return true;
            }

            document.getElementById("price").addEventListener("input", function (e) {
                let val = e.target.value.replace(/\D/g, "");
                val = val.replace(/\B(?=(\d{3})+(?!\d))/g, ".");
                e.target.value = val;
            });

            document.addEventListener("DOMContentLoaded", () => {
                toggleUnitInput(document.getElementById("unitSelect").value);
                toggleImageUpload();
            });
        </script>
    </body>
</html>
