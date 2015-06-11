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
<script type="text/javascript" src="js/formValidate.js"></script>
<script type="text/javascript">
	$(document).ready(function() {

	});

	function executeSave() {
		if (!validate()) {
			return;
		}

		$.post("dataTypeInfoUpdate.do", $("#ContentsForm").serialize(),
				function(data) {
					alert(data.json.MESSAGE);
				});
	}

	function executeDel() {
		var state = "${dataTypeInfo.useCount}";
		if (state > 0) {
			alert("사용중인 정보는 삭제할 수 없습니다.");
			return;
		}
		
		if (confirm("삭제하시겠습니까?")) {
			//$("[name='dataTypeState']").val("D");
			$.post("dataTypeInfoDelete.do", $("#ContentsForm").serialize(),
					function(data) {
						alert(data.json.MESSAGE);
						$("#ContentsForm").attr("action", "dataTypeInfoList.do");
						$("#ContentsForm").submit();
			});
		}
	}
</script>
</head>
<body>
	<form:form commandName="ContentsForm">
		<form:hidden path="dataTypeId" />

		<!-- 메뉴화면 관련 -->
		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td width="560"><img src="images/h3_ico.gif"><span>데이터
									타입관리 수정</span></td>
							<td><a href="javascript:executeSave();" onFocus="blur()"><img
									src="images/btn/modify7.gif" border="0"></a> <a
								href="javascript:executeDel();" onFocus="blur()"><img
									src="images/btn/delete7.gif" border="0"></a> <a
								href="dataTypeInfoList.do" onFocus="blur()"><img
									src="images/btn/btn_list.gif" border="0"></a></td>
						</tr>
					</table>
					<br>
					<table class="srvRegi">
						<colgroup>
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th class="first">이름</th>
								<td class="first"><input type="text" name="dataTypeName"
									value="${dataTypeInfo.dataTypeName}"
									class="textbox validate-req" style="width: 580px" title="이름"
									maxbyte="50" /></td>
							</tr>
							<tr>
								<th>상태</th>
								<td><input type="radio"
									name="dataTypeState" value="Y"
									<c:if test="${dataTypeInfo.dataTypeState == 'Y'}">checked="checked"</c:if> />
									사용 &nbsp;&nbsp; <input type="radio" name="dataTypeState"
									value="N" <c:if test="${dataTypeInfo.dataTypeState == 'N'}">checked="checked"</c:if> />
									미사용
								</td>
							</tr>
							<tr>
								<th>내용</th>
								<td><input type="text" name="dataTypeContent"
									class="textbox" style="width: 400px;" title="내용" value="${dataTypeInfo.dataTypeContent}"></td>
							</tr>
							<tr>
								<th>ETC</th>
								<td class="ttl4"><input type="text" name="etc"
									value="${dataTypeInfo.etc}" class="textbox"
									style="width: 600px" title="etc" maxbyte="150" /></td>
							</tr>
							<tr>
								<th>등록일</th>
								<td>${dataTypeInfo.dataTypeSdate}</td>
							</tr>
						</tbody>
					</table>
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
												<table width="750" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td class="ttl7">[DataType 정보 상세]</td>
														<td align="right" style="padding: 0 0 5 0"><a
															href="javascript:executeSave();" onFocus="blur()"><img
																src="images/btn/modify7.gif" border="0"></a> <a
															href="javascript:executeDel();" onFocus="blur()"><img
																src="images/btn/delete7.gif" border="0"></a> <a
															href="dataTypeInfoList.do" onFocus="blur()"><img
																src="images/btn/btn_list.gif" border="0"></a></td>
													</tr>
												</table>

												<table width="750" border="0" cellspacing="0"
													cellpadding="0" background="images/box2.gif">
													<tr>
														<td><img src="images/box1.gif" /></td>
													</tr>
													<tr>
														<td align="center">
															<table width="748" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="130" height="5" class="ttl4">이름</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="5"></td>
																	<td class="ttl4"><input type="text"
																		name="dataTypeName"
																		value="${dataTypeInfo.dataTypeName}"
																		class="textbox validate-req" style="width: 600px"
																		title="이름" maxbyte="50" /></td>
																	<td width="5"></td>
																</tr>
																<tr>
																	<td height="1" colspan="4" bgcolor="#f3961d"></td>
																</tr>
															</table>
															<table width="748" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="130" height="15" class="ttl4">사용여부</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="5"></td>
																	<td class="ttl5">&nbsp;&nbsp; <input type="radio"
																		name="dataTypeState" value="Y"
																		<c:if test="${dataTypeInfo.dataTypeState == 'Y'}">checked="checked"</c:if> />
																		사용 &nbsp;&nbsp; <input type="radio"
																		name="dataTypeState" value="N"
																		<c:if test="${dataTypeInfo.dataTypeState == 'N'}">checked="checked"</c:if> />
																		미사용
																	</td>
																	<td width="5"></td>
																</tr>
																<tr>
																	<td height="1" colspan="4" bgcolor="#f3961d"></td>
																</tr>
															</table>
															<table width="748" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="130" class="ttl4">내용</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="5"></td>
																	<td class="ttl4"><textarea name="dataTypeContent"
																			rows="5" class="textbox"
																			style="width: 98%; height: 40; resize: none;"
																			title="내용">${dataTypeInfo.dataTypeContent}</textarea>
																	</td>
																	<td width="5"></td>
																</tr>
																<tr>
																	<td height="1" colspan="4" bgcolor="#f3961d"></td>
																</tr>
															</table>
															<table width="748" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="130" height="5" class="ttl4">ETC</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="5"></td>
																	<td class="ttl4"><input type="text" name="etc"
																		value="${dataTypeInfo.etc}" class="textbox"
																		style="width: 600px" title="etc" maxbyte="150" /></td>
																	<td width="5"></td>
																</tr>
																<tr>
																	<td height="1" colspan="4" bgcolor="#f3961d"></td>
																</tr>
															</table>
															<table width="748" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="130" height="5" class="ttl4">등록일</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="5"></td>
																	<td class="ttl4"><input type="text"
																		class="invisible"
																		style="width: 98%; ime-mode: disabled;"
																		value="${dataTypeInfo.dataTypeSdate}"
																		readonly="readonly" /></td>
																	<td width="5"></td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td><img src="images/box3.gif" /></td>
													</tr>
												</table>
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