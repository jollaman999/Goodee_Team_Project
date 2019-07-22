<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품상세 보기</title>
</head>
<body>
<table>
    <tr>
        <td>
            <img src="${path}/item/img/${item.item_no}/${item.mainpicurl}">
        </td>
        <td>
        
            <table>         
                <tr>
                    <td>상품명</td>
                    <td>${item.name}</td>
                </tr>
                
                   <tr>
                    <td>카테고리 그룹</td>
                    <td>
	                <c:forEach items="${CategoryGroupList}" var="CategoryGroup">
	                <c:if test="${CategoryGroup.group_code eq item.category_group_code}">
	                <c:out value="${CategoryGroup.group_name}" />
	                </c:if>	
	                </c:forEach>
                    </td>
                </tr>
                    
                  <tr>
                    <td>아이템 그룹</td>
                    <td>
            	    <c:forEach items="${CategoryItemList}" var="CategoryItem">
	                <c:if test="${CategoryItem.group_code eq item.category_group_code}">
	              	<c:if test="${CategoryItem.code eq item.category_item_code}">
	                <c:out value="${CategoryItem.name}" />
	              	</c:if>
	                </c:if>
	                </c:forEach>
                    </td>
                  </tr>
                  
                <tr>
                    <td>제조사</td>
                    <td>${item.mfr}</td>
                </tr>
                
                <tr>
                    <td>제조사 연락처</td>
                    <td>${item.mfr_tel}</td>
                </tr>
                
                <tr>
                    <td>유통기한</td>
                   <td><fmt:formatDate value="${item.expr_date}" pattern="yyyy-MM-dd"/></td>
                </tr>
                
                 <tr>
                    <td>원산지</td>
                    <td>${item.origin}</td>
                </tr>
                  
                <tr>
                    <td>상품설명</td>
                    <td>${item.description}</td>
                </tr>               
                
                
                <tr>
                    <td>가격</td>
                    <td><fmt:formatNumber type="CURRENCY" pattern="###,###" value="${item.price}"/></td>
                </tr>
                
                
                <tr>
                    <td>수량</td>
                    <td>${item.quantity}</td>  
                </tr>                
                <tr>
                    <td colspan="2">
                        <form action="../inventory/detail.shop">
                            <input type="hidden" name="name" value="${item.name}">
                            <table>
                                <tr>                                     
                                    <td>                                        
                                        <input type="button" value="리스트로 가기" onclick="location.href='list.shop'">
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>
