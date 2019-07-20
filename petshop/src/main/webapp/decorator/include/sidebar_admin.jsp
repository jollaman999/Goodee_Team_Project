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

<div class="sidebar admin">
    <a href="${path}/index.jsp">
        <img src="${path}/img/sidebar/Hotdog.png" alt="" width="120px" height="120px" style="margin-top: 100px; margin-bottom: 40px; margin-left: 40px">
    </a>
    <ul>
        <!-- admin 사이드메뉴 -->
        <li><a href="${path}/admin/list.shop"><i class="far fa-address-book sidebaricon"></i>&nbsp;&nbsp;회원관리</a></li>
        <li><a href="${path}/item/list.shop"><i class="fas fa-archive sidebaricon"></i>&nbsp;&nbsp;상품관리</a></li>
        <li><a href="${path}/item/list.shop"><i class="far fa-chart-bar sidebaricon"></i>&nbsp;&nbsp;판매내역</a></li>
        <li><a href="${path}/inventory/list.shop"><i class="fas fa-boxes sidebaricon"></i>&nbsp;&nbsp;재고관리</a></li>
        <li><a href="${path}/board/list.shop?type=0"><i class="fas fa-chalkboard-teacher sidebaricon"></i>&nbsp;&nbsp;공지사항</a></li>
        <li><a href="${path}/board/list.shop?type=1"><i class="far fa-comment-dots sidebaricon"></i>&nbsp;&nbsp;1:1문의</a></li>
        <li><a href="${path}/member/logout.shop"><i class="fas fa-sign-out-alt sidebaricon"></i>&nbsp;&nbsp;로그아웃</a></li>
    </ul>
</div>

<div class="button">
    <button class="sidebtn">
    <span></span>
</div>