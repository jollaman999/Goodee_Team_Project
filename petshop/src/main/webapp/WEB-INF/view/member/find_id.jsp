<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>아이디 찾기 검색결과</title>


    <link rel="stylesheet" type="text/css" href="${path}/fonts/iconic/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" type="text/css" href="${path}/vendor/animate/animate.css">
    <link rel="stylesheet" type="text/css" href="${path}/vendor/css-hamburgers/hamburgers.min.css">
    <link rel="stylesheet" type="text/css" href="${path}/vendor/animsition/css/animsition.min.css">
    <link rel="stylesheet" type="text/css" href="${path}/vendor/select2/select2.min.css">
    <link rel="stylesheet" type="text/css" href="${path}/vendor/daterangepicker/daterangepicker.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/loginform-util.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/loginform-main.css">

    <script>
        $(function () {
            $("#loginBtn").click(function () {
                location.href = 'login_form.shop';
            })
        })
    </script>
</head>
<body>
<div class="container-login100">
     <div class="wrap-login100 p-l-55 p-r-55 p-t-80 p-b-30" style="margin-top: 80px; margin-bottom: 80px; width: 500px">
        <span class="login100-form-title p-b-37">
            Find ID Result
        </span>

        <div style="text-align: center; margin-top: 10px; margin-bottom: 50px">
            <h5>${id}</h5>
        </div>

        <div class="container-login100-form-btn" style="margin-top: 30px;">
            <input type="button" value="로그인" onclick="location.href='login.shop?id=${id}'" class="login100-form-btn">
            <input type="button" value="비밀번호 찾기" onclick="location.href='find_pw_form.shop'" class="login100-form-btn" style="margin-left: 20px">
        </div>
    </div>
</div>

<div id="dropDownSelect1"></div>

<script src="${path}/vendor/animsition/js/animsition.min.js"></script>
<script src="${path}/js/popper.js"></script>
<script src="${path}/js/bootstrap.min.js"></script>
<script src="${path}/vendor/select2/select2.min.js"></script>
<script src="${path}/vendor/daterangepicker/moment.min.js"></script>
<script src="${path}/vendor/daterangepicker/daterangepicker.js"></script>
<script src="${path}/vendor/countdowntime/countdowntime.js"></script>
<script src="${path}/js/loginform/loginform.js"></script>
</body>
</html>