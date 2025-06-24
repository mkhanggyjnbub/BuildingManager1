<%-- 
    Document   : createRoomForDashboard
    Created on : Jun 20, 2025, 3:00:43 PM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Create New Room</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700&display=swap" rel="stylesheet">
        <style>
            body {
                margin: 0;
                padding: 0;
                font-family: 'Poppins', sans-serif;
                background: linear-gradient(to right, #f5f7fa, #c3cfe2);
                color: #333;
            }

            .form-container {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(6px);
                max-width: 800px;
                margin: 40px auto;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            }

            .form-container h2 {
                text-align: center;
                margin-bottom: 20px;
                color: #007BFF;
            }

            form {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 16px;
            }

            label {
                font-size: 14px;
                font-weight: 500;
                margin-bottom: 5px;
                display: block;
            }

            input[type="text"],
            input[type="number"],
            textarea,
            select {
                padding: 8px;
                font-size: 14px;
                border: 1px solid #ccc;
                border-radius: 6px;
                width: 100%;
                box-sizing: border-box;
            }

            textarea {
                resize: vertical;
                min-height: 60px;
            }

            .full-width {
                grid-column: 1 / -1;
            }

            button[type="submit"] {
                padding: 12px;
                background-color: #007BFF;
                color: white;
                font-weight: bold;
                font-size: 15px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: background 0.3s;
                grid-column: 1 / -1;
            }

            button[type="submit"]:hover {
                background-color: #0056b3;
            }

            .custom-file-upload {
                display: flex;
                align-items: center;
                gap: 10px;
                flex-wrap: wrap;
            }

            .custom-file-upload input[type="file"] {
                display: none;
            }

            .custom-file-upload .file-label {
                background-color: #007BFF;
                color: white;
                padding: 6px 12px;
                font-size: 13px;
                font-weight: 500;
                border-radius: 6px;
                cursor: pointer;
                transition: background 0.3s;
            }

            .custom-file-upload .file-label:hover {
                background-color: #0056b3;
            }

            .custom-file-upload #file-name {
                font-size: 13px;
                color: #555;
                font-style: italic;
            }

            @media screen and (max-width: 600px) {
                form {
                    grid-template-columns: 1fr;
                }
            }
            .bed-checkbox-group {
                display: grid;
                grid-template-columns: repeat(3, 1fr); /* mỗi hàng 3 item */
                gap: 10px 20px; /* khoảng cách hàng và cột */
                margin-top: 5px;
            }

            .bed-checkbox-group label {
                display: flex;
                align-items: center;
                gap: 6px; /* khoảng cách giữa checkbox và chữ */
                font-weight: 400;
                font-size: 14px;
            }
            @media screen and (max-width: 600px) {
                .bed-checkbox-group {
                    grid-template-columns: repeat(2, 1fr);
                }
            }

        </style>
    </head>
    <body>
        <%@include file="../header/header.jsp" %>
        <br>
        <br>
        <div class="form-container">
            <h2>Create New Room</h2>
                <form action="CreateRoomForDashboard" method="post" enctype="multipart/form-data">
                    <div>
                        <label>Room Number:</label>
                        <input type="number" name="roomNumber"  min="0" max="9999" required>
                    </div>

                    <div>
                        <label>Floor Number:</label>
                        <input type="number" name="floorNumber"  min="0" max="100" required>
                    </div>

                    <div>



                        <label>Room Type:</label>
                        <select id="roomType" name="roomType" required>
                            <option value="">-- Select Type --</option>
                            <option  value="Standard">Standard Room</option>
                            <option value="Deluxe">Deluxe Room</option>
                            <option  value="Twin">Twin Room</option>
                            <option  value="Family">Family Room</option>
                        </select>
                    </div>

                    <div>
                        <label>Price (VNĐ):</label>
                        <input id="price" type="text" name="price" required>
                    </div>

                    <div class="full-width">
                        <label>Bed Type:</label>
                        <div class="bed-checkbox-group">
                            <label id="single"><input  type="radio" name="bedType" value="Single|1" > Single Bed</label>
                            <label id="double"><input type="radio" name="bedType" value="Double|2" > Double Bed</label>
                            <label id="queen"><input type="radio" name="bedType" value="Queen|2" > Queen Bed</label>
                            <label id="king"><input type="radio" name="bedType" value="King|2" > King Bed</label>
                            <label id="twin"><input type="radio" name="bedType" value="Twin|2" > Twin Bed</label>
                            <div id="treePeople" style="display: none">
                                <label>Option 3 people</label>
                                <label ><input type="radio" name="bedType" value="1 Double Bed + 1  Single Bed|3" > 1 Double Bed + 1 Single Bed</label>
                                <label ><input type="radio" name="bedType" value="1 Queen Bed + 1 Single Bed|3" > 1 Queen Bed + 1 Single Bed</label>
                                <label ><input type="radio" name="bedType" value="3 Single Beds|3" >3 Single Beds</label>
                            </div>
                            <div id="fourPeople" style="display: none">
                                <label>Option 4 people</label>
                                <label ><input type="radio" name="bedType" value=" 2 Double Beds|4" > 2 Double Beds</label>
                                <label ><input type="radio" name="bedType" value="1 King Bed + 1 Double Bed|4" > 1 King Bed + 1 Double Bed</label>
                                <label ><input type="radio" name="bedType" value="1 Queen Bed + 2 Single Beds|4" > 1 Queen Bed + 2 Single Beds</label>
                                <label ><input type="radio" name="bedType" value="2 Twin Beds + 2 Single Beds|4" > 2 Twin Beds + 2 Single Beds</label>  
                            </div>
                            <div id="fivePeople" style="display: none">
                                <label>Option 5 people</label>
                                <label ><input type="radio" name="bedType" value="2 Double Beds|5" > 2 Double Beds</label>
                                <label ><input type="radio" name="bedType" value="2 Queen Beds + 1 Single Bed|5" > 2 Queen Beds + 1 Single Bed</label>
                                <label ><input type="radio" name="bedType" value="1 King Bed + 2 Single Beds|5" >1 King Bed + 2 Single Beds</label>
                                <label ><input type="radio" name="bedType" value="1 Double Bed + 3 Single Beds|5" >1 Double Bed + 3 Single Beds</label>  
                                <label ><input type="radio" name="bedType" value="5 Single Beds|5" >5 Single Beds</label>  
                            </div>
                        </div>
                    </div>

                    <div class="full-width">
                        <label>Description:</label>
                        <textarea name="description" required></textarea>
                    </div>

                    <div class="full-width">
                        <label>Room Image:</label>
                        <div class="custom-file-upload">
                            <label for="imageFile" class="file-label">📁 Choose Image</label>
                            <input type="file" name="imageFile" id="imageFile" accept="image/*">
                            <span id="file-name">No file chosen</span>
                        </div>
                    </div>
                    <label>Choose URL:</label>
                    <div class="full-width">
                        <input type="text" name="imageUrl" placeholder="https://example.com/your-image.jpg">
                    </div>

                    <div class="full-width" style="display: flex; flex-wrap: wrap; gap: 16px;">
                        <div style="flex: 1 1 45%;">
                            <label>Status:</label>
                            <select name="status" required>
                                <option value="Active">Active</option>
                                <option value="InActive">InActive</option>
                            </select>
                        </div>

                        <div style="flex: 1 1 45%;">
                            <label>Location:</label>
                            <select name="location" required>
                                <option value="1">Can Tho</option>
                            </select>
                        </div>
                    </div>


                    <!--                    <div style="flex: 1;">
                                            <label>Area (m²):</label>
                                            <input id="area" type="number" name="area" placeholder="e.g. 35" min="0" max="100" step="0.1" required>
                                        </div>-->


                    <button type="submit">Create Room</button>
                </form>
        </div>

        <script>
            // Hiển thị tên file khi chọn ảnh
            document.getElementById("imageFile").addEventListener("change", function () {
                const fileName = this.files[0] ? this.files[0].name : "No file chosen";
                document.getElementById("file-name").textContent = fileName;
            });


            document.addEventListener("DOMContentLoaded", function () {
                let price = document.getElementById("price");
                // Không cho nhập chữ kể cả khi đang rỗng
                const MAX_DIGITS = 9;
                price.addEventListener("beforeinput", function (e) {
                    if (e.inputType === "insertText" && /\D/.test(e.data)) {
                        e.preventDefault();
                    }
                });

                // format khi nhập tiền
                price.addEventListener("input", function () {
                    let raw = price.value.replace(/\D/g, "");
                    // Cắt giới hạn tối đa chữ số
                    if (raw.length > MAX_DIGITS) {
                        raw = raw.substring(0, MAX_DIGITS);
                    }
                    let num = parseInt(raw);
                    if (!isNaN(num)) {
                        price.value = num.toLocaleString("vi-VN");
                    }
                });
                // Không cho dán chữ vào 
                price.addEventListener("paste", function (e) {
                    const pasted = e.clipboardData.getData('text');
                    if (!/^\d+$/.test(pasted.replace(/\D/g, ''))) {
                        e.preventDefault();
                    }
                });





            });

            // làm thay đổi bed khi chọn phòng 
            document.getElementById("roomType").addEventListener("change", function () {
                const roomType = document.getElementById("roomType");
                if (roomType.value === "Standard") {
                    document.getElementById("single").style.display = 'block';
                    document.getElementById("double").style.display = 'block';
                    document.getElementById("queen").style.display = 'none';
                    document.getElementById("king").style.display = 'none';
                    document.getElementById("treePeople").style.display = 'none';
                    document.getElementById("fourPeople").style.display = 'none';
                    document.getElementById("fivePeople").style.display = 'none';
                } else if (roomType.value === "Deluxe") {
                    document.getElementById("queen").style.display = 'block';
                    document.getElementById("king").style.display = 'block';
                    document.getElementById("single").style.display = 'none';
                    document.getElementById("double").style.display = 'none';
                    document.getElementById("twin").style.display = 'none';
                    document.getElementById("treePeople").style.display = 'none';
                    document.getElementById("fourPeople").style.display = 'none';
                    document.getElementById("fivePeople").style.display = 'none';
                } else if (roomType.value === "Twin") {
                    document.getElementById("twin").style.display = 'block';
                    document.getElementById("single").style.display = 'none';
                    document.getElementById("double").style.display = 'none';
                    document.getElementById("king").style.display = 'none';
                    document.getElementById("queen").style.display = 'none';
                    document.getElementById("treePeople").style.display = 'none';
                    document.getElementById("fourPeople").style.display = 'none';
                    document.getElementById("fivePeople").style.display = 'none';
                } else if (roomType.value === "Family") {
                    document.getElementById("twin").style.display = 'none';
                    document.getElementById("single").style.display = 'none';
                    document.getElementById("double").style.display = 'none';
                    document.getElementById("king").style.display = 'none';
                    document.getElementById("queen").style.display = 'none';
                    document.getElementById("treePeople").style.display = 'block';
                    document.getElementById("fourPeople").style.display = 'block';
                    document.getElementById("fivePeople").style.display = 'block';
                } else {
                    document.getElementById("single").style.display = 'block';
                    document.getElementById("double").style.display = 'block';
                    document.getElementById("queen").style.display = 'block';
                    document.getElementById("king").style.display = 'block';
                    document.getElementById("twin").style.display = 'block';
                    document.getElementById("treePeople").style.display = 'none';
                    document.getElementById("fourPeople").style.display = 'none';
                    document.getElementById("fivePeople").style.display = 'none';
                }
            });

        </script>

    </body>
</html>
