<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path" />

<header class="header-section">
    <div class="header-top">
        <div class="container">
            <div class="row">
                <div class="col-lg-2 text-center text-lg-left">
                    <!-- logo -->
                    <a href="${path}/index.jsp" class="site-logo">
                        <!--  핫 도그몰 로고 제작 필요 -->
                        <!--<img src="${path}/img/logo.png" alt="">-->
                        <h3>핫 도그몰</h3>
                    </a>
                </div>
                <div class="col-xl-6 col-lg-5">
                    <form class="header-search-form">
                        <input type="text" placeholder="핫 도그몰에서 검색" style="text-align: center"
                               onclick="this.placeholder=''" onfocusout="this.placeholder='핫 도그몰에서 검색'">
                        <button><i class="flaticon-search"></i></button>
                    </form>
                </div>
                <div class="col-xl-4 col-lg-5">
                    <div class="user-panel">
                        <div class="up-item">
                            <i class="flaticon-profile"></i>
                            <c:choose>
                                <c:when test="${empty sessionScope.loginMember}">
                                    <a href="${path}/member/login.shop">로그인</a>&nbsp;&nbsp;/&nbsp;
                                    <a href="${path}/member/memberEntry.shop">회원가입</a>
                                </c:when>
                                <c:otherwise>
                                    ${sessionScope.loginMember.name}님&nbsp;&nbsp;/&nbsp;<a href="${path}/member/logout.shop">로그아웃</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="up-item">
                            <div class="shopping-card">
                                <i class="flaticon-bag"></i>
                                <!-- 장바구니 수량 DB 쿼리하여 표시되도록 수정 필요 -->
                                <span>0</span>
                            </div>
                            <a href="${path}/cart/cartView.shop">장바구니</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <nav class="main-navbar">
        <div class="container">
            <!-- menu -->
            <ul class="main-menu">
                <li><a href="${path}/index.jsp">Home</a></li>
                <li>
                    <!-- side bar include -->
                    <jsp:include page = "sidebar.jsp"/>

                    <a href="#">
                        Meal
                        <!-- DB 쿼리 조회하여 최근에 등록 된 상품 있을시에만 New 표시하도록 수정 -->
                        <span class="new">New</span>
                    </a>
                    <ul class="sub-menu">
                        <li><a href="/petshop/item/list.shop">건식사료</a></li>
                        <li><a href="#">소프트사료</a></li>
                        <li><a href="#">습식사료</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">
                        Snack
                        <!-- DB 쿼리 조회하여 최근에 등록 된 상품 있을시에만 New 표시하도록 수정 -->
                        <span class="new">New</span>
                    </a>
                    <ul class="sub-menu">
                        <li><a href="#">껌</a></li>
                        <li><a href="#">소시지</a></li>
                        <li><a href="#">음료</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">
                        Dress
                        <!-- DB 쿼리 조회하여 최근에 등록 된 상품 있을시에만 New 표시하도록 수정 -->
                        <span class="new">New</span>
                    </a>
                    <ul class="sub-menu">
                        <li><a href="#">티셔츠</a></li>
                        <li><a href="#">후드티</a></li>
                        <li><a href="#">신발</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">
                        House
                        <!-- DB 쿼리 조회하여 최근에 등록 된 상품 있을시에만 New 표시하도록 수정 -->
                        <span class="new">New</span>
                    </a>
                    <ul class="sub-menu">
                        <li><a href="#">방석</a></li>
                        <li><a href="#">집</a></li>
                        <li><a href="#">울타리</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">
                        Living
                        <!-- DB 쿼리 조회하여 최근에 등록 된 상품 있을시에만 New 표시하도록 수정 -->
                        <span class="new">New</span>
                    </a>
                    <ul class="sub-menu">
                        <li><a href="#">서브메뉴 1</a></li>
                        <li><a href="#">서브메뉴 2</a></li>
                        <li><a href="#">서브메뉴 3</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
</header>