<%@ page import="org.springframework.web.context.ContextLoader" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="dao.ItemDao" %>
<%@ page import="logic.Item" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
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
            $("#0").show();
            $("#1").hide();
            $("#2").hide();
            $("#3").hide();
            $("#4").hide();
            $("#5").hide();
            $("#6").hide();
            $("#7").hide();

            $(".saleLine").each(function() {  //주문상품 목록 숨김.
                $(this).hide();
            });
            $("#tab0").addClass("select"); //class 속성에 select 값을 추가.
        });

        function disp_div(id,tab) {
            $(".info").each(function() {
                $(this).hide();
            });
            $(".tab").each(function() {
                $(this).removeClass("select");
            });
            $("#"+id).show();
            $("#" + tab).addClass("select");
        }

        function list_disp(id) {
            $("#"+id).toggle(); //
        }

        var reply_write_form;

        function win_reply_write(itemno) {
            if (reply_write_form != null)
                reply_write_form.close();

            var op = "width=750, height=820, left=50, top=150";
            reply_write_form = open("../reply/writeForm.shop?type=0&itemno=" + itemno, "", op);
        }
    </script>

    <style type="text/css">
        .select
        {
            background-color: #007bff;
        }

        .select > a
        {  color : #ffffff;
            text-decoration: none;
            font-weight: bold;
        }

        tbody tr:nth-child(even) {
            background-color: #ffffff;
        }

        tbody tr:nth-child(odd) {
            background-color: #ffffff;
        }

        .order_list:hover {
            color: #555555;
            background-color: #f2f2f2;
            cursor: pointer;
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
        <td id="tab0" class="tab" onclick="disp_div('0','tab0')">
            <a href="#">0.입금대기중</a>
        </td>
        <td id="tab1" class="tab" onclick="disp_div('1','tab1')">
            <a href="#">1.입금확인</a>
        </td>
        <td id="tab2" class="tab" onclick="disp_div('2','tab2')">
            <a href="#">2.상품준비중</a>
        </td>
        <td id="tab3" class="tab" onclick="disp_div('3','tab3')">
            <a href="#">3.발송완료</a>
        </td>
        <td id="tab4" class="tab" onclick="disp_div('4','tab4')">
            <a href="#">4.취소상태</a>
        </td>
        <td id="tab5" class="tab" onclick="disp_div('5','tab5')">
            <a href="#">5.취소완료</a>
        </td>
        <td id="tab6" class="tab" onclick="disp_div('6','tab6')">
            <a href="#">6.환불접수</a>
        </td>
        <td id="tab7" class="tab" onclick="disp_div('7','tab7')">
            <a href="#">7.환불완료</a>
        </td>
    </tr>
</table>

<%-- 0 --%>
<!-- -------------------------------------------------------------------------------------------------------- -->
<div id="0" class="info" style="display: none; width:100%;">
    <table>
        <tr>
            <td colspan="8" align="center">
                <h3>입금대기중</h3>
            </td>
        </tr>

        <tr>
            <th style="width: 8%">주문번호</th>
            <th style="width: auto">상품명</th>
            <th style="width: 8%">수량</th>
            <th style="width: 15%">금액(총)</th>
            <th style="width: 12%">주문상태</th>
            <th style="width: 12%">주문날짜</th>
            <th style="width: 12%">상태변경</th>
            <th style="width: 12%">계좌번호</th>
        </tr>

        <c:forEach items="${ordersList_7}" var="order" varStatus="stat1">
            <tr>
                <!-- 주문번호 -->
                
                <td rowspan="${order.orders_lists.size()}">
                    <a href="javascript:list_disp('saleLine${stat1.index}')">
                        ${order.num}
                    </a>
                </td>

                <c:forEach items="${order.orders_lists}" var="orders_lists" varStatus="stat2">
                    <c:if test="${stat2.index eq 0}">
                    
                        <!-- 상품명 -->
                        
                        <td style="padding-bottom: 0">
                            <div class="row">
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
                                <a href="${path}/shop/detail.shop?item_no=${itemno}" style="margin-bottom: 15px; width: 80%">
                                    <div class="row" style="text-align: left; margin-left: 10px; margin-right: 100px">
                                        <div><img src="${path}/item/img/${itemno}/<%= mainpic %>" style="width: 50px; height: 50px"></div>
                                        <div style="margin-left: 10px; margin-top: 12px"><h6><%= itemname %></h6></div>
                                    </div>
                                </a>
                                <c:if test="${order.status eq '3'}">
                                    <div style="text-align: right; margin-top: 16px; padding-right: 20px; padding-left: 20px; width: 20%">
                                        <a href="javascript:win_reply_write(${itemno})">후기작성</a>
                                    </div>
                                </c:if>
                            </div>
                        </td>

                        <!-- 수량 -->
                        <td>
                            ${orders_lists.quantity}개
                        </td>
                        
                    </c:if>
                </c:forEach>

                <!-- 금액(총) -->
                <td rowspan="${order.orders_lists.size()}">
                    ${order.price_total} 원
                </td>

                <!-- 주문상태 -->
                <td rowspan="${order.orders_lists.size()}">
                    <c:choose>
                        <c:when test="${order.status eq '0'}">
                            입금대기중
                        </c:when>
                        <c:when test="${order.status eq '1'}">
                            입금확인
                        </c:when>
                        <c:when test="${order.status eq '2'}">
                            입금대기중
                        </c:when>
                        <c:when test="${order.status eq '3'}">
                            <div style="margin-bottom: 8px">발송완료</div>
                            
                            <c:if test="${delivery.courier eq '1'}">
                            	<div><a href="https://service.epost.go.kr/trace.RetrieveDomRigiTraceList.comm?sid1=&displayHeader=N" target="_blank">배송조회<br> (ex우체국택배)</a></div>
                            </c:if> 
                           
                            <div><a href="https://service.epost.go.kr/trace.RetrieveDomRigiTraceList.comm?sid1=&displayHeader=N" target="_blank">배송조회<br> (ex우체국택배)</a></div>                          
                        </c:when>
                        <c:when test="${order.status eq '4'}">
                            취소접수
                        </c:when>
                        <c:when test="${order.status eq '5'}">
                            취소완료
                        </c:when>
                        <c:when test="${order.status eq '6'}">
                            환불접수
                        </c:when>
                        <c:when test="${order.status eq '7'}">
                            환불완료
                        </c:when>
                    </c:choose>
                </td>

                <!-- 주문날짜 -->
                <td rowspan="${order.orders_lists.size()}">
                    <c:set var="update_time" value="${order.update_time}" />
                    <%
                        Date date = (Date)pageContext.getAttribute("update_time");
                        String datestr = "";

                        if (date != null) {
                            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");

                            datestr = simpleDateFormat.format(date);
                        }
                    %>
                    <%= datestr  %>
                </td>
                
                 <!-- 상태변경 -->
                     <td rowspan="${order.orders_lists.size()}">
                           <button onclick="">입금확인</button>
                     </td>   
                     
                
                    
            </tr>

            <!-- 주문한 상품이 2개 이상 있을때 -->
            <c:forEach items="${order.orders_lists}" var="orders_lists" varStatus="stat3">
                <c:if test="${stat3.index gt 0}">
                    <tr>
                        <!-- 상품명 -->
                        <td style="padding-bottom: 0">
                            <div class="row">
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
                                <a href="${path}/shop/detail.shop?item_no=${itemno}" style="margin-bottom: 15px; width: 80%">
                                    <div class="row" style="text-align: left; margin-left: 10px; margin-right: 100px">
                                        <div><img src="${path}/item/img/${itemno}/<%= mainpic %>" style="width: 50px; height: 50px"></div>
                                        <div style="margin-left: 10px; margin-top: 12px"><h6><%= itemname %></h6></div>
                                    </div>
                                </a>
                                <c:if test="${order.status eq '3'}">
                                    <div style="text-align: right; margin-top: 16px; padding-right: 20px; padding-left: 20px; width: 20%">
                                        <a href="javascript:win_reply_write(${itemno})">후기작성</a>
                                    </div>
                                </c:if>
                            </div>
                        </td>
                        
                        <!-- 수량 -->
                        <td>
                            ${orders_lists.quantity}개
                        </td>
                     
                    </tr>
                </c:if>
            </c:forEach>
        </c:forEach>
    </table>
</div>

<%-- 1 --%>
<!-- ------------------------------------------------------------------------------------------------------- -->
<div id="1" class="info">
    <table>
        <tr>
            <td colspan="7" align="center">
                <h3>입금확인</h3>
            </td>
        </tr>

        <tr>
            <th style="width: 8%">주문번호</th>
            <th style="width: auto">상품명</th>
            <th style="width: 8%">수량</th>
            <th style="width: 15%">금액(총)</th>
            <th style="width: 12%">주문상태</th>
            <th style="width: 12%">주문날짜</th>
            <th style="width: 12%">상태변경</th>
        </tr>

        <c:forEach items="${ordersList_30}" var="order" varStatus="stat1">
            <tr>
                <!-- 주문번호 -->
                <td rowspan="${order.orders_lists.size()}">
                    <a href="javascript:list_disp('saleLine${stat1.index}')">
                            ${order.num}
                    </a>
                </td>

                <c:forEach items="${order.orders_lists}" var="orders_lists" varStatus="stat2">
                    <c:if test="${stat2.index eq 0}">
                        <!-- 상품명 -->
                        <td style="padding-bottom: 0">
                            <div class="row">
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
                                <a href="${path}/shop/detail.shop?item_no=${itemno}" style="margin-bottom: 15px; width: 80%">
                                    <div class="row" style="text-align: left; margin-left: 10px; margin-right: 100px">
                                        <div><img src="${path}/item/img/${itemno}/<%= mainpic %>" style="width: 50px; height: 50px"></div>
                                        <div style="margin-left: 10px; margin-top: 12px"><h6><%= itemname %></h6></div>
                                    </div>
                                </a>
                                <c:if test="${order.status eq '3'}">
                                    <div style="text-align: right; margin-top: 16px; padding-right: 20px; padding-left: 20px; width: 20%">
                                        <a href="javascript:win_reply_write(${itemno})">후기작성</a>
                                    </div>
                                </c:if>
                            </div>
                        </td>

                        <!-- 수량 -->
                        <td>
                                ${orders_lists.quantity}개
                        </td>
                    </c:if>
                </c:forEach>

                <!-- 금액(총) -->
                <td rowspan="${order.orders_lists.size()}">
                        ${order.price_total} 원
                </td>

                <!-- 주문상태 -->
                <td rowspan="${order.orders_lists.size()}">
                    <c:choose>
                        <c:when test="${order.status eq '0'}">
                            입금대기중
                        </c:when>
                        <c:when test="${order.status eq '1'}">
                            입금확인
                        </c:when>
                        <c:when test="${order.status eq '2'}">
                            입금대기중
                        </c:when>
                        <c:when test="${order.status eq '3'}">
                            <div style="margin-bottom: 8px">발송완료</div>
                            <div><a href="https://service.epost.go.kr/trace.RetrieveDomRigiTraceList.comm?sid1=&displayHeader=N" target="_blank">배송조회<br> (ex우체국택배)</a></div>
                        </c:when>
                        <c:when test="${order.status eq '4'}">
                            취소접수
                        </c:when>
                        <c:when test="${order.status eq '5'}">
                            취소완료
                        </c:when>
                        <c:when test="${order.status eq '6'}">
                            환불접수
                        </c:when>
                        <c:when test="${order.status eq '7'}">
                            환불완료
                        </c:when>
                    </c:choose>
                </td>

                <!-- 주문날짜 -->
                <td rowspan="${order.orders_lists.size()}">
                    <c:set var="update_time" value="${order.update_time}" />
                    <%
                        Date date = (Date)pageContext.getAttribute("update_time");
                        String datestr = "";

                        if (date != null) {
                            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");

                            datestr = simpleDateFormat.format(date);
                        }
                    %>
                    <%= datestr  %>
                </td>
                 <!-- 상태변경 -->
                     <td rowspan="${order.orders_lists.size()}">
                           <button onclick="">상품준비중</button>
                     </td>   
            </tr>

            <!-- 주문한 상품이 2개 이상 있을때 -->
            <c:forEach items="${order.orders_lists}" var="orders_lists" varStatus="stat3">
                <c:if test="${stat3.index gt 0}">
                    <tr>
                        <!-- 상품명 -->
                        <td style="padding-bottom: 0">
                            <div class="row">
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
                                <a href="${path}/shop/detail.shop?item_no=${itemno}" style="margin-bottom: 15px; width: 80%">
                                    <div class="row" style="text-align: left; margin-left: 10px; margin-right: 100px">
                                        <div><img src="${path}/item/img/${itemno}/<%= mainpic %>" style="width: 50px; height: 50px"></div>
                                        <div style="margin-left: 10px; margin-top: 12px"><h6><%= itemname %></h6></div>
                                    </div>
                                </a>
                                <c:if test="${order.status eq '3'}">
                                    <div style="text-align: right; margin-top: 16px; padding-right: 20px; padding-left: 20px; width: 20%">
                                        <a href="javascript:win_reply_write(${itemno})">후기작성</a>
                                    </div>
                                </c:if>
                            </div>
                        </td>
                        <!-- 수량 -->
                        <td>
                                ${orders_lists.quantity}개
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
        </c:forEach>
    </table>
</div>

<!-- 2 -->
<div id="2" class="info">
    <table>
        <tr>
            <td colspan="7" align="center">
                <h3>상품준비중</h3>
            </td>
        </tr>

        <tr>
            <th style="width: 8%">주문번호</th>
            <th style="width: auto">상품명</th>
            <th style="width: 8%">수량</th>
            <th style="width: 15%">금액(총)</th>
            <th style="width: 12%">주문상태</th>
            <th style="width: 12%">주문날짜</th>
            <th style="width: 12%">상태변경</th>
        </tr>

        <c:forEach items="${ordersList_180}" var="order" varStatus="stat1">
            <tr>
                <!-- 주문번호 -->
                <td rowspan="${order.orders_lists.size()}">
                    <a href="javascript:list_disp('saleLine${stat1.index}')">
                            ${order.num}
                    </a>
                </td>

                <c:forEach items="${order.orders_lists}" var="orders_lists" varStatus="stat2">
                    <c:if test="${stat2.index eq 0}">
                        <!-- 상품명 -->
                        <td style="padding-bottom: 0">
                            <div class="row">
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
                                <a href="${path}/shop/detail.shop?item_no=${itemno}" style="margin-bottom: 15px; width: 80%">
                                    <div class="row" style="text-align: left; margin-left: 10px; margin-right: 100px">
                                        <div><img src="${path}/item/img/${itemno}/<%= mainpic %>" style="width: 50px; height: 50px"></div>
                                        <div style="margin-left: 10px; margin-top: 12px"><h6><%= itemname %></h6></div>
                                    </div>
                                </a>
                                <c:if test="${order.status eq '3'}">
                                    <div style="text-align: right; margin-top: 16px; padding-right: 20px; padding-left: 20px; width: 20%">
                                        <a href="javascript:win_reply_write(${itemno})">후기작성</a>
                                    </div>
                                </c:if>
                            </div>
                        </td>

                        <!-- 수량 -->
                        <td>
                                ${orders_lists.quantity}개
                        </td>
                    </c:if>
                </c:forEach>

                <!-- 금액(총) -->
                <td rowspan="${order.orders_lists.size()}">
                        ${order.price_total} 원
                </td>

                <!-- 주문상태 -->
                <td rowspan="${order.orders_lists.size()}">
                    <c:choose>
                        <c:when test="${order.status eq '0'}">
                            입금대기중
                        </c:when>
                        <c:when test="${order.status eq '1'}">
                            입금확인
                        </c:when>
                        <c:when test="${order.status eq '2'}">
                            입금대기중
                        </c:when>
                        <c:when test="${order.status eq '3'}">
                            <div style="margin-bottom: 8px">발송완료</div>
                            <div><a href="https://service.epost.go.kr/trace.RetrieveDomRigiTraceList.comm?sid1=&displayHeader=N" target="_blank">배송조회<br> (ex우체국택배)</a></div>
                        </c:when>
                        <c:when test="${order.status eq '4'}">
                            취소접수
                        </c:when>
                        <c:when test="${order.status eq '5'}">
                            취소완료
                        </c:when>
                        <c:when test="${order.status eq '6'}">
                            환불접수
                        </c:when>
                        <c:when test="${order.status eq '7'}">
                            환불완료
                        </c:when>
                    </c:choose>
                </td>

                <!-- 주문날짜 -->
                <td rowspan="${order.orders_lists.size()}">
                    <c:set var="update_time" value="${order.update_time}" />
                    <%
                        Date date = (Date)pageContext.getAttribute("update_time");
                        String datestr = "";

                        if (date != null) {
                            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");

                            datestr = simpleDateFormat.format(date);
                        }
                    %>
                    <%= datestr  %>
                </td>
                <!-- 상태변경 -->
                     <td rowspan="${order.orders_lists.size()}">
                           <button onclick="">발송완료</button>
                     </td>   
            </tr>

            <!-- 주문한 상품이 2개 이상 있을때 -->
            <c:forEach items="${order.orders_lists}" var="orders_lists" varStatus="stat3">
                <c:if test="${stat3.index gt 0}">
                    <tr>
                        <!-- 상품명 -->
                        <td style="padding-bottom: 0">
                            <div class="row">
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
                                <a href="${path}/shop/detail.shop?item_no=${itemno}" style="margin-bottom: 15px; width: 80%">
                                    <div class="row" style="text-align: left; margin-left: 10px; margin-right: 100px">
                                        <div><img src="${path}/item/img/${itemno}/<%= mainpic %>" style="width: 50px; height: 50px"></div>
                                        <div style="margin-left: 10px; margin-top: 12px"><h6><%= itemname %></h6></div>
                                    </div>
                                </a>
                                <c:if test="${order.status eq '3'}">
                                    <div style="text-align: right; margin-top: 16px; padding-right: 20px; padding-left: 20px; width: 20%">
                                        <a href="javascript:win_reply_write(${itemno})">후기작성</a>
                                    </div>
                                </c:if>
                            </div>
                        </td>
                        <!-- 수량 -->
                        <td>
                                ${orders_lists.quantity}개
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
        </c:forEach>
    </table>
</div>

<!-- 3 -->
<!-- ------------------------------------------------------------------------------------------ -->
<div id="3" class="info">
    <table>
        <tr>
            <td colspan="6" align="center">
                <h3>발송완료</h3>
            </td>
        </tr>

        <tr>
            <th style="width: 8%">주문번호</th>
            <th style="width: auto">상품명</th>
            <th style="width: 8%">수량</th>
            <th style="width: 15%">금액(총)</th>
            <th style="width: 12%">주문상태</th>
            <th style="width: 12%">주문날짜</th>
        </tr>

        <c:forEach items="${ordersList_all}" var="order" varStatus="stat1">
            <tr>
                <!-- 주문번호 -->
                <td rowspan="${order.orders_lists.size()}">
                    <a href="javascript:list_disp('saleLine${stat1.index}')">
                            ${order.num}
                    </a>
                </td>

                <c:forEach items="${order.orders_lists}" var="orders_lists" varStatus="stat2">
                    <c:if test="${stat2.index eq 0}">
                        <!-- 상품명 -->
                        <td style="padding-bottom: 0">
                            <div class="row">
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
                                <a href="${path}/shop/detail.shop?item_no=${itemno}" style="margin-bottom: 15px; width: 80%">
                                    <div class="row" style="text-align: left; margin-left: 10px; margin-right: 100px">
                                        <div><img src="${path}/item/img/${itemno}/<%= mainpic %>" style="width: 50px; height: 50px"></div>
                                        <div style="margin-left: 10px; margin-top: 12px"><h6><%= itemname %></h6></div>
                                    </div>
                                </a>
                                <c:if test="${order.status eq '3'}">
                                    <div style="text-align: right; margin-top: 16px; padding-right: 20px; padding-left: 20px; width: 20%">
                                        <a href="javascript:win_reply_write(${itemno})">후기작성</a>
                                    </div>
                                </c:if>
                            </div>
                        </td>

                        <!-- 수량 -->
                        <td>
                                ${orders_lists.quantity}개
                        </td>
                    </c:if>
                </c:forEach>

                <!-- 금액(총) -->
                <td rowspan="${order.orders_lists.size()}">
                        ${order.price_total} 원
                </td>

                <!-- 주문상태 -->
                <td rowspan="${order.orders_lists.size()}">
                    <c:choose>
                        <c:when test="${order.status eq '0'}">
                            입금대기중
                        </c:when>
                        <c:when test="${order.status eq '1'}">
                            입금확인
                        </c:when>
                        <c:when test="${order.status eq '2'}">
                            입금대기중
                        </c:when>
                        <c:when test="${order.status eq '3'}">
                            <div style="margin-bottom: 8px">발송완료</div>
                            <div><a href="https://service.epost.go.kr/trace.RetrieveDomRigiTraceList.comm?sid1=&displayHeader=N" target="_blank">배송조회<br> (ex우체국택배)</a></div>
                        </c:when>
                        <c:when test="${order.status eq '4'}">
                            취소접수
                        </c:when>
                        <c:when test="${order.status eq '5'}">
                            취소완료
                        </c:when>
                        <c:when test="${order.status eq '6'}">
                            환불접수
                        </c:when>
                        <c:when test="${order.status eq '7'}">
                            환불완료
                        </c:when>
                    </c:choose>
                </td>

                <!-- 주문날짜 -->
                <td rowspan="${order.orders_lists.size()}">
                    <c:set var="update_time" value="${order.update_time}" />
                    <%
                        Date date = (Date)pageContext.getAttribute("update_time");
                        String datestr = "";

                        if (date != null) {
                            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");

                            datestr = simpleDateFormat.format(date);
                        }
                    %>
                    <%= datestr  %>
                </td>
            </tr>

            <!-- 주문한 상품이 2개 이상 있을때 -->
            <c:forEach items="${order.orders_lists}" var="orders_lists" varStatus="stat3">
                <c:if test="${stat3.index gt 0}">
                    <tr>
                        <!-- 상품명 -->
                        <td style="padding-bottom: 0">
                            <div class="row">
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
                                <a href="${path}/shop/detail.shop?item_no=${itemno}" style="margin-bottom: 15px; width: 80%">
                                    <div class="row" style="text-align: left; margin-left: 10px; margin-right: 100px">
                                        <div><img src="${path}/item/img/${itemno}/<%= mainpic %>" style="width: 50px; height: 50px"></div>
                                        <div style="margin-left: 10px; margin-top: 12px"><h6><%= itemname %></h6></div>
                                    </div>
                                </a>
                                <c:if test="${order.status eq '3'}">
                                    <div style="text-align: right; margin-top: 16px; padding-right: 20px; padding-left: 20px; width: 20%">
                                        <a href="javascript:win_reply_write(${itemno})">후기작성</a>
                                    </div>
                                </c:if>
                            </div>
                        </td>
                        <!-- 수량 -->
                        <td>
                                ${orders_lists.quantity}개
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
        </c:forEach>
    </table>
</div>
<%-- 4 --%>
<!-- -------------------------------------------------------------------------------------------------------- -->
<div id="4" class="info">
    <table>
        <tr>
            <td colspan="7" align="center">
                <h3>취소접수</h3>
            </td>
        </tr>

        <tr>
            <th style="width: 8%">주문번호</th>
            <th style="width: auto">상품명</th>
            <th style="width: 8%">수량</th>
            <th style="width: 15%">금액(총)</th>
            <th style="width: 12%">주문상태</th>
            <th style="width: 12%">주문날짜</th>
            <th style="width: 12%">상태변경</th>
        </tr>

        <c:forEach items="${ordersList_7}" var="order" varStatus="stat1">
            <tr>
                <!-- 주문번호 -->
                <td rowspan="${order.orders_lists.size()}">
                    <a href="javascript:list_disp('saleLine${stat1.index}')">
                        ${order.num}
                    </a>
                </td>

                <c:forEach items="${order.orders_lists}" var="orders_lists" varStatus="stat2">
                    <c:if test="${stat2.index eq 0}">
                        <!-- 상품명 -->
                        <td style="padding-bottom: 0">
                            <div class="row">
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
                                <a href="${path}/shop/detail.shop?item_no=${itemno}" style="margin-bottom: 15px; width: 80%">
                                    <div class="row" style="text-align: left; margin-left: 10px; margin-right: 100px">
                                        <div><img src="${path}/item/img/${itemno}/<%= mainpic %>" style="width: 50px; height: 50px"></div>
                                        <div style="margin-left: 10px; margin-top: 12px"><h6><%= itemname %></h6></div>
                                    </div>
                                </a>
                                <c:if test="${order.status eq '3'}">
                                    <div style="text-align: right; margin-top: 16px; padding-right: 20px; padding-left: 20px; width: 20%">
                                        <a href="javascript:win_reply_write(${itemno})">후기작성</a>
                                    </div>
                                </c:if>
                            </div>
                        </td>

                        <!-- 수량 -->
                        <td>
                            ${orders_lists.quantity}개
                        </td>
                    </c:if>
                </c:forEach>

                <!-- 금액(총) -->
                <td rowspan="${order.orders_lists.size()}">
                    ${order.price_total} 원
                </td>

                <!-- 주문상태 -->
                <td rowspan="${order.orders_lists.size()}">
                    <c:choose>
                        <c:when test="${order.status eq '0'}">
                            입금대기중
                        </c:when>
                        <c:when test="${order.status eq '1'}">
                            입금확인
                        </c:when>
                        <c:when test="${order.status eq '2'}">
                            입금대기중
                        </c:when>
                        <c:when test="${order.status eq '3'}">
                            <div style="margin-bottom: 8px">발송완료</div>
                            
                            <c:if test="${delivery.courier eq '1'}">
                            	<div><a href="https://service.epost.go.kr/trace.RetrieveDomRigiTraceList.comm?sid1=&displayHeader=N" target="_blank">배송조회<br> (ex우체국택배)</a></div>
                            </c:if> 
                           
                            <div><a href="https://service.epost.go.kr/trace.RetrieveDomRigiTraceList.comm?sid1=&displayHeader=N" target="_blank">배송조회<br> (ex우체국택배)</a></div>                          
                        </c:when>
                        <c:when test="${order.status eq '4'}">
                            취소접수
                        </c:when>
                        <c:when test="${order.status eq '5'}">
                            취소완료
                        </c:when>
                        <c:when test="${order.status eq '6'}">
                            환불접수
                        </c:when>
                        <c:when test="${order.status eq '7'}">
                            환불완료
                        </c:when>
                    </c:choose>
                </td>

                <!-- 주문날짜 -->
                <td rowspan="${order.orders_lists.size()}">
                    <c:set var="update_time" value="${order.update_time}" />
                    <%
                        Date date = (Date)pageContext.getAttribute("update_time");
                        String datestr = "";

                        if (date != null) {
                            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");

                            datestr = simpleDateFormat.format(date);
                        }
                    %>
                    <%= datestr  %>
                </td>
                <!-- 상태변경 -->
                     <td rowspan="${order.orders_lists.size()}">
                           <button onclick="">취소승인</button>
                     </td>   
            </tr>

            <!-- 주문한 상품이 2개 이상 있을때 -->
            <c:forEach items="${order.orders_lists}" var="orders_lists" varStatus="stat3">
                <c:if test="${stat3.index gt 0}">
                    <tr>
                        <!-- 상품명 -->
                        <td style="padding-bottom: 0">
                            <div class="row">
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
                                <a href="${path}/shop/detail.shop?item_no=${itemno}" style="margin-bottom: 15px; width: 80%">
                                    <div class="row" style="text-align: left; margin-left: 10px; margin-right: 100px">
                                        <div><img src="${path}/item/img/${itemno}/<%= mainpic %>" style="width: 50px; height: 50px"></div>
                                        <div style="margin-left: 10px; margin-top: 12px"><h6><%= itemname %></h6></div>
                                    </div>
                                </a>
                                <c:if test="${order.status eq '3'}">
                                    <div style="text-align: right; margin-top: 16px; padding-right: 20px; padding-left: 20px; width: 20%">
                                        <a href="javascript:win_reply_write(${itemno})">후기작성</a>
                                    </div>
                                </c:if>
                            </div>
                        </td>
                        <!-- 수량 -->
                        <td>
                            ${orders_lists.quantity}개
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
        </c:forEach>
    </table>
</div>

<!-- 5 -->
<div id="5" class="info">
    <table>
        <tr>
            <td colspan="6" align="center">
                <h3>취소완료</h3>
            </td>
        </tr>

        <tr>
            <th style="width: 8%">주문번호</th>
            <th style="width: auto">상품명</th>
            <th style="width: 8%">수량</th>
            <th style="width: 15%">금액(총)</th>
            <th style="width: 12%">주문상태</th>
            <th style="width: 12%">주문날짜</th>
        </tr>

        <c:forEach items="${ordersList_180}" var="order" varStatus="stat1">
            <tr>
                <!-- 주문번호 -->
                <td rowspan="${order.orders_lists.size()}">
                    <a href="javascript:list_disp('saleLine${stat1.index}')">
                            ${order.num}
                    </a>
                </td>

                <c:forEach items="${order.orders_lists}" var="orders_lists" varStatus="stat2">
                    <c:if test="${stat2.index eq 0}">
                        <!-- 상품명 -->
                        <td style="padding-bottom: 0">
                            <div class="row">
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
                                <a href="${path}/shop/detail.shop?item_no=${itemno}" style="margin-bottom: 15px; width: 80%">
                                    <div class="row" style="text-align: left; margin-left: 10px; margin-right: 100px">
                                        <div><img src="${path}/item/img/${itemno}/<%= mainpic %>" style="width: 50px; height: 50px"></div>
                                        <div style="margin-left: 10px; margin-top: 12px"><h6><%= itemname %></h6></div>
                                    </div>
                                </a>
                                <c:if test="${order.status eq '3'}">
                                    <div style="text-align: right; margin-top: 16px; padding-right: 20px; padding-left: 20px; width: 20%">
                                        <a href="javascript:win_reply_write(${itemno})">후기작성</a>
                                    </div>
                                </c:if>
                            </div>
                        </td>

                        <!-- 수량 -->
                        <td>
                                ${orders_lists.quantity}개
                        </td>
                    </c:if>
                </c:forEach>

                <!-- 금액(총) -->
                <td rowspan="${order.orders_lists.size()}">
                        ${order.price_total} 원
                </td>

                <!-- 주문상태 -->
                <td rowspan="${order.orders_lists.size()}">
                    <c:choose>
                        <c:when test="${order.status eq '0'}">
                            입금대기중
                        </c:when>
                        <c:when test="${order.status eq '1'}">
                            입금확인
                        </c:when>
                        <c:when test="${order.status eq '2'}">
                            입금대기중
                        </c:when>
                        <c:when test="${order.status eq '3'}">
                            <div style="margin-bottom: 8px">발송완료</div>
                            <div><a href="https://service.epost.go.kr/trace.RetrieveDomRigiTraceList.comm?sid1=&displayHeader=N" target="_blank">배송조회<br> (ex우체국택배)</a></div>
                        </c:when>
                        <c:when test="${order.status eq '4'}">
                            취소접수
                        </c:when>
                        <c:when test="${order.status eq '5'}">
                            취소완료
                        </c:when>
                        <c:when test="${order.status eq '6'}">
                            환불접수
                        </c:when>
                        <c:when test="${order.status eq '7'}">
                            환불완료
                        </c:when>
                    </c:choose>
                </td>

                <!-- 주문날짜 -->
                <td rowspan="${order.orders_lists.size()}">
                    <c:set var="update_time" value="${order.update_time}" />
                    <%
                        Date date = (Date)pageContext.getAttribute("update_time");
                        String datestr = "";

                        if (date != null) {
                            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");

                            datestr = simpleDateFormat.format(date);
                        }
                    %>
                    <%= datestr  %>
                </td>
            </tr>

            <!-- 주문한 상품이 2개 이상 있을때 -->
            <c:forEach items="${order.orders_lists}" var="orders_lists" varStatus="stat3">
                <c:if test="${stat3.index gt 0}">
                    <tr>
                        <!-- 상품명 -->
                        <td style="padding-bottom: 0">
                            <div class="row">
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
                                <a href="${path}/shop/detail.shop?item_no=${itemno}" style="margin-bottom: 15px; width: 80%">
                                    <div class="row" style="text-align: left; margin-left: 10px; margin-right: 100px">
                                        <div><img src="${path}/item/img/${itemno}/<%= mainpic %>" style="width: 50px; height: 50px"></div>
                                        <div style="margin-left: 10px; margin-top: 12px"><h6><%= itemname %></h6></div>
                                    </div>
                                </a>
                                <c:if test="${order.status eq '3'}">
                                    <div style="text-align: right; margin-top: 16px; padding-right: 20px; padding-left: 20px; width: 20%">
                                        <a href="javascript:win_reply_write(${itemno})">후기작성</a>
                                    </div>
                                </c:if>
                            </div>
                        </td>
                        <!-- 수량 -->
                        <td>
                                ${orders_lists.quantity}개
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
        </c:forEach>
    </table>
</div>


<%-- 6 --%>
<!-- ------------------------------------------------------------------------------------------------------- -->
<div id="6" class="info">
    <table>
        <tr>
            <td colspan="7" align="center">
                <h3>환불접수</h3>
            </td>
        </tr>

        <tr>
            <th style="width: 8%">주문번호</th>
            <th style="width: auto">상품명</th>
            <th style="width: 8%">수량</th>
            <th style="width: 15%">금액(총)</th>
            <th style="width: 12%">주문상태</th>
            <th style="width: 12%">주문날짜</th>
            <th style="width: 12%">상태변경</th>
        </tr>

        <c:forEach items="${ordersList_30}" var="order" varStatus="stat1">
            <tr>
                <!-- 주문번호 -->
                <td rowspan="${order.orders_lists.size()}">
                    <a href="javascript:list_disp('saleLine${stat1.index}')">
                            ${order.num}
                    </a>
                </td>

                <c:forEach items="${order.orders_lists}" var="orders_lists" varStatus="stat2">
                    <c:if test="${stat2.index eq 0}">
                        <!-- 상품명 -->
                        <td style="padding-bottom: 0">
                            <div class="row">
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
                                <a href="${path}/shop/detail.shop?item_no=${itemno}" style="margin-bottom: 15px; width: 80%">
                                    <div class="row" style="text-align: left; margin-left: 10px; margin-right: 100px">
                                        <div><img src="${path}/item/img/${itemno}/<%= mainpic %>" style="width: 50px; height: 50px"></div>
                                        <div style="margin-left: 10px; margin-top: 12px"><h6><%= itemname %></h6></div>
                                    </div>
                                </a>
                                <c:if test="${order.status eq '3'}">
                                    <div style="text-align: right; margin-top: 16px; padding-right: 20px; padding-left: 20px; width: 20%">
                                        <a href="javascript:win_reply_write(${itemno})">후기작성</a>
                                    </div>
                                </c:if>
                            </div>
                        </td>

                        <!-- 수량 -->
                        <td>
                                ${orders_lists.quantity}개
                        </td>
                    </c:if>
                </c:forEach>

                <!-- 금액(총) -->
                <td rowspan="${order.orders_lists.size()}">
                        ${order.price_total} 원
                </td>

                <!-- 주문상태 -->
                <td rowspan="${order.orders_lists.size()}">
                    <c:choose>
                        <c:when test="${order.status eq '0'}">
                            입금대기중
                        </c:when>
                        <c:when test="${order.status eq '1'}">
                            입금확인
                        </c:when>
                        <c:when test="${order.status eq '2'}">
                            입금대기중
                        </c:when>
                        <c:when test="${order.status eq '3'}">
                            <div style="margin-bottom: 8px">발송완료</div>
                            <div><a href="https://service.epost.go.kr/trace.RetrieveDomRigiTraceList.comm?sid1=&displayHeader=N" target="_blank">배송조회<br> (ex우체국택배)</a></div>
                        </c:when>
                        <c:when test="${order.status eq '4'}">
                            취소접수
                        </c:when>
                        <c:when test="${order.status eq '5'}">
                            취소완료
                        </c:when>
                        <c:when test="${order.status eq '6'}">
                            환불접수
                        </c:when>
                        <c:when test="${order.status eq '7'}">
                            환불완료
                        </c:when>
                    </c:choose>
                </td>

                <!-- 주문날짜 -->
                <td rowspan="${order.orders_lists.size()}">
                    <c:set var="update_time" value="${order.update_time}" />
                    <%
                        Date date = (Date)pageContext.getAttribute("update_time");
                        String datestr = "";

                        if (date != null) {
                            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");

                            datestr = simpleDateFormat.format(date);
                        }
                    %>
                    <%= datestr  %>
                </td>
                <!-- 상태변경 -->
                     <td rowspan="${order.orders_lists.size()}">
                           <button onclick="">환불승인</button>
                     </td>   
            </tr>

            <!-- 주문한 상품이 2개 이상 있을때 -->
            <c:forEach items="${order.orders_lists}" var="orders_lists" varStatus="stat3">
                <c:if test="${stat3.index gt 0}">
                    <tr>
                        <!-- 상품명 -->
                        <td style="padding-bottom: 0">
                            <div class="row">
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
                                <a href="${path}/shop/detail.shop?item_no=${itemno}" style="margin-bottom: 15px; width: 80%">
                                    <div class="row" style="text-align: left; margin-left: 10px; margin-right: 100px">
                                        <div><img src="${path}/item/img/${itemno}/<%= mainpic %>" style="width: 50px; height: 50px"></div>
                                        <div style="margin-left: 10px; margin-top: 12px"><h6><%= itemname %></h6></div>
                                    </div>
                                </a>
                                <c:if test="${order.status eq '3'}">
                                    <div style="text-align: right; margin-top: 16px; padding-right: 20px; padding-left: 20px; width: 20%">
                                        <a href="javascript:win_reply_write(${itemno})">후기작성</a>
                                    </div>
                                </c:if>
                            </div>
                        </td>
                        <!-- 수량 -->
                        <td>
                                ${orders_lists.quantity}개
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
        </c:forEach>
    </table>
</div>

<!-- 7 -->
<div id="7" class="info">
    <table>
        <tr>
            <td colspan="6" align="center">
                <h3>환불완료</h3>
            </td>
        </tr>

        <tr>
            <th style="width: 8%">주문번호</th>
            <th style="width: auto">상품명</th>
            <th style="width: 8%">수량</th>
            <th style="width: 15%">금액(총)</th>
            <th style="width: 12%">주문상태</th>
            <th style="width: 12%">주문날짜</th>
        </tr>

        <c:forEach items="${ordersList_180}" var="order" varStatus="stat1">
            <tr>
                <!-- 주문번호 -->
                <td rowspan="${order.orders_lists.size()}">
                    <a href="javascript:list_disp('saleLine${stat1.index}')">
                            ${order.num}
                    </a>
                </td>

                <c:forEach items="${order.orders_lists}" var="orders_lists" varStatus="stat2">
                    <c:if test="${stat2.index eq 0}">
                        <!-- 상품명 -->
                        <td style="padding-bottom: 0">
                            <div class="row">
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
                                <a href="${path}/shop/detail.shop?item_no=${itemno}" style="margin-bottom: 15px; width: 80%">
                                    <div class="row" style="text-align: left; margin-left: 10px; margin-right: 100px">
                                        <div><img src="${path}/item/img/${itemno}/<%= mainpic %>" style="width: 50px; height: 50px"></div>
                                        <div style="margin-left: 10px; margin-top: 12px"><h6><%= itemname %></h6></div>
                                    </div>
                                </a>
                                <c:if test="${order.status eq '3'}">
                                    <div style="text-align: right; margin-top: 16px; padding-right: 20px; padding-left: 20px; width: 20%">
                                        <a href="javascript:win_reply_write(${itemno})">후기작성</a>
                                    </div>
                                </c:if>
                            </div>
                        </td>

                        <!-- 수량 -->
                        <td>
                                ${orders_lists.quantity}개
                        </td>
                    </c:if>
                </c:forEach>

                <!-- 금액(총) -->
                <td rowspan="${order.orders_lists.size()}">
                        ${order.price_total} 원
                </td>

                <!-- 주문상태 -->
                <td rowspan="${order.orders_lists.size()}">
                    <c:choose>
                        <c:when test="${order.status eq '0'}">
                            입금대기중
                        </c:when>
                        <c:when test="${order.status eq '1'}">
                            입금확인
                        </c:when>
                        <c:when test="${order.status eq '2'}">
				상품준비중
                        </c:when>
                        <c:when test="${order.status eq '3'}">
                            <div style="margin-bottom: 8px">발송완료</div>
                            <div><a href="https://service.epost.go.kr/trace.RetrieveDomRigiTraceList.comm?sid1=&displayHeader=N" target="_blank">배송조회<br> (ex우체국택배)</a></div>
                        </c:when>
                        <c:when test="${order.status eq '4'}">
                            취소접수
                        </c:when>
                        <c:when test="${order.status eq '5'}">
                            취소완료
                        </c:when>
                        <c:when test="${order.status eq '6'}">
                            환불접수
                        </c:when>
                        <c:when test="${order.status eq '7'}">
                            환불완료
                        </c:when>
                    </c:choose>
                </td>

                <!-- 주문날짜 -->
                <td rowspan="${order.orders_lists.size()}">
                    <c:set var="update_time" value="${order.update_time}" />
                    <%
                        Date date = (Date)pageContext.getAttribute("update_time");
                        String datestr = "";

                        if (date != null) {
                            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");

                            datestr = simpleDateFormat.format(date);
                        }
                    %>
                    <%= datestr  %>
                </td>
            </tr>

            <!-- 주문한 상품이 2개 이상 있을때 -->
            <c:forEach items="${order.orders_lists}" var="orders_lists" varStatus="stat3">
                <c:if test="${stat3.index gt 0}">
                    <tr>
                        <!-- 상품명 -->
                        <td style="padding-bottom: 0">
                            <div class="row">
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
                                <a href="${path}/shop/detail.shop?item_no=${itemno}" style="margin-bottom: 15px; width: 80%">
                                    <div class="row" style="text-align: left; margin-left: 10px; margin-right: 100px">
                                        <div><img src="${path}/item/img/${itemno}/<%= mainpic %>" style="width: 50px; height: 50px"></div>
                                        <div style="margin-left: 10px; margin-top: 12px"><h6><%= itemname %></h6></div>
                                    </div>
                                </a>
                                <c:if test="${order.status eq '3'}">
                                    <div style="text-align: right; margin-top: 16px; padding-right: 20px; padding-left: 20px; width: 20%">
                                        <a href="javascript:win_reply_write(${itemno})">후기작성</a>
                                    </div>
                                </c:if>
                            </div>
                        </td>
                        <!-- 수량 -->
                        <td>
                                ${orders_lists.quantity}개
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
        </c:forEach>
    </table>
</div>
</body>
</html>
