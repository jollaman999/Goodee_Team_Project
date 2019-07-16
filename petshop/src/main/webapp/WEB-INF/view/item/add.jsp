<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>

<script>
	//jsondata에서 level값이 1인 경우에만 cate1Obj에 추가하고, 
	//이 추가한 데이터를 cate1Arr에 추가합니다. 
	//이렇게 추가한 값을 cate1Select에 추가합니다. 

	// 컨트롤러에서 데이터 받기
	var jsonData = JSON.parse('${category}');
	console.log(jsonData);

	var cate1Arr = [];
	var cate1Obj = {};

	// 1차 분류 셀렉트 박스에 삽입할 데이터 준비
	for (var i = 0; i < jsonData.length; i++) {

		if (jsonData[i].level == "1") {
			cate1Obj = new Object(); //초기화
			cate1Obj.cateCode = jsonData[i].cateCode;
			cate1Obj.cateName = jsonData[i].cateName;
			cate1Arr.push(cate1Obj);
		}
	}

	// 1차 분류 셀렉트 박스에 데이터 삽입
	var cate1Select = $("select.category1")

	for (var i = 0; i < cate1Arr.length; i++) {
		cate1Select.append("<option value='" + cate1Arr[i].cateCode + "'>"
				+ cate1Arr[i].cateName + "</option>");
	}
</script>
<script type="text/javascript">
	//이제 2차 분류에 데이터를 추가하기 위한 코드를 작성합니다. 
	
	$(document).on("change", "select.category1", function(){

 var cate2Arr = new Array();
 var cate2Obj = new Object();
 
 // 2차 분류 셀렉트 박스에 삽입할 데이터 준비
 for(var i = 0; i < jsonData.length; i++) {
  
  if(jsonData[i].level == "2") {
   cate2Obj = new Object();  //초기화
   cate2Obj.cateCode = jsonData[i].cateCode;
   cate2Obj.cateName = jsonData[i].cateName;
   cate2Obj.cateCodeRef = jsonData[i].cateCodeRef;
   
   cate2Arr.push(cate2Obj);
  }
 }
 
 var cate2Select = $("select.category2");
/*
 for(var i = 0; i < cate2Arr.length; i++) {
   cate2Select.append("<option value='" + cate2Arr[i].cateCode + "'>"
        + cate2Arr[i].cateName + "</option>");
 } 
 */
 $(document).on("change", "select.category1", function(){

	 var cate2Arr = new Array();
	 var cate2Obj = new Object();
	 
	 // 2차 분류 셀렉트 박스에 삽입할 데이터 준비
	 for(var i = 0; i < jsonData.length; i++) {
	  
	  if(jsonData[i].level == "2") {
	   cate2Obj = new Object();  //초기화
	   cate2Obj.cateCode = jsonData[i].cateCode;
	   cate2Obj.cateName = jsonData[i].cateName;
	   cate2Obj.cateCodeRef = jsonData[i].cateCodeRef;
	   
	   cate2Arr.push(cate2Obj);
	  }
	 }
	 
	 var cate2Select = $("select.category2");
	 
	 /*
	 for(var i = 0; i < cate2Arr.length; i++) {
	   cate2Select.append("<option value='" + cate2Arr[i].cateCode + "'>"
	        + cate2Arr[i].cateName + "</option>");
	 }
	 */
	 
	 cate2Select.children().remove();

	 $("option:selected", this).each(function(){
	  
	  var selectVal = $(this).val();  
	  cate2Select.append("<option value=''>전체</option>");
	  
	  for(var i = 0; i < cate2Arr.length; i++) {
	   if(selectVal == cate2Arr[i].cateCodeRef) {
	    cate2Select.append("<option value='" + cate2Arr[i].cateCode + "'>"
	         + cate2Arr[i].cateName + "</option>");
	   }
	  }
	  
	 });
	 
	});
});
</script>
</head>
<body>
	<form:form modelAttribute="item" action="register.shop"
		enctype="multipart/form-data">
		<h2>상품 등록</h2>
		<form role="form" method="post" autocomplete="off">

			<label>1차 분류</label> 
			<select class="category1">
				<option>전체</option>
				<option>Meal</option>
				<option>Snack</option>
				<option>Dress</option>
				<option>House</option>
				<option>Living</option>
			</select> 
			
			<label>2차 분류</label> 
			<select class="category2">
				<option>전체</option>
				<option>건식</option>
				<option>소프트</option>
				<option>껌</option>
				<option>소시지</option>
				<option>음료</option>
				<option>티셔츠</option>
				<option>후드티</option>
				<option>음료</option>
				<option>방석</option>
				<option>집</option>
				<option>울타리</option>
				<option>서브메뉴1</option>
				<option>서브메뉴2</option>
				<option>서브메뉴3</option>
			</select>

		</form>
		<table>
			<tr>
				<td>상품명</td>
				<td><form:input path="name" maxlength="20" /></td>
				<td><font color="red"><form:errors path="name" /></font></td>
			</tr>
			<tr>
				<td>상품 가격</td>
				<td><form:input path="price" maxlength="20" /></td>
				<td><font color="red"><form:errors path="price" /></font></td>
			</tr>
			<tr>
				<td>상품 이미지</td>
				<td colspan="2"><input type="file" name="picture" /></td>
			</tr>
			<tr>
				<td>상품 설명</td>
				<td><form:textarea path="description" cols="20" rows="5" /></td>
				<td><font color="red"><form:errors path="description" /></font></td>
			</tr>
			<tr>
				<td colspan="3"><input type="submit" value="상품 등록">&nbsp;
					<input type="button" value="상품 목록"
					onclick="location.href='list.shop'"></td>
			</tr>
		</table>
	</form:form>
</body>
</html>
