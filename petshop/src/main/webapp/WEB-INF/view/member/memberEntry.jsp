<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>회원 가입 - 핫 도그몰</title>

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
        var idcheckForm;
        var emailcheckForm;
        var jusoForm;

        function win_id_check() {
            document.f.id.focus();

            if (idcheckForm != null)
                idcheckForm.close();

            var op = "width=600, height=150, left=50, top=150";
            idcheckForm = open("idcheckForm.shop", "", op);
        }

        function win_email_check() {
            document.f.email.focus();

            if (emailcheckForm != null)
                emailcheckForm.close();

            var op = "width=600, height=150, left=50, top=150";
            emailcheckForm = open("emailcheckForm.shop", "", op);
        }

        function onlyNumber() {
            if(((event.keyCode < 48) || (event.keyCode > 57)) && (event.keyCode != 189) && (event.keyCode != 8)) {
                event.returnValue = false;
                alert("숫자와 대쉬(-)만 입력하세요!");
            }
        }

        function join_submit() {
            f = document.f;

            if (!f.id.value || f.id.value === "") {
                alert("아이디를 입력 해주세요!");
                f.id.focus();
                return;
            }

            if (f.id.value.length < 3 || f.id.value.length > 50) {
                alert("아이디를 3자 이상 50자 이하로 입력 해주세요!");
                f.id.focus();
                return;
            }

            if (!f.pass.value) {
                alert("비밀번호를 입력해주세요!");
                f.pass.focus();
                return;
            }

            if (!f.pass_check.value) {
                alert("재확인 비밀번호를 입력해주세요!");
                f.pass_check.focus();
                return;
            }

            if (f.pass.value !== f.pass_check.value) {
                alert("입력한 두 비밀번호가 다릅니다! 비밀번호를 재입력 해주세요!");
                f.pass.focus();

                return;
            }

            if (f.pass.value.length < 5 || f.pass.value.length > 100) {
                alert("비밀번호를 5자 이상 100자 이하로 입력 해주세요!");
                f.id.focus();
                return;
            }

            if (!f.pass.value) {
                alert("비밀번호를 입력해주세요!");
                f.pass.focus();
                return;
            }

            if (f.pass.value.length < 5 || f.pass.value.length > 100) {
                alert("비밀번호를 5자 이상 100자 이하로 입력 해주세요!");
                f.id.focus();
                return;
            }

            if (!f.email.value) {
                alert("이메일을 입력해주세요!");
                f.email.focus();
                return;
            }

            if (!f.name.value || f.name.value === "") {
                alert("이름을 입력해주세요!");
                f.name.focus();
                return;

            }

            if (!f.phone.value) {
                alert("전화번호를 입력해주세요!");
                f.phone.focus();
                return;

            }

            if (!f.address.value) {
                alert("주소를 입력해주세요!");
                f.address.focus();
                return;

            }

            if (f.checked_duplicate_id.value === 0) {
                alert("아이디 중복확인을 해주세요!");
                f.id.focus();
                return;
            }

            if (f.checked_duplicate_email.value === 0) {
                alert("이메일 중복확인을 해주세요!");
                f.email.focus();
                return;
            }

            if (f.email_check_passed.value * 1 === 0) {
                alert("이메일 주소가 올바르지 않습니다!");
                f.email.focus();
                return;
            }

            f.submit();
        }
    </script>

    <!-- change phone input format -->
    <script type="text/javascript" src="${path}/js/phone_format.js"></script>

    <!-- kakao address API -->
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script>
        //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function (data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var roadAddr = data.roadAddress; // 도로명 주소 변수

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('postcode').value = data.zonecode;
                    document.getElementById("address").value = roadAddr;
                }
            }).open();
        }
    </script>
</head>
<body>
<div style="margin-left: 100px; margin-right: 100px">
    <form class="contact100-form validate-form" action="memberEntry.shop" name="f" method="post">
        <input type="hidden" name="checked_duplicate_id" value="0">
        <input type="hidden" name="checked_duplicate_email" value="0">
        <input type="hidden" name="email_check_passed" value="0">

        <div class="wrap-input100 validate-input" data-validate="ID 중복확인을 해주세요!">
            <i class="input100 fa fa-id-badge fa-fw"
               style="position: absolute; margin-top: 25px; margin-left: 23px; color: #828282"></i>
            <input class="input100" type="text" name="id" placeholder="ID" onclick="win_id_check()" value="" readonly>
            <span class="focus-input100"></span>
        </div>

        <div class="wrap-input100 validate-input" id="div-pass" data-validate="비밀번호를 입력해주세요!">
            <i class="input100 fa fa-key fa-fw"
               style="position: absolute; margin-top: 25px; margin-left: 23px; color: #828282"></i>
            <input class="input100" type="password" name="pass" placeholder="PASSWORD">
            <span class="focus-input100"></span>
        </div>

        <div class="wrap-input100 validate-input" id="div-pass_check" data-validate="재확인 비밀번호를 입력해주세요!">
            <i class="input100 fa fa-key fa-fw"
               style="position: absolute; margin-top: 25px; margin-left: 23px; color: #828282"></i>
            <input class="input100" type="password" name="pass_check" placeholder="PASSWORD CHECK">
            <span class="focus-input100"></span>
        </div>

        <div class="wrap-input100 validate-input" data-validate="이메일 중복확인을 해주세요!">
            <i class="input100 fa fa-envelope fa-fw"
               style="position: absolute; margin-top: 25px; margin-left: 23px; color: #828282"></i>
            <input class="input100" type="text" name="email" placeholder="E-MAIL" onclick="win_email_check()" readonly>
            <span class="focus-input100"></span>
        </div>

        <div class="wrap-input100 validate-input" data-validate="이름을 입력해주세요!">
            <i class="input100 fa fa-user-o fa-fw"
               style="position: absolute; margin-top: 25px; margin-left: 23px; color: #828282"></i>
            <input class="input100" type="text" name="name" placeholder="NAME">
            <span class="focus-input100"></span>
        </div>

        <div class="wrap-input100 validate-input" data-validate="전화번호를 입력해주세요!">
            <i class="input100 fa fa-phone fa-fw"
               style="position: absolute; margin-top: 25px; margin-left: 23px; color: #828282"></i>
            <input class="input100" type="phone" name="phone" placeholder="PHONE"
                   onkeyup="inputPhoneNumber(this)" onkeydown="onlyNumber()" maxlength="13">
            <span class="focus-input100"></span>
        </div>

        <div class="wrap-input100 validate-input" data-validate="주소를 입력해 주세요!">
            <i class="input100 fa fa-address-card fa-fw"
               style="position: absolute; margin-top: 25px; margin-left: 23px; color: #828282"></i>
            <input class="input100" type="text" name="address" id="address" placeholder="ADDRESS" onclick="execDaumPostcode()"
                   readonly>
            <span class="focus-input100"></span>
        </div>

        <div class="wrap-input100">
            <i class="input100 fa fa-home fa-fw"
               style="position: absolute; margin-top: 25px; margin-left: 23px; color: #828282"></i>
            <input class="input100" type="text" name="address_detail" placeholder="ADDRESS DETAIL">
            <span class="focus-input100"></span>
        </div>

        <div class="wrap-input100 validate-input" data-validate="주소란을 클릭하여 우편번호를 입력해 주세요!">
            <i class="input100 fa fa-envelope-open-o fa-fw"
               style="position: absolute; margin-top: 25px; margin-left: 23px; color: #828282"></i>
            <input class="input100" type="text" name="postcode" id="postcode" placeholder="POSTCODE" onkeydown="onlyNumber()">
            <span class="focus-input100"></span>
        </div>


        <div class="container-contact100-form-btn">
            <a href="javascript:join_submit()" class="contact100-form-btn">회원가입</a>
        </div>
    </form>
</div>

<script src="${path}/vendor/animsition/js/animsition.min.js"></script>
<script src="${path}/js/popper.js"></script>
<script src="${path}/js/bootstrap.min.js"></script>
<script src="${path}/vendor/select2/select2.min.js"></script>
<script src="${path}/vendor/daterangepicker/moment.min.js"></script>
<script src="${path}/vendor/daterangepicker/daterangepicker.js"></script>
<script src="${path}/vendor/countdowntime/countdowntime.js"></script>
<script src="${path}/js/submitform/submitform.js"></script>
</body>
</html>