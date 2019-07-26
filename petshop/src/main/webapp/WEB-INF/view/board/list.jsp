<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set value="${pageContext.request.contextPath}" var="path"/>
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

    <link rel="stylesheet" type="text/css" href="${path}/css/w3.css">
</head>
<body>
<br>
<table>
    <tr>
        <td colspan="5">
            <form action="list.shop" method="post" name="searcform">
                <input type="hidden" name="type" value="${param.type}">
                <input type="hidden" name="pageNum" value="1">
                <select name="searchtype" style="width: 120px;">
                    <option value="">선택하세요</option>
                    <option value="title">제목</option>
                    <c:if test="${sessionScope.loginMember.id == 'admin'}">
                        <option value="name">글쓴이</option>
                    </c:if>
                    <option value="content">내용</option>
                    <option value="item_name">상품이름</option>
                    <!-- 상품이름 value 바꾸기 -->
                </select>
                <script>
                    document.searcform.searchtype.value = "${param.searchtype}";
                </script>
                <input type="text" name="searchcontent"
                       value="${param.searchcontent}" style="width: 250px;"> <input
                    type="submit" value="검색">
            </form>
        </td>
    </tr>
    <c:if test="${listcount > 0}">
        <tr>
            <td colspan="4">Spring 게시판</td>
            <td>글개수 : ${listcount}</td>
        </tr>
        <tr>
            <th width="10%">번호</th>
            <th width="10%">상품이름</th>
            <th>제목</th>
            <th width="12%">글쓴이</th>
            <th width="15%">날짜</th>
        </tr>
        <c:forEach var="board" items="${boardlist}">
            <tr>
                <td>${boardno}</td>
                <td>${board.item_name}</td>
                <c:set var="boardno" value="${boardno - 1}"/>
                <td style="text-align: left"><c:choose>
                    <c:when test="${!empty board.fileurl}">
                        <a href="file/${board.num}/${board.fileurl}"><img
                                src="../img/file.png" width="15px"></a>
                    </c:when>
                    <c:otherwise>
                        &nbsp;&nbsp;&nbsp;
                    </c:otherwise>
                </c:choose> <a href="detail.shop?type=${param.type}&num=${board.num}">${board.title}</a>
                </td>
                <td>${board.name}</td>
                <td><fmt:formatDate value="${board.regdate}"
                                    pattern="yyyy-MM-dd"/></td>
            </tr>
        </c:forEach>
        <tr>
            <td colspan="5" style="border-bottom: 0">
				<%-- 페이지 처리 부분 --%>
				<div class="w3-center" style="margin-top: 6px">
					<div class="w3-bar">
						<c:choose>
							<c:when test="${pageNum <= 1}">
								<div class="w3-bar-item">«</div>
							</c:when>
							<c:otherwise>
								<a href="javascript:listcall(${pageNum - 1})" class="w3-bar-item w3-button w3-hover-deep-purple">«</a>
							</c:otherwise>
						</c:choose>
						<c:forEach var="a" begin="${startpage}" end="${endpage}">
							<c:choose>
								<c:when test="${a == pageNum}">
									<div class="w3-bar-item w3-deep-purple">
											${a}
									</div>
								</c:when>
								<c:otherwise>
									<a href="javascript:listcall(${a})" class="w3-bar-item w3-button w3-hover-deep-purple">${a}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="${pageNum >= endpage}">
								<div class="w3-bar-item">»</div>
							</c:when>
							<c:otherwise>
								<a href="javascript:listcall(${pageNum + 1})" class="w3-bar-item w3-button w3-hover-deep-purple">»</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</td>
        </tr>
    </c:if>
    <c:if test="${listcount == 0}">
        <tr>
            <td colspan="5">등록된 게시물이 없습니다!</td>
        </tr>
    </c:if>
</table>
</body>
</html>
