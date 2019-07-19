<%@ page import="org.springframework.web.context.ContextLoader" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="dao.BasketDao" %>
<%@ page import="logic.Item" %>
<%@ page import="dao.ItemDao" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
</head>
<body>
<!-- Page info -->
<div class="page-top-info">
    <div class="container">
        <h4>Your cart</h4>
        <div class="site-pagination">
            <a href="">Home</a> /
            <a href="">Your cart</a>
        </div>
    </div>
</div>
<!-- Page info end -->

<!-- cart section end -->
<section class="cart-section spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-8">
                <div class="cart-table">
                    <h3>Your Cart</h3>
                    <div class="cart-table-warp">
                        <table>
                            <thead>
                            <tr>
                                <th class="product-th" style="font-size: 16px">상품</th>
                                <th class="quy-th" style="font-size: 16px">수량</th>
                                <th class="total-th" style="font-size: 16px">가격</th>
                            </tr>
                            </thead>
                            <tbody>
                                <%
                                    WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();
                                    ItemDao itemDao = null;

                                    if (context != null) {
                                        itemDao = (ItemDao)context.getBean("ItemDao");
                                    }
                                %>
                                <c:set var="total" value="0" />
                                <c:forEach items="${basketList}" var="basket">
                                    <c:set var="item_no" value="${basket.item_no}" />
                                    <%
                                        if (itemDao != null && pageContext.getAttribute("item_no") != null) {
                                            pageContext.setAttribute("item", itemDao.selectOne((Integer)pageContext.getAttribute("item_no")));
                                        }
                                    %>
                                    <tr>
                                        <td class="product-col">
                                            <img src="../item/img/${item.item_no}/${item.mainpicurl}" alt="">
                                            <div class="pc-title">
                                                <h4>${item.name}</h4>
                                                <p><fmt:formatNumber value="${item.price}" pattern="###,###" /> 원</p>
                                            </div>
                                        </td>
                                        <td class="quy-col">
                                            <div class="quantity">
                                                <form name="f" method="post" action="update.shop">
                                                    <div class="pro-qty">
                                                        <input type="number" name="quantity" value="${basket.quantity}">
                                                    </div>
                                                    <input type="hidden" name="item_no" value="${item.item_no}">
                                                    <input type="submit" class="site-btn sb-dark" value="변경"
                                                           style="width: 50px; height: 20px; padding: 5px 0 20px; font-size: 12px; margin-left: 10px; margin-top: 6px">
                                                </form>
                                            </div>
                                        </td>
                                        <td class="total-col"><h4><fmt:formatNumber value="${item.price * basket.quantity}" pattern="###,###" /> 원</h4></td>
                                    </tr>
                                    <c:set var="total" value="${total + item.price * basket.quantity}" />
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="total-cost">
                        <h6>합 계 <span><fmt:formatNumber value="${total}" pattern="###,###" /> 원</span></h6>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 card-right">
                <a href="" class="site-btn" style="font-size: 20px">주문 하기</a>
                <a href="" class="site-btn sb-dark" style="font-size: 20px">쇼핑 계속하기</a>
            </div>
        </div>
    </div>
</section>
<!-- cart section end -->

<!-- Related product section -->
<section class="related-product-section">
    <div class="container">
        <div class="section-title text-uppercase">
            <h2>Continue Shopping</h2>
        </div>
        <div class="row">
            <div class="col-lg-3 col-sm-6">
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
            </div>
            <div class="col-lg-3 col-sm-6">
                <div class="product-item">
                    <div class="pi-pic">
                        <img src="./img/product/5.jpg" alt="">
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
            <div class="col-lg-3 col-sm-6">
                <div class="product-item">
                    <div class="pi-pic">
                        <img src="./img/product/9.jpg" alt="">
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
            <div class="col-lg-3 col-sm-6">
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
            </div>
        </div>
    </div>
</section>
<!-- Related product section end -->
</body>
</html>
