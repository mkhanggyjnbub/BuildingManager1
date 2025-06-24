<%-- 
    Document   : adminView
    Created on : May 4, 2025, 11:44:22 AM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table border ="1" cellpadding="10" cellspacing="0" style="width: 100%; text-align: left; border-collapse: collapse;">
            <tr>
                <th colspan="4" style="font-size: 18px; text-align: center;">👤 THÔNG TIN CHI TIẾT: ${user.userName} <a href="DashboardUser">Đóng</a> </th>
            </tr>
            <tr>
                <td colspan="1" style="width: 30%;"> Ảnh đại diện: </td>
                <td>🔹 Họ tên:</td>
                <td colspan="2" >${user.fullName} </td>

            </tr>
            <tr>
                <td  rowspan="6"><img src="${user.avatarUrl}" alt="Hình avatar" style="width: 50px; height: 50px; border-radius: 50%;"></td>
            </tr>

            <tr>
                <td>🔹 Email:</td>
                <td colspan="2" >${user.email}</td>
            </tr>
            <tr>
                <td>🔹 SĐT:</td>
                <td colspan="2" >${user.phone}</td>
            </tr>
            <tr>
                <td>🔹 Vai trò:</td>
                <td colspan="2">${user.role.roleName}</td>
            </tr>
            <tr>        
                <td>🔹 Trạng thái:</td>
                <td colspan="2"> ${user.status}</td>
            </tr>
            <tr>
                <td colspan="2">📅 Ngày tạo: 01/01/2024</td>
                <td>🔄 Lần cuối đăng nhập: 05/05/2024</td>
            </tr>
        </table>
    </body>
</html>
