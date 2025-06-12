<%-- 
    Document   : login
    Created on : Apr 15, 2025, 9:53:01 AM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="Login" method="post">
            <label  >Name</label>
            <br>
            <input name="tk" type="text"> 
            <br>
            <label>password</label>
            <br>
            <input name="pas" type="password"> 
            <br>
            <input  name="sub" type="submit"/>
        </form>
        <a href="SignUp" >
           Sign up
        </a>

    </body>
</html>
