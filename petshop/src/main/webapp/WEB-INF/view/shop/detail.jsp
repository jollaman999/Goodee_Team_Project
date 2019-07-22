<%@ page import="org.springframework.web.context.ContextLoader" %>
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

    <!-- HighSlide -->
    <script type="text/javascript" src="${path}/vendor/highslide/highslide.js"></script>
    <link rel="stylesheet" type="text/css" href="${path}/vendor/highslide/highslide.css" />

    <script type="text/javascript">

        function check_quantity() {
            var quantity = document.getElementById("quantity").value;

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
    </script>
</head>
<body>
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
                    [추천수 표시할 영역]
                </div>
                <div class="p-review">
                    <a href="">3 reviews</a>|<a href="">Add your review</a>
                </div>
                <div class="quantity" style="margin-top: -10px">
                    <c:if test="${item.remained_quantity > 0}">
                        <p>수량</p>
                        <div class="pro-qty" style="margin-top: 10px"><input type="text" value="1" id="quantity"></div>
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
            <div class="product-item">
                <div class="pi-pic">
                    <img src="./img/product/1.jpg" alt="">
                    <div class="pi-links">
                        <a href="#" class="add-card"><i class="flaticon-bag"></i><span>ADD TO CART</span></a>
                        <a href="#" class="wishlist-btn"><i class="flaticon-heart"></i></a>
                    </div>
                </div>
                <div class="pi-text">
                    <h6>$35,00</h6>
                    <p>Flamboyant Pink Top </p>
                </div>
            </div>
            <div class="product-item">
                <div class="pi-pic">
                    <div class="tag-new">New</div>
                    <img src="./img/product/2.jpg" alt="">
                    <div class="pi-links">
                        <a href="#" class="add-card"><i class="flaticon-bag"></i><span>ADD TO CART</span></a>
                        <a href="#" class="wishlist-btn"><i class="flaticon-heart"></i></a>
                    </div>
                </div>
                <div class="pi-text">
                    <h6>$35,00</h6>
                    <p>Black and White Stripes Dress</p>
                </div>
            </div>
            <div class="product-item">
                <div class="pi-pic">
                    <img src="./img/product/3.jpg" alt="">
                    <div class="pi-links">
                        <a href="#" class="add-card"><i class="flaticon-bag"></i><span>ADD TO CART</span></a>
                        <a href="#" class="wishlist-btn"><i class="flaticon-heart"></i></a>
                    </div>
                </div>
                <div class="pi-text">
                    <h6>$35,00</h6>
                    <p>Flamboyant Pink Top </p>
                </div>
            </div>
            <div class="product-item">
                <div class="pi-pic">
                    <img src="./img/product/4.jpg" alt="">
                    <div class="pi-links">
                        <a href="#" class="add-card"><i class="flaticon-bag"></i><span>ADD TO CART</span></a>
                        <a href="#" class="wishlist-btn"><i class="flaticon-heart"></i></a>
                    </div>
                </div>
                <div class="pi-text">
                    <h6>$35,00</h6>
                    <p>Flamboyant Pink Top </p>
                </div>
            </div>
            <div class="product-item">
                <div class="pi-pic">
                    <img src="./img/product/6.jpg" alt="">
                    <div class="pi-links">
                        <a href="#" class="add-card"><i class="flaticon-bag"></i><span>ADD TO CART</span></a>
                        <a href="#" class="wishlist-btn"><i class="flaticon-heart"></i></a>
                    </div>
                </div>
                <div class="pi-text">
                    <h6>$35,00</h6>
                    <p>Flamboyant Pink Top </p>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- RELATED PRODUCTS section end -->
</body>
</html>
