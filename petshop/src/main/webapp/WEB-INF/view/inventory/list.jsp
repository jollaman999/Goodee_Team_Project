<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">

    <script type="text/javascript">
        function listcall(page) {
            document.f.pageNum.value = page;
            document.f.submit();
        }

        function limitcall() {
            document.f.submit();
        }
    </script>

    <link rel="stylesheet" type="text/css" href="${path}/css/w3.css">

    <style>
        .header:hover, .listcall-area:hover {
            background: #ffffff;
        }

        a {
            color: #000000;
        }

        a:hover {
            color: #7d858b;
        }
    </style>

   <title>상품 관리&등록 </title>
</head>
<body>

<!-- 제목 -->
<h2>
    <a href="${path}/inventory/list.shop">상품 관리</a>&nbsp;&nbsp;
    <a href="${path}/item/create.shop?pageNum=${param.pageNum}">상품등록</a>
</h2><br>

<!-- 재고관리 리스트 -->
<table>
    <tr class="header">
        <td colspan="9">
            <input type="hidden" name="pageNum" value="${pageNum}">
            <div style="width: 100%">
                <select name="searchtype" style="height: 30px; margin-right: 5px">
                    <option value="">선택하세요</option>
                    <option value="#">그룹코드</option>
                    <option value="#">아이템코드</option>
                    <option value="#">국가별</option>
                </select>
                <input type='text' name='word' value='' placeholder="특수문자는 사용할수 없습니다." style="width: 50%; height: 30px; margin-right: 5px">
                <button type='submit' class="w3-button w3-dark-gray" style="font-size: 14px; margin-bottom: 4px">검색</button>
            </div>

            <div style="text-align: right; margin-top: 10px">
                표시할 상품 갯수&nbsp;&nbsp;
                    <select name="limit" onchange="limitcall()">
                        <option value="10">10</option>
                        <option value="20">20</option>
                        <option value="30">30</option>
                        <option value="40">40</option>
                        <option value="50">50</option>
                        <script>
                            document.f.limit.value = "${limit}";
                        </script>
                    </select>

                &nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;상품 갯수 : ${listcount}
            </div>
        </td>
    </tr>

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
        <th style="width: 9%">수량 추가</th>
    </tr>

<!--  현재 수량   선언 -->
<c:set var="nowquantity" value="${0}"/>

    <!-- 아이템 리스트 가져오기 -->
    <c:forEach items="${itemList}" var="item">
        <!-- 테이블 바 value-->
        <tr>
           <td>
            <a href="../inventory/detail.shop?item_no=${item.item_no}&pageNum=${pageNum}">${item.name}</a>
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
            <fmt:formatNumber type="CURRENCY" pattern="###,###" value="${item.price}"/>
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
            <td style="padding: 2px">
                <form id="itemUpdate_${item.item_no}" action="listsubmit.shop" method="post">
                    <input type="hidden" name="item_no" value="${item.item_no}">
                    <input type="hidden" name="pageNum" value="${param.pageNum}">

                    <div class="row" style="width: 150px; height:auto; text-align: center; margin-left: 22px">
                            <input type="number" name="itemUpdate" style="width: 50px; font-size: 15px; margin-right: 10px">
                            <input type="submit" value="적용" style="font-size: 15px; ">
                    </div>
                </form>
            </td>
        </tr>
    </c:forEach>
    <tr class="listcall-area">
        <td colspan="9">
            <%-- 페이지 처리 부분 --%>
            <div class="w3-center" style="margin-top: 6px">
                <div class="w3-bar">
                    <c:choose>
                        <c:when test="${pageNum <= 1}">
                            <div class="w3-bar-item">«</div>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:listcall(${pageNum - 1})" class="w3-bar-item w3-button w3-hover-deep-purple">«</a>
                        </c:otherwise>
                    </c:choose>
                    <c:forEach var="a" begin="${startpage}" end="${endpage}">
                        <c:choose>
                            <c:when test="${a == pageNum}">
                                <div class="w3-bar-item w3-deep-purple">
                                        ${a}
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a href="javascript:listcall(${a})" class="w3-bar-item w3-button w3-hover-deep-purple">${a}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:choose>
                        <c:when test="${pageNum >= endpage}">
                            <div class="w3-bar-item">»</div>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:listcall(${pageNum + 1})" class="w3-bar-item w3-button w3-hover-deep-purple">»</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </td>
    </tr>
</table>
</body>
</html>

