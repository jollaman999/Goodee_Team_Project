<%@ page import="org.springframework.web.context.ContextLoader" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.BasketDao" %>
<%@ page import="dao.CategoryGroupDao" %>
<%@ page import="dao.CategoryItemDao" %>
<%@ page import="dao.ItemDao" %>
<%@ page import="logic.CategoryGroup" %>
<%@ page import="logic.CategoryItem" %>
<%@ page import="logic.Member" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path" />

<% WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext(); %>

<header class="header-section">
    <div class="header-top">
        <div class="container">
            <div class="row">
                <div class="col-lg-2 text-center text-lg-left">
                    <!-- side bar include -->
                    <c:if test="${!empty sessionScope.loginMember}">
                        <c:choose>
                            <c:when test="${sessionScope.loginMember.id == 'admin'}">
                                <jsp:include page = "sidebar_admin.jsp"/>
                            </c:when>
                            <c:otherwise>
                                <jsp:include page = "sidebar_user.jsp"/>
                            </c:otherwise>
                        </c:choose>
                    </c:if>

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
                                <%
                                    Member loginMember = (Member)session.getAttribute(("loginMember"));
                                    if (context != null) {
                                        BasketDao basketDao = (BasketDao)context.getBean("BasketDao");
                                        if (loginMember != null && basketDao != null) { %>
                                            <span><%= basketDao.count(loginMember.getId()) %></span>
                                <%
                                        }
                                    }
                                %>
                            </div>
                            <a href="${path}/basket/view.shop">장바구니</a>
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
                <li>
                    <a href="${path}/index.jsp">Home</a>
                </li>

                <%
                    if (context != null) {
                        ItemDao itemDao = (ItemDao) context.getBean("ItemDao");
                        CategoryGroupDao categoryGroupDao = (CategoryGroupDao) context.getBean("CategoryGroupDao");
                        CategoryItemDao categoryItemDao = (CategoryItemDao) context.getBean("CategoryItemDao");
                %>
                        <li>
                            <a href="${path}/shop/list.shop">
                                All
                                <% if (itemDao != null && itemDao.check_new(null, null, null)) { %>
                                    <span class="new">New</span>
                                <% } %>
                            </a>
                        </li>

                <%
                        if (categoryGroupDao != null && categoryItemDao != null) {
                            List<CategoryGroup> categoryGroupList = categoryGroupDao.list();
                            List<CategoryItem> categoryItemList = categoryItemDao.list();

                            if (categoryGroupList != null && categoryItemList != null) {
                                for (CategoryGroup categoryGroup : categoryGroupList) {
                %>
                                    <li>
                                        <a href="${path}/shop/list.shop?category_group=<%= categoryGroup.getGroup_code() %>">
                                            <%= categoryGroup.getGroup_name() %>
                                            <% if (itemDao.check_new(categoryGroup.getGroup_code(), null, null)) { %>
                                                <span class="new">New</span>
                                            <% } %>
                                        </a>
                                        <ul class="sub-menu">
                <%
                                            for (CategoryItem categoryItem : categoryItemList) {
                                                if (categoryGroup.getGroup_code() == categoryItem.getGroup_code()) {
                %>
                                                    <li>
                                                        <a href="${path}/shop/list.shop?category_group=<%= categoryGroup.getGroup_code() %>&category_item=<%= categoryItem.getCode() %>">
                                                            <%= categoryItem.getName() %>
                                                            <% if (itemDao.check_new(categoryGroup.getGroup_code(), categoryItem.getCode(), null)) { %>
                                                                <span class="new" style="margin-left: 65px; margin-top: 14px">New</span>
                                                            <% } %>
                                                        </a>
                                                    </li>
                <%
                                                }
                                            }
                %>
                                        </ul>
                                    </li>
                <%
                                }
                            }
                        }
                    } else {
                        System.out.println("header: Can't get WebApplicationContext!");
                    }
                %>
            </ul>
        </div>
    </nav>
</header>