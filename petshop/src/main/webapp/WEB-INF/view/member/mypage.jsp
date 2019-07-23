<%@ page import="org.springframework.web.context.ContextLoader" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="dao.ItemDao" %>
<%@ page import="logic.Item" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <!--
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
    </script>  -->

<style type="text/css">
/* .select {
            padding: 3px;
            text-decoration: none;
            font-weight: bold;
            background-color: #0000ff;
}

.select > a {
            color: #ffffff;
} 
   		
 */

table a:link {
	color: #666;
	font-weight: bold;
	text-decoration: none;
}
table a:visited {
	color: #999999;
	font-weight: bold;
	text-decoration: none;
}
table a:active,


table a:hover {
	color: #bd5a35;
	text-decoration: underline;
}
table {
	font-family: Arial, Helvetica, sans-serif;
	color: #666;
	font-size: 12px;
	text-shadow: 1px 1px 0px #fff;
	background: #eaebec;
	margin: 20px;
	border: #ccc 1px solid;

	-webkit-border-radius: 3px;
	border-radius: 3px;

	-webkit-box-shadow: 0 1px 2px #d1d1d1;
	box-shadow: 0 1px 2px #d1d1d1;
}


table > tbody > tr {
	text-align: center;
	padding-left: 20px;
}
table > tbody > tr > td:first-child {
	text-align: left;
	padding-left: 20px;
	border-left: 0;
}
table > tbody > tr > td {
	padding:18px;
	border-top: 1px solid #ffffff;
	border-bottom: 1px solid #e0e0e0;
	border-left: 1px solid #e0e0e0;

	background: #fbfbfb; /* Old browsers */
	background: -moz-linear-gradient(top,  #fbfbfb 0%, #fafafa 100%); /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#fbfbfb), color-stop(100%,#fafafa)); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top,  #fbfbfb 0%,#fafafa 100%); /* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top,  #fbfbfb 0%,#fafafa 100%); /* Opera 11.10+ */
	background: -ms-linear-gradient(top,  #fbfbfb 0%,#fafafa 100%); /* IE10+ */
	background: linear-gradient(to bottom,  #fbfbfb 0%,#fafafa 100%); /* W3C */
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#fbfbfb', endColorstr='#fafafa',GradientType=0 ); /* IE6-9 */
}
table > tbody > tr:nth-child(even) > td{
	background: #f8f8f8; /* Old browsers */
	background: -moz-linear-gradient(top,  #f8f8f8 0%, #f6f6f6 100%); /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#f8f8f8), color-stop(100%,#f6f6f6)); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top,  #f8f8f8 0%,#f6f6f6 100%); /* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top,  #f8f8f8 0%,#f6f6f6 100%); /* Opera 11.10+ */
	background: -ms-linear-gradient(top,  #f8f8f8 0%,#f6f6f6 100%); /* IE10+ */
	background: linear-gradient(to bottom,  #f8f8f8 0%,#f6f6f6 100%); /* W3C */
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#f8f8f8', endColorstr='#f6f6f6',GradientType=0 ); /* IE6-9 */
}
table > tbody > tr:last-child > td{
	border-bottom: 0;
}
table > tbody > tr:last-child > td:first-child {
	-webkit-border-bottom-left-radius: 3px;
	border-bottom-left-radius: 3px;
}
table > tbody > tr:last-child > td:last-child {
	-webkit-border-bottom-right-radius: 3px;
	border-bottom-right-radius: 3px;
}
table > tbody > tr:hover > td {
	background: #f2f2f2; /* Old browsers */
	background: -moz-linear-gradient(top,  #f2f2f2 0%, #f0f0f0 100%); /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#f2f2f2), color-stop(100%,#f0f0f0)); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top,  #f2f2f2 0%,#f0f0f0 100%); /* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top,  #f2f2f2 0%,#f0f0f0 100%); /* Opera 11.10+ */
	background: -ms-linear-gradient(top,  #f2f2f2 0%,#f0f0f0 100%); /* IE10+ */
	background: linear-gradient(to bottom,  #f2f2f2 0%,#f0f0f0 100%); /* W3C */
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#f2f2f2', endColorstr='#f0f0f0',GradientType=0 ); /* IE6-9 */
}


</style>

</head>
<body>
<%--  <table>
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
</table>  --%>
<%-- <div id="oinfo" class="info" style="display: none; width: 100%">
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
</div> --%>

<div id="minfo" class="info">
            <h3 style="text-align: center;">회원 정보</h3>
    <table> 	
           
        <tbody>
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
        <tbody>
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
