<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
    header {
        background: linear-gradient(to right, #7b1e1e, #3e1f1f);
        color: white;
        padding: 16px 32px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: fixed;
        top: 0;
        width: 100%;
        z-index: 1000;
        box-shadow: 0 4px 12px rgba(0,0,0,0.25);
    }

    .logo {
        font-size: 24px;
        font-weight: bold;
        color: #fff;
        letter-spacing: 1px;
    }

    nav {
        display: flex;
        gap: 24px;
    }

    nav a {
        color: #fff;
        text-decoration: none;
        font-weight: 500;
        font-size: 15px;
        position: relative;
        transition: color 0.3s ease;
    }

    nav a::after {
        content: '';
        position: absolute;
        width: 0%;
        height: 2px;
        bottom: -2px;
        left: 0;
        background-color: #f4a261;
        transition: width 0.3s ease;
    }

    nav a:hover {
        color: #ffd8b1;
    }

    nav a:hover::after {
        width: 100%;
    }

    #menu-toggle {
        display: none;
        font-size: 1.8rem;
        background: none;
        border: none;
        color: white;
        cursor: pointer;
    }

    @media (max-width: 768px) {
        nav {
            display: none;
            flex-direction: column;
            background: linear-gradient(to right, #7b1e1e, #3e1f1f);
            width: 100%;
            padding: 1rem;
            border-top: 1px solid rgba(255,255,255,0.1);
        }

        nav.show {
            display: flex;
        }

        #menu-toggle {
            display: block;
        }
    }
</style>

<header>
    <div class="logo">HotelManager</div>
    <nav id="nav-menu">
        <a href="Index">Home</a>
        <a href="ViewRooms">Rooms</a>
        <a href="ViewVouchers">Vouchers</a>
        <a href="UserVouchers">My Vouchers</a>
        <a href="ViewNews">News</a>
        <a href="ViewServices">Services</a>
        <a href="Login">Login</a>
    </nav>
    <button id="menu-toggle">☰</button>
</header>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const toggle = document.getElementById("menu-toggle");
        const nav = document.getElementById("nav-menu");
        toggle.addEventListener("click", function () {
            nav.classList.toggle("show");
        });
    });
</script>
