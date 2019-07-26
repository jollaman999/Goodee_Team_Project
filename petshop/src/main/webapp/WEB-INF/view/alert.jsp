<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<script type="text/javascript">
    <c:if test="${empty basket_ok}">
        alert("${msg}");
    </c:if>

    <c:choose>
        <c:when test="${close}">
            self.close();
        </c:when>
        <c:when test="${basket_ok}">
            if (confirm("상품이 장바구니에 추가 되었습니다. 장바구니로 이동하시겠습니까?") == true){
                location.href = "../basket/view.shop";
            } else {
                location.href = "<%= request.getHeader("referer") %>";
            }
        </c:when>
        <c:when test="${reply_reload}">
            opener.document.location.href = "list.shop?type=${type}&itemno=${itemno}&pageNum=${pageNum}";
            self.close();
        </c:when>
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