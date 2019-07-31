<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<!-- style -->
<link rel="stylesheet" href="${path}/css/funny.css"/>

</head>
<body>
<!--  마리오   -->
<div class="sky">
    <img class="cloud" src="http://shimotmk.com/wp-content/uploads/2019/07/cloud.png" alt="">
    <img class="cloud" src="http://shimotmk.com/wp-content/uploads/2019/07/cloud.png" alt="">
  </div>
  <div class="grass"></div>  
  <div class="road">
    <div class="lines"></div>
    <img class="mario" src="http://shimotmk.com/wp-content/uploads/2019/07/mario.png" alt="">
    <img class="luigi" src="http://shimotmk.com/wp-content/uploads/2019/07/luigi.png" alt="">
  </div>
</div>

</body>
</html>