<%-- 
    Document   : editServiceDashboard
    Created on : 18-Jun-2025, 03:41:54
    Author     : dodan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update Service Dashboard</title>
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
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Update Service</h1>
            <form action="${pageContext.request.contextPath}/EditServiceDashboard" method="post">
                <!-- ID dịch vụ (ẩn) -->
                <input type="hidden" name="serviceId" value="${s.serviceId}" />

                <label>Service Name:</label>
                <input type="text" name="name" value="${s.serviceName}" required />

                <label>Service Type:</label>
                <input type="text" name="type" value="${s.serviceType}" required />

                <label>Description:</label>
                <textarea name="description" rows="4" required>${s.description}</textarea>

                <label>Price:</label>
                <input type="number" name="price" value="${s.price}" required />

                <label>Image URL:</label>
                <input type="text" name="imageURL" value="${s.imageURL}" required />

                <label>Status:</label>
                <div class="checkbox-group">
                    <label>
                        <input type="radio" name="isActive" value="true" ${s.isActive ? 'true' : ''} /> Active
                    </label><br>
                    <label>
                        <input type="radio" name="isActive" value="false" ${!s.isActive ? 'false' : ''} /> Deactivated
                    </label>
                </div>



                <button type="submit">Cập nhật dịch vụ</button>
            </form>
        </div>
    </body>
</html>

