<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    </script>
</head>
<body>

<!-- 서치  -->
<!-- <table>
    <tr>
        <td colspan="5">
            <form action="list.shop" method="post" name="searchform">
                <input type="hidden" name="pageNum" value="1">
                <select name="searchtype">
                    <option value="">선택하세요</option>
                    <option value="subject">Id</option>
                    <option value="name">Name</option>
                    <option value="content">Phone</option>
                    <option value="content">Email</option>
                    <option value="content">Postcode</option>
                </select>
                <input type='text' name='word' value='' placeholder="특수문자는 사용할수 없습니다.">
                <button type='submit'>검색</button>

            </form>
        </td>
    </tr>
</table> -->

	<div style="">
    
            <form action="list.shop" method="post" name="searchform" style=" text-align: center;" >
                <input type="hidden" name="pageNum" value="1">
                <select name="searchtype">
                    <option value="">선택하세요</option>
                    <option value="subject">Id</option>
                    <option value="name">Name</option>
                    <option value="content">Phone</option>
                    <option value="content">Email</option>
                    <option value="content">Postcode</option>
                </select>
                <input type='text' name='word' value='' style="width:400px;" placeholder="특수문자는 사용할수 없습니다.">
                <button type='submit'>검색</button>

            </form>
 	</div> 
 	<br>
<!-- 테이블 -->
<form action="mailForm.shop" method="post">
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

        <!--버튼-->
        <tr>
            <td colspan="7">
                <input type="submit" value="메일보내기">&nbsp;&nbsp;
                <input type="button" value="delete" onclick="location.href='delete.shop?id=${member.id}'">&nbsp;&nbsp;
            </td>
        </tr>
    </table>  <!--  테이블 종료  -->
</form>
</body>
</html>
