<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 삭제 확인</title>

    <!-- HighSlide -->
    <script type="text/javascript" src="${path}/vendor/highslide/highslide.js"></script>
    <link rel="stylesheet" type="text/css" href="${path}/vendor/highslide/highslide.css" />

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
<h2>상품 삭제 확인</h2>
<br><br>
<table>
    <tr class="nohover">
        <td>
            <a href="${path}/item/img/${item.item_no}/${item.mainpicurl}" class="highslide" onclick="return hs.expand(this)">
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
                    <td>가격</td>
                    <td>${item.price}원</td>
                </tr>
                <tr>
                    <td>상품 설명</td>
                    <td>${item.description}</td>
                </tr>
                <tr>
                    <td colspan="2" class="nohover">
                        <form action="delete.shop" method="post">
                            <input type="hidden" name="item_no" value="${item.item_no}">

                            <input type="submit" value="상품 삭제">
                            <input type="button" value="상품 리스트" onclick="location.href='${path}/inventory/list.shop?pageNum=${param.pageNum}'">
                        </form>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>
