<%@ page import="org.springframework.web.context.ContextLoader" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="dao.ItemDao" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>주문 하기</title>

    <script type="text/javascript">
        function onlyNumber() {
            if(((event.keyCode < 48) || (event.keyCode > 57)) && (event.keyCode != 189) && (event.keyCode != 8)) {
                event.returnValue = false;
                alert("숫자와 대쉬(-)만 입력하세요!");
            }
        }

        function checkout_submit() {
            f = document.checkout;

            if (!f.name.value || f.name.value === "") {
                alert("이름을 입력해주세요!");
                f.name.focus();
                return;

            }

            if (!f.phone.value) {
                alert("전화번호를 입력해주세요!");
                f.phone.focus();
                return;

            }

            if (!f.address.value) {
                alert("주소를 입력해주세요!");
                f.address.focus();
                return;

            }

            if (f.deposit_bank_select.value == 0) {
                alert("입금하실 은행을 선택해 주세요!");
                f.deposit_bank_select.focus();
                return;

            }

            f.submit();
        }
    </script>

    <!-- change phone input format -->
    <script type="text/javascript" src="${path}/js/phone_format.js"></script>

    <!-- kakao address API -->
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script>
        //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function (data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var roadAddr = data.roadAddress; // 도로명 주소 변수

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('postcode').value = data.zonecode;
                    document.getElementById("address").value = roadAddr;
                }
            }).open();
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
        <h4>Checkout</h4>
        <div class="site-pagination">
            <a href="${path}/index.jsp">Home</a> /
            <a href="${path}/basket/checkout.shop">Checkout</a>
        </div>
    </div>
</div>
<!-- Page info end -->

<!-- cart section -->
<section class="cart-section" style="margin-top: 90px">
    <div class="container">
        <div class="row">
            <div style="width: 100%">
                <div class="cart-table">
                    <h3>주문할 상품 목록</h3>
                    <div class="cart-table-warp">
                        <table>
                            <thead>
                            <tr>
                                <th style="font-size: 16px; width: 58%">상품</th>
                                <th style="font-size: 16px; width: 22%">수량</th>
                                <th style="font-size: 16px; width: 20%">가격</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:set var="total" value="0" />
                                <c:forEach items="${checkoutList}" var="basket">
                                    <c:set var="item_no" value="${basket.item_no}" />
                                    <%
                                        if (itemDao != null && pageContext.getAttribute("item_no") != null) {
                                            pageContext.setAttribute("item", itemDao.selectOne((Integer)pageContext.getAttribute("item_no")));
                                        }
                                    %>
                                    <tr>
                                        <td class="product-col">
                                            <a href="${path}/shop/detail.shop?item_no=${item.item_no}">
                                                <img src="${path}/item/img/${item.item_no}/${item.mainpicurl}" alt="">
                                            </a>
                                            <div class="pc-title">
                                                <a href="${path}/shop/detail.shop?item_no=${item.item_no}">
                                                    <h4>${item.name}</h4>
                                                </a>
                                                <p><fmt:formatNumber value="${item.price}" pattern="###,###" /> 원</p>
                                            </div>
                                        </td>
                                        <td class="quy-col">
                                            <div class="quantity">
                                                <c:choose>
                                                    <c:when test="${!empty items}">
                                                        <form name="f" method="post" action="update.shop">
                                                            <div class="pro-qty">
                                                                <input type="text" name="quantity" value="${basket.quantity}" onkeydown="onlyNumber()">
                                                            </div>
                                                            <input type="hidden" name="item_no" value="${item.item_no}">
                                                            <input type="submit" class="site-btn sb-dark" value="변경"
                                                                   style="width: 50px; height: 20px; padding: 5px 0 20px; font-size: 12px; margin-left: 10px; margin-top: 6px">
                                                        </form>
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${basket.quantity}
                                                    </c:otherwise>
                                                </c:choose>
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
        </div>
    </div>
</section>
<!-- cart section end -->

<!-- checkout section  -->
<section class="checkout-section spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-8 order-2 order-lg-1">
                <form class="checkout-form" name="checkout" action="order.shop" method="post">
                    <input type="hidden" name="items" value="${items}">
                    <input type="hidden" name="item_no" value="${param.item_no}">
                    <input type="hidden" name="quantity" value="${param.quantity}">
                    <input type="hidden" name="price_total" value="${total + 3000}">

                    <div class="cf-title">배송지 정보</div>
                    <div class="row address-inputs">
                        <div class="col-md-6">
                            <input type="text" name="name" placeholder="배송받는 분" value="${loginMember.name}">
                        </div>
                        <div class="col-md-12">
                            <input type="text" name="address" id="address" placeholder="주소"
                                   value="${loginMember.address}" onclick="execDaumPostcode()">
                            <input type="text" name="address_detail" placeholder="상세 주소" value="${loginMember.address_detail}">
                        </div>
                        <div class="col-md-6">
                            <input type="text" name="postcode" id="postcode" placeholder="우편 번호"
                                   onkeydown="onlyNumber()" value="${loginMember.postcode}">
                        </div>
                        <div class="col-md-6">
                            <input type="text" name="phone" placeholder="휴대 전화 번호"
                                   onkeyup="inputPhoneNumber(this)" onkeydown="onlyNumber()" maxlength="13" value="${loginMember.phone}">
                        </div>
                        <div class="col-md-6">
                            <input type="text" name="phone2" placeholder="전화 번호 (옵션)"
                                   onkeyup="inputPhoneNumber(this)" onkeydown="onlyNumber()" maxlength="13">
                        </div>
                    </div>
                    <div class="cf-title">결제 정보</div>
                    <ul class="payment-list" style="margin-left: 20px">
                        <div style="margin-bottom: 30px">
                            <li>입금할 은행 선택</li>
                            <select name="deposit_bank_select" style="width: 400px">
                                <option value="0">입금하실 은행을 선택해 주세요.</option>
                                <c:forEach items="${depositList}" var="deposit">
                                    <option value="${deposit.num}">${deposit.account_bank} : ${deposit.account_number}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <li>
                            입급하시는 분 성함
                            <input type="text" name="account_holder" placeholder="성함">
                        </li>
                        <li>
                            입금하시는 분 계좌 번호
                            <input type="text" name="account_bank" placeholder="은행 명">
                            <input type="text" name="account_number" placeholder="계좌 번호">
                        </li>

                        <div style="color: red; font-size: 10pt">입금하시는 분 성함과 계좌번호는 환불요청시 해당 계좌로 입금해 드리는데 사용됩니다.</div>
                    </ul>
                    <a href="javascript:checkout_submit()" class="site-btn submit-order-btn">주문 하기</a>
                </form>
            </div>
            <div class="col-lg-4 order-1 order-lg-2">
                <div class="checkout-cart">
                    <h3>총 가격</h3>
                    <ul class="price-list">
                        <li>상품 총 가격<span><fmt:formatNumber value="${total}" pattern="###,###" /> 원</span></li>
                        <li>배송비<span>3,000 원</span></li>
                        <li class="total">합계<span><fmt:formatNumber value="${total + 3000}" pattern="###,###" /> 원</span></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- checkout section end -->
</body>
</html>