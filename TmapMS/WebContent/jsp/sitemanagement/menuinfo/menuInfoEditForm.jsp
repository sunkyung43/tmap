<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script language="JavaScript" src="js/common.js"></script>
<script language="JavaScript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script language="JavaScript" src="js/formValidate.js"></script>
<script>
	//수정
	function executSave() {

		if (!validate()) {
			return;
		}
		
		/* if (confirm("삭제하시겠습니까?")) {
			ContentsForm.action = "menuInfoUpdate.do";
			ContentsForm.submit();
		} */
		
		var re = /^[0-9]+$/;
		if (!re.test(menuOrder.value)) {
			alert("정렬순서는 숫자만 넣으셔야 합니다.");
			menuOrder.value = "";
			menuOrder.focus();
			return;
		}
		
		 $.post("menuInfoUpdate.do", $("#ContentsForm").serialize(),
				function(data) {
					if (data.json.result == true) {
						alert("수정 되었습니다.");
						location.replace('menuInfoList.do');
					} else {
						alert("수정 실패했습니다.");
					}
				}); 
	}

	//삭제
	function del(state) {
if(state == 'N'){
		if (confirm("삭제하시겠습니까?")) {
			ContentsForm.action = "menuInfoDelete.do";
			ContentsForm.submit();
		}
}else{
	alert('사용중인 메뉴는 삭제할 수없습니다.');
}
	}
</script>
</head>
<body>
	<form name="ContentsForm" method="post" id="ContentsForm">

		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td width="560"><img src="images/h3_ico.gif"><span>메뉴
									수정</span></td>
							<td class="btn"><a href="javascript:executSave();"
								onFocus="blur()"><img src="images/btn/modify7.gif"
									border="0"></a> <a href="javascript:del('${modifyInfo.useFlag}');" onFocus="blur()"><img
									src="images/btn/delete7.gif" border="0"></a> <a
								href="menuInfoList.do" onFocus="blur()"><img
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
							<th class="first">메뉴 아이디</th>
							<td class="first"><input type="text" name="menuId"
								class="invisible" value="${modifyInfo.menuId}"
								style="width: 620px" title="메뉴아이디" maxlength="20"
								readonly="readonly" /></td>
						</tr>
						<tr>
							<th>상위메뉴 아이디</th>
							<td class="td03"><select class="textbox" name="hMenuId"
								style="width: 100px;">
									<option value="">== 선택 ==</option>
									<c:forEach var="hMenuList" items="${hMenuList}">
										<c:choose>
											<c:when test="${modifyInfo.hMenuId == hMenuList.menuId}">
												<option value="${hMenuList.menuId}" selected="selected">${hMenuList.menuName}</option>
											</c:when>
											<c:otherwise>
												<option value="${hMenuList.menuId}">${hMenuList.menuName}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
							</select></td>
						</tr>
						<tr>
							<th>메뉴명</th>
							<td class="td03"><input type="text" name="menuName"
								class="textbox validate-req" style="width: 620px" title="메뉴명"
								maxlength="50" value="${modifyInfo.menuName}" /></td>
						</tr>
						<tr>
							<th>URL</th>
							<td class="td03"><input type="text" name="menuUrl"
								class="textbox" style="width: 620px" title="URL" maxlength="50"
								value="${modifyInfo.menuUrl}" /></td>
						</tr>
						<tr>
							<th>사용여부</th>
							<td class="td03">
							<input type="radio" name="useFlag"
								value="Y"
								<c:if test="${modifyInfo.useFlag == 'Y'}">checked="checked"</c:if>>
								사용&nbsp;&nbsp; <input type="radio" name="useFlag"
								value="N"
								<c:if test="${modifyInfo.useFlag == 'N'}">checked="checked"</c:if>>
								미사용
							</td>
						</tr>
						<tr>
							<th>정렬순서</th>
							<td class="td03"><input type="text" name="menuOrder" id="menuOrder"
								class="textbox" title="비고" maxlength="100" style="width: 620px"
								value="${modifyInfo.menuOrder}"></td>
						</tr>
						<tr>
							<th>비고</th>
							<td class="td03"><input type="text" name="etc"
								class="textbox" value="${modifyInfo.etc}" style="width: 620px;"
								title="내용" /></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />



		<%-- <table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td ><img src="images/h3_ico.gif"><span>메뉴 수정하기</span></td>
							<td width="30"></td>
						</tr>
						<tr>
							<td height="10"></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</table>
					<table width="750" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="btn"><a href="javascript:save();"
								onFocus="blur()"><img src="images/btn/modify7.gif"
									border="0"></a> <a href="javascript:del();" onFocus="blur()"><img
									src="images/btn/delete7.gif" border="0"></a> <a
								href="menuInfoList.do" onFocus="blur()"><img
									src="images/btn/btn_list.gif" border="0"></a></td>
						</tr>
					</table>
					<table width="750" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td><img src="images/box1.gif"></td>
						</tr>
						<tr>
							<td align="center" background="images/box2.gif"><table
									width="748" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="150" class="ttl4">메뉴 아이디</td>
										<td width="1" bgcolor="#f3961d"></td>
										<td width="10"></td>
										<td><input type="text" name="menuId" class="invisible"
											value="${modifyInfo.menuId}" style="width: 300" title="메뉴아이디"
											maxlength="10" readonly="readonly" /></td>
									</tr>
									<tr>
										<td height="1" colspan="4" bgcolor="#f3961d"></td>
									</tr>
								</table>
								<table width="748" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="150" class="ttl4">상위메뉴 아이디</td>
										<td width="1" bgcolor="#f3961d"></td>
										<td width="10"></td>
										<td><select class="textbox" name="hMenuId"
											style="width: 150px;"">
												<option value="">== 선택 ==</option>
												<c:forEach var="hMenuList" items="${hMenuList}">
													<c:choose>
														<c:when test="${modifyInfo.hMenuId == hMenuList.menuId}">
															<option value="${hMenuList.menuId}" selected="selected">${hMenuList.menuName}</option>
														</c:when>
														<c:otherwise>
															<option value="${hMenuList.menuId}">${hMenuList.menuName}</option>
														</c:otherwise>
													</c:choose>
												</c:forEach>
										</select></td>
									</tr>
									<tr>
										<td height="1" colspan="4" bgcolor="#f3961d"></td>
									</tr>
								</table>
								<table width="748" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="150" class="ttl4">메뉴명</td>
										<td width="1" bgcolor="#f3961d"></td>
										<td width="10"></td>
										<td><input type="text" name="menuName"
											class="textbox validate-req" style="width: 580px" title="메뉴명"
											maxlength="50" value="${modifyInfo.menuName}" /></td>
									</tr>
									<tr>
										<td height="1" colspan="4" bgcolor="#f3961d"></td>
									</tr>
								</table>
								<table width="748" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="150" class="ttl4">URL</td>
										<td width="1" bgcolor="#f3961d"></td>
										<td width="10"></td>
										<td><input type="text" name="menuUrl" class="textbox"
											style="width: 580px" title="URL" maxlength="50"
											value="${modifyInfo.menuUrl}" /></td>
									</tr>
									<tr>
										<td height="1" colspan="4" bgcolor="#f3961d"></td>
									</tr>
								</table>
								<table width="748" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="150" class="ttl4">사용여부</td>
										<td width="1" bgcolor="#f3961d"></td>
										<td width="10"></td>
										<td><select class="textbox" name="useFlag"
											style="width: 100px;">
												<c:choose>
													<c:when test="${modifyInfo.useFlag == 'Y'}">
														<option value="Y" selected="selected">사용</option>
														<option value="N">미사용</option>
													</c:when>
													<c:otherwise>
														<option value="Y">사용</option>
														<option value="N" selected="selected">미사용</option>
													</c:otherwise>
												</c:choose>
										</select></td>
									</tr>
									<tr>
										<td height="1" colspan="4" bgcolor="#f3961d"></td>
									</tr>
								</table>
								<table width="748" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="150" class="ttl4">정렬순서</td>
										<td width="1" bgcolor="#f3961d"></td>
										<td width="10"></td>
										<td><input type="text" name="menuOrder" class="textbox"
											title="정렬순서" maxlength="4" style="width: 580px"
											value="${modifyInfo.menuOrder}"></td>
									</tr>
									<tr>
										<td height="1" colspan="4" bgcolor="#f3961d"></td>
									</tr>
								</table>
								<table width="748" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="150" class="ttl4">비고</td>
										<td width="1" bgcolor="#f3961d"></td>
										<td width="10"></td>
										<td><input type="text" name="etc" class="textbox"
											title="비고" maxlength="100" style="width: 580px"
											value="${modifyInfo.etc}"></td>
									</tr>
								</table></td>
						</tr>
						<tr>
							<td><img src="images/box3.gif"></td>
						</tr>
					</table> --%>
		<%-- </div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" /> --%>

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
														<td><img src="images/title/title613.gif"></td>
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
														<td class="btn"><a href="javascript:save();"
															onFocus="blur()"><img src="images/btn/modify7.gif"
																border="0"></a> <a href="javascript:del();"
															onFocus="blur()"><img src="images/btn/delete7.gif"
																border="0"></a> <a href="menuInfoList.do"
															onFocus="blur()"><img src="images/btn/btn_list.gif"
																border="0"></a></td>
													</tr>
												</table>
												<table width="750" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td><img src="images/box1.gif"></td>
													</tr>
													<tr>
														<td align="center" background="images/box2.gif"><table
																width="748" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="150" class="ttl4">메뉴 아이디</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="10"></td>
																	<td><input type="text" name="menuId"
																		class="invisible" value="${modifyInfo.menuId}"
																		style="width: 300" title="메뉴아이디" maxlength="10"
																		readonly="readonly" /></td>
																</tr>
																<tr>
																	<td height="1" colspan="4" bgcolor="#f3961d"></td>
																</tr>
															</table>
															<table width="748" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="150" class="ttl4">상위메뉴 아이디</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="10"></td>
																	<td><select class="textbox" name="hMenuId"
																		style="width: 150px;"">
																			<option value="">== 선택 ==</option>
																			<c:forEach var="hMenuList" items="${hMenuList}">
																				<c:choose>
																					<c:when
																						test="${modifyInfo.hMenuId == hMenuList.menuId}">
																						<option value="${hMenuList.menuId}"
																							selected="selected">${hMenuList.menuName}</option>
																					</c:when>
																					<c:otherwise>
																						<option value="${hMenuList.menuId}">${hMenuList.menuName}</option>
																					</c:otherwise>
																				</c:choose>
																			</c:forEach>
																	</select></td>
																</tr>
																<tr>
																	<td height="1" colspan="4" bgcolor="#f3961d"></td>
																</tr>
															</table>
															<table width="748" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="150" class="ttl4">메뉴명</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="10"></td>
																	<td><input type="text" name="menuName"
																		class="textbox validate-req" style="width: 580px"
																		title="메뉴명" maxlength="50"
																		value="${modifyInfo.menuName}" /></td>
																</tr>
																<tr>
																	<td height="1" colspan="4" bgcolor="#f3961d"></td>
																</tr>
															</table>
															<table width="748" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="150" class="ttl4">URL</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="10"></td>
																	<td><input type="text" name="menuUrl"
																		class="textbox" style="width: 580px" title="URL"
																		maxlength="50" value="${modifyInfo.menuUrl}" /></td>
																</tr>
																<tr>
																	<td height="1" colspan="4" bgcolor="#f3961d"></td>
																</tr>
															</table>
															<table width="748" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="150" class="ttl4">사용여부</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="10"></td>
																	<td><select class="textbox" name="useFlag"
																		style="width: 100px;">
																			<c:choose>
																				<c:when test="${modifyInfo.useFlag == 'Y'}">
																					<option value="Y" selected="selected">사용</option>
																					<option value="N">미사용</option>
																				</c:when>
																				<c:otherwise>
																					<option value="Y">사용</option>
																					<option value="N" selected="selected">미사용</option>
																				</c:otherwise>
																			</c:choose>
																	</select></td>
																</tr>
																<tr>
																	<td height="1" colspan="4" bgcolor="#f3961d"></td>
																</tr>
															</table>
															<table width="748" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="150" class="ttl4">정렬순서</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="10"></td>
																	<td><input type="text" name="menuOrder"
																		class="textbox" title="정렬순서" maxlength="4"
																		style="width: 580px" value="${modifyInfo.menuOrder}"></td>
																</tr>
																<tr>
																	<td height="1" colspan="4" bgcolor="#f3961d"></td>
																</tr>
															</table>
															<table width="748" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="150" class="ttl4">비고</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="10"></td>
																	<td><input type="text" name="etc" class="textbox"
																		title="비고" maxlength="100" style="width: 580px"
																		value="${modifyInfo.etc}"></td>
																</tr>
															</table></td>
													</tr>
													<tr>
														<td><img src="images/box3.gif"></td>
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
			<tr>
				<td><jsp:include page="../../common/footer.jsp" /></td>
			</tr>
		</table> --%>
	</form>
</body>
</html>