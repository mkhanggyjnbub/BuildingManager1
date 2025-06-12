<%-- 
    Document   : dashBoardUser
    Created on : May 3, 2025, 2:04:23 PM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>

            .pagination{

                display: flex;

                list-style: none;
            }

            nav ul li {
                margin: 10px;
                display: flex;
                list-style: none;
            }


        </style>
    </head>
    <body>

        <form method="get" action="DashboardUser">            
            <input type="search" name="search" placeholder="Nhập Từ Khóa...">
            <button type="submit" ><i class='bx bx-search-alt-2'></i></button>
        </form>

        <table border="1">
            <thead>
                <tr>
                    <th>STT</th>
                    <th>HỌ TÊN </th>
                    <th>EMAIL</th>
                    <th>VAI TRÒ</th>
                    <th>THAO TÁC</th>
                </tr>   
            </thead>
            <tbody>
                <c:forEach var="user"  items="${list}"  varStatus="i" > 
                    <tr>
                        <!--Công thức in ra số trang ở từng phân trang-->
                        <td>${(thisPage - 1) * 10 + i.index + 1}</td>
                        <td>${user.userName}</td>
                        <td>${user.email}</td>
                        <td>${user.role.roleName}</td>
                        <td><a href="AdminView?id=${user.userId}"><i  class="fa-solid fa-eye"></i></a>
                            <a href="AdminEdit?id=${user.userId}"><i class="fa-solid fa-pencil"></i></a>
                            <a href="AdminDelete?id=${user.userId}"><i  class="fa-solid fa-circle-user"></i></a> 
                            <a href="Decentralization?id=${user.userId}"><i  class="fa-solid fa-gear"></i></a>  
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>


        <nav aria-label="Page navigation">
            <ul class="pagination">
                <c:forEach  begin="1" end="${finalPage}" var ="i">
                    <li><a href="DashboardUser?Page=${i}">${i}</a></li>
                    </c:forEach>
            </ul>

        </nav>
    </body>
</html>
