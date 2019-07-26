<%@ page import="org.springframework.web.context.ContextLoader" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="dao.ItemDao" %>
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

    <title>상품 상세 정보</title>

    <link rel="stylesheet" type="text/css" href="${path}/css/w3.css">

    <!-- HighSlide -->
    <script type="text/javascript" src="${path}/vendor/highslide/highslide.js"></script>
    <link rel="stylesheet" type="text/css" href="${path}/vendor/highslide/highslide.css" />

    <script type="text/javascript">
        function onlyNumber() {
            if(((event.keyCode < 48)||(event.keyCode > 57)) && ((event.keyCode < 96)||(event.keyCode > 105)) &&
                (event.keyCode != 8) && (event.keyCode != 35) && (event.keyCode != 36) && (event.keyCode != 37) && (event.keyCode != 39) && (event.keyCode != 46) &&
                (event.keyCode != 116))  {
                event.returnValue = false;
                alert("숫자만 입력하세요!");
            }
        }

        function check_quantity() {
            var quantity = parseInt(document.getElementById("quantity").value);

            if (quantity > ${item.remained_quantity}) {
                alert("입력 하신 수량이 주문 가능 수량 보다 많습니다!");
                return false;
            }

            return true;
        }

        function do_basket_add() {
            if (!check_quantity())
                return;

            var quantity = document.getElementById("quantity").value;

            location.href = "${path}/basket/add.shop?item_no=${item.item_no}&quantity=" + quantity;
        }

        function do_checkout() {
            if (!check_quantity())
                return;

            var quantity = document.getElementById("quantity").value;

            location.href = "${path}/basket/checkout.shop?item_no=${item.item_no}&quantity=" + quantity;
        }

        function iframe_autoResize(iframe)
        {
            var iframeHeight = (iframe).contentWindow.document.body.scrollHeight;

            (iframe).height = iframeHeight;
        }
    </script>
</head>
<body>
<%
    WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();

    ItemDao itemDao = null;
    if (context != null) {
        itemDao = (ItemDao)context.getBean("ItemDao");
    }
%>

<!-- Page info -->
<div class="page-top-info">
    <div class="container">
        <h4>DEtail PAge</h4>
        <br>
        <div class="site-pagination">
            <a href="${path}/shop/list.shop">All</a>
            <a href="${path}/shop/list.shop?category_group=${item.category_group_code}"> / ${categoryGroupName}</a>
            <a href="${path}/shop/list.shop?category_group=${item.category_group_code}&category_item=${item.category_item_code}"> / ${categoryItemName}</a>
        </div>
    </div>
</div>
<!-- Page info end -->

<!-- product section -->
<section class="product-section">
    <div class="container">
        <div class="back-link">
            <a href="${path}/shop/list.shop?category_group=${item.category_group_code}&category_item=${item.category_item_code}" style="font-size: 12pt"> &lt;&lt; 목록으로 돌아가기</a>
        </div>
        <div class="row">
            <div class="col-lg-6">
                <a href="${path}/item/img/${item.item_no}/${item.mainpicurl}" class="highslide" onclick="return hs.expand(this)">
                    <img class="product-big-img" src="${path}/item/img/${item.item_no}/${item.mainpicurl}" alt="">
                </a>
            </div>
            <div class="col-lg-6 product-details">
                <h2 class="p-title">${item.name}</h2>
                <h3 class="p-price"><fmt:formatNumber value="${item.price}" pattern="###,###" /> 원</h3>
                <c:choose>
                    <c:when test="${item.remained_quantity > 0}">
                        <h4 class="p-stock">재고 현황 : <span class="available">주문 가능</span></h4>
                        <h4 class="p-stock">주문 가능 수량 : ${item.remained_quantity}</h4>
                    </c:when>
                    <c:otherwise>
                        <h4 class="p-stock">재고 현황 : <span class="sold-out">재고 없음</span></h4>
                    </c:otherwise>
                </c:choose>
                <div style="margin-top: 20px; margin-bottom: 10px">
                    <!-- Recommend -->
                    <button id="rec_update" class="w3-button w3-pink w3-round" style="width: 100px; font-weight: bold">
                        <i class="fa fa-heart" style="font-size:16px;color:white"></i>
                        &nbsp;<span class="rec_count"></span>
                    </button>
                </div>
                <div class="p-review">
                    <a href="#reply_area">${review_count} reviews</a>
                </div>
                <div class="quantity" style="margin-top: -10px">
                    <c:if test="${item.remained_quantity > 0}">
                        <p>수량</p>
                        <div class="pro-qty" style="margin-top: 10px"><input type="text" value="1" id="quantity" onkeydown="onlyNumber()"></div>
                    </c:if>
                </div>
                <a href="javascript:do_basket_add()" class="site-btn" style="margin-right: 10px">장바구니 담기</a>
                <a href="${path}/board/write.shop?type=1&item_no=${item.item_no}" class="site-btn sb-dark" style="margin-right: 10px">상품 문의</a>
                <a href="javascript:do_checkout()" class="site-btn" style="margin-right: 10px">바로 구매</a>
                <div id="accordion" class="accordion-area">
                    <div class="panel">
                        <div class="panel-header" id="headingOne">
                            <button class="panel-link active" data-toggle="collapse" data-target="#collapse1" aria-expanded="true" aria-controls="collapse1">상품 정보</button>
                        </div>
                        <div id="collapse1" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion">
                            <div class="panel-body">
                                <p>${item.description}</p>
                            </div>
                        </div>
                    </div>
                    <div class="panel">
                        <div class="panel-header" id="headingThree">
                            <button class="panel-link" data-toggle="collapse" data-target="#collapse3" aria-expanded="false" aria-controls="collapse3">환불 정책</button>
                        </div>
                        <div id="collapse3" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
                            <div class="panel-body">
                                <h4>7일 내에 환불 가능</h4>
                                <p>환불은 포장을 개봉하지 않은 상태에서 <span>7일 내</span>에 가능합니다.</p></span></p>
                                <p>환불시 택배 비용은 본인이 부담하셔야 합니다.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div style="margin-top: 90px; margin-bottom: 80px; margin-left: 70px; margin-right: 70px">
            ${item.content}
        </div>
    </div>
</section>
<!-- product section end -->


<!-- RELATED PRODUCTS section -->
<section class="related-product-section">
    <div class="container">
        <div class="section-title">
            <h2>RELATED PRODUCTS</h2>
        </div>
        <div class="product-slider owl-carousel">
            <c:forEach var="randomitem" items="${randomitemList}">
                <div class="product-item">
                    <div class="pi-pic">
                        <%
                            Item item = (Item) pageContext.getAttribute("item");
                            if (itemDao != null && item != null && itemDao.check_new(null, null, item.getItem_no())) { %>
                        <div class="tag-new">new</div>
                        <%
                            }
                        %>
                        <a href="${path}/shop/detail.shop?item_no=${randomitem.item_no}">
                            <img src="${path}/item/img/${randomitem.item_no}/${randomitem.mainpicurl}" alt="">
                        </a>
                        <div class="pi-links">
                            <a href="${path}/basket/add.shop?item_no=${randomitem.item_no}" class="add-card"><i class="flaticon-bag"></i><span>ADD TO CART</span></a>
                            <a href="#" class="wishlist-btn" id="rec_update_${randomitem.item_no}" style="width: 80px"><i class="flaticon-heart"></i><span style="font-size: 12pt" class="rec_count_${randomitem.item_no}"></span></a>
                        </div>
                    </div>
                    <div class="pi-text">
                        <h6>${randomitem.price}원</h6>
                        <a href="detail.shop?item_no=${randomitem.item_no}">
                            <p>${randomitem.name}</p>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>
<!-- RELATED PRODUCTS section end -->

<!-- Reply Area Start -->
<div id="reply_area" style="text-align: center; margin-top: 50px">
    <section class="related-product-section">
    <div class="container">
        <div class="section-title">
            <h2>USER REVIEWS</h2>
        </div>
    </div>
    <iframe src="${path}/reply/list.shop?type=0&itemno=${item.item_no}"
            onload="iframe_autoResize(this)" scrolling="no" style="width: 90%; border: 0"></iframe>
    </section>
</div>
<!-- Reply Area End -->

<script type="text/javascript">
    (function ($) {
        // 좋아요 버튼 클릭시(좋아요 반영 또는 취소)
        $("#rec_update").click(function () {
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
                            $(".rec_count").html(count);
                        },
                    });
                </c:otherwise>
            </c:choose>
        });

        // 좋아요 수
        function recCount() {
            $.ajax({
                url: "${path}/recommend/count.shop",
                type: "GET",
                data: {
                    type: "0",
                    itemno: "${item.item_no}",
                    member_id: "${sessionScope.loginMember.id}"
                },
                success: function (count) {
                    $(".rec_count").html(count);
                },
            })
        }

        recCount(); // 처음 시작했을 때 실행되도록 해당 함수 호출
    })(jQuery);
</script>

<script type="text/javascript">
    <c:forEach var="randomitem" items="${randomitemList}">
        (function ($) {
            // 좋아요 버튼 클릭시(좋아요 반영 또는 취소)
            $("#rec_update_${randomitem.item_no}").click(function () {
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
                                itemno: "${randomitem.item_no}",
                                member_id: "${sessionScope.loginMember.id}"
                            },
                            success: function (count) {
                                $(".rec_count_${randomitem.item_no}").html(count);
                            },
                        });
                    </c:otherwise>
                </c:choose>
            });

            // 좋아요 수
            function recCount_${randomitem.item_no}() {
                $.ajax({
                    url: "${path}/recommend/count.shop",
                    type: "GET",
                    data: {
                        type: "0",
                        itemno: "${randomitem.item_no}",
                        member_id: "${sessionScope.loginMember.id}"
                    },
                    success: function (count) {
                        $(".rec_count_${randomitem.item_no}").html(" " + count);
                    },
                })
            }

            recCount_${randomitem.item_no}(); // 처음 시작했을 때 실행되도록 해당 함수 호출
        })(jQuery);
    </c:forEach>
</script>
</body>
</html>
