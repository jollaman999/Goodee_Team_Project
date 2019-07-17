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
	<title>비밀번호 찾기</title>


	<link rel="stylesheet" type="text/css" href="${path}/fonts/iconic/css/material-design-iconic-font.min.css">
	<link rel="stylesheet" type="text/css" href="${path}/vendor/animate/animate.css">
	<link rel="stylesheet" type="text/css" href="${path}/vendor/css-hamburgers/hamburgers.min.css">
	<link rel="stylesheet" type="text/css" href="${path}/vendor/animsition/css/animsition.min.css">
	<link rel="stylesheet" type="text/css" href="${path}/vendor/select2/select2.min.css">
	<link rel="stylesheet" type="text/css" href="${path}/vendor/daterangepicker/daterangepicker.css">
	<link rel="stylesheet" type="text/css" href="${path}/css/loginform-util.css">
	<link rel="stylesheet" type="text/css" href="${path}/css/loginform-main.css">
</head>
<body>
<div class="container-login100">
	<div class="wrap-login100 p-l-55 p-r-55 p-t-80 p-b-30" style="margin-top: 80px; margin-bottom: 80px; width: 500px">
		<form:form modelAttribute="member" method="post" action="find_pw.shop" class="login100-form validate-form">
            <span class="login100-form-title p-b-37">
                Find Password
            </span>

			<div class="wrap-input100 validate-input m-b-20" data-validate="아이디 입력">
				<input class="input100" type="text" name="id" placeholder="ID">
				<span class="focus-input100"></span>
			</div>

			<div class="wrap-input100 validate-input m-b-20" data-validate="올바른 이메일 주소를 입력해 주세요">
				<input class="input100" type="text" id="email" name="email" placeholder="E-MAIL">
				<span class="focus-input100"></span>
			</div>

			<div class="container-login100-form-btn" style="margin-top: 30px;">
				<input type="submit" value="Find" class="login100-form-btn">
				<input type="button" value="Cancel" onclick="history.go(-1)" class="login100-form-btn" style="margin-left: 20px">
			</div>
		</form:form>
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