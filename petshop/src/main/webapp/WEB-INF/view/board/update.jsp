<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 수정</title>

    <script src="https://cdn.ckeditor.com/4.5.7/full-all/ckeditor.js"></script>

    <script type="text/javascript">
        function file_delete() {
            document.getElementById("file_desc").innerHTML ="<input type=\"file\" name=\"file1\">";
        }

        function fileCheck(file)
        {
            // 확장자 체크
            var ext = file.value.toLowerCase();

            // endsWith compatibility (IE not support endsWith method)
            if (!String.prototype.endsWith) {
                String.prototype.endsWith = function(search, this_len) {
                    if (this_len === undefined || this_len > this.length) {
                        this_len = this.length;
                    }
                    return this.substring(this_len - search.length, this_len) === search;
                };
            }

            if (ext.endsWith("exe") || ext.endsWith("jsp") || ext.endsWith("asp") || ext.endsWith("js") || ext.endsWith("php") || ext.endsWith("htm") ||
                ext.endsWith("html") || ext.endsWith("vbs") || ext.endsWith("bat") || ext.endsWith("cmd")){
                alert("첨부 파일로 등록 불가능한 파일 유형이 첨부 되어있습니다!");
                return;
            }

            // 사이즈체크
            //var maxSize = 2147483647; // 2GB
            var maxSize = 2147483647;
            var fileSize = 0;

            // 브라우저 확인
            var browser = navigator.appName;

            // 익스플로러일 경우
            if (browser == "Microsoft Internet Explorer")
            {
                var oas = new ActiveXObject("Scripting.FileSystemObject");
                fileSize = oas.getFile(file.value).size;
            }
            // 익스플로러가 아닐경우
            else
            {
                fileSize = file.files[0].size;
            }

            if(fileSize > maxSize)
            {
                alert("첨부파일 사이즈는 2GB 이내로 등록 가능합니다!");
                return -1;
            }

            return 0;
        }

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

        function board_submit() {
            f = document.f;

            if (!f.title.value) {
                alert("제목을 입력하세요!");
                f.title.focus();
                return;
            }

            if (!validate()) {
                alert("내용을 입력하세요!");
                f.content.focus();
                return;
            }

            if (f.file1 != null && f.file1.value && fileCheck(f.file1) != 0) {
                return;
            }

            f.submit();
        }
    </script>

    <link rel="stylesheet" type="text/css" href="${path}/css/w3.css">
</head>
<body>
<br>
<form:form modelAttribute="board" action="update.shop" enctype="multipart/form-data" name="f">
    <form:hidden path="num" />
    <form:hidden path="type" />
    <input type="hidden" name="member_id" value="${sessionScope.loginMember.id}">

    <table>
        <tr>
            <td>제목</td>
            <td>
                <form:input path="title" />
                <font color="red"><form:errors path="title" /></font>
            </td>
        </tr>
        <c:if test="${param.type != 0}">
            <tr>
                <td>상품 이름</td>
                <td>${board.item_name}</td>
            </tr>
        </c:if>
        <tr>
            <td>내용</td>
            <td>
                <form:textarea path="content" rows="15" cols="80" />
                <font color="red"><form:errors path="content" /></font>
                <script type="text/javascript">
                    CKEDITOR.replace("content", {filebrowserImageUploadUrl : "imgupload.shop"});
                </script>
            </td>
        </tr>
        <tr>
            <td>첨부파일</td>
            <td>
                <c:choose>
                    <c:when test="${!empty board.fileurl}">
                        <div id="file_desc">
                            <a href="file/${board.num}/${board.fileurl}">${board.fileurl}</a>
                            <a class="w3-button w3-bar-item w3-deep-purple" href="javascript:file_delete()">첨부 파일 삭제</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <input type="file" name="file1">
                    </c:otherwise>
                </c:choose>
                <form:hidden path="fileurl" />
            </td>
        </tr>
        <tr>
            <td colspan="2" style="border: 0; padding-top: 20px">
                <a class="w3-button w3-bar-item w3-deep-purple" href="javascript:board_submit()"
                   style="margin-right: 10px">게시글 수정</a>
                <a class="w3-button w3-bar-item w3-deep-purple" href="list.shop">게시글 목록</a>
            </td>
        </tr>
    </table>
</form:form>
</body>
</html>
