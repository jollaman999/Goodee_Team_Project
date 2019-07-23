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

    <link rel="stylesheet" type="text/css" href="${path}/css/w3.css">

    <script type="text/javascript">
        function listcall(page) {
            document.listform.pageNum.value = page;
            document.listform.submit();
        }
    </script>
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
            (${listcount})
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
                                        <a href="#" class="wishlist-btn" id="rec_update_${item.item_no}" style="width: 80px"><i class="flaticon-heart"></i><span style="font-size: 12pt" class="rec_count_${item.item_no}"></span></a>
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
                        <form action="list.shop" method="post" name="listform">
                            <input type="hidden" name="pageNum" value="1">
                            <input type="hidden" name="category_group" value="${category_group}">
                            <input type="hidden" name="category_item" value="${category_item}">

                            <div class="w3-center" style="margin-top: 20px; margin-bottom: 20px">
                                <div class="w3-bar">
                                    <c:choose>
                                        <c:when test="${pageNum <= 1}">
                                            <div class="w3-bar-item">«</div>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="javascript:listcall(${pageNum - 1})" class="w3-bar-item w3-button w3-hover-deep-purple">«</a>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:forEach var="a" begin="${startpage}" end="${endpage}">
                                        <c:choose>
                                            <c:when test="${a == pageNum}">
                                                <div class="w3-bar-item w3-deep-purple">
                                                        ${a}
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="javascript:listcall(${a})" class="w3-bar-item w3-button w3-hover-deep-purple">${a}</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <c:choose>
                                        <c:when test="${pageNum >= endpage}">
                                            <div class="w3-bar-item">»</div>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="javascript:listcall(${pageNum + 1})" class="w3-bar-item w3-button w3-hover-deep-purple">»</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Category section end -->

<script type="text/javascript">
    <c:forEach var="item" items="${itemList}">
    (function ($) {
        // 좋아요 버튼 클릭시(좋아요 반영 또는 취소)
        $("#rec_update_${item.item_no}").click(function () {
            <c:choose>
            <c:when test="${sessionScope.loginMember == null}">
            alert("좋아요를 반영 하시려면 로그인이 필요합니다!");
            </c:when>
            <c:otherwise>
            $.ajax({
                url: "${path}/recommend/update.shop",
                type: "GET",
                data: {
                    type: "0",
                    itemno: "${item.item_no}",
                    member_id: "${sessionScope.loginMember.id}"
                },
                success: function (count) {
                    $(".rec_count_${item.item_no}").html(count);
                },
            });
            </c:otherwise>
            </c:choose>
        });

        // 좋아요 수
        function recCount_${item.item_no}() {
            $.ajax({
                url: "${path}/recommend/count.shop",
                type: "GET",
                data: {
                    type: "0",
                    itemno: "${item.item_no}",
                    member_id: "${sessionScope.loginMember.id}"
                },
                success: function (count) {
                    $(".rec_count_${item.item_no}").html(" " + count);
                },
            })
        }

        recCount_${item.item_no}(); // 처음 시작했을 때 실행되도록 해당 함수 호출
    })(jQuery);
    </c:forEach>
</script>
</body>
</html>
