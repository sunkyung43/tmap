<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	    
	 	//조회 버튼 클릭 이벤트 처리
	    $("#btnSearch").bind("click", function() {
	    	searchPage(1);
	    });
	    
	   //조회 버튼 엔터 이벤트 처리
	    $("#appMappingName").bind("keydown", function(event) {
	        if (event.keyCode == 13) {	
	        	searchPage(1);
	        }
	    });
	});
	
	function executeDetail(appMappingId) {
		$("#appMappingId").val(appMappingId);
		$("#ContentsForm").attr('action','appServiceInfoEdit.do');
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
		$("#ContentsForm").attr('action','appServiceInfoList.do');
	    $("#ContentsForm").submit();
	};
</script>
</head>
<body>
	<jsp:include page="../../common/menu.jsp" />
	<div id="bodyDiv">
		<div class="contentsDiv">
			<div class="contentDiv">
				<img src="images/h3_ico.gif"><span>데이터 대기정보</span>
				<div>
					<table class="sub_0601_table">
						<colgroup>
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>번호</th>
								<th>매핑데이터명</th>
								<th>내용</th>
								<th>배포정보</th>
								<th>배포타입</th>
								<th>배포여부</th>
							</tr>
							<c:choose>
								<c:when test="${empty appServiceInfoListReady}">
									<tr>
										<td colspan="6" height="100" class="td03">등록된 게시물이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="list" items="${appServiceInfoListReady}">
										<tr
											onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
											onMouseOut="rowOnMouseOut(this);"
											onclick="javascript:executeDetail(${list.appMappingId});">
											<td class="td03">${list.rownum}</td>
											<td class="td03">${list.appMappingName}</td>
											<td class="td03">${list.appMappingContent}</td>
											<td class="td03"><c:if
													test="${list.appServiceState == 'Y'}">사용</c:if> <c:if
													test="${list.appServiceState == 'N'}">미사용</c:if> <c:if
													test="${list.appServiceState == 'W'}">대기중</c:if></td>
											<td class="td03"><c:if
													test="${list.appServiceType == 'T'}">테스트배포</c:if> <c:if
													test="${list.appServiceType == 'R'}">배포</c:if>
												<c:if test="${list.appServiceType == 'W'}">대기중</c:if></td>
											<td class="td03"><c:if
													test="${list.appServiceDistribute == 'P'}">배포중</c:if> <c:if
													test="${list.appServiceDistribute == 'S'}">배포중지</c:if>
												<c:if test="${list.appServiceDistribute == 'W'}">대기중</c:if></td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<br></br> <img src="images/h3_ico.gif"><span>데이터 배포정보</span>
				<form:form commandName="ContentsForm">
					<form:hidden path="currentPage" />
					<form:hidden path="startRowNum" />
					<form:hidden path="countPerPage" />
					<form:hidden path="pageCount" />
					<form:hidden path="totalCount" />
					<form:hidden path="appMappingId" />
					<form:hidden path="appVerId" />
					<div>
						<table class="sub_0601_table">
							<colgroup>
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
							</colgroup>
							<tbody>
								<tr>
									<th>번호</th>
									<th>매핑데이터명</th>
									<th>내용</th>
									<th>배포정보</th>
									<th>배포타입</th>
									<th>배포여부</th>
								</tr>
								<c:choose>
									<c:when test="${empty appServiceInfoList}">
										<tr>
											<td colspan="6" height="100" class="td03">등록된 게시물이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="list" items="${appServiceInfoList}">
											<tr
												onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
												onMouseOut="rowOnMouseOut(this);"
												onclick="javascript:executeDetail(${list.appMappingId});">
												<td class="td03">${list.rownum}</td>
												<td class="td03">${list.appMappingName}</td>
												<td class="td03">${list.appMappingContent}</td>
												<td class="td03"><c:if
														test="${list.appServiceState == 'Y'}">사용</c:if> <c:if
														test="${list.appServiceState == 'N'}">미사용</c:if> <c:if
														test="${list.appServiceState != 'Y' && list.appServiceState != 'N'}">미등록</c:if></td>
												<td class="td03"><c:if
														test="${list.appServiceType == 'T'}">테스트배포</c:if> <c:if
														test="${list.appServiceType == 'R'}">배포</c:if></td>
												<td class="td03"><c:if
														test="${list.appServiceDistribute == 'P'}">배포중</c:if> <c:if
														test="${list.appServiceDistribute == 'S'}">배포중지</c:if></td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
						<div id="paging"></div>
						<div id="search">
							<fieldset>
								<form:select path="keywordTp">
									<form:option value="1" label="매핑데이터명" />
								</form:select>
								<form:input type="text" size="30" path="appMappingName" />
								<img src="images/btn/search3.gif" id="btnSearch"
									name="btnSearch" style="vertical-align: bottom; width: 70px;">
							</fieldset>
						</div>
					</div>
				</form:form>
			</div>
			<!-- <div id="divPageing" class="paging"></div> -->
		</div>
	</div>
	<jsp:include page="../../common/footer.jsp" />
</body>
</html>