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
        <style>
            /* Phần container dịch vụ khách hàng */
            .dichvukhachhang {
                position: relative;
                display: inline-block;
            }

            /* Nội dung dropdown mặc định ẩn */
            .dichvukhachhang-content {
                display: none;
                position: absolute;
                background-color: #ffffff;
                min-width: 200px;
                box-shadow: 0px 8px 16px rgba(0,0,0,0.2);
                z-index: 10;
                right: 0; /* Hiện bên phải nếu bạn muốn khớp với tên */
                border-radius: 4px;
                padding: 8px 0;
            }

            /* Các item bên trong dropdown */
            .dichvukhachhang-content a {
                color: #333;
                padding: 10px 16px;
                text-decoration: none;
                display: block;
                font-size: 14px;
            }

            .dichvukhachhang-content a:hover {
                background-color: #f0f0f0;
            }

            /* Khi hover vào tên người dùng thì hiển thị dropdown */
            .dichvukhachhang:hover .dichvukhachhang-content {
                display: block;
            }
        </style>
    </head>
    <body>

        <header>
            <div class="logo">🏨 HotelManager</div>
            <nav id="nav-menu">
                <a href="Index">Trang chủ</a>
                <a href="#">Phòng</a>
                <a href="#">Đặt phòng</a>
                <a href="#">Liên hệ</a>
                <a href="UpImage">Up ảnh</a>
                <div class="dichvukhachhang">
                    <c:choose  > 
                        <c:when test="${customerName==null  }">  
                            <a href="Login">Đăng nhập</a> </c:when>
                        <c:otherwise>
                            <a>${customerName}</a>
                            <div class="dichvukhachhang-content">
                                <a href="UserInfomation?id=${customerId}"> 🔹 Tài khoản của tôi </a>
                                <a href="#"> 🔹 Đơn đặt phòng </a>
                                <a href="#"> 🔹 Lịch sử thanh toán </a>
                                <a href="#"> 🔹 Ưu đãi thành viên </a>
                                <a href="#"> 🔹 Trợ giúp </a>
                                <a href=""> 🔹 Đăng xuất </a>
                            </div>
                        </c:otherwise>
                    </c:choose>  
                </div>
                <a href="news">News</a>
                <a href="NewsAdminR">NAdmin</a>
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

        <!-- first body -->
        <section>
            <div class="hotel_booking_area position">
                <div class="container">
                    <div class="hotel_booking_table">
                        <div class="col-md-3">
                            <h2>Book<br> Your Room</h2>
                        </div>
                        <div class="col-md-9">
                            <div class="boking_table">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="book_tabel_item">
                                            <div class="form-group">
                                                <div class='input-group date' id='datetimepicker11'>
                                                    <input type='text' class="form-control" placeholder="Arrival Date"/>
                                                    <span class="input-group-addon">
                                                        <i class="fa fa-calendar" aria-hidden="true"></i>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class='input-group date' id='datetimepicker1'>
                                                    <input type='text' class="form-control" placeholder="Departure Date"/>
                                                    <span class="input-group-addon">
                                                        <i class="fa fa-calendar" aria-hidden="true"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="book_tabel_item">
                                            <div class="input-group">
                                                <select class="wide">
                                                    <option data-display="Adult">Adult</option>
                                                    <option value="1">Old</option>
                                                    <option value="2">Younger</option>
                                                    <option value="3">Potato</option>
                                                </select>
                                            </div>
                                            <div class="input-group">
                                                <select class="wide">
                                                    <option data-display="Child">Child</option>
                                                    <option value="1">Child</option>
                                                    <option value="2">Baby</option>
                                                    <option value="3">Child</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="book_tabel_item">
                                            <div class="input-group">
                                                <select class="wide">
                                                    <option data-display="Child">Number of Rooms</option>
                                                    <option value="1">Room 01</option>
                                                    <option value="2">Room 02</option>
                                                    <option value="3">Room 03</option>
                                                </select>
                                            </div>
                                            <a class="book_now_btn button_hover" href="#">Book Now</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
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
