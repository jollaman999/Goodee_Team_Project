<%--<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--
   isErrorPage="true" : exception 객체가 전달
                        exception 객체 : exception.CartEmptyException 객체
--%>
<script type="text/javascript">
    alert("${exception.message}");
    location.href="${exception.url}"; // getUrl() 메서드 호출
</script>