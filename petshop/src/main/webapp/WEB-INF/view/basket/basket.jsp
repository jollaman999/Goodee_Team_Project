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
    <title>장바구니</title>

    <script type="text/javascript">
        Number.prototype.format = function(){
            if(this == 0) return 0;

            var reg = /(^[+-]?\d+)(\d{3})/;
            var n = (this + '');

            while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');

            return n;
        };

        function calculate_total() {
            var chks = document.getElementsByName("itemchks");
            var prices = document.getElementsByName("price");
            var quantities = document.getElementsByName("quantity");
            var total = 0;

            for (var i = 0; i < chks.length; i++) {
                if (chks[i].checked) {
                    total += prices[i].value * quantities[i].value;
                }
            }

            document.getElementById("total").innerHTML = "<h6>합 계 <span>" + total.format() + " 원</span></h6>";
        }

        function allchkbox(allchk) {
            var chks = document.getElementsByName("itemchks");
            for (var i = 0; i < chks.length; i++) {
                chks[i].checked = allchk.checked;
            }

            calculate_total();
        }

        let items;

        function parse_selected_items() {
            items = "";

            var chks = document.getElementsByName("itemchks");
            var checked = false;

            for (var i = 0; i < chks.length; i++) {
                if (chks[i].checked) {
                    items += chks[i].value + ",";
                    checked = true;
                }
            }

            if (checked) {
                items = items.substr(0, items.length - 1);
            }
        }

        function delete_items() {
            parse_selected_items();
            location.href = "delete.shop?items=" + items;
        }

        function order_items() {
            parse_selected_items();
            location.href = "checkout.shop?items=" + items;
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
        <h4>Your cart</h4>
        <div class="site-pagination">
            <a href="${path}/index.jsp">Home</a> /
            <a href="${path}/basket/view.shop">Your cart</a>
        </div>
    </div>
</div>
<!-- Page info end -->

<!-- cart section -->
<section class="cart-section spad">
    <div class="container">
        <div class="row">
            <div style="width: 80%; padding-right: 30px">
                <div class="cart-table">
                    <h3>장바구니 목록</h3>
                    <div class="cart-table-warp">
                        <table>
                            <thead>
                            <tr>
                                <th style="padding-top: 10px"><input type="checkbox" name="allchk" onchange="allchkbox(this)" style="margin-right: 5px" checked></th>
                                <th style="font-size: 16px; width: 50%">상품</th>
                                <th style="font-size: 16px; width: 22%">수량</th>
                                <th style="font-size: 16px; width: 8%">삭제</th>
                                <th style="font-size: 16px; width: 20%">가격</th>
                            </tr>
                            </thead>
                            <tbody>
                                <c:set var="total" value="0" />
                                <c:choose>
                                    <c:when test="${basketList != null && !basketList.isEmpty()}">
                                        <c:forEach items="${basketList}" var="basket">
                                            <c:set var="item_no" value="${basket.item_no}" />
                                            <%
                                                if (itemDao != null && pageContext.getAttribute("item_no") != null) {
                                                    pageContext.setAttribute("item", itemDao.selectOne((Integer)pageContext.getAttribute("item_no"), false));
                                                }
                                            %>
                                            <tr>
                                                <td style="text-align: center">
                                                    <input type="checkbox" name="itemchks" value="${basket.item_no}"
                                                           style="margin-right: 5px; margin-bottom: 23px" checked onclick="calculate_total()">
                                                </td>
                                                <td class="product-col">
                                                    <a href="${path}/shop/detail.shop?item_no=${item.item_no}">
                                                        <img src="${path}/item/img/${item.item_no}/${item.mainpicurl}" alt="">
                                                    </a>
                                                    <div class="pc-title">
                                                        <a href="${path}/shop/detail.shop?item_no=${item.item_no}">
                                                            <h4>${item.name}</h4>
                                                        </a>
                                                        <input type="hidden" name="price" value="${item.price}">
                                                        <p><fmt:formatNumber value="${item.price}" pattern="###,###" /> 원</p>
                                                    </div>
                                                </td>
                                                <td class="quy-col">
                                                    <div class="quantity">
                                                        <form name="quantity_form_${basket.item_no}" method="post" action="update.shop">
                                                            <div class="pro-qty">
                                                                <input type="number" id="quantity_${basket.item_no}" name="quantity" value="${basket.quantity}"
                                                                        min="0" pattern="[0-9]*">
                                                            </div>
                                                            <input type="hidden" name="item_no" value="${item.item_no}">
                                                            <input type="button" class="site-btn sb-dark" value="변경" onclick="check_quantity_${basket.item_no}()"
                                                                   style="width: 50px; height: 20px; padding: 5px 0 20px; font-size: 12px; margin-left: 10px; margin-top: 6px">
                                                        </form>
                                                    </div>
                                                </td>
                                                <td class="size-col">
                                                    <form name="delete_form_${basket.item_no}" method="post" action="delete.shop">
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
                                            <td colspan="5">
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
                    <div class="total-cost" id="total">
                        <h6>합 계 <span><fmt:formatNumber value="${total}" pattern="###,###" /> 원</span></h6>
                    </div>
                </div>
            </div>
            <div class="card-right" style="width: 20%">
                <div style="margin-bottom: 20px; text-align: center">
                    <h4>선택한 상품을</h4>
                </div>
                <input type="button" class="site-btn" style="font-size: 18px; min-width: 160px; padding-left: 15px;
                            padding-right: 15px; padding-bottom: 22px" value="주문 하기" onclick="order_items()">
                <input type="button" class="site-btn" style="font-size: 18px; min-width: 160px; padding-left: 15px;
                            padding-right: 15px; padding-bottom: 22px" value="삭제 하기" onclick="delete_items()">
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
                            <%
                                Item item = (Item) pageContext.getAttribute("item");
                                if (itemDao != null && item != null && itemDao.check_new(null, null, item.getItem_no())) { %>
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
                            </div>
                        </div>
                        <div class="pi-text">
                            <h6><fmt:formatNumber value="${item.price}" pattern="###,###" />원</h6>
                            <a href="${path}/shop/detail.shop?item_no=${item.item_no}">
                                <p>${item.name}</p>
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>
<!-- Related product section end -->

<c:if test="${basketList != null && !basketList.isEmpty()}">
    <script type="text/javascript">
        <c:forEach items="${basketList}" var="basket">
            <c:set var="item_no" value="${basket.item_no}" />
            <%
                if (itemDao != null && pageContext.getAttribute("item_no") != null) {
                    pageContext.setAttribute("item", itemDao.selectOne((Integer)pageContext.getAttribute("item_no"), true));
                }
            %>

            function check_quantity_${basket.item_no}() {
                var quantity = parseInt(document.getElementById("quantity_${basket.item_no}").value);

                if (quantity > ${item.remained_quantity}) {
                    alert("입력 하신 수량이 주문 가능 수량 보다 많습니다!");
                    return;
                }

                document.quantity_form_${basket.item_no}.submit();
            }
        </c:forEach>
    </script>
</c:if>

<script type="text/javascript">
    <c:forEach var="item" items="${randomitemList}">
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
