//package Websocket;
//
//import jakarta.servlet.http.HttpSession;
//import jakarta.websocket.CloseReason;
//import jakarta.websocket.EndpointConfig;
//import jakarta.websocket.OnClose;
//import jakarta.websocket.OnMessage;
//import jakarta.websocket.OnOpen;
//import jakarta.websocket.server.ServerEndpoint;
//import java.io.IOException;
//import java.util.Collections;
//import java.util.HashSet;
//import java.util.Set;
//import jakarta.websocket.Session;
//import java.util.HashMap;
//import java.util.Map;
//
//@ServerEndpoint("/notification")
//public class WebSocket {
//
//    private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
//    private static Map<String, Session> userSessions = new HashMap<>();
//
//    @OnOpen
//    public void onOpen(Session session, EndpointConfig sec) {
//       clients.add(session);
//    }
//
//    @OnClose
//    public void onClose(Session session, CloseReason reason) {
//        clients.remove(session);
//    }
//
//    @OnMessage
//    public void onMessage(String message, Session sender) {
//        synchronized (clients) {
//            for (Session client : clients) {
//                try {
//                    client.getBasicRemote().sendText(message);
//                } catch (IOException e) {
//                    e.printStackTrace();
//                }
//            }
//        }
//    }
//
//}
