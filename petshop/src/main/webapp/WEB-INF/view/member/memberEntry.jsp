<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입 - 핫도그 몰</title>

    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script>
        //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var roadAddr = data.roadAddress; // 도로명 주소 변수

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('sample4_postcode').value = data.zonecode;
                    document.getElementById("sample4_roadAddress").value = roadAddr;
                }
            }).open();
        }
    </script>
</head>
<body>
<h2>회원가입</h2>
<br>
<form:form modelAttribute="member" method="post" action="memberEntry.shop" >
    <spring:hasBindErrors name="member">
        <font color="red">
            <c:forEach items="${errors.globalErrors}" var="error">
                <spring:message code="${error.code}" />
            </c:forEach>
        </font>
    </spring:hasBindErrors>
           		
           		아이디 
                <form:input path="id" class="form-control" />
                <font color="red"><form:errors path="id" /></font>
                <br><br>

				비밀번호            
                <form:password path="pass" class="form-control" />
                <font color="red"><form:errors path="pass" /></font>
                <br><br>

         		 이름           
                <form:input path="name" class="form-control" />
                <font color="red"><form:errors path="name" /></font>
                <br><br>
    
       			 전화번호
                <form:input path="phone" class="form-control" />
                <font color="red"><form:errors path="phone" /></font>
                <br><br>

  				이메일
                <form:input path="email" class="form-control"/>
                <font color="red"><form:errors path="email" /></font>
                <br><br>

        		주소    
				<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
				<form:input path="address" class="form-control" type="text" id="sample4_roadAddress" placeholder="주소"/>
                <font color="red"><form:errors path="address" /></font>
                
				<form:input path="address_detail" class="form-control" id="sample4_extraAddress" placeholder="상세주소" />
                
                <form:input path="postcode" class="form-control" id="sample4_postcode" placeholder="우편번호" />
                <font color="red"><form:errors path="postcode" /></font>
                <br><br>
	


               
           
                <input type="submit" value="등록">
                <input type="reset" value="초기화">
          
</form:form>
</body>
</html>

