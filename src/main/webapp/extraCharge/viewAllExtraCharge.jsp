<%-- 
    Document   : viewAllExtraCharge
    Created on : 16 Jul 2025, 07:03:08
    Author     : dodan
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Extra Charges</title>
        <!-- CSS giống như trang customer -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            :root {
                --primary: #1e88e5;
                --primary-dark: #0d47a1;
                --white: #ffffff;
                --gray-light: #f3f6fa;
                --gray-medium: #e0e6ed;
                --text-color: #2b2b2b;
                --shadow: 0 6px 16px rgba(0, 0, 0, 0.08);
                --radius: 12px;
            }

            body {
                font-family: 'Segoe UI', Tahoma, sans-serif;
                background: linear-gradient(to bottom right, #eef3fc, #f9fbff);
                margin: 0;
                color: var(--text-color);
            }

            .main-content {
                margin-left: 240px;
                padding: 60px 40px 40px;
            }

            h2 {
                font-size: 32px;
                font-weight: 800;
                margin-bottom: 30px;
                color: var(--primary-dark);
                border-left: 6px solid var(--primary-dark);
                padding-left: 15px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background: var(--white);
                border-radius: var(--radius);
                box-shadow: var(--shadow);
                overflow: hidden;
            }

            th, td {
                padding: 16px 12px;
                text-align: center;
                font-size: 15px;
            }

            th {
                background-color: var(--primary-dark);
                color: white;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                font-size: 13px;
            }

            tr:nth-child(even) {
                background-color: var(--gray-light);
            }

            tr:hover {
                background-color: var(--gray-medium);
            }

            .actions a {
                margin: 0 6px;
                font-size: 16px;
                padding: 8px 12px;
                border-radius: 8px;
                color: white;
                transition: all 0.3s ease;
                text-decoration: none;
            }

            .actions a.fa-eye {
                background-color: #4caf50;
            }

            .actions a.fa-eye:hover {
                background-color: #388e3c;
            }

            .actions a.fa-pencil {
                background-color: #2196f3;
            }

            .actions a.fa-pencil:hover {
                background-color: #1565c0;
            }

            .navbar {
                background-color: var(--primary-dark);
                color: var(--white);
                padding: 0 30px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                height: 60px;
                font-weight: bold;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            }

            .navbar h1 {
                font-size: 22px;
                margin: 0;
                font-weight: 700;
            }

            .navbar a {
                color: var(--white);
                text-decoration: none;
                font-size: 16px;
                display: flex;
                align-items: center;
                gap: 6px;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .main-content {
                    margin-left: 0;
                    padding: 20px;
                }

                h2 {
                    font-size: 24px;
                }

                table, thead, tbody, th, td, tr {
                    display: block;
                }

                thead {
                    display: none;
                }

                tr {
                    margin-bottom: 20px;
                    border-radius: 10px;
                    box-shadow: var(--shadow);
                    background: white;
                    overflow: hidden;
                }

                td {
                    padding: 14px 20px;
                    text-align: right;
                    position: relative;
                }

                td::before {
                    content: attr(data-label);
                    position: absolute;
                    left: 20px;
                    top: 14px;
                    font-weight: bold;
                    color: var(--primary-dark);
                    text-align: left;
                }

                .actions {
                    text-align: center;
                }
            }
        </style>
    </head>
    <body>

        <%@ include file="../navbarDashboard/navbarDashboard.jsp" %>
        <%@ include file="../sidebarDashboard/sidebarDashboard.jsp" %>

        <div class="main-content">
            <h2>Extra Charges List</h2>

            <div style="margin-bottom: 20px;">
                <a href="CreateExtraCharge" style="background-color: #1e88e5; color: white; padding: 10px 20px; border-radius: 8px; text-decoration: none; font-weight: bold;">
                    + Create New Extra Charge
                </a>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Booking ID</th>
                        <th>Charge Type</th>
                        <th>Quantity</th>
                        <th>Unit Price</th>
                        <th>Start Time</th>
                        <th>End Time</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty extraCharges}">
                            <tr>
                                <td colspan="7">No extra charges available.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="e" items="${extraCharges}">
                                <tr>
                                    <td data-label="Booking ID">${e.bookingId}</td>
                                    <td data-label="Charge Type">${e.chargeType}</td>
                                    <td data-label="Quantity">${e.quantity}</td>
                                    <td data-label="Unit Price">${e.unitPrice}</td>
                                    <td data-label="Start Time">${e.startTime}</td>
                                    <td data-label="End Time">${e.endTime}</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

        </div>

    </body>
</html>

