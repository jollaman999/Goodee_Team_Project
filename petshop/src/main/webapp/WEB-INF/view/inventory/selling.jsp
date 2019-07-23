<!-- 재고관리  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <style> <!-- 검색창 가운데 정렬 -->
    .centeringContainer { text-align: center; } 
    .centered { display: table; margin-left: auto; margin-right: auto; display: inline-block; } 
    </style>
   
   <title>주문 내역 </title>
</head><body>


<!-- 제목 -->   
<h2>주문 내역</h2>

 
<!-- 재고관리 리스트 -->
<form action="selling" method="post">

<!-- 서치  -->
<table> 
<!-- 드랍바 -->
<tr><td>
<div class="col-xl-6 col-lg-5 centered"> 
     <input type='text' name='word' value='' placeholder="특수문자는 사용할수 없습니다." style="text-align: center">
     <button type='submit'>검색</button>   
</div></td></tr>

<table> 
     <div style="text-align:left"><select name="searchtype">
       <option value="">선택하세요</option>
       <option value="#">그룹코드</option>
       <option value="#">아이템코드</option>
       <option value="#">국가별</option>
     </select></div>    
</table> 
 
 
<table>       
<!-- 테이블 바 이름 -->        
        <tr>
            <th>주문번호</th>   
            <th>수취인명</th>   
            <th>번호</th>
            <th>번호2</th>        
            <th>주소</th>
            <th>세부주소</th>            
            <th>우편번호</th>
            <th>계좌 유형</th>
            <th>금액</th>
            <th>입금상태</th>      
            <th>날짜</th>
                                    

<!-- 아이템 리스트 가져오기 -->
<c:forEach items="${Orderslist}" var="orders"> 

        <!-- 테이블 바 value-->           
         <tr>
         
         <!-- 주문번호 -->  
           <td>
           <a href="../inventory/detail.shop?item_no=${orders.num}" style="color:black">${orders.num}</a>          
           </td>        
          <!--이름 -->
           <td>${orders.name}</td>
           <td>${orders.phone}</td>
           <td>${orders.phone2}</td>
           <td>${orders.address}</td>
           <td>${orders.address_detail}</td>        
           <td>${orders.postcode}</td>
           <td>${orders.deposit_bank_select}</td>
           <!-- 금액 -->         
           <td>
           <fmt:formatNumber type="CURRENCY" pattern="###,###" value="${orders.price_total}"/>\
           </td>
           
            <td>
            <c:choose>
            <c:when test="${orders.status==0}">입금대기중</c:when>
            <c:when test="${orders.status==1}">입금확인</c:when>
            <c:when test="${orders.status==2}">상품준비중</c:when>
            <c:when test="${orders.status==3}">발송완료</c:when>
            <c:when test="${orders.status==4}">취소접수</c:when>
            <c:when test="${orders.status==5}">취소완료</c:when>
            <c:when test="${orders.status==6}">환불접수</c:when>
            <c:when test="${orders.status==7}">환불완료</c:when>
            </c:choose></td>  
     
              
          
            <!-- 주문일자 -->
            <td><fmt:formatDate value="${orders.update_time}" pattern="yyyy-MM-dd"/></td>           
     </c:forEach>                              
 </tr>

  <!--  테이블 종료  -->                                 
</table></form></body></html>

