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
	//중복체크 버튼 클릭 여부
	var checkValue = "";

	//이벤트 등록
	$(document).ready(function() {

		//아이디 중복 체크 클릭시 이벤트 처리
		$("#anchIdDup").click(function() {
			checkValue = "T";
			processIdDuplication();
		});

	});

	//아이디 중복 체크
	function processIdDuplication() {

		//아이디 유효성 검증
		if ($("#menuId").val() == "") {
			alert("아이디를 입력하세요.");
			$("#menuId").val("");
			$("#menuId").focus();
			return;
		}

		//검증조건 값 할당
		$("#checkId").val($("#menuId").val());

		//호출 및 메시지 출력
		$.post("processMenuIdDuplication.do", $("#ContentsForm").serialize(),
				function(data) {

					if (data.json.checkName == "success") {
						alert("사용하실 수 있는 아이디 입니다.");
					} else {
						alert("사용하실 수 없는 아이디 입니다.");
					}
				});
	}

	function save() {

		var re = /^[0-9]+$/;
		if (!re.test(menuOrder.value)) {
			alert("정렬순서는 숫자만 넣으셔야 합니다.");
			menuOrder.value = "";
			menuOrder.focus();
			return;
		}
		
		//중복체크사용 여부 검사
		if (checkValue != "T") {
			alert("아이디 중복체크를 하세요.");
			$("#anchIdDup").focus();
			return;
		}

		if (!validate()) {
			return;
		}

		if (confirm("등록하시겠습니까?")) {
			ContentsForm.action = "menuInfoInsert.do";
			ContentsForm.submit();
		}
	}
</script>
</head>
<body>
	<form name="ContentsForm" method="post" id="ContentsForm">
		<input type="hidden" id="checkId" name="checkId" value="" />

		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td width="590"><img src="images/h3_ico.gif"><span>메뉴
									등록</span></td>
							<td class="btn"><a href="javascript:save();"
								onFocus="blur()"><img src="images/btn/btn_apply2.gif"
									border="0"></a> <a href="menuInfoList.do" onFocus="blur()"><img
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
							<td class="first"><input type="text" name="menuId" id="menuId"
								class="textbox" style="width: 550px" title="메뉴아이디" maxlength="20" />
								<a id="anchIdDup"><img src="images/btn/checkid.gif"
									align="absmiddle" style="cursor: hand"></a></td>
						</tr>
						<tr>
							<th>상위메뉴 아이디</th>
							<td><select class="textbox" name="hMenuId"
								style="width: 100px;">
									<option value="">== 선택 ==</option>
									<c:forEach var="hMenuList" items="${hMenuList}">
										<option value="${hMenuList.menuId}">${hMenuList.menuName}</option>
									</c:forEach>
							</select></td>
						</tr>
						<tr>
							<th>메뉴명</th>
							<td><input type="text" name="menuName"
								class="textbox validate-req" style="width: 620px" title="메뉴명"
								maxlength="50" /></td>
						</tr>
						<tr>
							<th>URL</th>
							<td><input type="text" name="menuUrl" class="textbox"
								style="width: 620px" title="URL" maxlength="50" /></td>
						</tr>
						<tr>
							<th>사용여부</th>
							<td><input type="radio" name="useFlag"
								value="Y" checked="checked"/>
								
								사용&nbsp;&nbsp; <input type="radio" name="useFlag"
								value="N"/>
								미사용</td>
						</tr>
						<tr>
							<th>정렬순서</th>
							<td><input type="text" name="menuOrder" id="menuOrder" class="textbox"
								title="정렬순서" maxlength="4" style="width: 620px"></td>
						</tr>
						<tr>
							<th>비고</th>
							<td><input type="text" name="etc"class="textbox"
									style="width: 620px;" title="내용"/></td>
						</tr>
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
										<td valign="top" bgcolor="#FFFFFF" width="750">

											<div id="contents" style="width: 850px">
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td><img src="images/h3_ico.gif"><span>메뉴
																등록</span></td>
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
															onFocus="blur()"><img src="images/btn/btn_apply2.gif"
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
																	<td><input type="text" name="menuId" id="menuId"
																		class="textbox" style="width: 300" title="메뉴아이디"
																		maxlength="10" /> <a id="anchIdDup"><img
																			src="images/btn/checkid.gif" align="absmiddle"
																			style="cursor: hand"></a></td>
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
																				<option value="${hMenuList.menuId}">${hMenuList.menuName}</option>
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
																		title="메뉴명" maxlength="50" /></td>
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
																		maxlength="50" /></td>
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
																			<option value="Y">사용</option>
																			<option value="N">미사용</option>
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
																		style="width: 580px"></td>
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
																		title="비고" maxlength="100" style="width: 580px"></td>
																</tr>
																<tr>
																	<td height="1" colspan="4" bgcolor="#f3961d"></td>
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