(function ($) {
    "use strict";

    /*==================================================================
    [ Validate after type ]*/
    $('.validate-input .input100').each(function () {
        $(this).on('blur', function () {
            if (validate(this) == false) {
                showValidate(this);
            } else {
                $(this).parent().addClass('true-validate');
            }
        })
    })

    /*==================================================================
    [ Validate ]*/
    var input = $('.validate-input .input100');

    $('.validate-form').on('submit', function () {
        var check = true;

        for (var i = 0; i < input.length; i++) {
            if (validate(input[i]) == false) {
                showValidate(input[i]);
                check = false;
            }
        }

        return check;
    });


    $('.validate-form .input100').each(function () {
        $(this).focus(function () {
            hideValidate(this);
            $(this).parent().removeClass('true-validate');
        });
    });

    $(document).ready(function () {
        if ($('input[name="email"]').val().trim().match(/^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{1,5}|[0-9]{1,3})(\]?)$/) == null) {
            $('input[name="email_check_passed"]').val("0");
        } else {
            $('input[name="email_check_passed"]').val("1");
        }
    });

    function validate(input) {
        if ($(input).attr('type') == 'email' || $(input).attr('name') == 'email') {
            if ($(input).val().trim().match(/^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{1,5}|[0-9]{1,3})(\]?)$/) == null) {
                $('input[name="email_check_passed"]').val("0");
                return false;
            } else {
                $('input[name="email_check_passed"]').val("1");
            }
        } else if ($(input).attr('name') == 'pass' || $(input).attr('name') == 'pass_check') { /* jolla_web*/
            if ($(input).attr('name') == 'pass' &&
                $('input[name="pass"]').val().length == 0) {
                $('div[id="div-pass"]').attr("data-validate", "비밀번호를 입력해주세요!");
                return false;
            }

            if ($(input).attr('name') == 'pass_check' &&
                $('input[name="pass_check"]').val().length == 0) {
                $('div[id="div-pass_check"]').attr("data-validate", "재확인 비밀번호를 입력해주세요!");
                return false;
            }

            if ($(input).attr('name') == 'pass' &&
                $('input[name="pass"]').val().length < 5 || $('input[name="pass"]').val().length > 100) {
                $('div[id="div-pass"]').attr("data-validate", "비밀번호를 5~100자로 입력해주세요!");
                return false;
            }

            if ($(input).attr('name') == 'pass_check' &&
                $('input[name="pass_check"]').val().length < 5 || $('input[name="pass_check"]').val().length > 100) {
                $('div[id="div-pass_check"]').attr("data-validate", "비밀번호를 5~100자로 입력해주세요!");
                return false;
            }

            if ($('input[name="pass"]').val().length != 0 &&
                $('input[name="pass_check"]').val().length != 0 &&
                $('input[name="pass"]').val() != $('input[name="pass_check"]').val()) {
                $('div[id="div-pass"]').attr("data-validate", "비밀번호가 일치하지 않습니다!");
                $('div[id="div-pass_check"]').attr("data-validate", "비밀번호가 일치하지 않습니다!");
                return false;
            }

            $('div[id="div-pass"]').attr("data-validate", "비밀번호를 입력해주세요!")
                .addClass('true-validate')
                .removeClass('alert-validate')
                .each(function () {
                    hideValidate(this);
                });

            $('div[id="div-pass_check"]').attr("data-validate", "재확인 비밀번호를 입력해주세요!")
                .addClass('true-validate')
                .removeClass('alert-validate')
                .each(function () {
                    hideValidate(this);
                });

            return true;
        } else {
            if ($(input).val().trim() == '') {
                return false;
            }
        }
    }

    function showValidate(input) {
        var thisAlert = $(input).parent();

        $(thisAlert).addClass('alert-validate');

        $(thisAlert).append('<span class="btn-hide-validate">&#xf135;</span>')
        $('.btn-hide-validate').each(function () {
            $(this).on('click', function () {
                hideValidate(this);
            });
        });
    }

    function hideValidate(input) {
        var thisAlert = $(input).parent();
        $(thisAlert).removeClass('alert-validate');
        $(thisAlert).find('.btn-hide-validate').remove();
    }
})(jQuery);