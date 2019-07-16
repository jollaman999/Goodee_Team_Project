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
    <title>로그인</title>


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
    <div class="wrap-login100 p-l-55 p-r-55 p-t-80 p-b-30">
        <form:form modelAttribute="member" method="post" action="login.shop" class="login100-form validate-form">
            <input type="hidden" name="back_url" value="<%= request.getHeader("referer") %>">

            <input type="hidden" name="name" value="유효성 검증 통과">
            <input type="hidden" name="phone" value="유효성 검증 통과">
            <input type="hidden" name="email" value="유효성 검증 통과">
            <input type="hidden" name="address" value="유효성 검증 통과">
            <input type="hidden" name="postcode" value="유효성 검증 통과">

            <spring:hasBindErrors name="member">
                <font color="red"> <c:forEach items="${errors.globalErrors}"
                                              var="error">
                    <spring:message code="${error.code}"/>
                </c:forEach>
                </font>
            </spring:hasBindErrors>

            <span class="login100-form-title p-b-37">
                Login
            </span>

            <div class="wrap-input100 validate-input m-b-20" data-validate="아이디 입력">
                <input class="input100" type="text" name="id" placeholder="ID">
                <span class="focus-input100"></span>
            </div>

            <div class="wrap-input100 validate-input m-b-25" data-validate="비밀번호 입력">
                <input class="input100" type="password" name="pass" placeholder="Password">
                <span class="focus-input100"></span>
            </div>

            <div class="container-login100-form-btn" style="margin-top: 30px;">
                <button type="submit" class="login100-form-btn">
                    로그인
                </button>
                <button onclick="location.href='memberEntry.shop'" class="login100-form-btn" style="margin-left: 10px">
                    회원가입
                </button>

                <button onclick="location.href='../member/find_id_form.shop'" class="login100-form-btn"
                        style="margin-left: 10px">
                    아이디 찾기
                </button>

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