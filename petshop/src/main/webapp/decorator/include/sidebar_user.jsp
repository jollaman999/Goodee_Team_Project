<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path"/>

<!-- css -->
<link rel="stylesheet" href="${path}/css/sidebar.min.css">

<!-- JS -->
<script src="${path}/js/sidebar.min.js"></script>

<div class="sidebar user">
    <a href="${path}/index.jsp">
        <img src="${path}/img/sidebar/Hotdog.png" alt="" width="120px" height="120px" style="margin-top: 100px; margin-bottom: 40px; margin-left: 40px">
    </a>
    <ul>
        <!-- user 사이드메뉴 -->
        <li><a href="${path}/member/mypage.shop"><i class="fa fa-id-badge sidebaricon"></i>&nbsp;&nbsp;마이페이지</a></li>
        <li><a href="${path}/member/orderHistory.shop"><i class="fa fa-truck sidebaricon"></i>&nbsp;&nbsp;주문내역</a></li>
        <li><a href="${path}/basket/view.shop"><i class="fa fa-shopping-cart sidebaricon"></i>&nbsp;&nbsp;장바구니</a></li>
        <li><a href="${path}/board/list.shop?type=1"><i class="fa fa-commenting-o sidebaricon"></i>&nbsp;&nbsp;1:1문의</a></li>
        <li><a href="${path}/member/logout.shop"><i class="fa fa-sign-out sidebaricon"></i>&nbsp;&nbsp;로그아웃</a></li>
        <li><a href="${path}/member/delete.shop"><i class="fa fa-user-times sidebaricon"></i>&nbsp;&nbsp;회원탈퇴</a></li>
    </ul>
</div>

<div class="button">
    <button class="sidebtn">
    <span></span>
</div>