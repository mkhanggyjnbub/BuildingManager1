<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <title>News list</title>
    <style>
        :root {
            /* 🎨 Màu sắc chính */
            --primary: #002b5c;
            --primary-light: #004080;
            --secondary: #007bff;
            --secondary-hover: #0069d9;
            --danger: #e74c3c;
            --danger-hover: #c0392b;
            --warning: #f1c40f;
            --warning-hover: #d4ac0d;

            --background: #f4f6f9;
            --white: #ffffff;
            --text-color: #222;
            --border-color: #e1e4e8;

            /* 🔠 Cỡ chữ */
            --font-title: 28px;
            --font-normal: 15px;
            --font-small: 14px;

            /* 🔳 Khác */
            --shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
            --radius: 10px;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--background);
            margin: 0;
            padding: 0;
            color: var(--text-color);
        }

        .main-content {
            padding: 30px;
            margin-left: 60px;
            transition: margin-left 0.3s;
        }

        .sidebar.open ~ .main-content {
            margin-left: 220px;
        }

        h1 {
            text-align: center;
            color: var(--primary);
            margin-bottom: 30px;
            font-size: var(--font-title);
            font-weight: 700;
        }

        .back-button {
            background-color: #bdc3c7;
            color: white;
            padding: 8px 14px;
            border-radius: 6px;
            font-size: var(--font-small);
            text-decoration: none;
            display: inline-block;
            margin-bottom: 20px;
            margin-right: 10px;
        }

        .back-button:hover {
            background-color: #95a5a6;
        }

        a button {
            padding: 8px 16px;
            background-color: var(--secondary);
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: var(--font-small);
            transition: background-color 0.3s ease;
            margin-bottom: 20px;
        }

        a button:hover {
            background-color: var(--secondary-hover);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: var(--white);
            box-shadow: var(--shadow);
            border-radius: var(--radius);
            overflow: hidden;
        }

        thead {
            background-color: var(--primary);
        }

        th, td {
            padding: 12px 14px;
            text-align: center;
            border-bottom: 1px solid var(--border-color);
            font-size: var(--font-normal);
        }

        thead th {
            color: white;
            font-weight: 600;
        }

        tbody tr:hover {
            background-color: #f5f8fa;
        }

        img {
            max-height: 50px;
            border-radius: 4px;
        }

        .btn {
            padding: 6px 12px;
            font-size: var(--font-small);
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin: 2px 0;
            font-weight: 500;
        }

        .btn-update {
            background-color: var(--warning);
            color: #000;
        }

        .btn-update:hover {
            background-color: var(--warning-hover);
        }

        .btn-delete {
            background-color: var(--danger);
            color: #fff;
        }

        .btn-delete:hover {
            background-color: var(--danger-hover);
        }

        form { display: inline; }

        @media (max-width: 768px) {
            th, td {
                font-size: 13px;
                padding: 8px;
            }

            a button {
                font-size: 14px;
                padding: 8px 16px;
            }
        }
    </style>
</head>
<body>
    <%@include file="../navbarDashboard/navbarDashboard.jsp" %>
    <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>

    <div class="main-content">
        <h1>News list</h1>
        <a href="javascript:history.back()" class="back-button">← Back</a>
        <a href="AddNewsDashboard">
            <button type="button">➕ Add news</button>
        </a>

        <c:if test="${not empty message}">
            <script>
                alert("${message}");
                window.location.href = "<c:url value='/Index' />";
            </script>
        </c:if>

        <c:if test="${not empty newsList}">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Summary</th>
                        <th>Image</th>
                        <th>Posted date</th>
                        <th>Status</th>
                        <th>Author</th>
                        <th>Building</th>
                        <th>View count</th>
                        <th>Content</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${newsList}" var="news"> 
                        <tr>
                            <td>${news.newsID}</td>
                            <td>${news.title}</td>
                            <td>${news.summary}</td>
                            <td><img src="${news.imageURL}" alt="News image" style="width: 100px; height: auto;"></td>
                            <td>${news.datePosted}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${news.isPublished}">
                                        <span style="color: green;">✔ Public</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: red;">✘ Unpublished</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${news.userId}</td>
                            <td>${news.buildingID}</td>
                            <td>${news.viewcount}</td>
                            <td>${news.content}</td>
                            <td>
                                <form action="EditNewsDashboard" method="get" style="margin-bottom: 5px;">
                                    <input type="hidden" name="id" value="${news.newsID}" />
                                    <button type="submit" class="btn btn-update">✏️ Edit</button>
                                </form>
                                <form action="DeleteNewsDashboard" method="post"
                                      onsubmit="return confirm('Are you sure you want to delete this news item?');">
                                    <input type="hidden" name="id" value="${news.newsID}" />
                                    <button type="submit" class="btn btn-delete">🗑️ Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
        <%@include file="../footer/footer.jsp" %>
</body>
</html>
