<%-- 
    Document   : messageForDashboard
    Created on : Jul 10, 2025, 9:41:48 PM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <title>Lễ Tân - Hộp thoại</title>
        <style>
            * {
                box-sizing: border-box;
            }
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                background-color: #f3f4f6;
                height: 100vh;
                display: flex;
                flex-direction: column;
            }
            header {
                background-color: #1d4ed8;
                color: white;
                padding: 16px;
                text-align: center;
                font-size: 20px;
                font-weight: bold;
            }
            main {
                flex: 1;
                padding: 16px;
                overflow-y: auto;
                display: flex;
                flex-direction: column;
                gap: 12px;
                background-color: #f9fafb;
            }
            .message {
                max-width: 70%;
                padding: 10px 14px;
                border-radius: 16px;
                line-height: 1.4;
                word-wrap: break-word;
            }
            .reception {
                background-color: #2563eb;
                color: white;
                align-self: flex-end;
            }
            .customer {
                background-color: white;
                border: 1px solid #ddd;
                align-self: flex-start;
            }
            footer {
                background-color: white;
                display: flex;
                gap: 8px;
                padding: 12px;
                border-top: 1px solid #e5e7eb;
            }
            input[type="text"] {
                flex: 1;
                padding: 10px 12px;
                border: 1px solid #ccc;
                border-radius: 20px;
                font-size: 14px;
            }
            button {
                padding: 10px 16px;
                background-color: #2563eb;
                color: white;
                border: none;
                border-radius: 20px;
                cursor: pointer;
            }
            button:hover {
                background-color: #1e40af;
            }
        </style>
    </head>
    <body>

        <header>💼 Lễ Tân đang hỗ trợ</header>

        <main id="chatBox">
            <!-- Tin nhắn sẽ được thêm vào bằng JS -->
        </main>

        <footer>
            <input type="text" id="msgInput" placeholder="Nhập tin nhắn..." />
            <button onclick="sendMessage()">Gửi</button>
        </footer>

        <script>
            const userType = "staff"; // Lễ tân
            const ws = new WebSocket("ws://" + location.host + "<%=request.getContextPath()%>/notification");

            ws.onopen = () => {
                console.log("Lễ tân đã kết nối WebSocket");
            };

            ws.onmessage = (event) => {
                const data = JSON.parse(event.data);
                const msgDiv = document.createElement("div");
                msgDiv.classList.add("message", data.senderType === "reception" ? "reception" : "customer");
                msgDiv.textContent = data.message;
                document.getElementById("chatBox").appendChild(msgDiv);
                document.getElementById("chatBox").scrollTop = document.getElementById("chatBox").scrollHeight;
            };
            document.getElementById("msgInput").addEventListener("keydown", function (event) {
                if (event.key === "Enter" && !event.shiftKey) {
                    event.preventDefault(); // Ngăn xuống dòng
                    sendMessage(); // Gọi hàm gửi tin nhắn
                }
            });


            function sendMessage() {
                const input = document.getElementById("msgInput");
                const msg = input.value.trim();
                if (msg === "")
                    return;

                const data = {
                    customerId: "1",
                    senderType: "reception",
                    message: msg
                };

                ws.send(JSON.stringify(data));
                input.value = "";
            }
        </script>

    </body>
</html>

