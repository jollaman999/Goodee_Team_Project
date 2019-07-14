<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

        function graph_open(url) {
            var op = "width=800, height=600, scrollbars=yes, left=50, top=150";
            window.open(url + ".shop", "graph", op);
        }
    </script>
</head>
<body>
<form action="mailForm.shop" method="post">
    <table>
        <tr>
            <td colspan="7">회원 목록</td>
        </tr>
        <tr>
            <th>아이디</th>
            <th>이름</th>
            <th>전화</th>
            <th>생일</th>
            <th>이메일</th>
            <th>&nbsp;</th>
            <th><input type="checkbox" name="allchk" onchange="allchkbox(this)"></th>
        </tr>
        <c:forEach items="${list}" var="user">
            <tr>
                <td>${user.userId}</td>
                <td>${user.userName}</td>
                <td>${user.phoneNo}</td>
                <td><fmt:formatDate value="${user.birthDay}" pattern="yyyy-MM-dd" /></td>
                <td>${user.email}</td>
                <td>
                    <a href="../user/update.shop?id=${user.userId}">수정</a>
                    <a href="../user/delete.shop?id=${user.userId}">강제 탈퇴</a>
                    <a href="../user/mypage.shop?id=${user.userId}">회원 정보</a>
                </td>
                <td>
                    <input type="checkbox" name="idchks" value="${user.userId}">
                </td>
            </tr>
        </c:forEach>
        <tr>
            <td colspan="7">
                <input type="submit" value="메일보내기">&nbsp;&nbsp;
            </td>
        </tr>
    </table>
</form>
</body>
</html>
