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
<link rel="stylesheet" href="css/tmap.css" type="text/css" />
<link rel="stylesheet" href="css/layout_contents.css" type="text/css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/paging.js"></script>
<script language="JavaScript" src="js/calendar.js"></script>
<script type="text/javascript">
	//이벤트 등록
	$(document).ready(function() {

		fnPaging();

	});

	function searchList() {
		searchPage(0);
	}

	//리스트조회
	function searchPage(page) {
		if (page == "" || page == 0) {
			$("#currentPage").val(1);
		} else {
			$("#currentPage").val(page);
		}

		$("#startRowNum").val((page - 1) * ($('#countPerPage').val()));
		$("#ContentsForm").attr('action', 'historyInfoList.do');
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

		<jsp:include page="../../common/menu.jsp" />
		
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
				<img src="images/h3_ico.gif"><span>히스토리 관리</span><br></br>
					<div id="hissearch">
						<fieldset>		
								일자 &nbsp;&nbsp;<input type="text" name="whereMODIFYDATEFR"
									value="${searchInfo.whereMODIFYDATEFR}" class="textbox"
									maxlength="10" style="width: 92;" readonly="readonly"
									ONCLICK="Calendar(this);"> ~ <input type="text"
									name="whereMODIFYDATETO"
									value="${searchInfo.whereMODIFYDATETO}" class="textbox"
									maxlength="10" style="width: 92;" readonly="readonly"
									ONCLICK="Calendar(this);"> &nbsp;&nbsp; 종류&nbsp;&nbsp;
								<select name="whereEVENTTYPE" class="textbox" style="width: 100">
									<option value="">== 선택 ==</option>
									<c:forEach var="list" items="${codeList}">
										<option value="${list.comCode}"
											<c:if test="${searchInfo.whereEVENTTYPE == list.comCode}">selected="selected"</c:if>>${list.comCode}</option>
									</c:forEach>
								</select> &nbsp;&nbsp;메뉴 &nbsp;&nbsp;<select name="whereMENUID"
									class="textbox" style="width: 150">
									<option value="">===== 선택 =====</option>
									<c:forEach var="list" items="${menuList}">
										<option value="${list.menuId}"
											<c:if test="${searchInfo.whereMENUID == list.menuId}">selected="selected"</c:if>>${list.menuName}</option>
									</c:forEach>
								</select> <br>아이디&nbsp;&nbsp; <select name="whereMOFIDYID"
									class="textbox" style="width: 100">
									<option value="">== 선택 ==</option>
									<c:forEach var="list" items="${userList}">
										<option value="${list.id}"
											<c:if test="${searchInfo.whereMOFIDYID == list.id}">selected="selected"</c:if>>${list.name}</option>
									</c:forEach>
								</select> &nbsp;&nbsp;아이피 &nbsp;&nbsp;<input type="text" name="whereIP"
									size="20" class="textbox" style="width: 150"
									value="${searchInfo.whereIP}"> 
									 <a href="javascript:searchList();"><img  
								src="images/btn/check.gif" style="vertical-align: bottom; width: 70px;"></a></br>
						</fieldset>
					</div>
					<table class="sub_0601_table">
						<colgroup>
							<col width="10%" />
							<col width="10%" />
							<col width="8%" />
							<col width="10%" />
							<col width="10%" />
							<col width="10%" />
							<col width="40%" />
						</colgroup>
						<tbody>
							<tr>
								<th>번호</th>
								<th>메뉴</th>
								<th>아이디</th>
								<th>IP</th>
								<th>일자</th>
								<th>종류</th>
								<th>데이터</th>
							</tr>
							<c:choose>
								<c:when test="${empty historyInfoList}">
									<tr>
										<td colspan="5" height="100" class="td03">등록된 히스토리가 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="list" items="${historyInfoList}">
										<tr>
											<td class="td03">${list.rownum}</td>
											<td class="td03">${list.menu_id}</td>
											<td class="td03">${list.modyfi_id}</td>
											<td class="td03">${list.ip}</td>
											<td class="td03">${list.modyfi_date}</td>
											<td class="td03">${list.event_type}</td>
											<td class="td03">${list.history_data}</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<div id="paging"></div>
				</div>
			</div>
			<div id="divPageing" class="paging"></div>
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
														<td><img src="images/title/title58.gif"></td>
													</tr>
													<tr>
														<td height="10"></td>
														<td></td>
														<td></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td align="right"><a href="javascript:searchList();"><img
																src="images/btn/check.gif" border="0"></a></td>
													</tr>
													<tr>
														<td height="5"></td>
													</tr>
													<tr>
														<td height="1" bgcolor="#FF8200"></td>
													</tr>
													<tr>
														<td align="center">
															<table width="99%" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="5%" height="30">일자</td>
																	<td width="28%"><input type="text"
																		name="whereMODIFYDATEFR"
																		value="${searchInfo.whereMODIFYDATEFR}"
																		class="textbox" maxlength="10" style="width: 92;"
																		readonly="readonly" ONCLICK="Calendar(this);">
																		~ <input type="text" name="whereMODIFYDATETO"
																		value="${searchInfo.whereMODIFYDATETO}"
																		class="textbox" maxlength="10" style="width: 92;"
																		readonly="readonly" ONCLICK="Calendar(this);">
																	</td>
																	<td width="5%">종류</td>
																	<td width="28%"><select name="whereEVENTTYPE"
																		class="textbox" style="width: 200">
																			<option value="">== 선택 ==</option>
																			<c:forEach var="list" items="${codeList}">
																				<option value="${list.comCode}"
																					<c:if test="${searchInfo.whereEVENTTYPE == list.comCode}">selected="selected"</c:if>>${list.comCode}</option>
																			</c:forEach>
																	</select></td>
																<tr>
																	<td width="5%" height="30">메뉴</td>
																	<td width="28%"><select name="whereMENUID"
																		class="textbox" style="width: 200">
																			<option value="">== 선택 ==</option>
																			<c:forEach var="list" items="${menuList}">
																				<option value="${list.menuId}"
																					<c:if test="${searchInfo.whereMENUID == list.menuId}">selected="selected"</c:if>>${list.menuName}</option>
																			</c:forEach>
																	</select></td>
																	<td width="5%">아이디</td>
																	<td width="28%"><select name="whereMOFIDYID"
																		class="textbox" style="width: 200">
																			<option value="">== 선택 ==</option>
																			<c:forEach var="list" items="${userList}">
																				<option value="${list.id}"
																					<c:if test="${searchInfo.whereMOFIDYID == list.id}">selected="selected"</c:if>>${list.name}</option>
																			</c:forEach>
																	</select></td>
																	<td width="5%">아이피</td>
																	<td width="28%"><input type="text" name="whereIP"
																		size="20" class="textbox" style="width: 200"
																		value="${searchInfo.whereIP}"></td>
															</table>
														</td>
													</tr>
													<tr>
														<td height="1" bgcolor="#FF8200"></td>
													</tr>
													<tr>
														<td height="5"></td>
													</tr>
												</table>
												<div id="contents2">
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0">
														<tr>

															<td width="5%" align="center">번호</td>

															<td width="10%" align="center">메뉴</td>

															<td width="10%" align="center">아이디</td>

															<td width="10%" align="center">아이피</td>

															<td width="15%" align="center">일자</td>

															<td width="10%" align="center">종류</td>

															<td width="40%" align="center">데이터</td>

														</tr>
													</table>
													<c:choose>
														<c:when test="${empty historyInfoList}">
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
															<table width="100%" border="0" cellspacing="0"
																cellpadding="0">
																<c:forEach var="list" items="${historyInfoList}">
																	<tr>

																		<td width="5%" align="center">${list.rownum}</td>

																		<td width="10%" align="center"><input type="text"
																			class="invisiblebox" style="width: 85px"
																			value="${list.menu_id}" readonly="readonly" /></td>

																		<td width="10%" align="center"><input type="text"
																			class="invisiblebox" style="width: 85px"
																			value="${list.modyfi_id}" readonly="readonly" /></td>

																		<td width="10%" align="center">${list.ip}</td>

																		<td width="15%" align="center">${list.modyfi_date}</td>

																		<td width="10%" align="center">${list.event_type}</td>

																		<td width="40%" align="center"><input type="text"
																			class="invisiblebox" style="width: 320px"
																			value="${list.history_data}" readonly="readonly" />
																		</td>

																	</tr>
																	<tr>
																		<!-- <td height="1" colspan="16" class="line"></td> -->
																	</tr>
																</c:forEach>
															</table>
														</c:otherwise>
													</c:choose>
													<br> <br>
													<div id="divPageing" class="paging"></div>
												</div>
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
			<tr>
				<td><jsp:include page="../../common/footer.jsp" /></td>
			</tr>
		</table> --%>
	</form:form>
</body>
</html>