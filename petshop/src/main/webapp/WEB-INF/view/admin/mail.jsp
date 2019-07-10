<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메일 보내기</title>
    <script src="https://cdn.ckeditor.com/4.11.4/standard/ckeditor.js"></script>
    <script type="text/javascript">
        function idinputckl(f) {
            if (f.brand.value == "") {
                alert("메일 브랜드를 입력하세요!");
                f.id.focus();

                return false;
            }

            if (f.id.value == "") {
                alert("메일 아이디를 입력하세요!");
                f.id.focus();

                return false;
            }

            if (f.pw.value == "") {
                alert("메일 비밀번호를 입력하세요!");
                f.pw.focus();

                return false;
            }

            return true;
        }
    </script>
</head>
<body>
<h2>메일 보내기</h2>
<form name="mailform" method="post" action="mail.shop" enctype="multipart/form-data" onsubmit="return idinputckl(this)">
    <table>
        <tr>
            <td width="20%" rowspan="2">
                메일 브랜드 :
                <select name="brand">
                    <option value="daum">Daum</option>
                    <option value="naver">Naver</option>
                    <option value="gmail">Gmail</option>
                    <option value="nate">Nate</option>
                </select>
            </td>
            <td width="12%">메일 아이디</td>
            <td><input type="text" name="id"></td>
        </tr>
        <tr>
            <td>메일 비밀번호</td>
            <td><input type="password" name="pw"></td>
        </tr>
    </table>
    <br>
    <table>
        <tr>
            <td>보내는 사람</td>
            <td>${loginUser.email}</td>
        </tr>
        <tr>
            <td>받는 사람</td>
            <td>
                <input type="text" name="recipient" size="100"
                       value="<c:forEach items="${userList}" var="user" varStatus="stat">${user.userName} &lt;${user.email}&gt;<c:if test="${!stat.last}">, </c:if></c:forEach>">
            </td>
        </tr>
        <tr>
            <td>제목</td>
            <td><input type="text" name="title" size="100"></td>
        </tr>
        <tr>
            <td>메시지 형식</td>
            <td>
                <select name="mtype">
                    <option value="text/html; charset=utf-8">HTML</option>
                    <option value="text/plain; charset=utf-8">TEXT</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>첨부파일 1</td>
            <td><input type="file" name="file1"></td>
        </tr>
        <tr>
            <td>첨부파일 2</td>
            <td><input type="file" name="file1"></td>
        </tr>
        <tr>
            <td colspan="2">
                <textarea name="contents" cols="120" rows="10"></textarea>
                <script type="text/javascript">CKEDITOR.replace("contents")</script>
            </td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" value="메일 보내기"></td>
        </tr>
    </table>
</form>
</body>
</html>

