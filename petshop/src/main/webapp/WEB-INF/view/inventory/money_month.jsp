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

        //  구글 차트
        google.charts.load('current', {packages: ['corechart', 'line']});
        google.charts.setOnLoadCallback(drawBasic);

        function drawBasic() {
            var data = new google.visualization.DataTable();

            //오른쪽 인덱스 표기
            data.addColumn('string', '월');
            data.addColumn('number', '월별 총판매금');


            // [시간(YY,MM,DD),총판매가격]
            data.addRows([
                <c:forEach items="${month_profit}" var="monthprofit">

                ["<fmt:formatDate value="${monthprofit.update_time}" pattern="yyyy"/>년 <fmt:formatDate value="${monthprofit.update_time}" pattern="MM"/>월", ${monthprofit.price_total}],
                </c:forEach>
            ]);

            // 차트 옵션
            var options = {
                title: '',
                width: 0,
                height: 900,

                hAxis: {
                    slantedText:true,
                    slantedTextAngle:90 // here you can even use 180
                }
            };

            var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
            chart.draw(data, options);

            $(window).resize(function(){
                var container = document.getElementById("chart_div").firstChild.firstChild;
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

<h3 style="text-align: center; margin-bottom: 50px">월별 수익</h3>

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
            <th>월</th>
            <th>총 판매금</th>
            <th>전월 대비 수익</th>
        </tr>
        <!-- 수익 리스트 가져오기 -->
        <c:forEach items="${month_profit}" var="monthprofit">
            <tr>
                <td><fmt:formatDate value="${monthprofit.update_time}" pattern="yyyy년 MM월"/></td>
                <td><fmt:formatNumber type="currency" pattern="###,###" value="${monthprofit.price_total}"/>\</td>
                <td>
                    <c:choose>
                        <c:when test="${empty monthprofit.totaldiff}">
                            전월 수익 비교 모델이 없습니다.
                        </c:when>
                        <c:otherwise>
                            <fmt:formatNumber type="currency" pattern="###,###" value="${monthprofit.totaldiff}"/>\
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<!-- 구글 차트 출력  -->
<div id="chart_div" style="text-align: center"></div>
<!--  https://jsfiddle.net/api/post/library/pure/
      https://private.tistory.com/66 -->

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
            var fileName = "HotDogMall_M_" + postfix + ".xls";

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
