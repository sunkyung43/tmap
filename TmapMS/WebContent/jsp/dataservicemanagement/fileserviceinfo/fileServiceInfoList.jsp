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
			searchPage(0);
		});

		//조회 버튼 엔터 이벤트 처리
		$("#dataFileName").bind("keydown", function(event) {
			if (event.keyCode == 13) {
				searchPage(0);
			}
		});
	});

	function executeNew() {
		$("#ContentsForm").attr('action', 'fileServiceInfoNew.do');
		$("#ContentsForm").submit();
	}

	function executeDetail(fileServId, dataFileId) {
		$("#fileServId").val(fileServId);
		$("#dataFileId").val(dataFileId);
		$("#ContentsForm").attr('action', 'fileServiceInfoEdit.do');
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
		$("#ContentsForm").attr('action', 'fileServiceInfoList.do');
		$("#ContentsForm").submit();
	};
</script>
</head>
<body>
	<form:form commandName="ContentsForm">
		<form:hidden path="currentPage" />
		<form:hidden path="startRowNum" />
		<form:hidden path="countPerPage" />
		<form:hidden path="pageCount" />
		<form:hidden path="totalCount" />
		<form:hidden path="fileServId" />
		<form:hidden path="dataFileId" />

		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<img src="images/h3_ico.gif"><span>파일서비스 정보</span><br></br>
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
								<th>타입명</th>
								<th>파일명</th>
								<th>저장공간</th>
								<th>등록일</th>
								<th>상태</th>
							</tr>
							<c:choose>
								<c:when test="${empty fileServiceList}">
									<tr>
										<td colspan="6" height="100" class="td03">등록된 게시물이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="list" items="${fileServiceList}">
										<tr
											onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
											onMouseOut="rowOnMouseOut(this);"
											onclick="javascript:executeDetail('${list.fileServId}', '${list.dataFileId}');">
											<td class="td03">${list.rownum}</td>
											<td class="td03">${list.dataTypeName}</td>
											<td class="td03">${list.dataFileName}</td>
											<td class="td03">${list.storageName}</td>
											<td class="td03">${list.fileServSdate}</td>
											<td class="td03"><c:if
													test="${list.fileServState == 'Y'}">사용</c:if> <c:if
													test="${list.fileServState == 'N'}">미사용</c:if></td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<div id="paging"></div>
					<div id="search">
						<fieldset>
							<form:select path="dataTypeId">
								<form:option value="" label="== 선택 ==" />
								<c:forEach var="typeList" items="${typeList}">
									<form:option value="${typeList.dataTypeId}"
										label="${typeList.dataTypeName}" />
								</c:forEach>
							</form:select>
							<form:select path="keywordTp">
								<form:option value="1" label="파일명" />
							</form:select>
							<form:input type="text" size="30" path="dataFileName" />
							<img src="images/btn/search3.gif" id="btnSearch" name="btnSearch"
								style="vertical-align: bottom; width: 70px;"> <a
								href="javascript:executeNew();" onFocus="blur()"><img
								src="images/btn/btn_apply2.gif"
								style="vertical-align: bottom; width: 70px;"></a>
						</fieldset>
					</div>
				</div>
			</div>
			<div id="divPageing" class="paging"></div>
		</div>
		<jsp:include page="../../common/footer.jsp" />






		<%-- <table width="100%" height="100%" border="0" cellspacing="0"
				cellpadding="0">
				<tr>
					<td height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0"
							cellpadding="0">
							<tr>
								<td height="100%" valign="top" class="contents">
									<table width="100%" height="100%" border="0" cellspacing="0"
										cellpadding="20">
										<tr>
											<td valign="top" bgcolor="#FFFFFF">
												<div id="contents" style="width: 850px">
													<table border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td><font style="font-weight: bold;">&nbsp;파일
																	서비스 정보</font></td>
															<!-- <img src="images/title/title11.gif"> -->
															<td width="30"></td>
														</tr>
														<tr>
															<td height="10"></td>
															<td></td>
															<td></td>
															<td></td>
														</tr>
													</table>
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0">
														<tr>
															<td><form:select path="dataTypeId">
																	<form:option value="" label="== 선택 ==" />
																	<c:forEach var="typeList" items="${typeList}">
																		<form:option value="${typeList.dataTypeId}"
																			label="${typeList.dataTypeName}" />
																	</c:forEach>
																</form:select> <form:select path="keywordTp">
																	<form:option value="1" label="파일명" />
																</form:select> <form:input type="text" size="30" path="dataFileName" />
																<img src="images/btn/search3.gif" id="btnSearch"
																name="btnSearch"
																style="vertical-align: bottom; width: 70px;"></td>
															<td class="btn"><a href="javascript:executeNew();"
																onFocus="blur()"><img
																	src="images/btn/btn_apply2.gif" border="0"></a></td>
														</tr>
														<!-- <tr><td height="3"></td></tr> -->
													</table>
													<table class="aaa1">
														<tr>
															<td width="7%" align="center">번호</td>
															<td width="20%" align="center">타입명</td>
															<td width="25%" align="center">파일명</td>
															<td width="13%" align="center">저장공간</td>
															<td width="20%" align="center">등록일</td>
															<td width="15%" align="center">사용여부</td>
															<td width="3"></td>
														</tr>
													</table>
													<c:choose>
														<c:when test="${empty fileServiceList}">
															<table class="aaa1">
																<tr>
																	<td height="100" align="center">등록된 게시물이 없습니다.</td>
																</tr>
																<tr>
																	<td height="1" class="line"></td>
																</tr>
															</table>
														</c:when>
														<c:otherwise>
															<c:forEach var="list" items="${fileServiceList}">
																<table class="aaa1">
																	<tr
																		onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
																		onMouseOut="rowOnMouseOut(this);"
																		onclick="javascript:executeDetail('${list.fileServId}', '${list.dataFileId}');">

																		<td width="7%" align="center">${list.rownum}</td>

																		<td width="20%" align="center">${list.dataTypeName}</td>

																		<td width="25%" align="center">${list.dataFileName}</td>

																		<td width="13%" align="center">${list.storageName}</td>

																		<td width="20%" align="center">${list.fileServSdate}</td>

																		<td width="15%" align="center"><c:if
																				test="${list.fileServState == 'Y'}">
																				<img src="images/state/ic_map1.gif">
																			</c:if> <c:if test="${list.fileServState == 'N'}">
																				<img src="images/state/ic_map3.gif">
																			</c:if></td>
																		<td width="3"></td>
																	</tr>
																	<tr>
																		<!-- <td height="1" colspan="13" class="line"></td> -->
																	</tr>
																</table>
															</c:forEach>
														</c:otherwise>
													</c:choose>
													<br>
													<br>
													<div id="divPageing" class="paging"></div>
												</div>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table> --%>
	</form:form>
</body>
</html>