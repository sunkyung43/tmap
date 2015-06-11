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
<link rel="stylesheet" href="css/tmap.css" type="text/css" />
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
		$("#searchAppName").bind("keydown", function(event) {
			if (event.keyCode == 13) {
				searchPage(1);
			}
		});

	});

	function executeNew() {
		$("#ContentsForm").attr('action', 'appInfoNew.do');
		$("#ContentsForm").submit();
	}

	function executeDetail(appInfoSeq) {
		$("#appInfoSeq").val(appInfoSeq);
		$("#ContentsForm").attr('action', 'appInfoEdit.do');
		$("#ContentsForm").submit();
	}

	//리스트조회
	function searchPage(page) {
		if (page == "" || page == 0) {
			$("#currentPage").val(1);
		} else {
			$("#currentPage").val(page);
		}

		$("#startRowNum").val((page - 1) * ($('#countPerPage').val()));
		$("#ContentsForm").attr('action', 'appInfoList.do');
		$("#ContentsForm").submit();
	};
</script>
<style>
.line{border-right: 1px solid #CFCFCF;border-bottom: 1px solid #CFCFCF}
 
</style>
</head>
<body>
	<form:form commandName="ContentsForm">
		<form:hidden path="currentPage" />
		<form:hidden path="startRowNum" />
		<form:hidden path="countPerPage" />
		<form:hidden path="pageCount" />
		<form:hidden path="totalCount" />
		<form:hidden path="appInfoSeq" />

		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<img src="images/h3_ico.gif"><span>APP List</span>
					<table class="sub_0601_table">
						<colgroup>
							<col width="30%" />
							<col width="35%" />
							<col width="35%" />
						</colgroup>
						<tbody>
							<tr>
								<th class="line">App 명</th>
								<th class="line">버전명</th>
								<th>버전내용</th>
							</tr>
							<c:choose>
								<c:when test="${empty appInfoList}">
									<tr>
										<td height="100" align="center">등록된 게시물이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:set var="prevAppName" value="" />
									<c:set var="rowSpanNumber" value="0" />
									<c:set var="line" value="1" />

									<c:forEach var="list" items="${appInfoList}">
										<c:set var="currentAppName" value="${list.appName}" />
										<c:set var="rowDraw" value="false" />

										<c:if
											test="${prevAppName == '' || currentAppName != prevAppName}">
											<c:set var="prevAppName" value="${list.appName}" />
											<c:set var="rowDraw" value="true" />
										</c:if>

										<tr onclick="javascript:executeDetail('${list.appInfoSeq}');">

											<c:choose>
												<c:when test="${rowInfo[list.appName] == 1}">
													<td style="border-right: 1px solid #CFCFCF;border-bottom: 1px solid #CFCFCF;"
														onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
														onMouseOut="rowOnMouseOut(this);">${list.appName}</td>
												</c:when>
												<c:otherwise>
													<c:if test="${rowDraw}">
														<c:set var="rowSpanNumber"
															value="${(rowInfo[list.appName])}" />
														<td rowspan="${rowSpanNumber}"
															onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
															onMouseOut="rowOnMouseOut(this);"
															style="border-right: 1px solid #CFCFCF; border-bottom: 1px solid #CFCFCF;">${list.appName}</td>
													</c:if>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${list.appVerName == null}">
													<td width="70%" colspan="3" style="border-bottom: 1px solid #CFCFCF;"
														onmouseover="rowOnMouseOver(this);"
														onMouseOut="rowOnMouseOut(this);">등록된 버전이 없습니다.</td>
												</c:when>
												<c:otherwise>
													<td width="35%" class="line"
														onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
														onMouseOut="rowOnMouseOut(this);">${list.appVerName}
													</td>
													<td width="35%" style="border-bottom: 1px solid #CFCFCF;"
														onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
														onMouseOut="rowOnMouseOut(this);">${list.appVerContent} 
													</td>
												</c:otherwise>
											</c:choose>
										</tr>
										<c:choose>
											<c:when test="${rowInfo[list.appName] == line}">
												<c:set var="line" value="1" />
											</c:when>
											<c:otherwise>
												<c:set var="line" value="${line+1}" />
											</c:otherwise>
										</c:choose>
									</c:forEach>

								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<div id="paging"></div>
					<div id="search">
						<fieldset>
							<form:select path="keywordTp">
								<form:option value="1" label="어플리케이션 이름" />
							</form:select>
							<form:input type="text" size="30" path="searchAppName" />
							<img src="images/btn/search3.gif" id="btnSearch" name="btnSearch"
								style="vertical-align: bottom; width: 70px;"> <a
								href="javascript:executeNew();" onFocus="blur()"><img
								src="images/btn/btn_apply2.gif"
								style="vertical-align: bottom; width: 70px;"></a>
						</fieldset>
					</div>

					<div id="divPageing" class="paging"></div>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />
	</form:form>
</body>
</html>
