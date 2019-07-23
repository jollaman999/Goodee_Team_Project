<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="../vendor/animate/animate.css">
    <link rel="stylesheet" type="text/css" href="../vendor/select2/select2.min.css">
    <link rel="stylesheet" type="text/css" href="../vendor/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" type="text/css" href="../css/submitform.css">
    <link rel="stylesheet" type="text/css" href="../css/table-util.css">
    <link rel="stylesheet" type="text/css" href="../css/table-reply.css">

    <link rel="stylesheet" type="text/css" href="../css/w3.css">

    <!-- HighSlide -->
    <script type="text/javascript" src="../vendor/highslide/highslide.js"></script>
    <link rel="stylesheet" type="text/css" href="../vendor/highslide/highslide.css" />

    <title>댓글 수정</title>

    <script type="text/javascript">
        function do_submit() {
            if (!f.content.value || f.content.value === " ") {
                alert("댓글 내용을 입력하세요")
                f.content.focus();
                return;
            }

            f.submit();
        }
    </script>
</head>
<body>
<div style="margin: 15px">
    <form action="update.shop" method="post" name="f">
        <input type="hidden" name="num" value="${param.num}">
        <input type="hidden" name="type" value="${param.type}">
        <input type="hidden" name="itemno" value="${param.itemno}">
        <input type="hidden" name="pageNum" value="${param.pageNum}">
        <div style="margin-bottom: 45px">
            <table style="height: 100px; background-color: #f5f5f5;">
                <tr>
                    <td style="width: 62%">
                        <textarea rows="7" name="content" style="width: 100%">${reply.content}</textarea>
                    </td>
                    <td>
                        <input type="button" value="댓글 수정" class="w3-button w3-bar-item w3-deep-purple" onclick="do_submit()">
                    </td>
                </tr>
            </table>
        </div>
    </form>
</div>
</body>
</html>