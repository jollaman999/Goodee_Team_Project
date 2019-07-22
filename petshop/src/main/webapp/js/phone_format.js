function inputPhoneNumber(obj) {

    var number = obj.value.replace(/[^0-9]/g, "");
    var phone = "";

    if (number.length < 4) {
        return number;
    } else if (number.length < 7) {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3);
    } else if (number.length < 11) {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3, 3);
        phone += "-";
        phone += number.substr(6);
    } else {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3, 4);
        phone += "-";
        phone += number.substr(7);
    }
    obj.value = phone;
}

function phoneFomatter(num, type) {

	var formatNum = '';

	if (num.length == 11) {

		if (type == 0) {

			formatNum = num.replace(/(\d{3})(\d{4})(\d{4})/, '$1-****-$3');

		} else {

			formatNum = num.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');

		}

	} else if (num.length == 8) {

		formatNum = num.replace(/(\d{4})(\d{4})/, '$1-$2');

	} else {

		if (num.indexOf('02') == 0) {

			if (type == 0) {

				formatNum = num.replace(/(\d{2})(\d{4})(\d{4})/, '$1-****-$3');

			} else {

				formatNum = num.replace(/(\d{2})(\d{4})(\d{4})/, '$1-$2-$3');

			}

		} else {

			if (type == 0) {

				formatNum = num.replace(/(\d{3})(\d{3})(\d{4})/, '$1-***-$3');

			} else {

				formatNum = num.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');

			}

		}

	}

	return formatNum;

}