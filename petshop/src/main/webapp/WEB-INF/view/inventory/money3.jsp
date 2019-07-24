<!-- orders.mapper 쿼리작성    orders dao 에서 선언. 컨트롤러에서 멤버호출후 객체 생성.    -->


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

  
<title>판매 내역 </title>
</head><body>

<h2 style="color:black;"><a href="${path}/inventory/money.shop">요일별</a>&nbsp;&nbsp;
                         <a href="${path}/inventory/money2.shop">월별</a>&nbsp;&nbsp;
                         <a href="${path}/inventory/money3.shop">년별</a>&nbsp;&nbsp;
                         <a href="${path}/inventory/money4.shop">상품별</a>                         
                         </h2><br><br><br> 
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
</table><br><br><br><br><br><br>



<!-- 년별 판매현황 -->
<h2>년별 수익</h2><br>
<table>       
<!-- 테이블 바 이름 -->        
        <tr>
            <th>년도</th>
            <th>총판매금</th>
<!-- 아이템 리스트 가져오기 -->
<c:forEach items="${moneyListYear}" var="moneyYear">
     <tr>   
     <td><fmt:formatDate value="${moneyYear.update_time}" pattern="yyyy"/>년</td>       
     <td><fmt:formatNumber type="CURRENCY" pattern="###,###" value="${moneyYear.price_total}"/>\</td>
    </tr></c:forEach></tr>                         
</table>
</form></body></html>

