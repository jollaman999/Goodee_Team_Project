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

   <title>상품 관리 게시판 </title>
</head><body>


<!-- 제목 --> <!-- 상품등록  -->   
<h2 style="color:black;"><a href="${path}/inventory/list.shop">상품 관리</a>&nbsp;&nbsp;<a href="${path}/item/create.shop">상품등록</a></h2><br>


 
<!-- 재고관리 리스트 -->
<form action="InventoryManagement" method="post">


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
           <td>
           <a href="../inventory/detail.shop?item_no=${item.item_no}" style="color:black">${item.name}</a>          
           </td>


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
            <td>${item.sold_quantity}</td>
            
            <!-- 남은수량 -->
            <td>${item.remained_quantity}</td>
            
            
            <!-- 수량 추가 -->            
            <td>
            <!-- submit 넘기기 히든값으로 컨트롤러 이름과 매칭되어있음.  -->
            <form id="itemUpdate" action="listsubmit.shop" method="post">
            <div><input type="number" id="itemUpdate" name="itemUpdate"><input type="submit" value="추가"></div>
            <input type="hidden" name="item_no" value="${item.item_no}">
            </form>
            </td>
            
     </c:forEach>                              
 </tr>

            
     


</table>  <!--  테이블 종료  -->        
</form></body></html>

