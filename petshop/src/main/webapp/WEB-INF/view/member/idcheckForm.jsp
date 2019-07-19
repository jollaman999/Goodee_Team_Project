<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path"/>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>ID 중복 체크</title>

    <link rel="stylesheet" type="text/css" href="${path}/css/style.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/submitform.css">

    <script type="text/javascript">
        function id_check() {
            const id = document.getElementById("id");

            if (!id.value || id.value === "") {
                alert("아이디를 입력하세요!")
                id.focus();
                return;
            }

            if (id.value.length < 3 || id.value.length > 50) {
                alert("아이디를 3자 이상 50자 이하로 입력 해주세요!");
                id.focus();
                return;
            }

            location.href="idcheck.shop?id=" + id.value;
        }

        function Enter_Check(){
            if(event.keyCode === 13){
                id_check();
            }
        }
    </script>
</head>
<body>
<c:if test="${duplicated}">
    <script>
        opener.document.f.checked_duplicate_id.value=0;
    </script>
</c:if>
<div style="margin-top: 20px">
    <div style="text-align: center">
        <input type="text" name="id" id="id" style="height: 45px; width: 300px; margin-right: 15px; background: #f3f3f3;
                padding-left: 20px; padding-right: 20px; font-size: 14pt" class="wrap-input100" value="${param.id}" placeholder="ID" onkeydown="Enter_Check()">
        <input id="search_btn" type="button" value="중복확인" class="submit-btn" style="margin-top: -3px" onclick="id_check()">
    </div>
</div>
</body>
</html>
