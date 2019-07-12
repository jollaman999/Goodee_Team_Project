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
    <link rel="stylesheet" type="text/css" href="${path}/css/normalize.css" />
    <link rel="stylesheet" type="text/css" href="${path}/css/demo.css" />
    <link rel="stylesheet" type="text/css" href="${path}/css/component.css" />
    <script src="${path}/js/modernizr.custom.js"></script>
    <decorator:head />
</head>
<body>
<div class="container">
    <ul id="gn-menu" class="gn-menu-main">
        <li class="gn-trigger">
            <a class="gn-icon gn-icon-menu"><span>Menu</span></a>
            <nav class="gn-menu-wrapper">
                <div class="gn-scroller">
                    <ul class="gn-menu">
                        <li class="gn-search-item">
                            <input placeholder="Search" type="search" class="gn-search">
                            <a class="gn-icon gn-icon-search"><span>Search</span></a>
                        </li>
                        <li>
                            <a class="gn-icon gn-icon-download">Downloads</a>
                            <ul class="gn-submenu">
                                <li><a class="gn-icon gn-icon-illustrator">Vector Illustrations</a></li>
                                <li><a class="gn-icon gn-icon-photoshop">Photoshop files</a></li>
                            </ul>
                        </li>
                        <li><a class="gn-icon gn-icon-cog">Settings</a></li>
                        <li><a class="gn-icon gn-icon-help">Help</a></li>
                        <li>
                            <a class="gn-icon gn-icon-archive">Archives</a>
                            <ul class="gn-submenu">
                                <li><a class="gn-icon gn-icon-article">Articles</a></li>
                                <li><a class="gn-icon gn-icon-pictures">Images</a></li>
                                <li><a class="gn-icon gn-icon-videos">Videos</a></li>
                            </ul>
                        </li>
                    </ul>
                </div><!-- /gn-scroller -->
            </nav>
        </li>
        <li><a href="http://tympanus.net/codrops">Codrops</a></li>
        <li><a class="codrops-icon codrops-icon-prev" href="http://tympanus.net/Development/HeaderEffects/"><span>Previous Demo</span></a></li>
        <li><a class="codrops-icon codrops-icon-drop" href="http://tympanus.net/codrops/?p=16030"><span>Back to the Codrops Article</span></a></li>
    </ul>
    <header>
        <decorator:body/>
    </header>
</div><!-- /container -->
<script src="${path}/js/classie.js"></script>
<script src="${path}/js/gnmenu.js"></script>
<script>
    new gnMenu( document.getElementById( 'gn-menu' ) );
</script>
<link rel="stylesheet" href="${path}/css/main.css">
</body>
</html>
