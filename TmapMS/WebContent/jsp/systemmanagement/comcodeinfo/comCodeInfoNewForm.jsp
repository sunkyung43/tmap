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
<!--  Stylesheet		-------------------------------------------------------------------------->
<link rel="stylesheet" href="css/common.css" type="text/css" />
<link rel="stylesheet" href="css/layout_contents.css" type="text/css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script language="JavaScript" src="js/common.js"></script>
<script language="JavaScript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script language="JavaScript" src="js/formValidate.js"></script>
<script language="JavaScript" src="js/sha256.js"></script>
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
		if ($("#comCode").val() == "") {
			alert("아이디를 입력하세요.");
			$("#comCode").val("");
			$("#comCode").focus();
			return;
		}

		//검증조건 값 할당
		$("#checkId").val($("#comCode").val());

		//호출 및 메시지 출력
		$.post("processCodeIdDuplication.do", $("#ContentsForm").serialize(),
				function(data) {
					if (data.json.check == "success") {
						alert("사용하실 수 있는 아이디입니다.");
					} else {
						alert("사용하실 수 없는 아이디입니다.");
					}

				});
	}

	function save() {

		//중복체크사용 여부 검사
		if (checkValue != "T") {
			alert("아이디 중복체크를 하세요.");
			$("#anchIdDup").focus();
			return;
		}

		if (!validate()) {
			return;
		}

		ContentsForm.action = "comCodeInfoInsert.do";
		ContentsForm.submit();
	}
</script>
</head>
<body>
	<form name="ContentsForm" method="post" id="ContentsForm">
		<input type="hidden" id="checkId" name="checkId" value="" /> <input
			type="hidden" name="codeLevel" value="1" />

		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td width="600"><img src="images/h3_ico.gif"><span>공통코드
									등록</span></td>
							<td class="btn"><a href="javascript:save();"
								onFocus="blur()"><img src="images/btn/btn_apply2.gif"
									border="0"></a> <a href="comCodeInfoList.do" onFocus="blur()"><img
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
							<th class="first">코드</th>
							<td class="first"><input type="text" name="comCode" id="comCode"
								class="textbox" style="width: 550px" title="코드" maxlength="10" />
								<a id="anchIdDup"><img src="images/btn/checkid.gif"
									align="absmiddle" style="cursor: hand"></a></td>
						</tr>
						<tr>
							<th>코드명</th>
							<td><input type="text" name="codeName"
								class="textbox validate-req" style="width: 620px" title="코드명"
								maxlength="20" /></td>
						</tr>
						<tr>
							<th>코드설명</th>
							<td><input type="text" name="codeRemark" class="textbox"
								style="width: 620px" title="코드설명" maxlength="100" /></td>
						</tr>
						<tr>
							<th>사용여부</th>
							<td>
							<input type="radio" name="useState" value="Y"
										title="" required="required" checked="checked"> 사용
										&nbsp;&nbsp;&nbsp; <input type="radio" name="useState"
										value="N" title="" required="required"> 미사용 
							</td>
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
														<td><img src="images/h3_ico.gif"><span>공통코드
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
																border="0"></a> <a href="comCodeInfoList.do"
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
																	<td width="130" class="ttl4">코드</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="10"></td>
																	<td><input type="text" name="comCode" id="comCode"
																		class="textbox" style="width: 300" title="코드"
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
																	<td width="130" class="ttl4">코드명</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="10"></td>
																	<td><input type="text" name="codeName"
																		class="textbox validate-req" style="width: 600px"
																		title="코드명" maxlength="20" /></td>
																</tr>
																<tr>
																	<td height="1" colspan="4" bgcolor="#f3961d"></td>
																</tr>
															</table>
															<table width="748" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="130" class="ttl4">코드설명</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="10"></td>
																	<td><input type="text" name="codeRemark"
																		class="textbox" style="width: 600px" title="코드설명"
																		maxlength="100" /></td>
																</tr>
																<tr>
																	<td height="1" colspan="4" bgcolor="#f3961d"></td>
																</tr>
															</table>
															<table width="748" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="130" class="ttl4">사용여부</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="10"></td>
																	<td><select name="useState" class="textbox"
																		style="width: 100px;">
																			<option value="Y">사용</option>
																			<option value="N">미사용</option>
																	</select></td>
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
		</table> -->
	</form>
</body>
</html>