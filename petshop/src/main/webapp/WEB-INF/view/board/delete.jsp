<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 삭제 전 확인</title>

    <script type="text/javascript">
        function delete_submit() {
            if (document.f.password.value === "") {
                alert("비밀번호를 입력하세요!");
                return false;
            }

            document.f.submit();
        }
    </script>
</head>
<body>
<h2>게시글을 삭제하시려면 비밀번호를 입력해 주세요.</h2>
<br>
<form action="delete.shop" method="post" name="f">
    <input type="hidden" name="num" value="${param.num}" />

    <table>
        <tr>
            <td>비밀번호</td>
            <td>
                <input type="password" name="password">
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="button" value="삭제" onclick="delete_submit()">&nbsp;&nbsp;
                <input type="button" value="취소" onclick="location.href='detail.shop?num=${param.num}'">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
