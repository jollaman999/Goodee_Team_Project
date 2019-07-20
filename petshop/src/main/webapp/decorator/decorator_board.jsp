<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title><decorator:title /></title>

    <!-- Stylesheets -->
    <link rel="stylesheet" href="${path}/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${path}/css/fontawesome.css"/>
    <link rel="stylesheet" href="${path}/css/brands.css"/>
    <link rel="stylesheet" href="${path}/css/flaticon.css"/>
    <link rel="stylesheet" href="${path}/css/slicknav.min.css"/>
    <link rel="stylesheet" href="${path}/css/jquery-ui.min.css"/>
    <link rel="stylesheet" href="${path}/css/owl.carousel.min.css"/>
    <link rel="stylesheet" href="${path}/css/animate.css"/>
    <link rel="stylesheet" href="${path}/css/style.css"/>

    <!-- Main Stylesheet -->
    <link rel="stylesheet" href="${path}/css/main.css"/>

    <!-- jQuery -->
    <script type="text/javascript" src="${path}/js/jquery-3.2.1.min.js"></script>
    
    <script type="text/javascript" src="https://cdn.ckeditor.com/4.5.7/full-all/ckeditor.js"></script>

    <decorator:head />
</head>
<body>
 
    <!-- Header section -->   
    <jsp:include page="include/header.jsp" />
    <!-- Header section end -->

    <!-- Body section -->
    <div class="container" style="margin-top: 50px; margin-bottom: 50px">
        <h2>${board_title}</h2>
        <decorator:body />
    </div>
    <!-- Body section end -->

    <!-- Footer section -->
    <jsp:include page="include/footer.jsp" />
    <!-- Footer section end -->

    <!--====== Javascripts ======-->
    <jsp:include page="include/javascripts.jsp" />
</body>
</html>
