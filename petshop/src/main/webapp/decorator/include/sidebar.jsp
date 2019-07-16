<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">        
    <!-- css  -->
    <link rel="stylesheet" href="${path}/css/sidebar.css">
    <link rel="stylesheet" href="${path}/css/regular.css">
    <link rel="stylesheet" href="${path}/css/regular.min.css">
    <link rel="stylesheet" href="${path}/css/solid.min.css">
    <link rel="stylesheet" href="${path}/css/solid.css">
    <!--  JS -->
    <script src="${path}/js/sidebar.js"></script>
</head>



<body>
  <div class="sidebar">    
    <img src="${path}/img/sidebar/Hotdog.png" alt=""  width="120px" height="120px">
    <ul>
       <!--admin 사이드메뉴-->
       
     <li><a href="${path}/admin/list.shop"><i class="far fa-address-book"></i>&nbsp;회원관리</a></li>   
     <li><a href="${path}/item/list.shop"><i class="fas fa-archive"></i>&nbsp;상품관리</a></li>                          
     <li><a href="${path}/item/list.shop"><i class="far fa-chart-bar"></i>&nbsp;판매내역</a></li>
     <li><a href="${path}/item/list.shop"><i class="fas fa-boxes"></i>&nbsp;재고관리</a></li>                       
     <li><a href="${path}/item/list.shop"><i class="fas fa-chalkboard-teacher"></i>&nbsp;공지사항</a></li>
     <li><a href="${path}/item/list.shop"><i class="far fa-comment-dots"></i>&nbsp;1:1문의</a></li>                 
     <li><a href="${path}/member/logout.shop"><i class="fas fa-sign-out-alt"></i>&nbsp;로그아웃</a></li>                              
    </ul>  
  </div>
  <div class="button">
    <button class="sidebtn">
      <span></span>
  </div>
</body>
</html>