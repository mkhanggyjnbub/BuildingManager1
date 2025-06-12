<%-- 
    Document   : addVoucher
    Created on : May 16, 2025, 3:48:15 PM
    Author     : CE180441_Dương Đinh Thế Vinh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <title>Thêm Voucher</title>
    <link rel="stylesheet" href="css/style.css"/>
</head>
<body>
    <h1>Thêm Voucher Mới</h1>
    <form action="AddVoucher" method="post">
        <label>Mã voucher:</label>
        <input type="text" name="code" required /><br/>

        <label>Loại voucher (1: %, 2: tiền):</label>
        <input type="number" name="typeId" min="1" max="2" required /><br/>

        <label>Giảm %:</label>
        <input type="number" name="discountPercent" /><br/>

        <label>Giảm số tiền (VNĐ):</label>
        <input type="number" name="discountAmount" /><br/>

        <label>Đơn tối thiểu:</label>
        <input type="number" name="minOrderAmount" required /><br/>

        <label>Ngày bắt đầu:</label>
        <input type="date" name="startDate" required /><br/>

        <label>Ngày kết thúc:</label>
        <input type="date" name="endDate" required /><br/>

        <label>Mô tả:</label>
        <textarea name="description"></textarea><br/>

        <button type="submit">Thêm voucher</button>
    </form>
</body>
</html>
