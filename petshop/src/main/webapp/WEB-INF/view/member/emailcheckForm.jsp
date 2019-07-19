<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path"/>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>이메일 중복 체크</title>

    <link rel="stylesheet" type="text/css" href="${path}/css/style.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/submitform.css">

    <script type="text/javascript" src="${path}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript">
        function email_check() {
            const email = document.getElementById("email");

            if (!email.value || email.value === "") {
                alert("이메일을 입력하세요!");
                email.focus();
                return;
            }

            if ($('input[id="email"]').val().trim().match(/^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{1,5}|[0-9]{1,3})(\]?)$/) == null) {
                alert("올바른 이메일 주소를 입력하세요!");
                email.focus();
                return;
            }

            location.href="emailcheck.shop?email=" + email.value;
        }

        function Enter_Check(){
            if(event.keyCode === 13){
                email_check();
            }
        }
    </script>
</head>
<body>
<c:if test="${duplicated}">
    <script>
        opener.document.f.checked_duplicate_email.value=0;
    </script>
</c:if>
<div style="margin-top: 20px">
    <div style="text-align: center">
        <input type="text" name="email" id="email" style="height: 45px; width: 400px; margin-right: 15px; background: #f3f3f3;
                    padding-left: 20px; padding-right: 20px; font-size: 14pt" class="wrap-input100" value="${param.email}" placeholder="E-MAIL" onkeydown="Enter_Check()">
        <input id="search_btn" type="button" value="중복확인" class="submit-btn" style="margin-top: -3px" onclick="email_check()">
    </div>
</div>
</body>
</html>
