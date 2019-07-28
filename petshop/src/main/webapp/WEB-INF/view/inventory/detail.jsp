<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set value="${pageContext.request.contextPath}" var="path"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 정보</title>

    <!-- HighSlide -->
    <script type="text/javascript" src="${path}/vendor/highslide/highslide.js"></script>
    <link rel="stylesheet" type="text/css" href="${path}/vendor/highslide/highslide.css"/>

    <style type="text/css">
        .nohover {
            background: #ffffff;
        }
        .nohover:hover {
            background: #ffffff;
        }
    </style>
</head>
<body>
<h2>상품 정보</h2>
<br><br>
<table>
    <tr class="nohover">
        <td class="nohover">
            <a href="${path}/item/img/${item.item_no}/${item.mainpicurl}" class="highslide"
               onclick="return hs.expand(this)">
                <img class="product-big-img" src="${path}/item/img/${item.item_no}/${item.mainpicurl}" alt=""
                     onerror="this.src='${path}/img/noimg.png'">
            </a>
        </td>
        <td>

            <table>
                <tr>
                    <td style="width: 15%">상품명</td>
                    <td>${item.name}</td>
                </tr>

                <tr>
                    <td>카테고리 그룹</td>
                    <td>
                        <c:forEach items="${categoryGroupList}" var="CategoryGroup">
                            <c:if test="${CategoryGroup.group_code eq item.category_group_code}">
                                <c:out value="${CategoryGroup.group_name}"/>
                            </c:if>
                        </c:forEach>
                    </td>
                </tr>

                <tr>
                    <td>아이템 그룹</td>
                    <td>
                        <c:forEach items="${categoryItemList}" var="CategoryItem">
                            <c:if test="${CategoryItem.group_code eq item.category_group_code}">
                                <c:if test="${CategoryItem.code eq item.category_item_code}">
                                    <c:out value="${CategoryItem.name}"/>
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
                <tr class="nohover">
                    <td colspan="2">
                        <form action="../inventory/detail.shop">
                            <input type="hidden" name="name" value="${item.name}">
                            <table>
                                <tr class="nohover">
                                    <td>
                                        <input type="button" value="리스트로 가기"
                                               onclick="location.href='list.shop?pageNum=${param.pageNum}'">
                                        <input type="button" value="상품 수정"
                                               onclick="location.href='${path}/item/edit.shop?item_no=${item.item_no}&pageNum=${param.pageNum}'">
                                        <input type="button" value="상품 삭제"
                                               onclick="location.href='${path}/item/confirm.shop?item_no=${item.item_no}&pageNum=${param.pageNum}'">
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
