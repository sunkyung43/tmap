<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		if ($("#menuAuthorityId").val() == "") {
			alert("아이디를 입력하세요.");
			$("#menuAuthorityId").val("");
			$("#menuAuthorityId").focus();
			return;
		}

		//검증조건 값 할당
		$("#checkId").val($("#menuAuthorityId").val());

		//호출 및 메시지 출력
		$.post("processAuIDuplication.do", $("#ContentsForm").serialize(),
				function(data) {

					if (data.json.checkName == "success") {
						alert("사용하실 수 있는 아이디 입니다.");
					} else {
						alert("사용하실 수 없는 아이디 입니다.");
					}

				});
	}

	function save(obj) {

		var menus = new Array();
		for ( var i = 1; i <= obj; i++) {

			if (eval("document.getElementById('menu" + i + "').checked"))

				menus.push(eval("document.getElementById('menu" + i
						+ "').value"));
		}

		if (menus.length == 0) {
			alert("선택된 메뉴가 없습니다.");
			return;
		}

		document.ContentsForm.selMenuIds.value = menus;

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

			$.post("authorityInfoInsert.do", $("#ContentsForm").serialize(),
					function(data) {

						if (data.json.authorityInfoInsert == "success") {
							alert("등록완료 되었습니다.");
						} else {
							alert("등록실패 하였습니다.");
						}
						$("#menuAuthorityId").val(data.json.menuAuthorityId);
						$("#ContentsForm").attr('action',
								'authorityInfoEditForm.do');
						$("#ContentsForm").submit();
					});
		}
	}
</script>
</head>
<body>
	<form name="ContentsForm" method="post" id="ContentsForm">
		<input type="hidden" id="checkId" name="checkId" value="" /> <input
			type="hidden" name="selMenuIds" value="" />

		<!-- 메뉴화면 관련 -->
		<%-- ${menuHtml} --%>
		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td width="610"><img src="images/h3_ico.gif"><span>권한
									등록</span></td>
							<td class="btn"><a
								href="javascript:save(${fn:length(menuList)});" onFocus="blur()"><img
									src="images/btn/btn_apply2.gif" border="0"></a> <a
								href="authorityInfoList.do" onFocus="blur()"><img
									src="images/btn/btn_list.gif" border="0"></a></td>
						</tr>
					</table>
					<table class="srvRegi">
						<colgroup>
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<tr>
							<th class="td06">권한 아이디</th>
							<td class="td06"><input type="text" name="menuAuthorityId"
								id="menuAuthorityId" title="권한아이디" maxlength="20"
								class="textbox" style="width: 620px"> <a id="anchIdDup"><img
									src="images/btn/checkid.gif" align="absmiddle"
									style="cursor: hand"></a></td>
						</tr>
						<tr>
							<th>권한 정보</th>
							<td><input type="text" name="authority" title="권한정보"
								maxlength="20" class="textbox validate-req" style="width: 620px"></td>
						</tr>
						<tr>
							<th>사용여부</th>
							<td><select name="useState" style="width: 80px;"
								class="textbox">
									<option value="">= 선택 =</option>
									<option value="Y">사용</option>
									<option value="N">미사용</option>
							</select></td>
						</tr>
						<tr>
							<th>비고</th>
							<td><textarea name="etc" rows="5" class="textbox"
									style="width: 620px;" title="내용"></textarea></td>
						</tr>
					</table>
					<table class="sub_0601_table">
						<colgroup>
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>메뉴 아이디</th>
								<th>상위메뉴 아이디</th>
								<th>메뉴명</th>
								<th>상태</th>
							</tr>
							<c:forEach var="menuList" items="${menuList}">
								<c:if test="${menuList.useFlag == 'Y' }">
									<tr onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
										onMouseOut="rowOnMouseOut(this);">
										<td class="td03">${menuList.menuId}</td>
										<td class="td03">${menuList.hMenuId}</td>
										<td class="td03">${menuList.menuName}</td>
										<td class="td03"><input type="radio" id="menu"
											name="menu${menuList.rownum}" value="${menuList.menuId}" />사용함
											<input type="radio" id="menu" name="menu${menuList.rownum}"
											value="${menuList.menuId}" checked="checked" />사용안함</td>
									</tr>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />

		<%-- <table width="100%" height="100%" border="0" cellspacing="0"
			cellpadding="0">
			<tr>
				<!-- <table width="95%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td width="120" align="center"><a href="mainAction.action" onFocus="blur()"><img src="images/logo.gif" border="0" /></a></td>
	    <td align="right" valign="bottom"><table border="0" cellspacing="0" cellpadding="2">
	      <tr>
	        <td><a href="javascript:showTmapRS();"><font color="#7f7f7f">[<span class="name">TMAP RS 바로가기</span>]</font></a>&nbsp;&nbsp;&nbsp;&nbsp;</td><td><img src="images/top_ic.gif" /></td>
	        <td><font color="#7f7f7f">[<span class="name"><s:property value="#session['ID']"/></span>]</font></td>
	        <td><a href="logoutAction.action"><img src="images/btn/logout.gif" border="0" style="cursor:hand" /></a></td>
	      </tr>
	    </table></td>
	  </tr>
	</table> -->
			</tr>
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
														<td><img src="images/h3_ico.gif"><span>권한
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
														<td class="btn"><a
															href="javascript:save(${fn:length(menuList)});"
															onFocus="blur()"><img src="images/btn/btn_apply2.gif"
																border="0"></a> <a href="authorityInfoList.do"
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
																	<td width="150" class="ttl4">권한 아이디</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="10"></td>
																	<td><input type="text" name="menuAuthorityId"
																		id="menuAuthorityId" title="권한아이디" maxlength="20"
																		class="textbox" style="width: 300"> <a
																		id="anchIdDup"><img src="images/btn/checkid.gif"
																			align="absmiddle" style="cursor: hand"></a></td>
																</tr>
																<tr>
																	<td height="1" colspan="4" bgcolor="#f3961d"></td>
																</tr>
															</table>
															<table width="748" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="150" class="ttl4">권한 정보</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="10"></td>
																	<td><input type="text" name="authority"
																		title="권한정보" maxlength="20"
																		class="textbox validate-req" style="width: 580px"></td>
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
																	<td><select name="useState" style="width: 100px;"
																		class="textbox">
																			<option value="Y">사용</option>
																			<option value="N" selected="selected">미사용</option>
																	</select></td>
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
																		maxlength="20" style="width: 580px"></td>
																</tr>
															</table></td>
													</tr>
													<tr>
														<td><img src="images/box3.gif"></td>
													</tr>
													<tr>
														<td height="30"></td>
													</tr>
												</table>
												<table width="750" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td width="3"><img src="images/ttl_bar1.gif"></td>
														<td width="168" background="images/ttl_bar2.gif"
															class="ttl">메뉴 아이디</td>
														<td width="2" background="images/ttl_bar2.gif"><img
															src="images/ttl_line.gif"></td>
														<td width="168" background="images/ttl_bar2.gif"
															class="ttl">상위메뉴아이디</td>
														<td width="2" background="images/ttl_bar2.gif"><img
															src="images/ttl_line.gif"></td>
														<td width="300" background="images/ttl_bar2.gif"
															class="ttl">메뉴명</td>
														<td width="2" background="images/ttl_bar2.gif"><img
															src="images/ttl_line.gif"></td>
														<td width="150" background="images/ttl_bar2.gif"
															class="ttl">사용유무</td>
														<td width="3"><img src="images/ttl_bar3.gif"></td>
													</tr>
												</table>
												<c:forEach var="menuList" items="${menuList}">
													<c:if test="${menuList.useFlag == 'Y' }">
														<table width="750" border="0" cellspacing="0"
															cellpadding="0">
															<tr
																onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
																onMouseOut="rowOnMouseOut(this);">
																<td width="3"></td>
																<td width="169" class="ttl4">${menuList.menuId}</td>
																<td width="1"></td>
																<td width="169" class="ttl4">${menuList.hMenuId}</td>
																<td width="1"></td>
																<td width="300" class="ttl4">${menuList.menuName}</td>
																<td width="1"></td>
																<td width="150" class="ttl4"><input type="radio"
																	id="menu" name="menu${menuList.rownum}"
																	value="${menuList.menuId}" />사용함 <input type="radio"
																	id="menu" name="menu${menuList.rownum}"
																	value="${menuList.menuId}" checked="checked" />사용안함</td>
																<td width="3"></td>
															</tr>
															<tr>
																<td height="1" colspan="12" class="line"></td>
															</tr>
														</table>
													</c:if>
												</c:forEach>

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