<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 등록</title>
    <script src="https://cdn.ckeditor.com/4.5.7/full-all/ckeditor.js"></script>
</head>
<body>
<form:form modelAttribute="item" action="register.shop"
           enctype="multipart/form-data">
    <h2>상품 등록</h2>

    <label>1차 분류</label>
    <select class="category1" name="category_group_code">
        <option value="">전체</option>
    </select>

    <label>2차 분류</label>
    <select class="category2" name="category_item_code">
        <option value="">전체</option>
    </select>
    <table>
        <tr>
            <td>상품명</td>
            <td><form:input path="name" maxlength="20"/></td>
            <td><font color="red"><form:errors path="name"/></font></td>
        </tr>
        <tr>
            <td>상품 이미지</td>
            <td colspan="2"><input type="file" name="mainpic"/></td>
        </tr>
        <tr>
            <td>상품 가격</td>
            <td><form:input path="price" maxlength="20"/></td>
            <td><font color="red"><form:errors path="price"/></font></td>
        </tr>
        <tr>
            <td>상품 설명</td>
            <td><form:textarea path="description" cols="20" rows="5"/></td>
            <td><font color="red"><form:errors path="description"/></font></td>
        </tr>
        <tr>
            <td>상품 상세</td>
            <td>
                <form:textarea path="content" rows="15" cols="80" />
                <font color="red"><form:errors path="content" /></font>
                <script type="text/javascript">
                    CKEDITOR.replace("content", {filebrowserImageUploadUrl : "imgupload.shop", language : "ko", skin : "moono"});
                </script>
            </td>
            <td><font color="red"><form:errors path="content"/></font></td>
        </tr>
        <tr>
            <td colspan="3"><input type="submit" value="상품 등록">&nbsp;
                <input type="button" value="상품 목록"
                       onclick="location.href='list.shop'"></td>
        </tr>
    </table>
</form:form>

<script type="text/javascript">
	//jsondata에서 level값이 1인 경우에만 cate1Obj에 추가하고,
	//이 추가한 데이터를 cate1Arr에 추가합니다.
	//이렇게 추가한 값을 cate1Select에 추가합니다.

	// 컨트롤러에서 데이터 받기
	var jsonData1 = JSON.parse('${categoryGroupList}');

	var cate1Arr = [];
	var cate1Obj = {};

	// 1차 분류 셀렉트 박스에 삽입할 데이터 준비
	for (var i = 0; i < jsonData1.length; i++) {
		cate1Obj = {}; //초기화
		cate1Obj.group_code = jsonData1[i].group_code;
		cate1Obj.group_name = jsonData1[i].group_name;
		cate1Arr.push(cate1Obj);
	}

	// 1차 분류 셀렉트 박스에 데이터 삽입
	var cate1Select = $("select.category1");

	for (var i = 0; i < cate1Arr.length; i++) {
		cate1Select.append("<option value='" + cate1Arr[i].group_code + "'>"
				+ cate1Arr[i].group_name + "</option>");
	}

	//이제 2차 분류에 데이터를 추가하기 위한 코드를 작성합니다.
	$(document).on("change", "select.category1", function () {
		var jsonData2 = JSON.parse('${categoryItemList}');

		var cate2Arr = [];
		var cate2Obj = {};

		// 2차 분류 셀렉트 박스에 삽입할 데이터 준비
		for (var i = 0; i < jsonData2.length; i++) {
			cate2Obj = {};  //초기화
			cate2Obj.group_code = jsonData2[i].group_code;
			cate2Obj.code = jsonData2[i].code;
			cate2Obj.name = jsonData2[i].name;
			cate2Arr.push(cate2Obj);
		}

		var cate2Select = $("select.category2");
		cate2Select.children().remove();

		$("option:selected", this).each(function () {
			var selectVal = $(this).val();
			cate2Select.append("<option value=''>전체</option>");

			for (var i = 0; i < cate2Arr.length; i++) {
				if (selectVal == cate2Arr[i].group_code) {
					cate2Select.append("<option value='" + cate2Arr[i].code + "'>"
							+ cate2Arr[i].name + "</option>");
				}
			}
		});
	});
</script>
</body>
</html>
