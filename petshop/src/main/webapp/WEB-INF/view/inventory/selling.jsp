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
    
    <!-- jQuery -->
    <script type="text/javascript" src="${path}/js/phone_format.js"></script>

   <title>판매 내역 </title>
</head><body>


<!-- 제목 -->   
<h2>판매 내역</h2>

 
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
                                    
<!--  현재 수량   선언 -->
<c:set var="nowquantity" value="${0}"/>  



<!-- 아이템 리스트 가져오기 -->
<c:forEach items="${Orderslist}" var="orders"> 

        <!-- 테이블 바 value-->           
         <tr>
         
         <!-- 주문번호 -->
           <td>
           <a href="#" style="color:black">${orders.num}</a>          
           </td>
                
          <!--이름 -->
           <td>${orders.name}</td>

           <td>${orders.phone}</td>
           <td>${orders.phone2}</td>
           <td>${orders.address}</td>
           <td>${orders.address_detail}</td>        
           <td>${orders.postcode}</td>
           <td>${orders.deposit_bank_select}</td>
         <script> 
           <!--  가격   -->
          function phoneFomatter(num,type) {
                alert(price_total);
            } 
         </script> 

           <td>
           ${orders.price_total}
           </td>
      
           <td>${orders.status}</td>
            
            <!-- 주문일자 -->
            <td><fmt:formatDate value="${orders.update_time}" pattern="yyyy-MM-dd"/></td>           
     </c:forEach>                              
 </tr>

            
     


</table>  <!--  테이블 종료  -->        
</form></body></html>

