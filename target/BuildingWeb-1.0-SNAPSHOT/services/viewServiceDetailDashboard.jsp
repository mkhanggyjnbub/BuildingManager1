<%-- 
    Document   : viewServiceDetailDashboard
    Created on : 18-Jun-2025, 01:29:57
    Author     : dodan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Service Detail Dashboard</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f0f2f5;
                margin: 0;
                padding: 20px;
            }

            .container {
                display: flex;
                justify-content: center;
                background-color: #fff;
                max-width: 900px;
                margin: auto;
                border: 1px solid #ccc;
                padding: 20px;
                border-radius: 8px;
            }

            .left, .right {
                flex: 1;
                padding: 20px;
            }

            .left {
                border-right: 1px solid #ddd;
                text-align: center;
            }

            .left img {
                max-width: 200px;
                height: auto;
                border-radius: 8px;
                margin-bottom: 20px;
            }

            .right h2 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 20px;
            }

            .form-group {
                margin-bottom: 15px;
            }

            label {
                display: block;
                font-weight: bold;
                margin-bottom: 5px;
            }

            input[type="text"],
            textarea {
                width: 100%;
                padding: 8px 10px;
                border: 1px solid #ccc;
                border-radius: 6px;
                background-color: #f9f9f9;
            }

            textarea {
                resize: vertical;
            }

            .btn {
                background-color: #2ecc71;
                color: white;
                padding: 10px 18px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 14px;
                margin-top: 10px;
            }

            .btn:hover {
                background-color: #27ae60;
            }

            .form-group.readonly input,
            .form-group.readonly textarea {
                background-color: #eaeaea;
            }
            
            .back-button {
                top: -40px;
                left: 20px;
                width: 80px;
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
        </style>
    </head>
    <body>
        <a href="javascript:history.back()" class="back-button">← Back</a>
        <div class="container">
            <div class="left">
                <h3>Service Image</h3>
                <img src="${service.imageURL}" alt="Ảnh dịch vụ" />
            </div>

            <div class="right">
                <h2>SERVICE INFORMATION</h2>
                <div class="form-group readonly">
                    <label>Tên dịch vụ:</label>
                    <input type="text" value="${service.serviceName}" readonly />
                </div>
                <div class="form-group readonly">
                    <label>Service type:</label>
                    <input type="text" value="${service.unitType}" readonly />
                </div>
                <div class="form-group readonly">
                    <label>Price:</label>
                    <input type="text" value="${service.price} VNĐ" readonly />
                </div>
                <div class="form-group readonly">
                    <label>Status:</label>
                    <input type="text" value="${service.isActive ? 'Active' : 'Deactivated'}" readonly />
                </div>
                <div class="form-group readonly">
                    <label>Description:</label>
                    <textarea rows="4" readonly>${service.description}</textarea>
                </div>

                <form action="ViewServicesDashboard">
                    <button class="btn">⬅ Back</button>
                </form>
            </div>
        </div>
    </body>
</html>

