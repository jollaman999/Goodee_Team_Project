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

    <c:choose>
        <c:when test="${param.type eq '0'}">
            <title>후기 수정</title>
        </c:when>
        <c:otherwise>
            <title>댓글 수정</title>
        </c:otherwise>
    </c:choose>

    <script type="text/javascript">
        function do_submit() {
            if (!f.content.value || f.content.value === " ") {
                <c:choose>
                    <c:when test="${param.type eq '0'}">
                        alert("후기 내용을 입력하세요");
                    </c:when>
                    <c:otherwise>
                        alert("댓글 내용을 입력하세요");
                    </c:otherwise>
                </c:choose>
                f.content.focus();
                return;
            }

            f.submit();
        }
    </script>

    <style type="text/css">
        tbody tr:hover {
            background-color: #ffffff;
            cursor: pointer;
        }
    </style>
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
                    <td style="width: 80%; padding-top: 10px; padding-bottom: 10px">
                        <c:choose>
                            <c:when test="${param.type eq '0'}">
                                <textarea rows="20" name="content" style="width: 100%">${reply.content}</textarea>
                            </c:when>
                            <c:otherwise>
                                <textarea rows="7" name="content" style="width: 100%">${reply.content}</textarea>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${param.type eq '0'}">
                                <input type="button" value="후기 수정" class="w3-button w3-bar-item w3-deep-purple" onclick="do_submit()()">
                            </c:when>
                            <c:otherwise>
                                <input type="button" value="댓글 수정" class="w3-button w3-bar-item w3-deep-purple" onclick="do_submit()()">
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</div>
</body>
</html>
