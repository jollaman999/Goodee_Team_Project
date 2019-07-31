<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 등록</title>
    <script src="https://cdn.ckeditor.com/4.5.7/full-all/ckeditor.js"></script>
</head>
<body>
<form:form modelAttribute="item" action="register.shop" enctype="multipart/form-data">
    <h2>상품 등록</h2>

    <spring:hasBindErrors name="item">
        <font color="red">
            <c:forEach items="${errors.globalErrors}" var="error">
                <spring:message code="${error.code}"/>
            </c:forEach>
        </font>
    </spring:hasBindErrors>
    <br><br>

    <table>
        <tr>
            <td>1차 분류</td>
            <td>
                <form:select class="category1" path="category_group_code" cssStyle="width: 100%">
                    <option value="0">전체</option>
                </form:select>
                <font color="red"><form:errors path="category_group_code"/></font>
            </td>
        </tr>
        <tr>
            <td>2차 분류</td>
            <td>
                <form:select class="category2" path="category_item_code" cssStyle="width: 100%">
                    <option value="0">전체</option>
                </form:select>
                <font color="red"><form:errors path="category_item_code"/></font>
            </td>
        </tr>
        <tr>
            <td>상품명</td>
            <td>
                <form:input path="name" maxlength="20"/>
                <font color="red"><form:errors path="name"/></font>
            </td>
        </tr>
        <tr>
            <td>상품 이미지</td>
            <td colspan="2"><input type="file" name="mainpic"/></td>
            <font color="red"><form:errors path="mainpic"/></font>
        </tr>
        <tr>
            <td>상품 가격</td>
            <td>
                <form:input path="price" maxlength="20"/>
                <font color="red"><form:errors path="price"/></font>
            </td>
        </tr>
        <tr>
            <td>상품 수량</td>
            <td>
                <form:input path="quantity" maxlength="20"/>
                <font color="red"><form:errors path="quantity"/></font>
            </td>
        </tr>
        <tr>
            <td>원산지</td>
            <td><form:input path="origin" maxlength="20"/></td>
        </tr>
        <tr>
            <td>제조사</td>
            <td><form:input path="mfr" maxlength="20"/></td>
        </tr>
        <tr>
            <td>제조사 연락처</td>
            <td><form:input path="mfr_tel" maxlength="20"/></td>
        </tr>
        
        <!--  유통기한 원본소스 
        <form id="frm" action="action.jsp">
        <p>유통기한 입력:</p>
        <div><input type="date" id="userdate" name="userdate"
                value="2015-10-10"></div>
        <div><input type="submit" value="전송"></div>
        </form>         
                                                  -->                                            
        <tr>
            <td>유통기한</td>
            <td><form:input path="expr_date" type="text" name="userdate"/></td>
        </tr>
      
        <tr>
            <td>상품 설명</td>
            <td>
                <form:textarea path="description" cols="20" rows="5"/>
                <font color="red"><form:errors path="description"/></font>
            </td>
        </tr>
        <tr>
            <td>상품 상세</td>
            <td colspan="2">
                <form:textarea path="content" rows="15" cols="80" />
                <font color="red"><form:errors path="content" /></font>
                <script type="text/javascript">
                    CKEDITOR.replace("content", {filebrowserImageUploadUrl : "imgupload.shop", language : "ko", skin : "moono"});
                </script>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <input type="submit" value="상품 등록">&nbsp;
                <input type="button" value="상품 리스트" onclick="location.href='${path}/inventory/list.shop?pageNum=${param.pageNum}'">
            </td>
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

	// 이제 2차 분류에 데이터를 추가하기 위한 코드를 작성합니다.
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
