<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<link rel="stylesheet" href="css/tmap.css" type="text/css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/paging.js"></script>
<script type="text/javascript">
	
	//이벤트 등록
	$(document).ready(function() {
	
	    fnPaging();
	  	
	});
	
	function executeNew() {
		var app_id = '${appInfoSeq}';
		$("#appInfoSeq").val(app_id);
		$("#ContentsForm").attr('action','appVerInfoNew.do');
	    $("#ContentsForm").submit();
	}
	
	function executeDetail(appVerId) {
		$("#appVerId").val(appVerId);
		$("#ContentsForm").attr('action','appVerInfoEdit.do');
	    $("#ContentsForm").submit();
	}
	
	//리스트조회
	function searchPage(page) {
		if (page == "" || page == 0){
	        $("#currentPage").val(1);
	    }else {
	        $("#currentPage").val(page);
	    }
		
	    $("#startRowNum").val((page-1) * ($('#countPerPage').val()));
		$("#ContentsForm").attr('action','appVerInfoList.do');
	    $("#ContentsForm").submit();
	};
	
</script>
</head>
<body>
<form:form commandName="ContentsForm">
<form:hidden path="currentPage"/>
<form:hidden path="startRowNum"/>
<form:hidden path="countPerPage"/>
<form:hidden path="pageCount"/>
<form:hidden path="totalCount"/>
<form:hidden path="appInfoSeq"/>
<form:hidden path="appVerId"/>
<div id="contents" style="position: absolute;">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
    	<tr>
	    	<td align="right" style="padding:0 0 5 0">
	    	<img src="images/btn/btn_apply2.gif" border="0" style="cursor:hand" onclick="javascript:executeNew();" alt="등록하기" /></td>
	    </tr>
    </table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="3"><img src="images/ttl_bar1.gif"></td>
			<td width="10%" background="images/ttl_bar2.gif" class="ttl">번호</td>
			<td width="2" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
			<td width="30%" background="images/ttl_bar2.gif" class="ttl">버전 명</td>
			<td width="2" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
			<td width="40%" background="images/ttl_bar2.gif" class="ttl">내용</td>
			<td width="2" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
			<td width="20%" background="images/ttl_bar2.gif" class="ttl">버전 상태</td>
			<td width="3"><img src="images/ttl_bar3.gif"></td>
		</tr>
	</table>
	<c:choose>
	<c:when test="${empty appVerInfoList}">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="100" align="center">등록된 게시물이 없습니다.</td>
			</tr>
			<tr>
				<td height="1" class="line"></td>
			</tr>
		</table>
	</c:when>
	<c:otherwise>
	<c:forEach var="list" items="${appVerInfoList}" >
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr onmouseover="rowOnMouseOver(this);this.style.cursor='hand';" onMouseOut="rowOnMouseOut(this);" onclick="javascript:executeDetail('${list.appVerId}');">
				<td width="3"></td>
				<td width="10%" align="center" style="padding:7 0 7 0">
					<input type="text" class="invisiblebox" value="${list.rownum}" readonly="readonly" />
				</td>
				<td width="2"></td>
				<td width="30%" align="center" style="padding:7 0 7 0">
					<input type="text" class="invisiblebox" value="${list.appVerName}" readonly="readonly" />
				</td>
				<td width="2"></td>
				<td width="40%" align="center" style="padding:7 0 7 0">
					<input type="text" class="invisiblebox" value="${list.appVerContent}" readonly="readonly" />
				</td>
				<td width="2"></td>
				<td width="20%" align="center" style="padding:7 0 7 0">
					<c:if test="${list.appVerState == 'Y'}"><img src="images/state/ic_map1.gif"></c:if>
					<c:if test="${list.appVerState == 'N'}"><img src="images/state/ic_map4.gif"></c:if>
				</td>
				<td width="3"></td>
		  	</tr>
				</table>
	</c:forEach>
	</c:otherwise>
	</c:choose>
	<br>
    <div id="divPageing" class="paging"></div>
</div>
</form:form>
</body>
</html>