<%@ page import="org.springframework.web.context.ContextLoader" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.CategoryGroupDao" %>
<%@ page import="dao.CategoryItemDao" %>
<%@ page import="logic.CategoryGroup" %>
<%@ page import="logic.CategoryItem" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>상품 목록</title>
</head>
<body>
<!-- Page info -->
<div class="page-top-info">
    <div class="container">
        <h4>CAtegory PAge</h4>
        <div class="site-pagination">
            <a href="">Home</a> /
            <a href="">Shop</a> /
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
                            WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();

                            if (context != null) {
                                CategoryGroupDao categoryGroupDao = (CategoryGroupDao) context.getBean("CategoryGroupDao");
                                CategoryItemDao categoryItemDao = (CategoryItemDao) context.getBean("CategoryItemDao");
                                List<CategoryGroup> categoryGroupList = categoryGroupDao.list();
                                List<CategoryItem> categoryItemList = categoryItemDao.list();

                                for (CategoryGroup categoryGroup : categoryGroupList) {
                        %>
                        <li>
                            <a href="${path}/item/list.shop?category_group=<%= categoryGroup.getGroup_code() %>">
                                <%= categoryGroup.getGroup_name() %>
                                <!-- DB 쿼리 조회하여 최근에 등록 된 상품 있을시에만 New 표시하도록 수정 -->
                                <span class="new">New</span>
                            </a>
                            <ul class="sub-menu">
                                <%
                                    for (CategoryItem categoryItem : categoryItemList) {
                                        if (categoryGroup.getGroup_code() == categoryItem.getGroup_code()) {
                                %>
                                <li>
                                    <a href="${path}/shop/list.shop?category_group=<%= categoryGroup.getGroup_code() %>&category_item=<%= categoryItem.getCode() %>">
                                        <%= categoryItem.getName() %>
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
                    <c:forEach var="item" items="${itemList}">
                    <div class="col-lg-4 col-sm-6">
                        <div class="product-item">
                            <div class="pi-pic">
                                <!-- DB 쿼리 조회하여 최근에 등록 된 상품 있을시에만 New 표시하도록 수정 -->
                                <div class="tag-new">new</div>
                                <div style="height: 420px">
                                    <img src="${path}/item/img/${item.item_no}/${item.mainpicurl}" alt="">
                                </div>
                                <div class="pi-links">
                                    <a href="#" class="add-card"><i class="flaticon-bag"></i><span>ADD TO CART</span></a>
                                    <a href="#" class="wishlist-btn"><i class="flaticon-heart"></i></a>
                                </div>
                            </div>
                            <div class="pi-text">
                                <h6>${item.price}원</h6>
                                <p>${item.name}</p>
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
