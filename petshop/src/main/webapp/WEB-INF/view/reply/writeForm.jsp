<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${path}/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${path}/vendor/animate/animate.css">
    <link rel="stylesheet" type="text/css" href="${path}/vendor/select2/select2.min.css">
    <link rel="stylesheet" type="text/css" href="${path}/vendor/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/submitform.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/table-util.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/table.css">

    <link rel="stylesheet" type="text/css" href="${path}/css/w3.css">

    <title>후기 작성하기</title>

    <script type="text/javascript" src="https://cdn.ckeditor.com/4.5.7/full-all/ckeditor.js"></script>

    <!-- jQuery -->
    <script type="text/javascript" src="${path}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript">
        function validate() {
            if (validateCKEDITORforBlank($.trim(CKEDITOR.instances.content.getData().replace(/<[^>]*>|\s/g, '')))) {
                CKEDITOR.instances.content.setData("");
                return false;
            }

            return true;
        }

        function validateCKEDITORforBlank(field) {
            var vArray;

            vArray = field.split("&nbsp;");
            var vFlag = 0;

            for (var i = 0; i < vArray.length; i++) {
                if (vArray[i] == '' || vArray[i] == "") {
                    continue;
                } else {
                    vFlag = 1;
                    break;
                }
            }

            return vFlag == 0;
        }

        function do_write() {
            if (!validate()) {
                alert("후기 내용을 입력하세요!");
                return;
            }

            f1.submit();
        }
    </script>

    <style type="text/css">
        table {
            width: 90%;
            margin-top: 15px;
        }

        table * {
            background-color: #ffffff;
        }
    </style>
</head>
<body>
<form action="write.shop" method="post" name="f1">
    <input type="hidden" name="pageNum" value="1">
    <input type="hidden" name="type" value="${param.type}">
    <input type="hidden" name="itemno" value="${param.itemno}">
    <div style="margin-bottom: 45px">
        <table style="height: 100px; background-color: #f5f5f5;">
            <tr>
                <td style="width: 80%; padding-top: 10px; padding-bottom: 10px">
                    <textarea rows="40" id="content" name="content" style="width: 100%"></textarea>
                    <script type="text/javascript">
                        CKEDITOR.replace("content", {filebrowserImageUploadUrl : "imgupload.shop?itemno=${param.itemno}", language : "ko", skin : "moono", height : "500"});
                    </script>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="button" value="후기 남기기" class="w3-button w3-bar-item w3-deep-purple" onclick="do_write()">
                </td>
            </tr>
        </table>
    </div>
</form>
</body>
</html>
