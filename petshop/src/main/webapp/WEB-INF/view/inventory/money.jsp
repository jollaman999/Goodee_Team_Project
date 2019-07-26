<!-- orders.mapper 쿼리작성    orders dao 에서 선언. 컨트롤러에서 멤버호출후 객체 생성.    -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set value="${pageContext.request.contextPath}" var="path" />

<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   
    <!-- 프린트 -->
    <script type="text/javascript" src="${path}/js/jquery.techbytarun.excelexportjs.min.js"></script>
    
    <!-- 검색창 가운데 정렬 -->
    <style>
    .centeringContainer { text-align: center; }
    .centered { display: table; margin-left: auto; margin-right: auto; display: inline-block; }
    </style>
     
    <title>판매 내역 </title>
    </head><body>
    
    <h2 style="color:black;">
    <a href="${path}/inventory/money.shop">요일별</a>&nbsp;&nbsp;
    <a href="${path}/inventory/money2.shop">월별</a>&nbsp;&nbsp;
    <a href="${path}/inventory/money3.shop">년별</a>&nbsp;&nbsp;
    <a href="${path}/inventory/money4.shop">상품별</a>                         
    </h2><br><br><br>

<!-- 재고관리 리스트 -->
<form action="selling" method="post">


<table>

<!-- 서치  -->
<tr><td>
<div class="col-xl-6 col-lg-5 centered">
     <input type='text' name='word' value='' placeholder="특수문자는 사용할수 없습니다." style="text-align: center">
     <button type='submit'>검색</button>
</div></td></tr>


<!-- 드랍바 -->
<table>
     <div style="text-align:left"><select name="searchtype">
       <option value="">선택하세요</option>
       <option value="#">그룹코드</option>
       <option value="#">아이템코드</option>
       <option value="#">국가별</option>
     </select></div>
</table><br><br><br><br><br><br>


<!-- orders 테이블에 status=1(입금확인) 만 가져옴.orders mapper 에서 확인  -->

<div id="printme">

<!-- 요일별 판매현황 -->
<h2>요일별 수익</h2><br>

<!-- 테이블 바 상단 버튼 -->

<form>

<!-- 엑셀 -->
<a id="btnExport" href="#" download="">
    <button type='button'>Excel</button>
</a>
 <script type="text/javascript">
    $(document).ready(function () {
 
        function itoStr($num)
        {
            $num < 10 ? $num = '0'+$num : $num;
            return $num.toString();
        }
         
        var btn = $('#btnExport');
        var tbl = 'tblExport';
 
        btn.on('click', function () {
            var dt = new Date();
            var year =  itoStr( dt.getFullYear() );
            var month = itoStr( dt.getMonth() + 1 );
            var day =   itoStr( dt.getDate() );
            var hour =  itoStr( dt.getHours() );
            var mins =  itoStr( dt.getMinutes() );
 
            var postfix = year + month + day + "_" + hour + mins;
            var fileName = "HotDogMall_D_"+ postfix + ".xls";
 
            var uri = $("#"+tbl).excelexportjs({
                containerid: tbl
                , datatype: 'table'
                , returnUri: true
            });
 
            $(this).attr('download', fileName).attr('href', uri).attr('target', '_blank');
        });
    });
</script>



<!-- 프린트 버튼 -->
<input type="button" value="Print" 
onclick="javascript:printIt(document.getElementById('printme').innerHTML)" />
<script type="text/javascript">
function printIt(printThis)
{
    var win = null;
    win = window.open();
    self.focus();
    win.document.open();
    win.document.write(printThis);
    win.document.close();
    win.print();
    win.close();
}
</script>
</form>


<table id='tblExport'>
<!-- 테이블 바 이름 -->
        <tr>
            <th>요일</th>
            <th>총판매금</th>
            <th>전일대비 수익</th>
<!-- 아이템 리스트 가져오기 -->
<c:forEach items="${moneyListDay}" var="moneyDay" varStatus="stat1">
     <tr>
     <td><fmt:formatDate value="${moneyDay.update_time}" pattern="yyyy-MM-dd"/></td>
     <td><fmt:formatNumber type="CURRENCY" pattern="###,###" value="${moneyDay.price_total}"/>\</td>
     
     <!-- 전일대비  -->
     <td>
     	<c:forEach items="${day_profit}" var="dayprofit" varStatus="stat2">
	     	<c:if test="${stat1.index eq stat2.index}">	 
       
	        <c:choose>   	
	     	<c:when test="${empty dayprofit.totaldiff}">
                            전일 수익 비교 모델이 없습니다.
            </c:when>
                      
            <c:when test="${dayprofit.totaldiff eq dayprofit.totaldiff}">
            <fmt:formatNumber type="CURRENCY" pattern="###,###" value="${dayprofit.totaldiff}"/> \
            </c:when>
            </c:choose></c:if>
     	</c:forEach>
     </td>

    </tr></c:forEach>
</tr></table></div></table>  <!--  테이블 종료  -->


</form></body></html>

