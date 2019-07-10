<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 목록</title>

    <script type="text/javascript">
        function listcall(page) {
            document.searcform.pageNum.value = page;
            document.searcform.submit();
        }
    </script>
</head>
<body>
<table>
    <tr>
        <td colspan="5">
            <form action="list.shop" method="post" name="searcform">
                <input type="hidden" name="pageNum" value="1">
                <table>
                    <tr>
                        <td>
                            <select name="searchtype">
                                <option value="">선택하세요</option>
                                <option value="subject">제목</option>
                                <option value="name">작성자</option>
                                <option value="content">내용</option>
                            </select>
                            <script>
                                document.searcform.searchtype.value = "${param.searchtype}";
                            </script>
                        </td>
                        <td width="100%">
                            <input type="text" name="searchcontent" value="${param.searchcontent}">
                        </td>
                        <td>
                            <input type="submit" value="검색">
                        </td>
                    </tr>
                </table>
            </form>
        </td>
    </tr>
    <c:if test="${listcount > 0}">
        <tr>
            <td colspan="4">Spring 게시판</td>
            <td>글개수 : ${listcount}</td>
        </tr>
        <tr>
            <th width="7%">번호</th>
            <th>제목</th>
            <th width="12%">글쓴이</th>
            <th width="20%">날짜</th>
            <th width="10%">조회 수</th>
        </tr>
        <c:forEach var="board" items="${boardlist}">
            <tr>
                <td>${boardno}</td>
                <c:set var="boardno" value="${boardno - 1}" />
                <td style="text-align: left">
                    <c:choose>
                        <c:when test="${!empty board.fileurl}">
                            <a href="file/${board.num}/${board.fileurl}"><img src="../img/file.png" width="15px"></a>
                        </c:when>
                        <c:otherwise>
                            &nbsp;&nbsp;&nbsp;
                        </c:otherwise>
                    </c:choose>
                    <c:forEach begin="1" end="${board.reflevel}">&nbsp;&nbsp;</c:forEach>
                    <c:if test="${board.reflevel > 0}">└</c:if>
                    <a href="detail.shop?num=${board.num}">${board.subject}</a>
                </td>
                <td>${board.name}</td>
                <td>${board.regdate}</td>
                <td>${board.readcnt}</td>
            </tr>
        </c:forEach>
        <tr>
            <td colspan="5">
                <c:if test="${pageNum > 1}">
                    <a href="javascript:listcall(${pageNum - 1})">[이전]</a>
                </c:if>
                <c:if test="${pageNum <= 1}">[이전]</c:if>
                <c:forEach var="a" begin="${startpage}" end="${endpage}">
                    <c:choose>
                        <c:when test="${a == pageNum}">[${a}]</c:when>
                        <c:otherwise><a href="javascript:listcall(${a})">[${a}]</a> </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${pageNum < maxpage}">
                    <a href="javascript:listcall(${pageNum + 1})">[다음]</a>
                </c:if>
                <c:if test="${pageNum >= maxpage}">[다음]</c:if>
            </td>
        </tr>
    </c:if>
    <c:if test="${listcount == 0}">
        <tr>
            <td colspan="5">등록된 게시물이 없습니다!</td>
        </tr>
    </c:if>
    <tr>
        <td colspan="5" align="right">
            <a href="write.shop">[글쓰기]</a>
        </td>
    </tr>
</table>
</body>
</html>
