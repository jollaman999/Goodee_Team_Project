<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>주문 확정</title>
</head>
<body>
<h2>${loginUser.userName}님이 주문하신 정보입니다.</h2>
<h2>배송지 정보</h2>
<table>
    <tr>
        <td width="30%">구매자 ID</td>
        <td width="70%">${sessionScope.loginUser.userId}</td>
    </tr>
    <tr>
        <td width="30%">구매자 이름</td>
        <td width="70%">${sessionScope.loginUser.userName}</td>
    </tr>
    <tr>
        <td width="30%">우편 번호</td>
        <td width="70%">${sessionScope.loginUser.postcode}</td>
    </tr>
    <tr>
        <td width="30%">주소</td>
        <td width="70%">${sessionScope.loginUser.address}</td>
    </tr>
    <tr>
        <td width="30%">전화 번호</td>
        <td width="70%">${sessionScope.loginUser.phoneNo}</td>
    </tr>
    <tr>
        <td width="30%">이메일</td>
        <td width="70%">${sessionScope.loginUser.email}</td>
    </tr>
</table>
<h2>주문 완료 상품 목록</h2>
<table>
    <tr>
        <th>상품명</th>
        <th>가격</th>
        <th>수량</th>
        <th>합계</th>
    </tr>
    <c:forEach items="${sale.itemList}" var="saleItem" varStatus="stat">
        <tr>
            <td>${saleItem.item.name}</td>
            <td>${saleItem.item.price}</td>
            <td>${saleItem.quantity}</td>
            <td>${saleItem.item.price * saleItem.quantity}</td>
        </tr>
    </c:forEach>

    <tr>
        <td colspan="4" align="right">
            총 구입 금액: <fmt:formatNumber value="${tot}" pattern="###,###" />원
        </td>
    </tr>
    <tr>
        <td colspan="4">
            <a href="../item/list.shop">상품 목록</a>&nbsp;
        </td>
    </tr>
</table>
</body>
</html>