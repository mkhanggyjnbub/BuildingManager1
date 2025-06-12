/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Websocket;

import jakarta.servlet.http.HttpSession;
import jakarta.websocket.HandshakeResponse;
import jakarta.websocket.server.HandshakeRequest;
import jakarta.websocket.server.ServerEndpointConfig;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class HttpSessionConfigurator extends ServerEndpointConfig.Configurator {

    @Override
    public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response) {
            HttpSession Session = (HttpSession) request.getHttpSession(); // lấy lại session đăng nhập
        sec.getUserProperties().put(HttpSession.class.getName(), Session); // truyền vào config
    }
   
    
}
