<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
div.links  {
	  margin: auto;
   	  width: 100%;
   	  text-align: center;
   	  margin-top : 80px	
}
div.deliveryInfo{
	margin-top: 50px
}

</style>
<meta charset="EUC-KR">
<title>�ֹ� Ȯ��</title>
</head>
<body>
	<div id="container">
		<div class="main">
			<div class="completeState">
				<h1>�ֹ��� ���������� �Ϸ� �Ǿ����ϴ�.</h1>
				<div class="deliveryInfo" style="text-align: center;">
					
   						 <h3>�ڼ��� �ֹ������� ���������� > �ֹ�/��� �޴��� �̿��� �ּ���.</h3>
   										
				</div>
				<div class="links">
					<ul>
						<a class="site-btn" style="margin-right :10px" href="../shop/list.shop">���ΰ���ϱ�</a>
						<a class="site-btn" style="margin-right :10px" href="../basket/end1.shop">�ֹ� ���� ����</a>
						<a class="site-btn" style="margin-right :10px" href="http://www.gdu.co.kr">Ÿ���θ�</a><br><br>
						<img src="${path}/img/k.png" width="150" height="150" alt="">	
  	
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>