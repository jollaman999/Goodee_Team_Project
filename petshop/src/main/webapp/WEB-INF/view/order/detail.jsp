<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>주문 확정</title>
</head>
<body>	 
<!-- checkout section  -->
<h2>${loginMember.name}님이주문하신 정보입니다.</h2> 
 
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
                            <input type="text" name="name" placeholder="구매자" value="${loginMember.name}">
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
                    </div>
                    </form>
                    </div>
                    </div></div>
   </section>                    
	
	<h2>주문 완료 상품 목록</h2>
	<!-- cart section -->
	<section class="cart-section" style="margin-top: 90px">
    <div class="container">
        <div class="row">
            <div style="width: 100%">
                <div class="cart-table">                    
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
                                <c:forEach items="${sale.itemList}" var="saleItem" varStatus="stat">
                                    <c:set var="item_no" value="${basket.item_no}" />                                  	
                                    <tr>
                                        <td class="product-col">
                                            <a href="${path}/shop/detail.shop?item_no=${item.item_no}">
                                                <img src="${path}/item/img/${item.item_no}/${item.mainpicurl}" alt="">
                                            </a>
                                            <div class="pc-title">
                                                <a href="${path}/shop/detail.shop?item_no=${item.item_no}">
                                                    <h4>${saleItem.item.name}</h4>
                                                </a>
                                                <p><fmt:formatNumber value="${saleItem.item.price}" pattern="###,###" /> 원</p>
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
                        <h6>합 계 <span><fmt:formatNumber value="${total}" pattern="###,###" /> 원</span></h6><br>
                        <h6>총 구입 금액<span><fmt:formatNumber value="${total}" pattern="###,###" /> 원</span></h6>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- cart section end -->
	<h2>주문 완료 상품 목록</h2>
	<table>
		<tr>
			<th>상품명</th>
			<th>가격</th>
			<th>수량</th>
			<th>합계</th>
		</tr>
		<c:forEach items="${sale.itemList}" var="saleItem" varStatus="stat">
			<tr>
				<td>${saleItem.item.name}</td>
				<td>${saleItem.item.price}</td>
				<td>${saleItem.quantity}</td>
				<td>${saleItem.item.price *saleItem.quantity}</td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="4" align="right">총 구입 금액 : <fmt:formatNumber
					value="${tot}" pattern="###,###" />원
			</td>
		</tr>
		<tr>
			<td colspan="4"><a href="../item/list.shop">상품 목록</a>&nbsp;</td>
		</tr>
	</table>
</body>
</html>