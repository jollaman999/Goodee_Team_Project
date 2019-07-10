<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Websocket Client</title>
    <c:set var="port" value="${pageContext.request.localPort}" />
    <c:set var="server" value="${pageContext.request.serverName}" />
    <c:set var="path" value="${pageContext.request.contextPath}" />
    <script type="text/javascript" src="${path}/js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript">
        $(function () {
            var ws = new WebSocket("ws://${server}:${port}${path}/chatting.shop");
            ws.onopen = function () {
                $("#chatStatus").text("[INFO] Connection opened");
                $("input[name = chatInput]").on("keydown", function(evt) {
                    if (evt.keyCode === 13) {
                        var msg = $("input[name = chatInput]");
                        ws.send(msg.val());
                        msg.val("");
                    }
                })
            }

            ws.onmessage = function (event) {
                $("textarea").eq(0).prepend(event.data + "\n");
            }

            ws.onclose = function (event) {
                $("#chatStatus").text("[INFO] Connection close");
            }
        })
    </script>
</head>
<body>
<p>
<div id="chatStatus"></div>
<textarea name="chatMsg" rows="15" cols="40" readonly></textarea><br>
메시지 입력 : <input type="text" name="chatInput">
</body>
</html>
