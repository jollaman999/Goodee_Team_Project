<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 정보</title>
</head>
<body>
<h2>${sessionScope.loginMember.name}님 반갑습니다!</h2>
<a href="mypage.shop?id=${loginMember.id}">마이페이지</a><br>
<a href="logout.shop">로그아웃</a>
</body>
</html>
