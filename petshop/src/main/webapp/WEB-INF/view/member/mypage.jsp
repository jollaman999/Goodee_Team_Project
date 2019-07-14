<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#minfo").show();
            $("#oinfo").hide();
            $(".saleLine").each(function () {
                $(this).hide();
            })
            $("#tab1").addClass("select");
        })

        function disp_div(id, tab) {
            $(".info").each(function () {
                $(this).hide();
            })
            $(".tab").each(function () {
                $(this).removeClass("select");
            })
            $("#" + id).show();
            $("#" + tab).addClass("select");
        }

        function list_disp(id) {
            $("#" + id).toggle();
        }
    </script>

    <style type="text/css">
        .select {
            padding: 3px;
            text-decoration: none;
            font-weight: bold;
            background-color: #0000ff;
        }

        .select > a {
            color: #ffffff;
        }
    </style>
</head>
<body>
<table>
    <tr>
        <td id="tab1" class="tab">
            <a href="javascript:disp_div('minfo', 'tab1')">회원 정보 보기</a>
        </td>
        <c:if test="${param.id != 'admin'}">
            <td id="tab2" class="tab">
                <a href="javascript:disp_div('oinfo', 'tab2')">주문 정보 보기</a>
            </td>
        </c:if>
    </tr>
</table>
<div id="oinfo" class="info" style="display: none; width: 100%">
    <table>
        <tr>
            <td colspan="3" align="center">
                <b>주문 목록</b>
            </td>
        </tr>
        <tr>
            <th>주문 번호</th>
            <th>주문 일자</th>
            <th>총 주문 금액</th>
        </tr>
        <c:forEach items="${salelist}" var="sale" varStatus="stat">
            <tr>
                <td align="center">
                    <a href="javascript:list_disp('saleLine${stat.index}')">${sale.saleId}</a>
                </td>
                <td align="center">
                    <fmt:formatDate value="${sale.updatetime}" pattern="yyyy-MM-dd" />
                </td>
                <td align="right">
                    ${sale.totAmount}원
                </td>
            </tr>
            <tr id="saleLine${stat.index}" class="saleLine">
                <td colspan="3" align="center">
                    <table>
                        <tr>
                            <th width="25%">상품명</th>
                            <th width="25%">상품 가격</th>
                            <th width="25%">구매 수량</th>
                            <th width="25%">상품 총액</th>
                        </tr>
                        <c:forEach items="${sale.itemList}" var="saleItem">
                            <tr>
                                <td class="title">${saleItem.item.name}</td>
                                <td>${saleItem.item.price}원</td>
                                <td>${saleItem.quantity}개</td>
                                <td>${saleItem.quantity * saleItem.item.price}원</td>
                            </tr>
                        </c:forEach>
                    </table>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<div id="minfo" class="info">
    <table>
        <tr>
            <td colspan="2">회원 정보</td>
        </tr>
        <tr>
            <td>아이디</td>
            <td>${member.id}</td>
        </tr>
        <tr>
            <td>이름</td>
            <td>${member.name}</td>
        </tr>
        <tr>
            <td>전화번호</td>
            <td>${member.phone}</td>
        </tr>
        <tr>
            <td>이메일</td>
            <td>${member.email}</td>
        </tr>
        <tr>
            <td>주소</td>
            <td>${member.address}</td>
        </tr>
        <tr>
            <td>상세 주소</td>
            <td>${member.address_detail}</td>
        </tr>
        <tr>
            <td>우편번호</td>
            <td>${member.postcode}</td>
        </tr>
    </table>
    <br>
    <a href="update.shop?id=${member.id}">[회원 정보 수정]</a>&nbsp;
    <c:if test="${member.id != 'admin'}">
        <a href="delete.shop?id=${member.id}">[회원 탈퇴]</a>&nbsp;
    </c:if>
    <c:if test="${loginMember.id == 'admin'}">
        <a href="../admin/list.shop">[회원 목록]</a>
    </c:if>
</div>
</body>
</html>
