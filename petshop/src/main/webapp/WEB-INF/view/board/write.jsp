<%@ page import="dao.ItemDao" %>
<%@ page import="org.springframework.web.context.ContextLoader" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="logic.Item" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set value="${pageContext.request.contextPath}" var="path"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 작성</title>

    <link rel="stylesheet" type="text/css" href="${path}/css/w3.css">

	<script type="text/javascript">
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
</head>
<body>
<%
    WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();

    ItemDao itemDao = null;
    Item item = null;

    if (context != null) {
        itemDao = (ItemDao) context.getBean("ItemDao");
    }
%>
<c:set var="item_no" value="${param.item_no}"/>
<%
    if (itemDao != null && pageContext.getAttribute("item_no") != null) {
        item = itemDao.selectOne(Integer.parseInt((String) pageContext.getAttribute("item_no")), false);
    }

    String item_name = "";
    if (item != null) {
        item_name = item.getName();
    }
%>
<form name="f" method="post" action="write.shop" enctype="multipart/form-data">
    <c:if test="${param.type != 0}">
        <input type="hidden" name="item_no" value="${param.item_no}">
    </c:if>
    <input type="hidden" name="item_name" value="${param.item_name}">
    <input type="hidden" name="type" value="${param.type}">
    <input type="hidden" name="member_id" value="${sessionScope.loginMember.id}">
    <br>
    <table>
        <tr>
            <td>제목</td>
            <td><input type="text" name="title" size="100"></td>
        </tr>
        <c:if test="${param.type != 0}">
            <tr>
                <td>상품 이름</td>
                <td><%= item_name %>
                </td>
            </tr>
        </c:if>
        <tr>
            <td>첨부파일</td>
            <td><input type="file" name="file1"></td>
        </tr>

        <tr>
            <td colspan="2"><textarea name="content" cols="120" rows="10"></textarea>
                <script type="text/javascript">
                    CKEDITOR.replace("content", {
                        filebrowserImageUploadUrl: "imgupload.shop",
                        language: "ko",
                        skin: "moono"
                    });
                </script>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="border: 0; padding-top: 20px">
                <input class="w3-button w3-bar-item w3-deep-purple"
                       type="button" onclick="board_submit()" value="게시판 등록" style="margin-right: 10px">
                <input class="w3-button w3-bar-item w3-deep-purple"
                       type="button" onclick="location.href='list.shop?type=${param.type}'" value="게시글 목록"></td>
        </tr>
    </table>
</form>
</body>
</html>
