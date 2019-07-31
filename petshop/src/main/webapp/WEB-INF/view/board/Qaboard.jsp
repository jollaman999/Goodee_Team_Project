<!-- 1:1 문의 답변 게시판    -->


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>1:1 문의 게시판 </title>
    
<!--  페이지 리스트   -->
   <script type="text/javascript">
        function listcall(page) {
            document.searcform.pageNum.value = page;
            document.searcform.submit();
        }
    </script></head><body>

<!-- 제목 -->
<h2>1:1 문의 게시판 </h2><br>


 
<!-- 1:1문의 리스트 -->
<form action="Qaboard" method="post">
    <table>
        <tr><td colspan="7"></td></tr>
<!-- 테이블 바 이름 -->        
        <tr>
            <th>Name</th>
            <th>Subject</th>
            <th>Content</th>
            <th>file1</th>
            <th>Date</th>            
            <th></th>
            <th><input type="checkbox" name="allchk" onchange="allchkbox(this)"></th>
        </tr>
        
        
<c:forEach items="${list}" var="board">             
        <!-- member 값 받아옴 -->
        <!-- 테이블 바 value-->   
        <tr>
            <td>${board.name}</td>
            <td>${board.subject}</td>
            <td>${board.content}</td>
            <td>${board.file1}</td>
            <td>${board.Date}</td> 
            <td><a href="../board/reply.shop?id=${member.id}">답변</a></td>           
                
<!--  체크 박스    -->       
<td>
  <input type="checkbox" name="idchks" value="${board.id}">
</td></tr></c:forEach>

<!--버튼-->
<tr>
  <td colspan="7">
  <!--  onclick ex : location.href='delete.shop?id=${member.id}  -->
  <input type="button" value="delete" onclick="#">&nbsp;&nbsp;
  </td></tr></table>  <!--  테이블 종료  -->
  
  <!-- 페이지 넘기기 -->
<table>
<tr><td colspan="5">
        <c:if test="${pageNum > 1}">
        <a href="javascript:listcall(${pageNum - 1})">[이전]</a>
        </c:if>
        
        <c:if test="${pageNum <= 1}">[이전]</c:if>
        <c:forEach var="a" begin="${startpage}" end="${endpage}">
        
        <c:choose>
        <c:when test="${a == pageNum}">[${a}]</c:when>
        <c:otherwise><a href="javascript:listcall(${a})">[${a}]</a> </c:otherwise>
        </c:choose> </c:forEach>
        
        <c:if test="${pageNum < maxpage}">
        <a href="javascript:listcall(${pageNum + 1})">[다음]</a>
        </c:if>        
        <c:if test="${pageNum >= maxpage}">[다음]</c:if>
</td></tr></table>      
        
        
</form></body></html>

