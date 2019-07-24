<%@ page import="org.springframework.web.context.ContextLoader" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="dao.MemberDao" %>
<%@ page import="logic.Member" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="day" class="java.util.Date"/>
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
            <title>후기 목록</title>
        </c:when>
        <c:otherwise>
            <title>댓글 목록</title>
        </c:otherwise>
    </c:choose>

    <script type="text/javascript">
        var reply_update_form;
        var reply_delete_form;

        function win_reply_update(num) {
            if (reply_update_form != null)
                reply_update_form.close();

            <c:choose>
                <c:when test="${param.type eq '0'}">
                    var op = "width=750, height=356, left=50, top=150";
                </c:when>
                <c:otherwise>
                    var op = "width=750, height=182, left=50, top=150";
                </c:otherwise>
            </c:choose>
            reply_update_form = open("../reply/updateForm.shop?num=" + num + "&type=${param.type}&itemno=${param.itemno}&pageNum=${param.pageNum}", "", op);
        }

        function win_reply_delete(num) {
            if (reply_delete_form != null)
                reply_delete_form.close();

            var op = "width=600, height=129, left=50, top=150";
            reply_delete_form = open("../reply/deleteForm.shop?num=" + num + "&type=${param.type}&itemno=${param.itemno}&pageNum=${param.pageNum}", "", op);
        }

        function listcall(page) {
            document.f2.pageNum.value = page;
            document.f2.submit();
        }

        function limitcall() {
            document.f2.submit();
        }

        function do_write() {
            if (!f1.content.value || f1.content.value === " ") {
                <c:choose>
                    <c:when test="${param.type eq '0'}">
                        alert("후기 내용을 입력하세요");
                    </c:when>
                    <c:otherwise>
                        alert("댓글 내용을 입력하세요");
                    </c:otherwise>
                </c:choose>
                f1.content.focus();
                return;
            }

            f1.submit();
        }
    </script>

    <style type="text/css">
        table th {
            background: #5722a9;
            color: white;
        }

        tbody tr:hover {
            background-color: #ffffff;
            cursor: pointer;
        }
    </style>
</head>
<body>
<%
    WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();

    MemberDao memberDao = null;
    if (context != null) {
        memberDao = (MemberDao) context.getBean("MemberDao");
    }
%>

<c:choose>
    <c:when test="${!empty sessionScope.loginMember}">
        <form action="write.shop" method="post" name="f1">
            <input type="hidden" name="pageNum" value="1">
            <input type="hidden" name="type" value="${param.type}">
            <input type="hidden" name="itemno" value="${param.itemno}">
            <div style="margin-bottom: 45px">
                <table style="height: 100px; background-color: #f5f5f5;">
                    <tr>
                        <td style="width: 80%; padding-top: 10px; padding-bottom: 10px">
                            <c:choose>
                                <c:when test="${param.type eq '0'}">
                                    <textarea rows="20" name="content" style="width: 100%"></textarea>
                                </c:when>
                                <c:otherwise>
                                    <textarea rows="7" name="content" style="width: 100%"></textarea>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${param.type eq '0'}">
                                    <input type="button" value="후기 남기기" class="w3-button w3-bar-item w3-deep-purple" onclick="do_write()">
                                </c:when>
                                <c:otherwise>
                                    <input type="button" value="댓글 달기" class="w3-button w3-bar-item w3-deep-purple" onclick="do_write()">
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </c:when>
    <c:otherwise>
        <div style="text-align: center; margin-bottom: 50px">
            <h5>로그인을 하시면 댓글을 남기실 수 있습니다.</h5>
        </div>
    </c:otherwise>
</c:choose>

<form action="list.shop" method="post" name="f2">
    <input type="hidden" name="pageNum" value="1">
    <input type="hidden" name="type" value="${param.type}">
    <input type="hidden" name="itemno" value="${param.itemno}">
    <c:choose>
        <c:when test="${reply_count == 0}">
            <div style="text-align: center; margin-bottom: 50px"><h5>등록된 댓글이 없습니다!</h5></div>
        </c:when>
        <c:otherwise>
            <div style="text-align: right; margin-bottom: 15px">
                표시할 댓글 갯수&nbsp;&nbsp;
                <select name="limit" onchange="limitcall(${limit})">
                    <option value="5">5</option>
                    <option value="10">10</option>
                    <option value="15">15</option>
                    <option value="20">20</option>
                    <script>
                        document.f2.limit.value = "${limit}";
                    </script>
                </select>
                &nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;댓글 갯수 : ${reply_count}
            </div>

            <table>
                <thead>
                    <tr class="table100-head">
                        <th width="8%">번호</th>
                        <th width="12%">작성자</th>
                        <th>내용</th>
                        <th width="15%">등록일</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="reply" items="${reply_list}">
                        <tr>
                            <td>${replynum}
                                <c:set var="replynum" value="${replynum - 1}"/>
                            </td>
                            <td>
                                <div style="margin-top: 10px">
                                    <div style="margin-top: 10px; margin-bottom: 10px">
                                        <c:set var="member_id" value="${reply.member_id}" />
                                        <%
                                            String reply_member_name = "";
                                            String member_id = (String)pageContext.getAttribute("member_id");
                                            if (memberDao != null) {
                                                Member member = memberDao.selectOne(member_id);
                                                if (member != null) {
                                                    reply_member_name = member.getName();
                                                }
                                            }
                                        %>
                                        <%= reply_member_name %>
                                    </div>
                                </div>
                            </td>
                            <td style="text-align: left; padding-top: 10px; padding-bottom: 10px">
                                <div style="position: relative;">
                                    <div style="display: table; height: 130px; margin-bottom: 10px">
                                        <div style="display: table-cell; vertical-align: middle">
                                            <pre style="font-family: 'Raleway', sans-serif; color: #6a6a6a; font-size: 14px; line-height: 2; font-weight: 500;
                                word-wrap: break-word; white-space: pre-wrap; white-space: -moz-pre-wrap; white-space: -o-pre-wrap; word-break:break-all;">${reply.content}</pre>
                                            <c:if test="${empty param.pageNum}">
                                                <c:set var="param.pageNum" value="1"/>
                                            </c:if>
                                        </div>
                                    </div><br><br>
                                    <div style="position: absolute; right: 0; bottom: 0">
                                        <c:set var="num" value="${reply.num}" />
                                        <c:if test="${sessionScope.loginMember.id eq reply.member_id}">
                                            <input type="button" class="w3-button w3-bar-item w3-deep-purple" value="수정" onclick="win_reply_update(${num})">
                                        </c:if>
                                        <c:if test="${sessionScope.loginMember.id eq admin || sessionScope.loginMember.id eq reply.member_id}">
                                            <input type="button" class="w3-button w3-bar-item w3-deep-purple" value="삭제" onclick="win_reply_delete(${num})")>
                                        </c:if>
                                    </div>
                                </div>
                            </td>
                            <fmt:formatDate value="${day}" pattern="yyyyMMdd" var="today"/>
                            <fmt:formatDate value="${reply.regdate}" pattern="yyyyMMdd" var="regdate"/>

                            <td>
                                <c:choose>
                                    <c:when test="${today == regdate}">
                                        <fmt:formatDate value="${reply.regdate}" pattern="HH:mm:ss"/>
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:formatDate value="${reply.regdate}" pattern="yyyy-MM-dd"/><br><br>
                                        <fmt:formatDate value="${reply.regdate}" pattern="HH:mm"/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <%-- 페이지 처리 부분 --%>
            <div class="w3-center" style="margin-top: 20px; margin-bottom: 20px">
                <div class="w3-bar">
                    <c:choose>
                        <c:when test="${pageNum <= 1}">
                            <div class="w3-bar-item">«</div>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:listcall(${pageNum - 1})" class="w3-bar-item w3-button w3-hover-deep-purple">«</a>
                        </c:otherwise>
                    </c:choose>
                    <c:forEach var="a" begin="${startpage}" end="${endpage}">
                        <c:choose>
                            <c:when test="${a == pageNum}">
                                <div class="w3-bar-item w3-deep-purple">
                                        ${a}
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a href="javascript:listcall(${a})" class="w3-bar-item w3-button w3-hover-deep-purple">${a}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:choose>
                        <c:when test="${pageNum >= endpage}">
                            <div class="w3-bar-item">»</div>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:listcall(${pageNum + 1})" class="w3-bar-item w3-button w3-hover-deep-purple">»</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</form>
</body>
</html>
