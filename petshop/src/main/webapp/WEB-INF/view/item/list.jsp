<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 목록</title>
</head>
<body>
<a href="create.shop">상품 등록</a>
<a href="../cart/cartView.shop" style="float:right;">장바구니</a>

<table border="1" style="border-collapse: collapse">
    <tr>
        <th width="80">상품ID</th>
        <th width="320">상품명</th>
        <th width="100">가격</th>
        <th width="80">수정</th>
        <th width="80">삭제</th>
    </tr>
    <c:forEach items="${itemList}" var="item">
        <tr>
            <td align="center">${item.id}</td>
            <td align="left"><a href="detail.shop?id=${item.id}">${item.name}</a></td>
            <td align="right">
                <fmt:formatNumber type="CURRENCY" pattern="###,###" value="${item.price}" />원
            </td>
            <td align="center"><a href="edit.shop?id=${item.id}">수정</a></td>
            <td align="center"><a href="confirm.shop?id=${item.id}">삭제</a></td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
