<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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

		//등록 버튼 클릭 이벤트 처리
		$("#btnRegister").bind("click", function() {
			executeNew();
		});

		//조회 버튼 엔터 이벤트 처리
		$("#searchDataTypeName").bind("keydown", function(event) {
			if (event.keyCode == 13) {
				searchPage(1);
			}
		});

		$("#btnDataFileList").bind("click", function() {
			$("#ContentsForm").attr("action", "dataFileInfoList.do");
			$("#ContentsForm").submit();
		});
	});

	function executeNew() {
		$("#ContentsForm").attr("action", "dataTypeInfoNew.do");
		$("#ContentsForm").submit();
	}

	function executeDetail(dataTypeId) {
		$("#dataTypeId").val(dataTypeId);
		$("#ContentsForm").attr("action", "dataTypeInfo.do");
		$("#ContentsForm").submit();
	}

	//리스트조회
	function searchPage(page) {
		if (page == "" || page == 0) {
			$("#currentPage").val(1);
		} else {
			$("#currentPage").val(page);
		}

		$("#startRowNum").val((page - 1) * ($("#countPerPage").val()));
		$("#ContentsForm").attr("action", "dataTypeInfoList.do");
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
		<form:hidden path="dataTypeId" />


		<!-- 메뉴화면 관련 -->
		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<img src="images/h3_ico.gif"><span>데이터 타입 관리</span>
					<table class="sub_0601_table">
						<colgroup>
							<col width="*" />
							<col width="*" />
							<col width="*" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th>번호</th>
								<th>이름</th>
								<th>등록일</th>
								<th>상태</th>
							</tr>
							<c:choose>
								<c:when test="${empty dataTypeInfoList}">
									<tr>
										<td colspan="4" height="100" align="center">등록된 게시물이
											없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="list" items="${dataTypeInfoList}">
										<tr
											onmouseover="rowOnMouseOver(this);this.style.cursor='hand';"
											onMouseOut="rowOnMouseOut(this);"
											onclick="javascript:executeDetail('${list.dataTypeId}');">
											<td class="td03">${list.rownum}</td>
											<td class="td03">${list.dataTypeName}</td>
											<td class="td03">${list.dataTypeSdate}</td>
											<td class="td03"><c:if test="${list.dataTypeState == 'Y'}">
													사용
												</c:if> <c:if test="${list.dataTypeState == 'N'}">
													미사용
												</c:if></td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<div id="paging"></div>
					<div id="search">
						<fieldset>
							상태
							<form:select path="searchDataTypeState">
								<form:option value="ALL" label="전체" />
								<form:option value="Y" label="사용중" />
								<form:option value="N" label="미사용중" />
							</form:select>
							&nbsp;&nbsp;&nbsp; DataType 이름
							<form:input type="text" size="30" path="searchDataTypeName"
								cssClass="textbox" />
							<a href="#" onFocus="blur();" id="btnDataFileList">DataFile
								List</a> <a href="#" onFocus="blur();"><img id="btnSearch"
								name="btnSearch" src="images/btn/search3.gif"
								style="vertical-align: bottom; width: 73px;"></a> <a href="#" onFocus="blur();"><img
								id="btnRegister" name="btnRegister"
								src="images/btn/btn_apply2.gif" style="vertical-align: bottom;"></a>
						</fieldset>
					</div>

					<div id="divPageing" class="paging"></div>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />



























		<%-- <table width="100%" height="100%" border="0" cellspacing="0"
			cellpadding="0">
			<tr>
				<td height="100%"><table width="100%" height="100%" border="0"
						cellspacing="0" cellpadding="0">
						<tr>
							<td width="10" background="images/bg_bar.gif"></td>
							<td height="100%" valign="top" class="contents"><table
									width="100%" height="100%" border="0" cellspacing="0"
									cellpadding="20">
									<tr>
										<td valign="top" bgcolor="#FFFFFF">

											<div id="contents" style="width: 850px">
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td><h1 style="color: red;">Data Type 관리</h1></td>
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
														<td class="ttl" style="text-align: left;">상태 <form:select
																path="searchDataTypeState">
																<form:option value="ALL" label="전체" />
																<form:option value="Y" label="사용중" />
																<form:option value="N" label="미사용중" />
															</form:select> &nbsp;&nbsp;&nbsp; DataType 이름 <form:input type="text"
																size="30" path="searchDataTypeName" cssClass="textbox" />
														</td>
														<td class="btn ttl"><a href="#" onFocus="blur();"
															id="btnDataFileList">DataFile List</a> <a href="#"
															onFocus="blur();"><img id="btnSearch"
																name="btnSearch" src="images/btn/search3.gif" border="0"
																style="width: 73px;"></a> <a href="#"
															onFocus="blur();"><img id="btnRegister"
																name="btnRegister" src="images/btn/btn_apply2.gif"
																border="0"></a></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td width="3"><img src="images/ttl_bar1.gif"></td>
														<td width="15%" background="images/ttl_bar2.gif"
															class="ttl">No</td>
														<td width="1" background="images/ttl_bar2.gif"><img
															src="images/ttl_line.gif"></td>
														<td width="50%" background="images/ttl_bar2.gif"
															class="ttl">이름</td>
														<td width="1" background="images/ttl_bar2.gif"><img
															src="images/ttl_line.gif"></td>
														<td width="20%" background="images/ttl_bar2.gif"
															class="ttl">생성일</td>
														<td width="1" background="images/ttl_bar2.gif"><img
															src="images/ttl_line.gif"></td>
														<td width="15%" background="images/ttl_bar2.gif"
															class="ttl">상태</td>
														<td width="3"><img src="images/ttl_bar3.gif"></td>
													</tr>
												</table>
												<c:choose>
													<c:when test="${empty dataTypeInfoList}">
														<table width="100%" border="0" cellspacing="0"
															cellpadding="0">
															<tr>
																<td height="100" align="center">등록된 게시물이 없습니다.</td>
															</tr>
															<tr>
																<td height="1" class="line"></td>
															</tr>
														</table>
													</c:when>
													<c:otherwise>
														<c:forEach var="list" items="${dataTypeInfoList}">
															<table width="100%" border="0" cellspacing="0"
																cellpadding="0">
																<tr
																	onmouseover="rowOnMouseOver(this);this.style.cursor='hand';"
																	onMouseOut="rowOnMouseOut(this);"
																	onclick="javascript:executeDetail('${list.dataTypeId}');">
																	<td width="3"></td>
																	<td width="15%" align="center" style="padding: 7 0 7 0">
																		<input type="text" class="invisiblebox"
																		value="${list.rownum}" readonly="readonly"
																		onmouseover="this.style.cursor='hand';" />
																	</td>
																	<td width="2"></td>
																	<td width="50%" align="center" style="padding: 7 0 7 0">
																		<input type="text" class="invisiblebox"
																		value="${list.dataTypeName}" readonly="readonly"
																		onmouseover="this.style.cursor='hand';" />
																	</td>
																	<td width="2"></td>
																	<td width="20%" align="center" style="padding: 7 0 7 0">
																		<input type="text" class="invisiblebox"
																		value="${list.dataTypeSdate}" readonly="readonly"
																		onmouseover="this.style.cursor='hand';" />
																	</td>
																	<td width="2"></td>
																	<td width="15%" align="center" style="padding: 7 0 7 0">
																		<c:if test="${list.dataTypeState == 'Y'}">
																			<img src="images/state/ic_map1.gif">
																		</c:if> <c:if test="${list.dataTypeState == 'N'}">
																			<img src="images/state/ic_map4.gif">
																		</c:if>
																	</td>
																	<td width="3"></td>
																</tr>
																<tr>
																	<td height="1" colspan="13" class="line"></td>
																</tr>
															</table>
														</c:forEach>
													</c:otherwise>
												</c:choose>

												<br> <br>
												<div id="divPageing" class="paging"></div>
											</div>
										</td>
									</tr>
								</table></td>
							<td width="10" background="images/bg_bar.gif"></td>
						</tr>
						<tr></tr>
					</table></td>
			</tr>
			<tr>
				<td height="10"><table width="100%" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td width="10"><img src="images/bottom_bg1.gif"></td>
							<td width="100%" background="images/bottom_bg2.gif"></td>
							<td width="10"><img src="images/bottom_bg3.gif"></td>
						</tr>
					</table></td>
			</tr>
		</table> --%>
	</form:form>
</body>
</html>
