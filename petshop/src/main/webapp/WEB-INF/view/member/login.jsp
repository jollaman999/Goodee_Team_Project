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
    <div class="wrap-login100 p-l-55 p-r-55 p-t-80 p-b-30" style="margin-top: 80px; margin-bottom: 80px">
        <form:form modelAttribute="member" method="post" action="login.shop" class="login100-form validate-form">
            <%
                String back_url = request.getParameter("back_url");

                if (back_url == null) {
                    back_url = request.getHeader("referer");
                    if (back_url != null && back_url.contains("member") && back_url.contains("find")) {
                        back_url = "../index.jsp";
                    }
                }
            %>
            <input type="hidden" name="back_url" value="<%= back_url %>">

            <input type="hidden" name="name" value="유효성 검증 통과">
            <input type="hidden" name="phone" value="유효성 검증 통과">
            <input type="hidden" name="email" value="유효성 검증 통과">
            <input type="hidden" name="address" value="유효성 검증 통과">
            <input type="hidden" name="postcode" value="유효성 검증 통과">

            <span class="login100-form-title p-b-37">
                Login
            </span>

            <div class="wrap-input100 validate-input m-b-20" data-validate="아이디 입력">
                <input class="input100" type="text" name="id" placeholder="ID" value="${param.id}">
                <span class="focus-input100"></span>
            </div>

            <div class="wrap-input100 validate-input m-b-25" data-validate="비밀번호 입력">
                <input class="input100" type="password" name="pass" placeholder="Password">
                <span class="focus-input100"></span>
            </div>

            <div style="text-align: center">
                <spring:hasBindErrors name="member">
                    <font color="red"> <c:forEach items="${errors.globalErrors}"
                                                  var="error">
                        <spring:message code="${error.code}"/>
                    </c:forEach>
                    </font>
                </spring:hasBindErrors>
            </div>

            <div class="container-login100-form-btn" style="margin-top: 30px;">
                <input type="submit" value="로그인" class="login100-form-btn">
                <input type="button" value="회원가입" onclick="location.href='memberEntry.shop'" class="login100-form-btn" style="margin-left: 20px">
            </div>
            <div style="text-align: center; margin-top: 45px; margin-bottom: 10px">
                <a href="find_id_form.shop">아이디 찾기</a>
            </div>
            <div style="text-align: center; margin-bottom: 10px">
                <a href="find_pw_form.shop">비밀번호  찾기</a>
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