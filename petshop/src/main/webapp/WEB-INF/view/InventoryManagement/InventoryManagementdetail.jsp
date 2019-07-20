<!-- 재고관리  -->


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>재고관리 게시판 </title>
    
<!--  페이지 리스트   -->
   <script type="text/javascript">
        function listcall(page) {
            document.searcform.pageNum.value = page;
            document.searcform.submit();
        }
    </script></head><body>

<!-- 제목 -->
<h2>재고관리</h2><br>


 
<!-- 재고관리 리스트 -->
<form action="InventoryManagement" method="post">
<!-- 서치  -->
<table>
 <tr><td colspan="5"><form action="InventoryManagement" method="post" name="searchform">
     <input type="hidden" name="pageNum" value="1">
     <select name="searchtype">
       <option value="">선택하세요</option>
       <option value="#">그룹코드</option>
       <option value="#">아이템코드</option>
       <option value="#">국가별</option>
     </select>
      <input type='text' name='word' value='' placeholder="특수문자는 사용할수 없습니다.">
      <button type='submit'>검색</button>
       
 </form></td></tr></table> 
 
 <table>
    
        
<!-- 테이블 바 이름 -->        
        <tr>               
            <th>최신등록</th>    
            <th>No</th>    
            <th>GroupCode</th>
            <th>ItemCode</th>
            <th>Product name</th>
            <th>&nbsp;Price&nbsp;</th>
            <th>Origin</th><!-- 원산지 -->
            <th>Company</th><!-- 제조사 -->
            <th>Tel</th><!-- 제조사 연락처 -->
            <th>Expiration Date</th><!-- 유통기한 -->
            <th>등록량</th><!-- 현재고 -->
            <th>판매량</th>
            <th>현재수량</th>
            <th>&nbsp;</th>
            
                                    
<!--  현재 수량   선언 -->
<c:set var="nowquantity" value="${0}"/>  

<!-- 아이템 리스트 가져오기 -->
<c:forEach items="${itemList}" var="item"> 
            
        <!-- 테이블 바 value-->   
        <tr>
            <td><fmt:formatDate value="${item.update_time}" pattern="yyyy-MM-dd"/></td>
            <td>${item.item_no}</td>
            <td>${item.category_group_code}</td>
            <td>${item.category_item_code}</td>
            <td>${item.name}</td>
         
            <td>
            <fmt:formatNumber type="CURRENCY" pattern="###,###" value="${item.price}"/>\
            </td>
            <td>${item.origin}</td>
            <td>${item.mfr}</td>
            <td>${item.mfr_tel}</td>
            <td><fmt:formatDate value="${item.expr_date}" pattern="yyyy-MM-dd"/></td>
            <!--  등록량 -->
            <td>${item.quantity}</td>
            
            <!-- 현재수량  = 0 + 등록량   
            <c:set var="nowquantity" value="${nowquantity + item.quantity}"/>  -->
            
            <!-- 판매량  -->          
            <td><c:forEach items="${sale.itemList}" var="saleItem" varStatus="stat">
            ${saleItem.quantity}</c:forEach></td>
            
            <!-- 현재수량  = 등록량  - 판매량   -->
            <c:set var="nowquantity" value="${item.quantity - saleItem.quantity}"/> 
            
            <!-- 현 수량 출력 -->
            <td>${nowquantity}</td>
            <td><a href="#">수정</a></td>  
         </c:forEach>                              
 </tr>


</table>  <!--  테이블 종료  -->
  
<!-- 페이지 넘기기 --> 
<table>         
<tr>
   <td colspan="5">
     <c:if test="${pageNum > 1}">
        <a href="list.shop?pageNum=${pageNum - 1}">[이전]</a>
     </c:if>
     <c:if test="${pageNum <= 1}">[이전]</c:if>
        <c:forEach var="a" begin="${startpage}" end="${endpage}">
     <c:choose>
     <c:when test="${a == pageNum}">[${a}]</c:when>
     <c:otherwise><a href="list.shop?pageNum=${a}">[${a}]</a> </c:otherwise>
     </c:choose>
     </c:forEach>
     <c:if test="${pageNum < maxpage}">
     <a href="list.shop?pageNum=${pageNum + 1}">[다음]</a>
     </c:if>
     <c:if test="${pageNum >= maxpage}">[다음]</c:if>
    </td>
</tr>
</table>        
       
        
</form></body></html>

