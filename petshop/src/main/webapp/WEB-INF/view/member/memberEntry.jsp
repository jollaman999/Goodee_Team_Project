<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="javascript">
// opener관련 오류가 발생하는 경우 아래 주석을 해지하고, 사용자의 도메인정보를 입력합니다. ("팝업API 호출 소스"도 동일하게 적용시켜야 합니다.)
//document.domain = "abc.go.kr";

function goPopup(){
	// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
    var pop = window.open("jusoPopup.shop","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
    
	// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
    //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
}
/** API 서비스 제공항목 확대 (2017.02) **/
function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn
						, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo){
	// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
	document.form.roadAddrPart1.value = roadAddrPart1;
	document.form.roadAddrPart2.value = roadAddrPart2;
	document.form.addrDetail.value = addrDetail;
	document.form.zipNo.value = zipNo;
}
</script>
    <meta charset="UTF-8">
    <title>회원가입 - 핫도그 몰</title>
    <link rel = "stylesheet" href="style.css">
</head>
<body>
<form name="form" id="form" method="post">
	<table >
			<colgroup>
				<col style="width:20%"><col>
			</colgroup>
			<tbody>
				<tr>
					<th>우편번호</th>
					<td>
					    <input type="hidden" id="confmKey" name="confmKey" value=""  >
						<input type="text" id="zipNo" name="zipNo" readonly style="width:100px">
						<input type="button"  value="주소검색" onclick="goPopup();">
					</td>
				</tr>
				<tr>
					<th><label>도로명주소</label></th>
					<td><input type="text" id="roadAddrPart1" style="width:85%"></td>
				</tr>
				<tr>
					<th>상세주소</th>
						<td>
							<input type="text" id="addrDetail" style="width:40%" value="">
							<input type="text" id="roadAddrPart2"  style="width:40%" value="">
						</td>
				</tr>
			</tbody>
		</table>
</form>
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
                <form:input path="address" class="form-control" />
                <font color="red"><form:errors path="address" /></font>
                <br><br>

				상세 주소
                <form:input path="address_detail" class="form-control" />
                <font color="red"><form:errors path="address_detail" /></font> 
                <br>
          		
          		 우편번호
                <form:input path="postcode" class="form-control"/>
                <font color="red"><form:errors path="postcode" /></font>
                <br>
           
                <input type="submit" value="등록">
                <input type="reset" value="초기화">
          
</form:form>
</body>
</html>

