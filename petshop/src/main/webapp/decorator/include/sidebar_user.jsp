<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path"/>

<!-- css -->
<link rel="stylesheet" href="${path}/css/sidebar.css">
<link rel="stylesheet" href="${path}/css/regular.css">
<link rel="stylesheet" href="${path}/css/regular.min.css">
<link rel="stylesheet" href="${path}/css/solid.min.css">
<link rel="stylesheet" href="${path}/css/solid.css">

<!-- JS -->
<script src="${path}/js/sidebar.js"></script>

<div class="sidebar user">
    <a href="${path}/index.jsp">
        <img src="${path}/img/sidebar/Hotdog.png" alt="" width="120px" height="120px" style="margin-top: 100px; margin-bottom: 40px; margin-left: 40px">
    </a>
    <ul>
        <!-- user 사이드메뉴 -->
        <li><a href="${path}/member/mypage.shop"><i class="far fa-id-badge sidebaricon"></i>&nbsp;&nbsp;마이페이지</a></li>
        <li><a href="${path}/cart/checkout.shop"><i class="fas fa-truck sidebaricon"></i>&nbsp;&nbsp;주문내역</a></li>
        <li><a href="${path}/cart/cartView.shop"><i class="fas fa-shopping-cart sidebaricon"></i>&nbsp;&nbsp;장바구니</a></li>
        <li><a href="${path}/board/write.shop?type=1"><i class="far fa-comment-dots sidebaricon"></i>&nbsp;&nbsp;1:1문의</a></li>
        <li><a href="${path}/member/logout.shop"><i class="fas fa-sign-out-alt sidebaricon"></i>&nbsp;&nbsp;로그아웃</a></li>
        <li><a href="${path}/member/delete.shop"><i class="fas fa-user-slash sidebaricon"></i>&nbsp;&nbsp;회원탈퇴</a></li>
    </ul>
</div>

<div class="button">
    <button class="sidebtn">
    <span></span>
</div>