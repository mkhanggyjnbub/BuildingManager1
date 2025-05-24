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
        <style>
            body {
                margin: 0;
                padding: 0;
                font-family: 'Segoe UI', sans-serif;
                background-color: #f4f6f8;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            h2 {
                text-align: center;
                margin-bottom: 10px;
                color: #333;
            }

            form {
                background-color: #fff;
                padding: 24px;
                border-radius: 12px;
                box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
                max-width: 600px;
                width: 100%;
            }

            .form-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 12px 16px;
                margin-bottom: 16px;
            }

            label {
                font-size: 13px;
                font-weight: 500;
                color: #444;
                align-self: center;
            }

            input[type="text"],
            input[type="number"],
            input[type="date"],
            textarea {
                font-size: 13px;
                padding: 8px 10px;
                border: 1px solid #ccc;
                border-radius: 6px;
                width: 100%;
            }

            textarea {
                resize: vertical;
                min-height: 60px;
                width: 100%;
                margin-top: 4px;
                margin-bottom: 12px;
            }

            input:focus,
            textarea:focus {
                outline: none;
                border-color: #007bff;
            }

            .button-group {
                display: flex;
                justify-content: flex-end;
                gap: 10px;
                margin-top: 10px;
            }

            button[type="submit"] {
                padding: 8px 16px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 6px;
                font-size: 13px;
                cursor: pointer;
            }

            button[type="submit"]:hover {
                background-color: #0056b3;
            }

            .cancel-btn {
                padding: 8px 16px;
                font-size: 13px;
                color: #555;
                border: 1px solid #ccc;
                border-radius: 6px;
                text-decoration: none;
            }

            .cancel-btn:hover {
                background-color: #eee;
            }
        </style>

    </head>
    <body>
        
        <form action="/EditVoucher" method="post">
            <h2>Sửa Voucher</h2>
            <input type="hidden" name="voucherId" value="${voucher.voucherId}" />

            <div class="form-grid">
                <label>Mã voucher:</label>
                <input type="text" name="code" value="${voucher.code}" />

                <label>Loại:</label>
                <input type="number" name="typeId" value="${voucher.typeId}" />

                <label>Phần trăm giảm (%):</label>
                <input type="number" min ="0" name="discountPercent" value="${voucher.discountPercent}" />

                <label>Số tiền giảm (đ):</label>
                <input type="number" name="discountAmount" value="${voucher.discountAmount}" />

                <label>Đơn hàng tối thiểu:</label>
                <input type="number" name="minOrderAmount" value="${voucher.minOrderAmount}" />

                <label>Ngày bắt đầu:</label>
                <input type="date" name="startDate" value="${voucher.startDate}" />

                <label>Ngày kết thúc:</label>
                <input type="date" name="endDate" value="${voucher.endDate}" />
                
                <label>Số lượng:</label>
                <input type="int" name="quantity" value="${voucher.quantity}" />
            </div>

            <label>Mô tả:</label>
            <textarea name="description">${voucher.description}</textarea>

            <div class="button-group">
                <button type="submit">Cập nhật</button>
                <a href="VouchersDashBoard" class="cancel-btn">Hủy</a>
            </div>
        </form>
    </body>

</html>