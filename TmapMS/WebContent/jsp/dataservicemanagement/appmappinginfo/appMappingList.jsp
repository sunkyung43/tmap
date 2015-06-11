<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
  response.setHeader("Cache-Control", "no-store"); // HTTP 1.1
			response.setHeader("Pragma", "no-cache"); // HTTP 1.0
			response.setDateHeader("Expires", 0);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tmap Managerment Site</title>
<!--  Stylesheet		-------------------------------------------------------------------------->
<link rel="stylesheet" href="css/common.css" type="text/css" />
<link rel="stylesheet" href="css/layout_contents.css" type="text/css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/paging.js"></script>
<script type="text/javascript">
	
	//이벤트 등록
	$(document).ready(function() {
	
	    fnPaging();
	  	//검색 조건 설정
	    searchCondChange();
	    $("#keywordTp").change(function(){
	    	searchCondChange();
	    });
	    //조회 버튼 클릭 이벤트 처리
	    $("#btnSearch").bind("click", function() {
	    	searchPage(0);
	    });
	   	//조회 버튼 엔터 이벤트 처리
	    $("#searchAppName").bind("keydown", function(event) {
	        if (event.keyCode == 13) {	
	        	searchPage(0);
	        }
	    });
	 	//조회 버튼 엔터 이벤트 처리
	    $("#appMappingName").bind("keydown", function(event) {
	        if (event.keyCode == 13) {	
	        	searchPage(0);
	        }
	    });
	});
	
	//검색 조건 변경
	function searchCondChange(keywordTp) {
		if ($("#keywordTp").val() == "1") {
			$("#appMappingName").val("");
			$("#appMappingName").hide();
			$("#searchAppName").show();
		} else {
	        $("#searchAppName").val("");
	        $("#searchAppName").hide();
	        $("#appMappingName").show();
		}
	};
	
	//리스트조회
	function searchPage(page) {
		if (page == "" || page == 0){
	        $("#currentPage").val(1);
	    }else {
	        $("#currentPage").val(page);
	    }
		
	    $("#startRowNum").val((page-1) * ($('#countPerPage').val()));
		$("#ContentsForm").attr('action','appMappingList.do');
	    $("#ContentsForm").submit();
	};
	
	function executeNew(appInfoSeq, appName) {
		$("#appInfoSeq",parent.document).val(appInfoSeq);
		$("#appName",parent.document).val(appName);
		$("#mappingListDiv",parent.document).hide();
		$("#mappingDiv",parent.document).show();
		$("#detail",parent.document).show();
		
	}
	
</script>
</head>
<body>
  <form:form commandName="ContentsForm">
    <form:hidden path="currentPage" />
    <form:hidden path="startRowNum" />
    <form:hidden path="countPerPage" />
    <form:hidden path="pageCount" />
    <form:hidden path="totalCount" />
    <form:hidden path="appMappingId" />
    <table class="sub_0601_table">
      <colgroup>
        <col width="10%" />
        <col width="30%" />
        <col width="30%" />
        <col width="30%" />
      </colgroup>
      <tbody>
        <tr>
          <th>번호</th>
          <th>App명</th>
          <th>내용</th>
          <th>등록일</th>
        </tr>
        <c:choose>
          <c:when test="${empty appList}">
            <tr style="height: 100px">
              <td colspan="4">등록 가능한 App이 없습니다. <br /> App 등록 후 사용하세요
              </td>
            </tr>
          </c:when>
          <c:otherwise>
            <c:forEach var="list" items="${appList}">
              <tr onmouseover="rowOnMouseOver(this);this.style.cursor='hand'" onMouseOut="rowOnMouseOut2(this);" onclick="javascript:executeNew(${list.appInfoSeq}, '${list.appName}');">
                <td class="td03">${list.rownum}</td>
                <td class="td03">${list.appName}</td>
                <td class="td03">${list.appContent}</td>
                <td class="td03">${list.appStoreDate}</td>
              </tr>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </tbody>
    </table>
  </form:form>
</body>
</html>