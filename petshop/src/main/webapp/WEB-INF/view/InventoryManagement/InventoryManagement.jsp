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
     <div style="text-align:right"><select name="searchtype" float="left">
       <option value="">선택하세요</option>
       <option value="#">그룹코드</option>
       <option value="#">아이템코드</option>
       <option value="#">국가별</option>
     </select></div>

      <input type='text' name='word' value='' placeholder="특수문자는 사용할수 없습니다.">
      <button type='submit'>검색</button>
      <input type="button" value="상세보기" onclick="location.href='InventoryManagementdetail.shop'">     
 </form></td></tr></table> 
 
 <table>
    
        
<!-- 테이블 바 이름 -->        
        <tr>
            <th>제품이름</th>   
            <th>그룹명</th>
            <th>카테고리명</th>        
            <th>&nbsp;가격&nbsp;</th>
            <th>유통기한</th><!-- 유통기한 -->
            <th>등록량</th><!-- 현재고 -->
            <th>판매량</th>
            <th>현재수량</th>      
            <th>수량추가</th>
                                    
<!--  현재 수량   선언 -->
<c:set var="nowquantity" value="${0}"/>  



<!-- 아이템 리스트 가져오기 -->
<c:forEach items="${itemList}" var="item"> 

        <!-- 테이블 바 value-->   
        <tr>
           <td>${item.name}</td> 
           
            <!-- 그룹명 -->
            <td>
	            <c:forEach items="${CategoryGroupList}" var="CategoryGroup">
	              <c:if test="${CategoryGroup.group_code eq item.category_group_code}">
	              <c:out value="${CategoryGroup.group_name}" />
	              </c:if>	
	            </c:forEach>
            </td>
            
            <!-- 카테고리 명  -->
            <td>
            	<c:forEach items="${CategoryItemList}" var="CategoryItem">
	              <c:if test="${CategoryItem.group_code eq item.category_group_code}">
	              	<c:if test="${CategoryItem.code eq item.category_item_code}">
	              		<c:out value="${CategoryItem.name}" />
	              	</c:if>
	              </c:if>
	            </c:forEach>
            </td>
            
            <!--  가격   -->
            <td>
            <fmt:formatNumber type="CURRENCY" pattern="###,###" value="${item.price}"/>\
            </td>
            
            <!-- 유통기한 -->
            <td><fmt:formatDate value="${item.expr_date}" pattern="yyyy-MM-dd"/></td>
            
            
            <!--  등록량 -->
            <td>${item.quantity}</td>
            
            
            <!-- 판매량  -->                 
                 <td>
            	<c:forEach items="${Orders_listList}" var="Orders_list">
	              		<c:out value="${Orders_listList.quantity}" />
	            </c:forEach>
            </td>
            
            <!-- 현재수량  = 등록량  - 판매량   -->
            <c:set var="nowquantity" value="${item.quantity - saleItem.quantity}"/> 
            
            <!-- 현 수량 출력 -->
            <td>${nowquantity}</td>
            
            <!-- 수량 추가 -->  
            <td>
            <form id="#" action="#">
            <div><input type="number" id="usernumber" name="usernumber"><input type="submit" value="전송"></div>
            </form>
            </td>
            
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

