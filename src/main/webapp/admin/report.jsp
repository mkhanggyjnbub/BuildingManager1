<%-- 
    Document   : report
    Created on : Jun 21, 2025, 5:02:11 PM
    Author     : KHANH
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Report" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách Báo Cáo Phòng</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f1f3f6;
            padding: 30px;
            animation: fadeIn 0.4s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .nav-bar {
            margin-bottom: 20px;
        }

        .back-button {
            background-color: #007BFF;
            color: white;
            padding: 10px 16px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            transition: background-color 0.3s, transform 0.2s;
            cursor: pointer;
        }

        .back-button:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
        }

        .back-button i {
            margin-right: 8px;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.05);
            animation: fadeIn 0.5s ease;
        }

        th, td {
            padding: 14px 16px;
            border-bottom: 1px solid #e0e0e0;
            text-align: left;
        }

        th {
            background-color: #007BFF;
            color: white;
        }

        tr:hover {
            background-color: #f9f9f9;
            transition: background-color 0.2s ease;
        }

        .error {
            color: red;
            font-weight: bold;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

    <!-- 🔙 Back button with JavaScript -->
    <div class="nav-bar">
        <button class="back-button" onclick="history.back()">
            <i class="fa-solid fa-arrow-left"></i> Quay lại
        </button>
    </div>

    <h2>📋 Danh sách Báo Cáo Phòng</h2>

    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
        <div class="error"><%= error %></div>
    <% } %>

    <%
        List<Report> reportList = (List<Report>) request.getAttribute("reportList");
        if (reportList == null || reportList.isEmpty()) {
    %>
        <p>Không có báo cáo nào.</p>
    <%
        } else {
    %>
        <table>
            <tr>
                <th>ID</th>
                <th>Phòng</th>
                <th>Khách báo cáo</th>
                <th>Người dùng báo cáo</th>
                <th>Thời gian báo cáo</th>
                <th>Mô tả</th>
                <th>Trạng thái</th>
                <th>Xử lý bởi</th>
                <th>Thời gian xử lý</th>
                <th>Ghi chú</th>
            </tr>
            <%
                for (Report r : reportList) {
            %>
            <tr>
                <td><%= r.getReportId() %></td>
                <td><%= r.getRoomId() %></td>
                <td><%= r.getReportedByCustomerId() %></td>
                <td><%= r.getReportedByUserId() %></td>
                <td><%= r.getReportTime() %></td>
                <td><%= r.getDescription() %></td>
                <td><%= r.getStatus() %></td>
                <td><%= r.getHandledBy() %></td>
                <td><%= r.getHandledTime() %></td>
                <td><%= r.getNotes() %></td>
            </tr>
            <%
                }
            %>
        </table>
    <%
        }
    %>

</body>
</html>
