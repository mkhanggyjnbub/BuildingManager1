<%-- 
    Document   : addVoucher
    Created on : May 16, 2025, 3:48:15 PM
    Author     : CE180441_Dương Đinh Thế Vinh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thêm Voucher Mới</title>
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

            form {
                background-color: #fff;
                padding: 24px;
                border-radius: 12px;
                box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
                max-width: 600px;
                width: 100%;
            }

            h1 {
                font-size: 20px;
                margin-bottom: 20px;
                color: #333;
                text-align: center;
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
        <form action="AddVoucher" method="post">
            <h1>Thêm Voucher Mới</h1>
            <div class="form-grid">
                <label>Mã voucher:</label>
                <input type="text" name="code" required />

                <label>Loại voucher (1: %, 2: tiền):</label>
                <input type="number" name="typeId" min="1" max="2" required />

                <label>Giảm %:</label>
                <input type="number" name="discountPercent" />

                <label>Giảm số tiền (VNĐ):</label>
                <input type="number" name="discountAmount" />

                <label>Đơn tối thiểu:</label>
                <input type="number" name="minOrderAmount" required />

                <label>Ngày bắt đầu:</label>
                <input type="date" name="startDate" required />

                <label>Ngày kết thúc:</label>
                <input type="date" name="endDate" required />
            </div>

            <label>Mô tả:</label>
            <textarea name="description"></textarea>

            <div class="button-group">
                <button type="submit">Thêm voucher</button>
                <a href="VouchersDashBoard" class="cancel-btn">Hủy</a>
            </div>
        </form>

    </body>
</html>
