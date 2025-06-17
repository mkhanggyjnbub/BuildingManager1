<%-- 
    Document   : editAmenitiesDashboard
    Created on : Jun 16, 2025, 12:37:26 AM
    Author     : KHANH
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.Amenities" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Amenity</title>
    <style>
        :root {
            --primary-color: #0a2f5c;
            --primary-hover: #0c3f7c;
            --background: #ffffff;
            --form-bg: #f4faff;
            --input-border: #ccc;
            --radius: 12px;
            --shadow: 0 10px 25px rgba(0, 0, 0, 0.12);
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #e4f0ff, #ffffff);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            position: relative;
        }

        /* Decorative icon background */
        body::before {
            content: "";
            position: absolute;
            top: 10%;
            left: 5%;
            width: 140px;
            height: 140px;
            background: url('https://cdn-icons-png.flaticon.com/512/847/847969.png') no-repeat center/contain;
            opacity: 0.05;
            pointer-events: none;
        }

        .form-container {
            background-color: var(--form-bg);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 40px;
            max-width: 480px;
            width: 90%;
            animation: fadeIn 0.5s ease-in-out;
        }

        h1 {
            color: var(--primary-color);
            text-align: center;
            margin-bottom: 10px;
            font-size: 26px;
        }

        .description {
            text-align: center;
            font-size: 14px;
            color: #555;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-top: 16px;
            margin-bottom: 6px;
            font-weight: 600;
            color: var(--primary-color);
        }

        label::before {
            content: attr(data-icon) " ";
            margin-right: 4px;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--input-border);
            border-radius: 8px;
            font-size: 15px;
            transition: border-color 0.3s;
            background-color: #fff;
        }

        input[type="text"]:focus,
        textarea:focus {
            border-color: var(--primary-color);
            outline: none;
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        button {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 14px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            width: 100%;
            margin-top: 30px;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: var(--primary-hover);
        }

        .back-link {
            text-align: center;
            margin-top: 20px;
        }

        .back-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: bold;
            font-size: 14px;
            transition: color 0.2s;
        }

        .back-link a:hover {
            color: var(--primary-hover);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 480px) {
            .form-container {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>

    <div class="form-container">
        <h1>🛠️ Edit Amenity</h1>
        <p class="description">Please fill in the details below to update this amenity in the system.</p>

        <form action="${pageContext.request.contextPath}/EditAmenitiesDashboard" method="post">
            <input type="hidden" name="id" value="${a.amenityId}" />

            <label for="name" data-icon="🏷️">Amenity Name:</label>
            <input type="text" id="name" name="name" maxlength="100" required value="${a.name}" />

            <label for="description" data-icon="📝">Description:</label>
            <textarea id="description" name="description" maxlength="255" rows="4">${a.description}</textarea>

            <button type="submit">Update Amenity</button>
        </form>

        <div class="back-link">
            <a href="${pageContext.request.contextPath}/ViewAmenitiesDashboard">← Back to Amenities List</a>
        </div>
    </div>

</body>
</html>