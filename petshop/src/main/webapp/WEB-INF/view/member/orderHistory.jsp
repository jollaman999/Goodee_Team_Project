<%@ page import="org.springframework.web.context.ContextLoader" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="dao.ItemDao" %>
<%@ page import="logic.Item" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 정보</title>

    <script type="text/javascript">

        // 주문 날짜 탭
        $(document).ready(function(){
            $("#weekinfo").show();
            $("#monthinfo").hide();
            $("#halfinfo").hide();
            $("#allinfo").hide();

            $(".saleLine").each(function() {  //주문상품 목록 숨김.
                $(this).hide();
            })
            $("#tab1").addClass("select"); //class 속성에 select 값을 추가.
        })
        function disp_div(id,tab) {
            $(".info").each(function() {
                $(this).hide();
            })
            $(".tab").each(function() {
                $(this).removeClass("select");
            })
            $("#"+id).show();
            $("#" + tab).addClass("select");
        }
        function list_disp(id) {
            $("#"+id).toggle(); //
        }
    </script>
    <style type="text/css">

        .select
        {
            padding:3px;
            background-color: #0000ff;
        }

        .select > a
        {  color : #ffffff;
            text-decoration: none;
            font-weight: bold;
        }

    </style>
</head>
<body>
<%
    WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();

    ItemDao itemDao = null;
    if (context != null) {
        itemDao = (ItemDao)context.getBean("ItemDao");
    }
%>

<table>
    <tr>
        <td id="tab1" class="tab">
            <a href="javascript:disp_div('weekinfo','tab1')">7일</a>
        </td>
        <td id="tab2" class="tab">
            <a href="javascript:disp_div('monthinfo','tab2')">30일</a>
        </td>
        <td id="tab3" class="tab">
            <a href="javascript:disp_div('halfinfo','tab3')">180일</a>
        </td>
        <td id="tab4" class="tab">
            <a href="javascript:disp_div('allinfo','tab4')">모든</a>
        </td>
    </tr>
</table>

<%-- weekinfo --%>
<!-- -------------------------------------------------------------------------------------------------------- -->
<div id="weekinfo" class="info" style="display: none; width:100%;">
    <table>
        <tr>
            <td colspan="5" align="center">
                <h3>7일 주문 내역</h3>
            </td>
        </tr>

        <tr>
            <th style="width: 8%">주문번호</th>
            <th>상품명</th>
            <th style="width: 15%">금액(총)</th>
            <th style="width: 10%">수량</th>
            <th style="width: 12%">주문상태</th>
            <th style="width: 12%">주문날짜</th>
        </tr>

            <c:forEach items="${ordersList_7}" var="order" varStatus="stat">
                <tr>

                    <!-- 주문번호 -->
                    <td align="center">
                        <a href="javascript:list_disp('saleLine${stat.index}')">
                                ${order.num}
                        </a>
                    </td>

                    <!-- 상품명 -->
                    <td align="left">
                        <c:forEach items="${order.orders_lists}" var="orders_lists">
                            <c:set var="itemno" value="${orders_lists.item_no}" />
                            <%
                                Integer itemno = (Integer)pageContext.getAttribute("itemno") ;
                                String mainpic = "";
                                String itemname = "";
                                if (itemDao != null && itemno != null) {
                                    Item item = itemDao.selectOne(itemno, false);
                                    if (item != null) {
                                        mainpic = item.getMainpicurl();
                                        itemname = item.getName();
                                    }
                                }
                            %>
                            <img src="${path}/item/img/${itemno}/<%= mainpic %>"
                                 width="50" height="50" align="left">
                            <a href="#" >
                                <h5 align="left"><%= itemname %></h5>
                            </a>
                        </c:forEach>
                    </td>

                    <!-- 단가 -->
                    <td align="right">${order.price_total} 원</td>

                    <!-- 수량 -->
                    <td>
                        <c:forEach items="${order.orders_lists}" var="orders_lists">
                            ${orders_lists.quantity}개
                        </c:forEach>
                    </td>

                    <!-- 주문상태 -->
                    <td>배송중</td>

                    <!-- 주문날짜 -->
                    <td>${order.update_time}</td>
                </tr>
            </c:forEach>
    </table>
</div>

<%-- month --%>
<!-- ------------------------------------------------------------------------------------------------------- -->
<div id="monthinfo" class="info">
    <table>
        <tr>
            <td colspan="5" align="center">
                <h3>30일 주문 내역</h3>
            </td>
        </tr>

        <tr>
            <th style="width: 8%">주문번호</th>
            <th>상품명</th>
            <th style="width: 15%">금액(총)</th>
            <th style="width: 10%">수량</th>
            <th style="width: 12%">주문상태</th>
            <th style="width: 12%">주문날짜</th>
        </tr>

        <c:forEach items="${ordersList_30}" var="order" varStatus="stat">
            <tr>

                <!-- 주문번호 -->
                <td align="center">
                    <a href="javascript:list_disp('saleLine${stat.index}')">
                            ${order.num}
                    </a>
                </td>

                <!-- 상품명 -->
                <td align="left">
                    <c:forEach items="${order.orders_lists}" var="orders_lists">
                        <c:set var="itemno" value="${orders_lists.item_no}" />
                        <%
                            Integer itemno = (Integer)pageContext.getAttribute("itemno") ;
                            String mainpic = "";
                            String itemname = "";
                            if (itemDao != null && itemno != null) {
                                Item item = itemDao.selectOne(itemno, false);
                                if (item != null) {
                                    mainpic = item.getMainpicurl();
                                    itemname = item.getName();
                                }
                            }
                        %>
                        <img src="${path}/item/img/${itemno}/<%= mainpic %>"
                             width="50" height="50" align="left">
                        <a href="#" >
                            <h5 align="left"><%= itemname %></h5>
                        </a>
                    </c:forEach>
                </td>

                <!-- 단가 -->
                <td align="right">${order.price_total} 원</td>

                <!-- 수량 -->
                <td>
                    <c:forEach items="${order.orders_lists}" var="orders_lists">
                        ${orders_lists.quantity}개
                    </c:forEach>
                </td>

                <!-- 주문상태 -->
                <td>배송중</td>

                <!-- 주문날짜 -->
                <td>${order.update_time}</td>
            </tr>
        </c:forEach>
    </table>
</div>

<!-- half -->
<div id="halfinfo" class="info">
    <table>
        <tr>
            <td colspan="5" align="center">
                <h3>180일 주문 내역</h3>
            </td>
        <tr>
            <th style="width: 8%">주문번호</th>
            <th>상품명</th>
            <th style="width: 15%">금액(총)</th>
            <th style="width: 10%">수량</th>
            <th style="width: 12%">주문상태</th>
            <th style="width: 12%">주문날짜</th>
        </tr>

        <c:forEach items="${ordersList_180}" var="order" varStatus="stat">
            <tr>

                <!-- 주문번호 -->
                <td align="center">
                    <a href="javascript:list_disp('saleLine${stat.index}')">
                            ${order.num}
                    </a>
                </td>

                <!-- 상품명 -->
                <td align="left">
                    <c:forEach items="${order.orders_lists}" var="orders_lists">
                        <c:set var="itemno" value="${orders_lists.item_no}" />
                        <%
                            Integer itemno = (Integer)pageContext.getAttribute("itemno") ;
                            String mainpic = "";
                            String itemname = "";
                            if (itemDao != null && itemno != null) {
                                Item item = itemDao.selectOne(itemno, false);
                                if (item != null) {
                                    mainpic = item.getMainpicurl();
                                    itemname = item.getName();
                                }
                            }
                        %>
                        <img src="${path}/item/img/${itemno}/<%= mainpic %>"
                             width="50" height="50" align="left">
                        <a href="#" >
                            <h5 align="left"><%= itemname %></h5>
                        </a>
                    </c:forEach>
                </td>

                <!-- 단가 -->
                <td align="right">${order.price_total} 원</td>

                <!-- 수량 -->
                <td>
                    <c:forEach items="${order.orders_lists}" var="orders_lists">
                        ${orders_lists.quantity}개
                    </c:forEach>
                </td>

                <!-- 주문상태 -->
                <td>배송중</td>

                <!-- 주문날짜 -->
                <td>${order.update_time}</td>
            </tr>
        </c:forEach>
    </table>
</div>

<!-- allinfo -->
<!-- ------------------------------------------------------------------------------------------ -->
<div id="allinfo" class="info">
    <table>
        <tr>
            <td colspan="5" align="center">
                <h3>모든 주문 내역</h3>
            </td>
        <tr>
            <th style="width: 8%">주문번호</th>
            <th>상품명</th>
            <th style="width: 15%">금액(총)</th>
            <th style="width: 10%">수량</th>
            <th style="width: 12%">주문상태</th>
            <th style="width: 12%">주문날짜</th>
        </tr>

        <c:forEach items="${ordersList_all}" var="order" varStatus="stat">
            <tr>

                <!-- 주문번호 -->
                <td align="center">
                    <a href="javascript:list_disp('saleLine${stat.index}')">
                            ${order.num}
                    </a>
                </td>

                <!-- 상품명 -->
                <td align="left">
                    <c:forEach items="${order.orders_lists}" var="orders_lists">
                        <c:set var="itemno" value="${orders_lists.item_no}" />
                        <%
                            Integer itemno = (Integer)pageContext.getAttribute("itemno") ;
                            String mainpic = "";
                            String itemname = "";
                            if (itemDao != null && itemno != null) {
                                Item item = itemDao.selectOne(itemno, false);
                                if (item != null) {
                                    mainpic = item.getMainpicurl();
                                    itemname = item.getName();
                                }
                            }
                        %>
                        <img src="${path}/item/img/${itemno}/<%= mainpic %>"
                             width="50" height="50" align="left">
                        <a href="#" >
                            <h5 align="left"><%= itemname %></h5>
                        </a>
                    </c:forEach>
                </td>

                <!-- 단가 -->
                <td align="right">${order.price_total} 원</td>

                <!-- 수량 -->
                <td>
                    <c:forEach items="${order.orders_lists}" var="orders_lists">
                        ${orders_lists.quantity}개
                    </c:forEach>
                </td>

                <!-- 주문상태 -->
                <td>배송중</td>

                <!-- 주문날짜 -->
                <td>${order.update_time}</td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>
