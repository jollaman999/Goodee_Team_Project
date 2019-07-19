<%@ page import="org.springframework.web.context.ContextLoader" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="dao.ItemDao" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>

    <script type="text/javascript">
        function onlyNumber(){
            if((event.keyCode<48)||(event.keyCode>57)) {
                event.returnValue = false;
                alert("숫자만 입력하세요!");
            }
        }
    </script>
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
            <div style="width: 80%; padding-right: 30px">
                <div class="cart-table">
                    <h3>Your Cart</h3>
                    <div class="cart-table-warp">
                        <table>
                            <thead>
                            <tr>
                                <th style="font-size: 16px; width: 50%">상품</th>
                                <th style="font-size: 16px; width: 22%">수량</th>
                                <th style="font-size: 16px; width: 8%">삭제</th>
                                <th style="font-size: 16px; width: 20%">가격</th>
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
                                <c:choose>
                                    <c:when test="${basketList != null && !basketList.isEmpty()}">
                                        <c:forEach items="${basketList}" var="basket">
                                            <c:set var="item_no" value="${basket.item_no}" />
                                            <%
                                                if (itemDao != null && pageContext.getAttribute("item_no") != null) {
                                                    pageContext.setAttribute("item", itemDao.selectOne((Integer)pageContext.getAttribute("item_no")));
                                                }
                                            %>
                                            <tr>
                                                <td class="product-col">
                                                    <img src="${path}/item/img/${item.item_no}/${item.mainpicurl}" alt="">
                                                    <div class="pc-title">
                                                        <h4>${item.name}</h4>
                                                        <p><fmt:formatNumber value="${item.price}" pattern="###,###" /> 원</p>
                                                    </div>
                                                </td>
                                                <td class="quy-col">
                                                    <div class="quantity">
                                                        <form name="f" method="post" action="update.shop">
                                                            <div class="pro-qty">
                                                                <input type="text" name="quantity" value="${basket.quantity}" onkeydown="onlyNumber()">
                                                            </div>
                                                            <input type="hidden" name="item_no" value="${item.item_no}">
                                                            <input type="submit" class="site-btn sb-dark" value="변경"
                                                                   style="width: 50px; height: 20px; padding: 5px 0 20px; font-size: 12px; margin-left: 10px; margin-top: 6px">
                                                        </form>
                                                    </div>
                                                </td>
                                                <td class="size-col">
                                                    <form name="f" method="post" action="delete.shop">
                                                        <input type="hidden" name="item_no" value="${item.item_no}">
                                                        <input type="submit" class="site-btn" value="삭제"
                                                               style="width: 50px; height: 20px; padding: 5px 0 20px; font-size: 12px;
                                                       margin-left: 10px; margin-top: 6px; background-color: #f51167">
                                                    </form>
                                                </td>
                                                <td class="total-col"><h4><fmt:formatNumber value="${item.price * basket.quantity}" pattern="###,###" /> 원</h4></td>
                                            </tr>
                                            <c:set var="total" value="${total + item.price * basket.quantity}" />
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="4">
                                                <div style="text-align: center">
                                                    <h5>장바구니에 담긴 상품이 없습니다.</h5>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                    <div class="total-cost">
                        <h6>합 계 <span><fmt:formatNumber value="${total}" pattern="###,###" /> 원</span></h6>
                    </div>
                </div>
            </div>
            <div class="card-right" style="width: 20%">
                <a href="" class="site-btn" style="font-size: 18px; min-width: 160px; padding-left: 15px;
                        padding-right: 15px; padding-bottom: 22px">주문 하기</a>
                <a href="" class="site-btn sb-dark" style="font-size: 18px; min-width: 160px; padding-left: 15px;
                        padding-right: 15px; padding-bottom: 22px">쇼핑 계속하기</a>
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
            <c:forEach var="item" items="${randomitemList}">
                <div class="col-lg-4 col-sm-6">
                    <div class="product-item">
                        <div class="pi-pic">
                            <!-- DB 쿼리 조회하여 최근에 등록 된 상품 있을시에만 New 표시하도록 수정 -->
                            <div class="tag-new">new</div>
                            <div style="height: 420px">
                                <img src="${path}/item/img/${item.item_no}/${item.mainpicurl}" alt="">
                            </div>
                            <div class="pi-links">
                                <a href="${path}/basket/add.shop?item_no=${item.item_no}" class="add-card"><i class="flaticon-bag"></i><span>ADD TO CART</span></a>
                                <a href="#" class="wishlist-btn" style="width: 80px"><i class="flaticon-heart"></i><span style="font-size: 12pt">&nbsp;123</span></a>
                            </div>
                        </div>
                        <div class="pi-text">
                            <h6>${item.price}원</h6>
                            <p>${item.name}</p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>
<!-- Related product section end -->
</body>
</html>
