<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="dao.ItemDao" %>
<%@ page import="org.springframework.web.context.ContextLoader" %>
<%@ page import="logic.Item" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.CategoryItemDao" %>
<%@ page import="dao.CategoryGroupDao" %>
<%@ page import="logic.CategoryGroup" %>
<%@ page import="logic.CategoryItem" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set value="${pageContext.request.contextPath}" var="path"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>핫 도그몰</title>

    <script type="text/javascript">
        function disp_div(id, tab) {
            $(".info").each(function () {
                $(this).hide();
            });
            $(".tab").each(function () {
                $(this).removeClass("select");
            });
            $("#" + id).show();
            $("#" + tab).addClass("select");
        }
    </script>
</head>
<body>
<%
    WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();

    ItemDao itemDao = null;
    CategoryGroupDao categoryGroupDao = null;
    CategoryItemDao categoryItemDao = null;

    if (context != null) {
        itemDao = (ItemDao)context.getBean("ItemDao");
        categoryGroupDao = (CategoryGroupDao) context.getBean("CategoryGroupDao");
        categoryItemDao = (CategoryItemDao) context.getBean("CategoryItemDao");
    }

    List<CategoryGroup> categoryGroupList = null;


    if (categoryGroupDao != null && categoryItemDao != null) {
        categoryGroupList = categoryGroupDao.list();
    }

    List<Item> latest_items = null;

    if (itemDao != null) {
        latest_items = itemDao.get_latest_items(16);
    }

    ArrayList<List<Item>> sold_items = null;
    if (categoryGroupList != null) {
        sold_items = new ArrayList<>();
        for (CategoryGroup categoryGroup : categoryGroupList) {
            List<Item> sold_items_by_category = null;
            if (itemDao != null) {
                sold_items_by_category = itemDao.get_sold_items(categoryGroup.getGroup_code(), 8);
            }
            sold_items.add(sold_items_by_category);
        }
    }
%>

<!-- Hero section -->
<section class="hero-section">
    <div class="hero-slider owl-carousel">
        <div class="hs-item set-bg" data-setbg="${path}/img/logo1.png">
            <div class="container">
                <div class="row">
                    <div class="col-xl-6 col-lg-7 text-white">
                        <span>New Arrivals</span>
                        <h2>denim jackets</h2>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis ipsum sus-pendisse ultrices gravida. Risus commodo viverra maecenas accumsan lacus vel facilisis. </p>
                        <a href="#" class="site-btn sb-line">DISCOVER</a>
                        <a href="#" class="site-btn sb-white">ADD TO CART</a>
                    </div>
                </div>
                <div class="offer-card text-white">
                    <span>from</span>
                    <h2>$29</h2>
                    <p>SHOP NOW</p>
                </div>
            </div>
        </div>
        <div class="hs-item set-bg" data-setbg="${path}/img/logo2.png">
            <div class="container">
                <div class="row">
                    <div class="col-xl-6 col-lg-7 text-white">
                        <span>New Arrivals</span>
                        <h2>denim jackets</h2>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis ipsum sus-pendisse ultrices gravida. Risus commodo viverra maecenas accumsan lacus vel facilisis. </p>
                        <a href="#" class="site-btn sb-line">DISCOVER</a>
                        <a href="#" class="site-btn sb-white">ADD TO CART</a>
                    </div>
                </div>
                <div class="offer-card text-white">
                    <span>from</span>
                    <h2>$29</h2>
                    <p>SHOP NOW</p>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="slide-num-holder" id="snh-1"></div>
    </div>
</section>
<!-- Hero section end -->

<!-- latest product section -->
<section class="top-letest-product-section">
    <div class="container">
        <div class="section-title">
            <h2>LATEST PRODUCTS</h2>
        </div>
        <div class="product-slider owl-carousel">

            <%
                if (latest_items != null) {
                    for (Item item : latest_items) {
                        pageContext.setAttribute("item", item) ;
            %>
                        <div class="product-item">
                            <div class="pi-pic">
                                <%
                                    if (itemDao.check_new(null, null, item.getItem_no())) { %>
                                        <div class="tag-new">new</div>
                                <%
                                    }
                                %>
                                <a href="${path}/shop/detail.shop?item_no=${item.item_no}">
                                    <img src="${path}/item/img/${item.item_no}/${item.mainpicurl}" alt="">
                                </a>
                                <div class="pi-links">
                                    <a href="${path}/basket/add.shop?item_no=${item.item_no}" class="add-card"><i class="flaticon-bag"></i><span>ADD TO CART</span></a>
                                    <a href="#" class="wishlist-btn" id="rec_update_${item.item_no}" style="width: 80px"><i class="flaticon-heart"></i><span style="font-size: 12pt" class="rec_count_${item.item_no}"></span></a>
                                    <script type="text/javascript">
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
                                    </script>
                                </div>
                            </div>
                            <div class="pi-text">
                                <%
                                    DecimalFormat dc = new DecimalFormat("###,###,###,###");
                                    String str_price = dc.format(item.getPrice());
                                %>
                                <h6><%= str_price %>원</h6>
                                <p>${item.name}</p>
                            </div>
                        </div>
            <%
                    }
                }
            %>

        </div>
    </div>
</section>
<!-- latest product section end -->

<!-- Product filter section -->
<section class="product-filter-section">
    <div class="container">
        <div class="section-title">
            <h2>TOP SELLING PRODUCTS</h2>
        </div>
        <ul class="product-filter-menu" style="text-align: center">
            <%
                if (categoryGroupList != null) {
                    for (CategoryGroup categoryGroup : categoryGroupList) {
            %>
                        <li style="margin-right: 30px"><a id="tab_<%= categoryGroup.getGroup_code() %>" class="tab" href="javascript:disp_div('category_<%= categoryGroup.getGroup_code() %>','tab_<%= categoryGroup.getGroup_code() %>')"><%= categoryGroup.getGroup_name() %></a></li>
            <%
                    }
                }
            %>
        </ul>

        <%
            if (categoryGroupList != null) {
                int i = 0;
                for (CategoryGroup categoryGroup : categoryGroupList) {
        %>
                    <div id="category_<%= categoryGroup.getGroup_code() %>" class="row info">
                        <%
                            if (sold_items.get(i) != null) {
                                for (Item item : sold_items.get(i)) {
                                    pageContext.setAttribute("item", item) ;
                        %>
                                <div class="col-lg-3 col-sm-6">
                                    <div class="product-item">
                                        <div class="pi-pic">
                                            <%
                                                if (itemDao.check_new(null, null, item.getItem_no())) { %>
                                            <div class="tag-new">new</div>
                                            <%
                                                }
                                            %>
                                            <a href="${path}/shop/detail.shop?item_no=${item.item_no}">
                                                <img src="${path}/item/img/${item.item_no}/${item.mainpicurl}" alt="">
                                            </a>
                                            <div class="pi-links">
                                                <a href="${path}/basket/add.shop?item_no=${item.item_no}" class="add-card"><i class="flaticon-bag"></i><span>ADD TO CART</span></a>
                                                <a href="#" class="wishlist-btn" id="rec_update_${item.item_no}" style="width: 80px"><i class="flaticon-heart"></i><span style="font-size: 12pt" class="rec_count_${item.item_no}"></span></a>
                                                <script type="text/javascript">
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
                                                </script>
                                            </div>
                                        </div>
                                        <div class="pi-text">
                                            <%
                                                DecimalFormat dc = new DecimalFormat("###,###,###,###");
                                                String str_price = dc.format(item.getPrice());
                                            %>
                                            <h6><%= str_price %>원</h6>
                                            <p>${item.name}</p>
                                        </div>
                                    </div>
                                </div>
                        <%
                                }
                            }
                        %>

                    </div>
        <%
                    i++;
                }
            }
        %>
    </div>
</section>
<!-- Product filter section end -->

<script type="text/javascript">
    $(document).ready(function () {
        <%
            if (categoryGroupList != null) {
                int i = 0;
                for (CategoryGroup categoryGroup : categoryGroupList) {
        %>
                    <% if (i == 0) { %>
                        $("#category_<%= categoryGroup.getGroup_code() %>").show();
                        $("#tab_<%= categoryGroup.getGroup_code() %>").addClass("select"); //class 속성에 select 값을 추가.
                    <% } else { %>
                        $("#category_<%= categoryGroup.getGroup_code() %>").hide();
                    <% } %>
        <%
                    i++;
                }
            }
        %>
    });
</script>
</body>
</html>
