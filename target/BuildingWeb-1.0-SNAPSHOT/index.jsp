<%-- 
    Document   : index
    Created on : Apr 29, 2025, 4:23:56 PM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/index.css">
        <script>
            const menuToggle = document.getElementById('menu-toggle');
            const navMenu = document.getElementById('nav-menu');

            menuToggle.addEventListener('click', () => {
                navMenu.classList.toggle('show');
            });

        </script>



    </head>
    <body>

        <header>
            <div class="logo">🏨 HotelManager</div>
            <nav id="nav-menu">
                <a href="Index">Trang chủ</a>
                <a href="ListRooms">Phòng</a>
                <a href="#">Đặt phòng</a>
                <a href="#">Liên hệ</a>
                <a href="UpImage">Up ảnh</a>
                <a href="VouchersDashBoard">voucher</a>
                <c:choose  > 
                    <c:when test="${customerName==null  }">  
                        <a href="Login">Đăng nhập</a> </c:when>
                    <c:otherwise>
                        <a href="?id=${customerId}">${customerName}</a>
                    </c:otherwise>
                </c:choose>

            </nav>
            <button id="menu-toggle">☰</button>
        </header>

        <!-- banner -->
        <section class="hero">
            <div class="overlay"></div>
            <div class="content">
                <h10>Away from monotonous life.</h10>
                <h1>Big Resort</h1>

                <p>If you are looking at blank cassettes on the web, you may be very confused <br>at the
                    difference in price. You may see some for as low as $.17 each.</p>
                <br>
                <a href="#" class="btn">Đặt phòng</a>
            </div>
        </section>
        <!-- end banner -->

        <jsp:include  page="menuSearch.jsp"/>


        <!-- end first body -->
        <section class="features">
            <div class="feature-box">
                <h2>Quản lý phòng</h2>
                <p>Thêm, sửa, xóa và theo dõi tình trạng phòng.</p>
            </div>
            <div class="feature-box">
                <h2>Quản lý khách hàng</h2>
                <p>Lưu trữ thông tin và lịch sử đặt phòng.</p>
            </div>
            <div class="feature-box">
                <h2>Báo cáo doanh thu</h2>
                <p>Thống kê, xuất báo cáo nhanh chóng.</p>
            </div>
        </section>

        <footer>
            <p>© 2025 HotelManager. Thiết kế bởi bạn.</p>
        </footer>

        <script src="script.js"></script>
    </body>
</html>
