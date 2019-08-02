<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>ToDo cmd</title>
    
    <link rel="stylesheet" href="${path}/css/funny/funny2.css"/>
</head>

<body>
<script type="text/javascript" src="${path}/js/funnyjs/funny.js"></script>
    <div id="result">
      <span>Soll's soft Windows [Version 10.0.666]<br>
      (c) Microsoft Corporation, 2017. All rights reserved.<br>   
      </span>
      <br><br>
    </div>
    <label id="label" for="cmd">C:\Users\Soll></label>
    <input id="cmd" type="text" onkeypress="return cmd(event)" maxlength="255" autofocus/>
</body>
</html>