<!-- orders.mapper 쿼리작성 orders dao 에서 선언. 컨트롤러에서 멤버호출후 객체 생성. -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set value="${pageContext.request.contextPath}" var="path"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <title>판매 내역 </title>

    <!-- 프린트 -->
    <script type="text/javascript" src="${path}/js/jquery.techbytarun.excelexportjs.min.js"></script>
    <!-- 구글 차트  -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <script type="text/javascript">
        // 프린트 버튼
        function printIt(printThis) {
            var win;
            win = window.open();
            self.focus();
            win.document.open();
            win.document.write("<style type='text/css'>");
            win.document.write("tbody tr:nth-child(even) {\n" +
                "    background-color: #f8f8f8;\n" +
                "}\n" +
                "\n" +
                "tbody tr:nth-child(odd) {\n" +
                "    background-color: #ffffff;\n" +
                "}\n" +
                "\n" +
                "tbody tr {\n" +
                "    font-size: 15px;\n" +
                "    color: #2a2a2a;\n" +
                "    line-height: 1;\n" +
                "    font-weight: unset;\n" +
                "}\n" +
                "\n" +
                "table {\n" +
                "    font-family: \"Malgun Gothic\", sans-serif;\n" +
                "    border-spacing: 1px;\n" +
                "    border-collapse: collapse;\n" +
                "    -moz-border-radius: 6px;\n" +
                "    -webkit-border-radius: 6px;\n" +
                "    border-radius: 6px;\n" +
                "    overflow: hidden;\n" +
                "    width: 100%;\n" +
                "    margin: 0 auto;\n" +
                "    position: relative;\n" +
                "    font-size: 12pt;\n" +
                "    background: #e7e7e7;\n" +
                "    border: 1px solid #e7e7e7;\n" +
                "    -webkit-box-shadow: 0 1px 1px #ccc;\n" +
                "    -moz-box-shadow: 0 1px 1px #ccc;\n" +
                "    box-shadow: 0 1px 1px #ccc;\n" +
                "}\n" +
                "\n" +
                "table * {\n" +
                "    position: relative;\n" +
                "}\n" +
                "\n" +
                "table th {\n" +
                "    font-size: 16px;\n" +
                "    background: #282828;\n" +
                "    color: white;\n" +
                "    height: 48px;\n" +
                "    border: 0;\n" +
                "}\n" +
                "\n" +
                "table tbody tr {\n" +
                "    min-height: 50px;\n" +
                "}\n" +
                "\n" +
                "table td {\n" +
                "    padding: 15px;\n" +
                "    text-align: center;\n" +
                "    border: 1px solid #e7e7e7;\n" +
                "}\n" +
                "\n" +
                "table th {\n" +
                "    text-align: center;\n" +
                "}\n" +
                "\n" +
                "table td.l, table th.l {\n" +
                "    text-align: center;\n" +
                "}\n" +
                "\n" +
                "table td.c, table th.c {\n" +
                "    text-align: center;\n" +
                "}\n" +
                "\n" +
                "table td.r, table th.r {\n" +
                "    text-align: center;\n" +
                "}\n" +
                "\n" +
                "th:first-child {\n" +
                "    -moz-border-radius: 6px 0 0 0;\n" +
                "    -webkit-border-radius: 6px 0 0 0;\n" +
                "    border-radius: 6px 0 0 0;\n" +
                "}\n" +
                "\n" +
                "th:last-child {\n" +
                "    -moz-border-radius: 0 6px 0 0;\n" +
                "    -webkit-border-radius: 0 6px 0 0;\n" +
                "    border-radius: 0 6px 0 0;\n" +
                "}\n" +
                "\n" +
                "th:only-child {\n" +
                "    -moz-border-radius: 6px 6px 0 0;\n" +
                "    -webkit-border-radius: 6px 6px 0 0;\n" +
                "    border-radius: 6px 6px 0 0;\n" +
                "}\n" +
                "\n" +
                "tr:last-child td:first-child {\n" +
                "    -moz-border-radius: 0 0 0 6px;\n" +
                "    -webkit-border-radius: 0 0 0 6px;\n" +
                "    border-radius: 0 0 0 6px;\n" +
                "}\n" +
                "\n" +
                "tr:last-child td:last-child {\n" +
                "    -moz-border-radius: 0 0 6px 0;\n" +
                "    -webkit-border-radius: 0 0 6px 3px;\n" +
                "    border-radius: 0 0 6px 3px;\n" +
                "}\n" +
                "\n" +
                "body{\n" +
                "    -webkit-print-color-adjust:exact;\n" +
                "}");
            win.document.write("</style>");
            win.document.write(printThis);
            win.document.close();
            win.print();
            win.close();
        }

        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            var data = google.visualization.arrayToDataTable([
                ['Item', 'Sold Quantity'],
                <c:forEach items="${itemList}" var="item">
                ['${item.name}', ${item.sold_quantity}],
                </c:forEach>
            ]);
            var options = {
                title: '상품별 판매 비율',
                width: 0,
                height: 900
            };
            var chart = new google.visualization.PieChart(document.getElementById('piechart'));
            chart.draw(data, options);

            $(window).resize(function(){
                var container = document.getElementById("piechart").firstChild.firstChild;
                container.style.width = "100%";

                chart.draw(data, options);
            });
        }
    </script>

    <link rel="stylesheet" type="text/css" href="${path}/css/w3.css">

    <style>
        a {
            color: #000000;
        }

        a:hover {
            color: #7d858b;
        }
    </style>
</head>

<body>

<h2 style="margin-bottom: 80px">
    <a href="${path}/inventory/money_day.shop">날짜별</a>&nbsp;&nbsp;
    <a href="${path}/inventory/money_month.shop">월별</a>&nbsp;&nbsp;
    <a href="${path}/inventory/money_year.shop">년별</a>&nbsp;&nbsp;
    <a href="${path}/inventory/money_item.shop">상품별</a>
</h2>

<h3 style="text-align: center; margin-bottom: 50px">상품별 수익</h3>

<!-- 테이블 바 상단 버튼 -->
<div style="margin-bottom: 20px">
    <!-- 엑셀 -->
    <a class="w3-button w3-dark-gray w3-round" id="btnExport" href="#" download="" style="margin-right: 5px">
        Excel 로 저장
    </a>

    <!-- 프린트 버튼 -->
    <input class="w3-button w3-dark-gray w3-round" type="button" value="프린트 하기"
           onclick="printIt(document.getElementById('printme').innerHTML)"/>
</div>

<!-- orders 테이블에 status=1(입금확인) 만 가져옴.orders mapper 에서 확인  -->
<div id="printme">
    <table id='tblExport'>
        <!-- 테이블 바 이름 -->
        <tr>
            <th>제품이름</th>
            <th>판매가</th>
            <th>판매량</th>
            <th>누적 판매금액</th>
        </tr>
        <!-- 아이템 리스트 가져오기 -->
        <c:forEach items="${itemList}" var="item">
            <!-- 판매량이 0인것들은 출력하지 않음.-->
            <c:if test="${item.sold_quantity != 0}">
                <!-- 테이블 바 value-->
                <tr>
                    <td>
                        ${item.name}
                    </td>

                    <!--  가격   -->
                    <td>
                        <fmt:formatNumber type="CURRENCY" pattern="###,###" value="${item.price}"/>\
                    </td>

                    <!-- 판매량  -->
                    <td>
                        ${item.sold_quantity}
                    </td>

                    <!-- 누적 판매량  -->
                    <td>
                        <fmt:formatNumber type="CURRENCY" pattern="###,###" value="${item.sold_quantity*item.price}"/>\
                    </td>
                </tr>
            </c:if>
        </c:forEach>
    </table>
</div>

<!-- 구글 차트 출력  -->
<div id="piechart"></div>

<script type="text/javascript">
    // 엑셀
    $(document).ready(function () {

        function itoStr($num) {
            $num < 10 ? $num = '0' + $num : $num;
            return $num.toString();
        }

        var btn = $('#btnExport');
        var tbl = 'tblExport';

        btn.on('click', function () {
            var dt = new Date();
            var year = itoStr(dt.getFullYear());
            var month = itoStr(dt.getMonth() + 1);
            var day = itoStr(dt.getDate());
            var hour = itoStr(dt.getHours());
            var mins = itoStr(dt.getMinutes());

            var postfix = year + month + day + "_" + hour + mins;
            var fileName = "HotDogMall_Item_" + postfix + ".xls";

            var uri = $("#" + tbl).excelexportjs({
                containerid: tbl
                , datatype: 'table'
                , returnUri: true
            });

            $(this).attr('download', fileName).attr('href', uri).attr('target', '_blank');
        });
    });
</script>
</body>
</html>
