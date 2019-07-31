<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 확정</title>

    <style type="text/css">
        div.links {
            width: 100%;
            text-align: center;
            margin: 50px auto auto;
        }

        div.deliveryInfo {
            margin-top: 50px
        }
    </style>
</head>
<body>
<div id="container">
    <div class="main">
        <div class="completeState" style="text-align: center">
            <h2>주문이 정상적으로 완료 되었습니다.</h2>
            <div class="deliveryInfo" style="text-align: center;">
                <h4>자세한 주문내역은 사이드바의 주문내역 메뉴를 이용해 주세요.</h4>
            </div>
            <div class="links">
                <a class="site-btn" style="margin-right :10px" href="${path}/shop/list.shop">쇼핑계속하기</a>
                <a class="site-btn" style="margin-right :10px" href="${path}/member/orderHistory.shop">주문 내역 보기</a>
                <a class="site-btn" style="margin-right :10px" href="https://www.irionmall.co.kr/">타쇼핑몰</a><br><br>
                <img src="${path}/img/k.png" width="150" height="150" alt="" style="margin-top: 30px">
            </div>
        </div>
    </div>
</div>
</body>
</html>