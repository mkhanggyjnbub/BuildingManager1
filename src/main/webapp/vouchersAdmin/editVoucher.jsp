<%-- 
    Document   : editVoucher
    Created on : May 18, 2025, 2:00:54 PM
    Author     : CE180441_Dương Đinh Thế Vinh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Sửa Voucher</title>
</head>
<body>
    <h2>Sửa Voucher</h2>
    <form action="/EditVoucher" method="post">
        <input type="hidden" name="voucherId" value="${voucher.voucherId}" />
        Mã voucher: <input type="text" name="code" value="${voucher.code}" /><br/>
        Loại: <input type="number" name="typeId" value="${voucher.typeId}" /><br/>
        Phần trăm giảm (%): <input type="number" name="discountPercent" value="${voucher.discountPercent}" /><br/>
        Số tiền giảm (đ): <input type="number" name="discountAmount" value="${voucher.discountAmount}" /><br/>
        Đơn hàng tối thiểu: <input type="number" name="minOrderAmount" value="${voucher.minOrderAmount}" /><br/>
        Ngày bắt đầu: <input type="date" name="startDate" value="${voucher.startDate}" /><br/>
        Ngày kết thúc: <input type="date" name="endDate" value="${voucher.endDate}" /><br/>
        Mô tả: <textarea name="description">${voucher.description}</textarea><br/>
        <input type="submit" value="Cập nhật" />
    </form>
</body>
</html>