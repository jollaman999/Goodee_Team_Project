<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set value="${pageContext.request.contextPath}" var="path"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>비밀번호 변경 - 핫 도그몰</title>

    <link rel="stylesheet" type="text/css" href="${path}/fonts/iconic/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" type="text/css" href="${path}/vendor/animate/animate.css">
    <link rel="stylesheet" type="text/css" href="${path}/vendor/css-hamburgers/hamburgers.min.css">
    <link rel="stylesheet" type="text/css" href="${path}/vendor/animsition/css/animsition.min.css">
    <link rel="stylesheet" type="text/css" href="${path}/vendor/select2/select2.min.css">
    <link rel="stylesheet" type="text/css" href="${path}/vendor/daterangepicker/daterangepicker.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/submitform_util.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/submitform.css">

    <!-- https://fontawesome.com/v4.7.0/icons/ -->
    <link rel="stylesheet" type="text/css" href="${path}/css/font-awesome-4.7.min.css">

    <!-- submit check -->
    <script type="text/javascript">
        function join_submit() {
            f = document.f;

            if (!f.previous_password.value) {
                alert("이전 비밀번호를 입력해주세요!");
                f.pass.focus();
                return;
            }

            if (!f.pass.value) {
                alert("새 비밀번호를 입력해주세요!");
                f.pass.focus();
                return;
            }

            if (!f.pass_check.value) {
                alert("새 재확인 비밀번호를 입력해주세요!");
                f.pass_check.focus();
                return;
            }

            if (f.pass.value !== f.pass_check.value) {
                alert("입력한 두 비밀번호가 다릅니다! 새 비밀번호를 재입력 해주세요!");
                f.pass.focus();

                return;
            }

            if (f.pass.value.length < 5 || f.pass.value.length > 100) {
                alert("새 비밀번호를 5자 이상 100자 이하로 입력 해주세요!");
                f.id.focus();
                return;
            }

            f.submit();
        }
    </script>
</head>
<body>
<div style="margin-left: 100px; margin-right: 100px">
    <div style="text-align: center; margin-bottom: 50px">
        <h3>비밀번호 변경</h3>
    </div>
    <form class="contact100-form validate-form" action="update_pw.shop" name="f" method="post">
        <div style="margin-bottom: 15px; color: red; font-size: 18px; font-weight: bold">
            <spring:hasBindErrors name="member">
                <c:forEach items="${errors.globalErrors}" var="error">
                    <spring:message code="${error.code}"/>
                </c:forEach>
            </spring:hasBindErrors>
        </div>

        <div class="wrap-input100 validate-input" data-validate="이전 비밀번호를 입력해주세요!" style="margin-bottom: 80px">
            <i class="input100 fa fa-key fa-fw"
               style="position: absolute; margin-top: 25px; margin-left: 23px; color: #828282"></i>
            <input class="input100" type="password" name="previous_password" placeholder="PREVIOUS PASSWORD">
            <span class="focus-input100"></span>
        </div>

        <div class="wrap-input100 validate-input" id="div-pass" data-validate="새 비밀번호를 입력해주세요!">
            <i class="input100 fa fa-key fa-fw"
               style="position: absolute; margin-top: 25px; margin-left: 23px; color: #828282"></i>
            <input class="input100" type="password" name="pass" placeholder="NEW PASSWORD">
            <span class="focus-input100"></span>
        </div>

        <div class="wrap-input100 validate-input" id="div-pass_check" data-validate="새 재확인 비밀번호를 입력해주세요!">
            <i class="input100 fa fa-key fa-fw"
               style="position: absolute; margin-top: 25px; margin-left: 23px; color: #828282"></i>
            <input class="input100" type="password" name="pass_check" placeholder="NEW PASSWORD CHECK">
            <span class="focus-input100"></span>
        </div>

        <div class="container-contact100-form-btn">
            <a href="javascript:join_submit()" class="contact100-form-btn">비밀번호 변경</a>
        </div>
    </form>
</div>

<script src="${path}/vendor/animsition/js/animsition.min.js"></script>
<script src="${path}/js/popper.min.js"></script>
<script src="${path}/js/bootstrap.min.js"></script>
<script src="${path}/vendor/select2/select2.min.js"></script>
<script src="${path}/vendor/daterangepicker/moment.min.js"></script>
<script src="${path}/vendor/daterangepicker/daterangepicker.js"></script>
<script src="${path}/vendor/countdowntime/countdowntime.js"></script>
<script src="${path}/js/submitform/submitform-pw.min.js"></script>
</body>
</html>