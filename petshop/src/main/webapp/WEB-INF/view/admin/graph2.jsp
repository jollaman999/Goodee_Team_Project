<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>글쓴이 분석</title>

    <script src="${path}/js/jquery.awesomeCloud-0.2.js"></script>
    <style type="text/css">
        .wordcloud {
            border: 1px solid #036;
            height: 6in;
            margin: 0.5in auto;
            padding: 0;
            page-break-after: always;
            page-break-inside: avoid;
        }
    </style>
    <link rel="stylesheet" href="${path}/css/jqueryscripttop.css">
</head>
<body>
<header style="margin-top: 50px"></header>
<div role="main">
    <div id="wordcloud1" class="wordcloud">
        <c:forEach items="${map}" var="m">
            <span data-weight="${m.value * 5}">${m.key}</span>
        </c:forEach>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $("#wordcloud1").awesomeCloud({
            "size" : {
                "grid" : 5,
                "factor": 0,
                "normalize" : true
            },
            "options" : {
                "color" : "random-dark",
                "rotationRatio" : 0.35
            },
            "font" : "'Times New Roman', Times, serif",
            "shape" : "square"
        })
    });
</script>
</body>
</html>
