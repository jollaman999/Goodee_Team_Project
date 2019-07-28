<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 등록</title>

    <script src="https://cdn.ckeditor.com/4.5.7/full-all/ckeditor.js"></script>

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

            if (!ext.endsWith("jpg") && !ext.endsWith("jpeg") && !ext.endsWith("png") &&  !ext.endsWith("gif") &&  !ext.endsWith("bmp")){
                alert("첨부 파일은 이미지 파일(jpg, jpeg, png, gif, bmp)만 등록 가능합니다!");
                return;
            }

            // 사이즈체크
            var maxSize = 10 * 1024 * 1024;
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
                alert("이미지 파일 사이즈는 10MB 이내로 등록 가능합니다!");
                return -1;
            }

            return 0;
        }

        function file_delete() {
            document.getElementById("file_desc").innerHTML ="<input type=\"file\" name=\"mainpic\">";
        }

        function do_submit() {
            f = document.f;

            if (f.mainpic != null && f.mainpic.value && fileCheck(f.mainpic) != 0) {
                return;
            }

            f.submit();
        }
    </script>
</head>
<body>
<form:form modelAttribute="item" action="update.shop" enctype="multipart/form-data" name="f">
    <input type="hidden" name="item_no" value="${item.item_no}">

    <h2>상품 수정</h2>

    <spring:hasBindErrors name="item">
        <font color="red">
            <c:forEach items="${errors.globalErrors}" var="error">
                <spring:message code="${error.code}"/>
            </c:forEach>
        </font>
    </spring:hasBindErrors>
    <br><br>

    <table>
        <tr>
            <td>1차 분류</td>
            <td>
                <form:select class="category1" path="category_group_code" cssStyle="width: 100%">
                    <option value="0">전체</option>
                </form:select>
                <font color="red"><form:errors path="category_group_code"/></font>
            </td>
        </tr>
        <tr>
            <td>2차 분류</td>
            <td>
                <form:select class="category2" path="category_item_code" cssStyle="width: 100%">
                    <option value="0">전체</option>
                </form:select>
                <font color="red"><form:errors path="category_item_code"/></font>
            </td>
        </tr>
        <tr>
            <td>상품명</td>
            <td>
                <form:input path="name" maxlength="20"/>
                <font color="red"><form:errors path="name"/></font>
            </td>
        </tr>
        <tr>
            <td>상품 이미지</td>
            <td colspan="2">
                <c:choose>
                    <c:when test="${!empty item.mainpicurl}">
                        <div id="file_desc">
                                ${item.mainpicurl}&nbsp;&nbsp;
                            <a href="javascript:file_delete()">[이미지 삭제]</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <input type="file" name="mainpic">
                    </c:otherwise>
                </c:choose>
            </td>
            <font color="red"><form:errors path="mainpic"/></font>
        </tr>
        <tr>
            <td>상품 가격</td>
            <td>
                <form:input path="price" maxlength="20"/>
                <font color="red"><form:errors path="price"/></font>
            </td>
        </tr>
        <tr>
            <td>상품 수량</td>
            <td>
                <form:input path="quantity" maxlength="20"/>
                <font color="red"><form:errors path="quantity"/></font>
            </td>
        </tr>
        <tr>
            <td>원산지</td>
            <td><form:input path="origin" maxlength="20"/></td>
        </tr>
        <tr>
            <td>제조사</td>
            <td><form:input path="mfr" maxlength="20"/></td>
        </tr>
        <tr>
            <td>제조사 연락처</td>
            <td><form:input path="mfr_tel" maxlength="20"/></td>
        </tr>

        <!--  유통기한 원본소스
        <form id="frm" action="action.jsp">
        <p>유통기한 입력:</p>
        <div><input type="date" id="userdate" name="userdate"
                value="2015-10-10"></div>
        <div><input type="submit" value="전송"></div>
        </form>
                                                  -->
        <tr>
            <td>유통기한</td>
            <td><form:input path="expr_date" type="text" name="userdate"/></td>
        </tr>

        <tr>
            <td>상품 설명</td>
            <td>
                <form:textarea path="description" cols="20" rows="5"/>
                <font color="red"><form:errors path="description"/></font>
            </td>
        </tr>
        <tr>
            <td>상품 상세</td>
            <td colspan="2">
                <form:textarea path="content" rows="15" cols="80" />
                <font color="red"><form:errors path="content" /></font>
                <script type="text/javascript">
                    CKEDITOR.replace("content", {filebrowserImageUploadUrl : "imgupload.shop", language : "ko", skin : "moono"});
                </script>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <input type="button" value="상품 수정" onclick="do_submit()">&nbsp;
                <input type="button" value="리스트로 가기" onclick="location.href='${path}/inventory/list.shop?pageNum=${param.pageNum}'">
            </td>
        </tr>
    </table>
</form:form>

<script type="text/javascript">
    //jsondata에서 level값이 1인 경우에만 cate1Obj에 추가하고,
    //이 추가한 데이터를 cate1Arr에 추가합니다.
    //이렇게 추가한 값을 cate1Select에 추가합니다.

    // 컨트롤러에서 데이터 받기
    var jsonData1 = JSON.parse('${categoryGroupList}');

    var cate1Arr = [];
    var cate1Obj = {};

    // 1차 분류 셀렉트 박스에 삽입할 데이터 준비
    for (var i = 0; i < jsonData1.length; i++) {
        cate1Obj = {}; //초기화
        cate1Obj.group_code = jsonData1[i].group_code;
        cate1Obj.group_name = jsonData1[i].group_name;
        cate1Arr.push(cate1Obj);
    }

    // 1차 분류 셀렉트 박스에 데이터 삽입
    var cate1Select = $("select.category1");

    for (var i = 0; i < cate1Arr.length; i++) {
        cate1Select.append("<option value='" + cate1Arr[i].group_code + "'>"
            + cate1Arr[i].group_name + "</option>");
    }

    document.getElementById("category_group_code").value = "${item.category_group_code}";

    // 이제 2차 분류에 데이터를 추가하기 위한 코드를 작성합니다.
    var cate2Select = $("select.category2");

    $(document).on("change", "select.category1", function () {
        var jsonData2 = JSON.parse('${categoryItemList}');

        var cate2Arr = [];
        var cate2Obj = {};

        // 2차 분류 셀렉트 박스에 삽입할 데이터 준비
        for (var i = 0; i < jsonData2.length; i++) {
            cate2Obj = {};  //초기화
            cate2Obj.group_code = jsonData2[i].group_code;
            cate2Obj.code = jsonData2[i].code;
            cate2Obj.name = jsonData2[i].name;
            cate2Arr.push(cate2Obj);
        }

        cate2Select.children().remove();

        $("option:selected", this).each(function () {
            var selectVal = $(this).val();
            cate2Select.append("<option value=''>전체</option>");

            for (var i = 0; i < cate2Arr.length; i++) {
                if (selectVal == cate2Arr[i].group_code) {
                    cate2Select.append("<option value='" + cate2Arr[i].code + "'>"
                        + cate2Arr[i].name + "</option>");
                }
            }
        });
    });

    $(document).ready(function () {
        var jsonData2 = JSON.parse('${categoryItemList}');

        var cate2Arr = [];
        var cate2Obj = {};

        // 2차 분류 셀렉트 박스에 삽입할 데이터 준비
        for (var i = 0; i < jsonData2.length; i++) {
            cate2Obj = {};  //초기화
            cate2Obj.group_code = jsonData2[i].group_code;
            cate2Obj.code = jsonData2[i].code;
            cate2Obj.name = jsonData2[i].name;
            cate2Arr.push(cate2Obj);
        }

        cate2Select.children().remove();

        $("option:selected", this).each(function () {
            var selectVal = document.getElementById("category_group_code").value;
            cate2Select.append("<option value=''>전체</option>");

            for (var i = 0; i < cate2Arr.length; i++) {
                if (selectVal == cate2Arr[i].group_code) {
                    cate2Select.append("<option value='" + cate2Arr[i].code + "'>"
                        + cate2Arr[i].name + "</option>");
                }
            }

            document.getElementById("category_item_code").value = "${item.category_item_code}";
        });
    });
</script>
</body>
</html>
