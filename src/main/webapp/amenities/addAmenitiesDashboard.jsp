<%-- 
    Document   : addAmenitiesDashboard
    Created on : Jun 15, 2025, 10:06:09 PM
    Author     : KHANH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${a != null ? 'Edit Amenity' : 'Add New Amenity'}</title>
    <style>
        :root {
            --main-color: #0a2f5c;
            --hover-color: #0c3f7c;
            --bg-color: #f0f6ff;
            --text-color: #333;
            --radius: 10px;
            --shadow: 0 10px 25px rgba(0, 0, 0, 0.12);
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            animation: fadeInBody 1s ease forwards;
        }

        @keyframes fadeInBody {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .form-wrapper {
            background-color: var(--bg-color);
            padding: 40px 30px;
            max-width: 540px;
            width: 90%;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            animation: slideIn 0.7s ease-out;
            opacity: 0;
            transform: translateY(30px);
            animation-fill-mode: forwards;
        }

        @keyframes slideIn {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-wrapper:hover {
            transform: scale(1.01);
            transition: transform 0.3s ease;
        }

        h2 {
            text-align: center;
            color: var(--main-color);
            margin-bottom: 10px;
            font-size: 26px;
        }

        .description-text {
            text-align: center;
            font-size: 14px;
            color: #555;
            margin-bottom: 30px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: var(--main-color);
        }

        label::before {
            content: attr(data-icon) " ";
            margin-right: 5px;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: var(--radius);
            font-size: 15px;
            background-color: #fff;
            transition: border 0.2s, box-shadow 0.2s;
        }

        input[type="text"]:focus,
        textarea:focus {
            border-color: var(--main-color);
            box-shadow: 0 0 5px rgba(10, 47, 92, 0.4);
            outline: none;
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        .button-group {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 10px;
        }

        input[type="submit"],
        input[type="reset"] {
            background-color: var(--main-color);
            color: #fff;
            border: none;
            padding: 12px 24px;
            border-radius: var(--radius);
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        input[type="submit"]:hover,
        input[type="reset"]:hover {
            background-color: var(--hover-color);
            transform: scale(1.05);
        }

        .back-link {
            text-align: center;
            margin-top: 25px;
        }

        .back-link a {
            text-decoration: none;
            color: var(--main-color);
            font-weight: bold;
            font-size: 14px;
            transition: color 0.2s ease;
        }

        .back-link a:hover {
            color: var(--hover-color);
        }
    </style>
</head>
<body>

<div class="form-wrapper">
    <h2>${a != null ? '🛠️ Edit Amenity' : '➕ Add New Amenity'}</h2>
    <p class="description-text">
        Please fill in the details below to ${a != null ? 'update the amenity' : 'add a new amenity'} to the system.
    </p>

    <form action="${pageContext.request.contextPath}/${a != null ? 'EditAmenitiesDashboard' : 'AddAmenitiesDashboard'}" method="post">
        <c:if test="${a != null}">
            <input type="hidden" name="id" value="${a.amenityId}" />
        </c:if>

        <label for="name" data-icon="🏷️">Amenity Name:</label>
        <input type="text" id="name" name="name" maxlength="100" required value="${a != null ? a.name : ''}">

        <label for="description" data-icon="📝">Description:</label>
        <textarea id="description" name="description" maxlength="255">${a != null ? a.description : ''}</textarea>

        <div class="button-group">
            <input type="submit" value="${a != null ? 'Update' : 'Add'}">
            <input type="reset" value="Reset">
        </div>
    </form>

    <div class="back-link">
        <a href="${pageContext.request.contextPath}/ViewAmenitiesDashboard">← Back to List</a>
    </div>
</div>

</body>
</html>