<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>

<!-- HTML -->
<html>
<!-- HEAD -->
  <head>
    <meta charset="utf-8"><!-- Used to specify character encoding, not useful here -->
    <title>Breakout</title><!-- Title of the website, can be seen in the tab -->
    <link rel="stylesheet" href="${path}/css/funny/funnygame.css">
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,700" rel="stylesheet">
    <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.css">
  </head>
<!-- END OF HEAD -->

  <body>

  <div class="tile_container">

    <div id="tile_0" class="tile">
      <i id="tile_icon_0" class="fa"></i>
    </div>

    <div id="tile_1" class="tile">
      <i id="tile_icon_1" class="fa"></i>
    </div>

    <div id="tile_2" class="tile">
      <i id="tile_icon_2" class="fa"></i>
    </div>

    <div id="tile_3" class="tile">
      <i id="tile_icon_3" class="fa"></i>
    </div>

    <div id="tile_4" class="tile">
      <i id="tile_icon_4" class="fa"></i>
    </div>

    <div id="tile_5" class="tile">
      <i id="tile_icon_5" class="fa"></i>
    </div>

    <div id="tile_6" class="tile">
      <i id="tile_icon_6" class="fa"></i>
    </div>

    <div id="tile_7" class="tile">
      <i id="tile_icon_7" class="fa"></i>
    </div>

    <div id="tile_8" class="tile">
      <i id="tile_icon_8" class="fa"></i>
    </div>

    <div id="tile_9" class="tile">
      <i id="tile_icon_9" class="fa"></i>
    </div>

    <div id="tile_10" class="tile">
      <i id="tile_icon_10" class="fa"></i>
    </div>

    <div id="tile_11" class="tile">
      <i id="tile_icon_11" class="fa"></i>
    </div>

    <div id="tile_12" class="tile">
      <i id="tile_icon_12" class="fa"></i>
    </div>

    <div id="tile_13" class="tile">
      <i id="tile_icon_13" class="fa"></i>
    </div>

    <div id="tile_14" class="tile">
      <i id="tile_icon_14" class="fa"></i>
    </div>

    <div id="tile_15" class="tile">
      <i id="tile_icon_15" class="fa"></i>
    </div>

  </div>

  <div class="overlay_win" id="overlay_win">
    <h2>You win!</h2>
    <div id="replay">Play again</div>
  </div>

  <script src="${path}/js/funnyjs/funnygame.js"></script><!-- Link to external JavaScript -->
  </body>
<!-- END OF BODY -->
</html>
