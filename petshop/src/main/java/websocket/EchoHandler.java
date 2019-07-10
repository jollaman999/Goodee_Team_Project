package websocket;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.HashSet;
import java.util.Set;

public class EchoHandler extends TextWebSocketHandler {
    private Set<WebSocketSession> clients = new HashSet<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        super.afterConnectionEstablished(session);
        System.out.println(session.getRemoteAddress() + " : 클라이언트 접속됨.");
        clients.add(session);
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        super.afterConnectionClosed(session, status);
        System.out.println(session.getRemoteAddress() + " : 클라이언트 접속 해제 : " + status.getReason());
        clients.remove(session);
    }

    @Override
    public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
        String loadMessage = (String)message.getPayload();
        System.out.println(session.getRemoteAddress() + " 메시지 : " + loadMessage);
        for (WebSocketSession s : clients) {
            s.sendMessage(new TextMessage(session.getRemoteAddress() + " : " + loadMessage));
        }
    }

    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        super.handleTransportError(session, exception);
        System.out.println("오류 발생!" + exception.getMessage());
    }
}
