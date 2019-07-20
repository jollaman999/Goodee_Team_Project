<%@ page import="org.springframework.web.context.ContextLoader" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.CategoryGroupDao" %>
<%@ page import="dao.CategoryItemDao" %>
<%@ page import="dao.ItemDao" %>
<%@ page import="logic.CategoryGroup" %>
<%@ page import="logic.CategoryItem" %>
<%@ page import="logic.Item" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>상품 목록</title>
</head>
<body>
<% WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext(); %>

<!-- Page info -->
<div class="page-top-info">
    <div class="container">
        <h4>CAtegory PAge</h4>
        <br>
        <div class="site-pagination">
            <a href="${path}/shop/list.shop">All</a>
            <c:if test="${!empty category_group}">
                <a href="${path}/shop/list.shop?category_group=${category_group}"> / ${categoryGroupName}</a>
            </c:if>
            <c:if test="${!empty category_item}">
                <a href="${path}/shop/list.shop?category_group=${category_group}&category_item=${category_item}"> / ${categoryItemName}</a>
            </c:if>
        </div>
    </div>
</div>
<!-- Page info end -->

<!-- Category section -->
<section class="category-section spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 order-2 order-lg-1">
                <div class="filter-widget">
                    <h2 class="fw-title">Categories</h2>
                    <ul class="category-menu">
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
                                System.out.println("shop-list: Can't get WebApplicationContext!");
                            }
                        %>
                    </ul>
                </div>
                <div class="filter-widget mb-0">
                    <h2 class="fw-title">refine by</h2>
                    <div class="price-range-wrap">
                        <h4>Price</h4>
                        <div class="price-range ui-slider ui-corner-all ui-slider-horizontal ui-widget ui-widget-content" data-min="10" data-max="270">
                            <div class="ui-slider-range ui-corner-all ui-widget-header" style="left: 0%; width: 100%;"></div>
                            <span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default" style="left: 0%;">
								</span>
                            <span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default" style="left: 100%;">
								</span>
                        </div>
                        <div class="range-slider">
                            <div class="price-input">
                                <input type="text" id="minamount">
                                <input type="text" id="maxamount">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-9  order-1 order-lg-2 mb-5 mb-lg-0">
                <div class="row">
                    <%
                        ItemDao itemDao = null;

                        if (context != null) {
                            itemDao = (ItemDao) context.getBean("ItemDao");
                        }
                    %>
                    <c:forEach var="item" items="${itemList}">
                        <div class="col-lg-4 col-sm-6">
                            <div class="product-item">
                                <div class="pi-pic">
                                    <%
                                        Item item = (Item) pageContext.getAttribute("item");
                                        if (itemDao != null && item != null && itemDao.check_new(null, null, item.getItem_no())) { %>
                                            <div class="tag-new">new</div>
                                    <%
                                        }
                                    %>
                                    <a href="detail.shop?item_no=${item.item_no}">
                                        <img src="${path}/item/img/${item.item_no}/${item.mainpicurl}" alt="">
                                    </a>
                                    <div class="pi-links">
                                        <a href="${path}/basket/add.shop?item_no=${item.item_no}" class="add-card"><i class="flaticon-bag"></i><span>ADD TO CART</span></a>
                                        <a href="#" class="wishlist-btn" style="width: 80px"><i class="flaticon-heart"></i><span style="font-size: 12pt">&nbsp;123</span></a>
                                    </div>
                                </div>
                                <div class="pi-text">
                                    <h6>${item.price}원</h6>
                                    <a href="detail.shop?item_no=${item.item_no}">
                                        <p>${item.name}</p>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <div class="text-center w-100 pt-3">
                        <button class="site-btn sb-line sb-dark">LOAD MORE</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Category section end -->
</body>
</html>
