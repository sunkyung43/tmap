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

		var storageMount = $("#storageMount").val();
		if (storageMount.lastIndexOf("/") == (storageMount.length - 1)) {
			$("#storageMount").val(
					storageMount.substr(0, storageMount.length - 1));
		}

		$.post("dataStorageInfoInsert.do", $("#ContentsForm").serialize(),
				function(data) {
					alert(data.json.MESSAGE);

					$("#storageId").val(data.json.storageId);
					location.replace('dataStorageInfoList.do');
				});
	}
</script>
</head>
<body>
	<form:form commandName="ContentsForm">
		<form:hidden path="storageId" />

		<!-- 메뉴화면 관련 -->
		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td width="600"><img src="images/h3_ico.gif"><span>Data
									Storage정보 등록</span></td>
							<td><a href="javascript:executeSave();" onFocus="blur()"><img
									src="images/btn/btn_apply2.gif" border="0"></a> <a
								href="dataStorageInfoList.do" onFocus="blur()"><img
									src="images/btn/btn_list.gif" border="0"></a></td>
						</tr>
					</table>
					<br>
					<table class="srvRegi">
						<colgroup>
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<tr>
							<th class="first">이름</th>
							<td class="first"><input type="text" name="storageName"
								class="textbox validate-req" style="width: 620px" title="이름"
								maxbyte="50" /></td>
						</tr>
						<tr>
							<th>마운트 위치</th>
							<td class="td03"><input type="text" id="storageMount"
								name="storageMount" class="textbox validate-req"
								style="width: 620px" title="이름" maxbyte="50" /></td>
						</tr>
						<tr>
							<th>현재 사용여부</th>
							<td class="td03"><input type="radio"
								name="storageCurrent" value="C" checked="checked" /> 현재 사용중
								&nbsp;&nbsp; <input type="radio" name="storageCurrent" value="O" />
								과거 사용
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td class="td03"><input type="text" name="storageContent" 
									class="textbox" style="width: 620px;"
									title="내용"/></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />



		<!-- <table width="100%" height="100%" border="0" cellspacing="0"
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
														<td><h1 style="color: red;">Data Storage 관리</h1></td>
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
														<td class="ttl7">[DataStorage 정보 등록]</td>
														<td align="right" style="padding: 0 0 5 0"><a
															href="javascript:executeSave();" onFocus="blur()"><img
																src="images/btn/btn_apply2.gif" border="0"></a> <a
															href="dataStorageInfoList.do" onFocus="blur()"><img
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
																		name="storageName" class="textbox validate-req"
																		style="width: 600px" title="이름" maxbyte="50" /></td>
																	<td width="5"></td>
																</tr>
																<tr>
																	<td height="1" colspan="4" bgcolor="#f3961d"></td>
																</tr>
															</table>
															<table width="748" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="130" height="5" class="ttl4">마운트 위치</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="5"></td>
																	<td class="ttl4"><input type="text"
																		id="storageMount" name="storageMount"
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
																	<td width="130" height="15" class="ttl4">현재 사용여부</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="5"></td>
																	<td class="ttl5">&nbsp;&nbsp; <input type="radio"
																		name="storageCurrent" value="C" checked="checked" />
																		현재 사용중 &nbsp;&nbsp; <input type="radio"
																		name="storageCurrent" value="O" /> 과거 사용
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
																	<td class="ttl4"><textarea name="storageContent"
																			rows="5" class="textbox"
																			style="width: 98%; height: 40; resize: none;"
																			title="내용"></textarea></td>
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
		</table> -->
	</form:form>
</body>
</html>