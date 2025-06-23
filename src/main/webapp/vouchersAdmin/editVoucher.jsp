<%-- 
    Document   : editVoucher
    Created on : May 18, 2025, 2:00:54 PM
    Author     : CE180441_Dương Đinh Thế Vinh
--%>

<%@page import="models.Vouchers"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Sửa Voucher</title>
        <style>
            * {
                box-sizing: border-box;
            }

            body {
                margin: 0;
                padding: 0;
                font-family: "Segoe UI", sans-serif;
                background-color: #f1f3f5;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }

            form {
                width: 100%;
                max-width: 700px;
                background: #fff;
                border-radius: 16px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
                padding: 2rem;
                display: flex;
                flex-direction: column;
            }

            h2 {
                margin: 0;
                text-align: center;
                font-size: 1.8rem;
                color: #333;
            }

            .form-group {
                display: flex;
                flex-direction: column;
            }

            label {
                font-weight: 600;
                margin-bottom: 0.3rem;
                color: #555;
            }

            input, select, textarea {
                padding: 0.6rem;
                font-size: 1rem;
                border: 1px solid #ccc;
                border-radius: 8px;
                width: 100%;
            }

            textarea {
                resize: vertical;
                min-height: 80px;
            }

            .button-group {
                display: flex;
                justify-content: space-between;
                gap: 1rem;
                margin-top: 1rem;
            }

            button, .cancel-btn {
                flex: 1;
                padding: 0.75rem;
                border: none;
                border-radius: 8px;
                font-size: 1rem;
                cursor: pointer;
                text-align: center;
            }

            button {
                background-color: #28a745;
                color: white;
            }

            .cancel-btn {
                background-color: #e0e0e0;
                color: #333;
                text-decoration: none;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            button:hover {
                background-color: #218838;
            }

            .cancel-btn:hover {
                background-color: #ccc;
            }

            input[readonly], textarea[readonly] {
                background-color: #e0e0e0;
                cursor: not-allowed;
            }

        </style>
        <script>
            function pad(n) {
                return n.toString().padStart(2, '0');
            }

            function getFormattedDateTimeLocal(date) {
                return date.getFullYear() + '-' +
                        pad(date.getMonth() + 1) + '-' +
                        pad(date.getDate()) + 'T' +
                        pad(date.getHours()) + ':' +
                        pad(date.getMinutes());
            }

            function validateForm() {
                const discount = parseFloat(document.getElementById("discountPercent").value);
                if (isNaN(discount) || discount < 0.01 || discount > 100) {
                    alert("Discount percent must be between 1.00 and 100.00.");
                    return false;
                }

                const decimalPlaces = (discount.toString().split('.')[1] || '').length;
                if (decimalPlaces > 2) {
                    alert("Discount percent must not have more than 2 decimal places.");
                    return false;
                }

                return true;
            }

            window.addEventListener("DOMContentLoaded", function () {
                const startInput = document.getElementById('startDate');
                const endInput = document.getElementById('endDate');

                if (!startInput || !endInput)
                    return;

                const now = new Date();
                const nowFormatted = getFormattedDateTimeLocal(now);

                // Nếu đang tạo mới (startInput chưa có giá trị)
                if (!startInput.value) {
                    startInput.value = nowFormatted;
                    startInput.min = nowFormatted;
                }

                // Nếu đang tạo mới (endInput chưa có giá trị)
                if (!endInput.value) {
                    endInput.value = nowFormatted;
                    endInput.min = nowFormatted;
                } else {
                    // Nếu đang chỉnh sửa, endDate phải sau hoặc bằng startDate
                    endInput.min = startInput.value;
                }

                // Khi thay đổi startDate → cập nhật min của endDate
                startInput.addEventListener('change', function () {
                    endInput.min = startInput.value;
                    if (endInput.value < startInput.value) {
                        endInput.value = startInput.value;
                    }
                });
            });
        </script>
    </head>

    <body>
        <form action="/EditVoucher" method="post" onsubmit="return validateForm()">
            <h2>Edit Voucher</h2>
            <input type="hidden" name="voucherId" value="${voucher.voucherId}" />

            <c:set var="isLocked" value="${voucher.isActive}" />

            <div class="form-group">
                <label for="code">Voucher code</label>
                <input type="text" id="code" name="code" maxlength="50" value="${voucher.code}" required placeholder="Maximum 50 characters"
                       ${isLocked ? 'readonly' : ''} />
            </div>

            <div class="form-group">
                <label for="quantity">Quantity</label>
                <input type="number" id="quantity" name="quantity" min="1" value="${voucher.quantity}" required
                       ${isLocked ? 'readonly' : ''} />
            </div>

            <div class="form-group">
                <label for="discountPercent">Percentage reduction (%)</label>
                <input type="number" step="0.01" min="1" max="100" id="discountPercent" name="discountPercent"
                       value="${voucher.discountPercent}" required ${isLocked ? 'readonly' : ''} />
            </div>

            <div class="form-group">
                <label for="minOrderAmount">Minimum order</label>
                <input type="number" id="minOrderAmount" name="minOrderAmount" min="1" value="${voucher.minOrderAmount}" required
                       ${isLocked ? 'readonly' : ''} />
            </div>

            <div class="form-group">
                <label for="startDate">Start date</label>
                <input type="datetime-local" id="startDate" name="startDate" value="${voucher.formattedStartDate}" required
                       ${isLocked ? 'readonly' : ''} />
            </div>

            <div class="form-group">
                <label for="endDate">End date</label>
                <input type="datetime-local" id="endDate" name="endDate" value="${voucher.formattedEndDate}" required
                       ${isLocked ? 'readonly' : ''} />
            </div>

            <div class="form-group">
                <label for="description">Describe</label>
                <textarea id="description" name="description" maxlength="200" placeholder="Maximum 200 characters"
                          ${isLocked ? 'readonly' : ''}>${voucher.description}</textarea>
            </div>

            <div class="form-group">
                <label for="isActive">Status</label>
                <select id="isActive" name="isActive">
                    <option value="false" ${!voucher.isActive ? 'selected' : ''}>Inactive</option>
                    <option value="true" ${voucher.isActive ? 'selected' : ''}>Active</option>
                </select>
            </div>

            <div class="button-group">
                <button type="submit">Update</button>
                <a href="VouchersDashBoard" class="cancel-btn">Cancel</a>
            </div>
        </form>
    </body>


</html>