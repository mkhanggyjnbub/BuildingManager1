<%-- 
    Document   : addServiceDashboard
    Created on : 18-Jun-2025, 02:19:48
    Author     : dodan
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Add New Service</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f0f2f5;
                margin: 0;
                padding: 20px;
            }

            .form-container {
                max-width: 700px;
                margin: auto;
                background-color: #fff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            }

            h2 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 30px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                font-weight: bold;
                margin-bottom: 6px;
            }

            input[type="text"],
            input[type="number"],
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

            .btn {
                display: block;
                margin: auto;
                padding: 10px 20px;
                font-size: 16px;
                border: none;
                border-radius: 6px;
                background-color: #3498db;
                color: white;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .btn:hover {
                background-color: #2980b9;
            }

            .back-link {
                text-align: center;
                margin-top: 20px;
            }

            .back-link a {
                color: #2980b9;
                text-decoration: none;
            }

            .back-link a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h2>Add New Service</h2>
            <form action="AddServiceDashboard" method="post">
                <div class="form-group">
                    <label for="serviceName">Service Name:</label>
                    <input type="text" id="serviceName" name="name" required>
                </div>

                <div class="form-group">
                    <label for="serviceType">Service Type:</label>
                    <input type="text" id="serviceType" name="type" required>
                </div>

                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea id="description" name="description" required></textarea>
                </div>

                <div class="form-group">
                    <label for="price">Price:</label>
                    <input type="number" step="1000" id="price" name="price" required>
                </div>

                <div class="form-group">
                    <label for="imageURL">Image URL:</label>
                    <input type="text" id="imageURL" name="imageURL" required>
                </div>

                <button type="submit" class="btn">💾 Add Service</button>
            </form>

            <div class="back-link">
                <a href="ViewServicesDashboard">⬅ Back List Of Services</a>
            </div>
        </div>
    </body>
</html>

