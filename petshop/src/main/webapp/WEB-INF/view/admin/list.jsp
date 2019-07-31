<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set value="${pageContext.request.contextPath}" var="path"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 목록</title>

    <script type="text/javascript">
        function allchkbox(allchk) {
            var chks = document.getElementsByName("idchks");
            for (var i = 0; i < chks.length; i++) {
                chks[i].checked = allchk.checked;
            }
        }

        function listcall(page) {
            document.topform.pageNum.value = page;
            document.topform.submit();
        }

        function limitcall() {
            document.topform.submit();
        }
    </script>

    <link rel="stylesheet" type="text/css" href="${path}/css/w3.css">
</head>
<body>
<form action="list.shop" method="post" name="topform" >
    <div style="text-align: center; margin-bottom: 20px">
        <input type="hidden" name="pageNum" value="${pageNum}">
        <select name="searchtype">
            <option value="">선택하세요</option>
            <option value="id">Id</option>
            <option value="name">Name</option>
            <option value="phone">Phone</option>
            <option value="email">Email</option>
            <option value="postcode">Postcode</option>
        </select>
        <script>
            document.topform.searchtype.value = "${param.searchtype}";
        </script>
        <input type='text' name='searchcontent' style="width:400px" placeholder="특수문자는 사용할수 없습니다." value="${searchcontent}">
        <input type='submit' value="검색">
    </div>

    <div style="text-align: right; margin-bottom: 15px">

        표시할 회원 수&nbsp;&nbsp;

        <select id="limit" name="limit" onchange="limitcall()">
            <option value="5">5</option>
            <option value="10">10</option>
            <option value="15">15</option>
            <option value="20">20</option>
            <script>
                document.getElementById("limit").value = "${limit}";
            </script>
        </select>
        &nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;

        회원 수

        : ${listcount}
    </div>
</form>

<!-- 테이블 -->
<form name="memberform" action="mailForm.shop" method="post">
    <table>
        <tr>
            <td colspan="7">회원 목록</td>
        </tr>
        <tr>
            <th>Id</th>
            <th>Name</th>
            <th>Phone</th>
            <th>Email</th>
            <th>Postcode</th>
            <th>&nbsp;</th>
            <th><input type="checkbox" name="allchk" onchange="allchkbox(this)"></th>
        </tr>
        <c:forEach items="${list}" var="member">
            <!-- member 값 받아옴 -->
            <tr>
                <td>${member.id}</td>
                <td>${member.name}</td>
                <td>${member.phone}</td>
                <td>${member.email}</td>
                <td>${member.postcode}</td>
                <td>
                    <a href="../member/update.shop?id=${member.id}">수정</a>&nbsp;&nbsp;
                    <a href="../member/mypage.shop?id=${member.id}">상세정보</a>
                </td>

                <!--  체크 박스    -->
                <td>
                    <input type="checkbox" name="idchks" value="${member.id}">
                </td>
            </tr>
        </c:forEach>

        <tr>
            <td colspan="7" style="border-bottom: 0">
                <%-- 페이지 처리 부분 --%>
                <div class="w3-center" style="margin-top: 6px">
                    <div class="w3-bar">
                        <c:choose>
                            <c:when test="${pageNum <= 1}">
                                <div class="w3-bar-item">«</div>
                            </c:when>
                            <c:otherwise>
                                <a href="javascript:listcall(${pageNum - 1})"
                                   class="w3-bar-item w3-button w3-hover-deep-purple">«</a>
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
                                    <a href="javascript:listcall(${a})"
                                       class="w3-bar-item w3-button w3-hover-deep-purple">${a}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <c:choose>
                            <c:when test="${pageNum >= endpage}">
                                <div class="w3-bar-item">»</div>
                            </c:when>
                            <c:otherwise>
                                <a href="javascript:listcall(${pageNum + 1})"
                                   class="w3-bar-item w3-button w3-hover-deep-purple">»</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </td>
        </tr>

        <!--버튼-->
        <tr>
            <td colspan="7">
                <input type="submit" value="메일보내기">&nbsp;&nbsp;
            </td>
        </tr>
    </table>  <!--  테이블 종료  -->
</form>
</body>
</html>
