<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<script type="text/javascript">
    alert("${msg}");

    <c:choose>
        <c:when test="${check_id}">
            opener.document.f.id.value="${param.id}";
            opener.document.f.checked_duplicate_id.value=1;
            opener.document.f.id.focus();
            self.close();
        </c:when>
        <c:when test="${check_email}">
            opener.document.f.email.value="${param.email}";
            opener.document.f.checked_duplicate_email.value=1;
            opener.document.f.email.focus();
            self.close();
        </c:when>
        <c:otherwise>
            location.href="${url}";
        </c:otherwise>
    </c:choose>
</script>