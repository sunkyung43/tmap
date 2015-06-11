<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<script type="text/javascript" src="js/formValidate.js"></script>
<script type="text/javascript">

	//중복체크 버튼 클릭 여부
	var checkValueName = "";

	//이벤트 등록
	$(document).ready(function() {

		//타입명 중복 체크 클릭시 이벤트 처리
		$("#anchInterIdDup").click(function() {
			checkValueName = "T";
			processNameDuplication();
		});

	});

	//통식방식명 중복 체크
	function processNameDuplication() {

		//아이디 유효성 검증
		if ($("#interfaceProtocol").val() == "") {
			alert("프로토콜명을 입력하세요.");
			$("#interfaceProtocol").val("");
			$("#interfaceProtocol").focus();
			return;
		}

		//검증조건 값 할당
		$("#checkName").val($("#interfaceProtocol").val());

		//호출 및 메시지 출력
		$.post("processInterIdDuplication.do", $("#ContentsForm").serialize(),
				function(data) {

					if (data.json.checkName == "success") {
						alert("사용 할 수 있는 프로토콜명 입니다.");
					} else {
						alert("사용 할 수 없는 프로토콜명 입니다.");
					}

				});
	}

	function save() {

		//중복체크사용 여부 검사
		if (checkValueName != "T") {
			alert("프로토콜명 중복체크를 하세요.");
			$("#anchInterIdDup").focus();
			return;
		}

		if (!validate()) {
			return;
		}

		if (confirm("등록하시겠습니까?")) {

			$.post("interfaceInsert.do", $("#ContentsForm").serialize(),
					function(data) {

						if (data.json.interfaceInsert == "success") {
							alert("등록완료 되었습니다.");
						} else {
							alert("등록실패 하였습니다.");
						}
						$("#interfaceId").val(data.json.interfaceId);
						$("#ContentsForm").attr('action',
								'rsInterfaceInfoEdit.do');
						$("#ContentsForm").submit();
					});
		}
	}

	function executeModify(interfaceId) {

		$("#interfaceId").val(interfaceId);

		if (confirm("RS Interface 정보를 수정하시겠습니까?")) {

			$.post("interfaceUpdate.do", $("#ContentsForm").serialize(),
					function(data) {

						if (data.json.interfaceUpdate == "success") {
							alert("수정완료 되었습니다.");
						} else {
							alert("수정실패 하였습니다.");
						}

						$("#ContentsForm").attr('action',
								'rsInterfaceInfoEdit.do');
						$("#ContentsForm").submit();
					});
		}
	}

	function executeDel(interfaceId, state) {

		$("#interfaceId").val(interfaceId);

		if (confirm("삭제하시겠습니까?")) {
			if (state == 'Y') {
				alert("사용중인 RS Interface 정보는 삭제할 수 없습니다.\n미사용으로 전환 후 삭제하십시요.");
				return;
			} else {
				$.post("interfaceDelete.do", $("#ContentsForm").serialize(),
						function(data) {

							if (data.json.interfaceDelete == "success") {
								alert("삭제완료 되었습니다.");
							} else {
								alert("삭제실패 하였습니다.");
							}

							$("#interfaceName").val("");
							$("#ContentsForm").attr('action', 'rsInterfaceInfo.do');
							$("#ContentsForm").submit();
						});
			}
		}
	}
	
</script>
</head>
<body>
	<form:form commandName="ContentsForm">
		<form:hidden path="checkName" />
		<form:hidden path="interfaceId" />
		<jsp:include page="../../common/menu.jsp" />

		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td width="590px;">
								<img src="images/h3_ico.gif"> &nbsp; RS Interface 정보
							</td>
							<td>
								<c:choose>
									<c:when test="${empty rsInterfaceInfo.interfaceId}">
										<a href="javascript:save();" onFocus="blur()">
											<img src="images/btn/btn_apply2.gif" border="0">
										</a>
									</c:when>
									<c:otherwise>
										<a href="javascript:executeDel('${rsInterfaceInfo.interfaceId}','${rsInterfaceInfo.interfaceState}');" onFocus="blur()">
											<img src="images/btn/delete7.gif" border="0">
										</a>&nbsp;
		                  				<a href="javascript:executeModify('${rsInterfaceInfo.interfaceId}');" onFocus="blur()">
											<img src="images/btn/modify7.gif" border="0">
										</a>&nbsp;
	                    			</c:otherwise>
								</c:choose> 
							<a href="rsInterfaceInfo.do" onFocus="blur()">
								<img src="images/btn/btn_list.gif" border="0">
							</a>
						</td>
					</tr>
				</table>
				<br>
				<table class="srvRegi">
					<colgroup>
						<col width="100px" />
						<col width="*" />
					</colgroup>
					<tbody>
						<c:choose>
							<c:when test="${empty rsInterfaceInfo.interfaceId}">
								<tr>
									<th class="first">프로토콜명</th>
									<td class="first">
										<input type="text" name="interfaceProtocol" id="interfaceProtocol" class="textbox validate-req" style="width: 550px" title="프로토콜명" maxlength="200" /> 
											<a id="anchInterIdDup">
												<img src="images/btn/checkid.gif" align="absmiddle" style="cursor: hand">
											</a>
									</td>
								</tr>
								<tr>
									<th>인터페이스명</th>
									<td>
										<input type="text" name="interfaceName" id="interfaceName" class="textbox validate-req" style="width: 610px" title="인터페이스명" maxlength="200" />
									</td>
								</tr>
								<tr>
									<th>정렬기준</th>
									<td>
										<input type="text" name="interfaceAlign" id="interfaceAlign" class="textbox validate-req" style="width: 610px" title="정렬기준" maxlength="200" />
									</td>
								</tr>
								<tr>
									<th>사용여부</th>
									<td>
										<input type="radio" style="cursor: hand;" name="interfaceState" value="Y" /> 사용 &nbsp;&nbsp; 
										<input type="radio" style="cursor: hand;" name="interfaceState" value="N" checked="checked" /> 미사용
									</td>
								</tr>
								<tr>
									<th>내용</th>
									<td>
										<input type="text" name="interfaceContent" class="textbox" style="width: 100%;" title="내용"/>
									</td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr class="td06">
									<th>프로토콜명</th>
									<td>
										<input type="text" style="width: 610px" class="invisible" value="${rsInterfaceInfo.interfaceProtocol}" />
									</td>
								</tr>
								<tr>
									<th>인터페이스명</th>
									<td>
										<input type="text" style="width: 610px" class="invisible" value="${rsInterfaceInfo.interfaceName}" />
									</td>
								</tr>
								<tr>
									<th>정렬기준</th>
									<td>
										<input type="text" class="invisible" style="width: 610px" value="${rsInterfaceInfo.interfaceAlign}" />
									</td>
								</tr>
								<tr>
									<th>사용여부</th>
									<td>
										<input type="radio" style="cursor: hand;" name="interfaceState" value="Y" <c:if test="${rsInterfaceInfo.interfaceState == 'Y'}">checked="checked"</c:if> /> 사용 &nbsp;&nbsp; 
										<input type="radio" style="cursor: hand;" name="interfaceState" value="N" <c:if test="${rsInterfaceInfo.interfaceState == 'N'}">checked="checked"</c:if> /> 미사용
									</td>
								</tr>
								<tr>
									<th>내용</th>
									<td>
										<input type="text" name="interfaceContent" value="${rsInterfaceInfo.interfaceContent}" class="textbox" style="width: 610px;" title="내용">
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				</div>
			</div>
		</div>

		<jsp:include page="../../common/footer.jsp" />



		<%-- <table width="100%" height="100%" border="0" cellspacing="0"
			cellpadding="0">

			<tr>
				<td height="100%">
					<table width="100%" height="100%" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td width="10" background="images/bg_bar.gif"></td>
							<td height="100%" valign="top" class="contents">
								<table width="100%" height="100%" border="0" cellspacing="0"
									cellpadding="20">
									<tr>
										<td valign="top" bgcolor="#FFFFFF">
											<div id="contents" style="width: 850px">
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td><img src="images/h3_ico.gif"><span>
																RS Interface 정보 등록</span></td>
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
														<td class="btn"><c:choose>
																<c:when test="${empty rsInterfaceInfo.interfaceId}">
																	<a href="javascript:save();" onFocus="blur()"><img
																		src="images/btn/btn_apply2.gif" border="0"></a>
																</c:when>
																<c:otherwise>
																	<a
																		href="javascript:executeDel('${rsInterfaceInfo.interfaceId}','${rsInterfaceInfo.interfaceState}');"
																		onFocus="blur()"><img src="images/btn/delete7.gif"
																		border="0"></a>&nbsp;
		                  		<a
																		href="javascript:executeModify('${rsInterfaceInfo.interfaceId}');"
																		onFocus="blur()"><img src="images/btn/modify7.gif"
																		border="0"></a>&nbsp;
	                    		</c:otherwise>
															</c:choose> <a href="rsInterfaceInfo.do" onFocus="blur()"><img
																src="images/btn/btn_list.gif" border="0"></a>
													</tr>
												</table>
												<table width="750" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td><img src="images/box1.gif"></td>
													</tr>
													<tr>
														<td align="center" background="images/box2.gif"><c:choose>
																<c:when test="${empty rsInterfaceInfo.interfaceId}">
																	<table width="748" border="0" cellspacing="0"
																		cellpadding="0">
																		<tr>
																			<td width="150" height="35" class="ttl4">프로토콜명</td>
																			<td width="1" bgcolor="#f3961d"></td>
																			<td width="10"></td>
																			<td><input type="text" name="interfaceProtocal"
																				id="interfaceProtocal" class="textbox validate-req"
																				style="width: 75%" title="프로토콜명" maxlength="200" />
																				<a id="anchInterIdDup"><img
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
																			<td width="150" height="35" class="ttl4">인터페이스명</td>
																			<td width="1" bgcolor="#f3961d"></td>
																			<td width="10"></td>
																			<td><input type="text" name="interfaceName"
																				id="interfaceName" class="textbox validate-req"
																				style="width: 85%" title="인터페이스명" maxlength="200" />
																			</td>
																		</tr>
																		<tr>
																			<td height="1" colspan="4" bgcolor="#f3961d"></td>
																		</tr>
																	</table>
																	<table width="748" border="0" cellspacing="0"
																		cellpadding="0">
																		<tr>
																			<td width="150" height="35" class="ttl4">정렬기준</td>
																			<td width="1" bgcolor="#f3961d"></td>
																			<td width="10"></td>
																			<td><input type="text" name="interfaceAlign"
																				id="interfaceAlign" class="textbox validate-req"
																				style="width: 85%" title="정렬기준" maxlength="200" />
																			</td>
																		</tr>
																		<tr>
																			<td height="1" colspan="4" bgcolor="#f3961d"></td>
																		</tr>
																	</table>
																	<table width="748" border="0" cellspacing="0"
																		cellpadding="0">
																		<tr>
																			<td width="150" height="35" class="ttl4">사용여부</td>
																			<td width="1" bgcolor="#f3961d"></td>
																			<td width="10"></td>
																			<td><input type="radio" style="cursor: hand;"
																				name="interfaceState" value="Y" /> 사용 &nbsp;&nbsp;
																				<input type="radio" style="cursor: hand;"
																				name="interfaceState" value="N" checked="checked" />
																				미사용</td>
																			<td width="5"></td>
																		</tr>
																		<tr>
																			<td height="1" colspan="4" bgcolor="#f3961d"></td>
																		</tr>
																	</table>
																	<table width="748" border="0" cellspacing="0"
																		cellpadding="0">
																		<tr>
																			<td width="150" class="ttl4">내용</td>
																			<td width="1" bgcolor="#f3961d"></td>
																			<td width="10"></td>
																			<td height="70"><textarea
																					name="interfaceContent" rows="5" class="textbox"
																					style="width: 85%; height: 50" title="내용"></textarea>
																			</td>
																			<td width="5"></td>
																		</tr>
																	</table>
																</c:when>
																<c:otherwise>
																	<table width="748" border="0" cellspacing="0"
																		cellpadding="0">
																		<tr>
																			<td width="150" height="35" class="ttl4">프로토콜명</td>
																			<td width="1" bgcolor="#f3961d"></td>
																			<td width="10"></td>
																			<td><input type="text" style="width: 85%"
																				class="invisible"
																				value="${rsInterfaceInfo.interfaceProtocal}" /></td>
																		</tr>
																		<tr>
																			<td height="1" colspan="4" bgcolor="#f3961d"></td>
																		</tr>
																	</table>
																	<table width="748" border="0" cellspacing="0"
																		cellpadding="0">
																		<tr>
																			<td width="150" height="35" class="ttl4">인터페이스명</td>
																			<td width="1" bgcolor="#f3961d"></td>
																			<td width="10"></td>
																			<td><input type="text" style="width: 85%"
																				class="invisible"
																				value="${rsInterfaceInfo.interfaceName}" /></td>
																		</tr>
																		<tr>
																			<td height="1" colspan="4" bgcolor="#f3961d"></td>
																		</tr>
																	</table>
																	<table width="748" border="0" cellspacing="0"
																		cellpadding="0">
																		<tr>
																			<td width="150" height="35" class="ttl4">정렬기준</td>
																			<td width="1" bgcolor="#f3961d"></td>
																			<td width="10"></td>
																			<td><input type="text" class="invisible"
																				value="${rsInterfaceInfo.interfaceAlign}" /></td>
																		</tr>
																		<tr>
																			<td height="1" colspan="4" bgcolor="#f3961d"></td>
																		</tr>
																	</table>
																	<table width="748" border="0" cellspacing="0"
																		cellpadding="0">
																		<tr>
																			<td width="150" height="35" class="ttl4">사용여부</td>
																			<td width="1" bgcolor="#f3961d"></td>
																			<td width="10"></td>
																			<td><input type="radio" style="cursor: hand;"
																				name="interfaceState" value="Y"
																				<c:if test="${rsInterfaceInfo.interfaceState == 'Y'}">checked="checked"</c:if> />
																				사용 &nbsp;&nbsp; <input type="radio"
																				style="cursor: hand;" name="interfaceState"
																				value="N"
																				<c:if test="${rsInterfaceInfo.interfaceState == 'N'}">checked="checked"</c:if> />
																				미사용</td>
																			<td width="5"></td>
																		</tr>
																		<tr>
																			<td height="1" colspan="4" bgcolor="#f3961d"></td>
																		</tr>
																	</table>
																	<table width="748" border="0" cellspacing="0"
																		cellpadding="0">
																		<tr>
																			<td width="150" class="ttl4">내용</td>
																			<td width="1" bgcolor="#f3961d"></td>
																			<td width="10"></td>
																			<td height="70"><textarea
																					name="interfaceContent" rows="5" class="textbox"
																					style="width: 62%; height: 50" title="내용">${rsInterfaceInfo.interfaceContent}</textarea>
																			</td>
																			<td width="5"></td>
																		</tr>
																	</table>
																</c:otherwise>
															</c:choose></td>
													</tr>
													<tr>
														<td><img src="images/box3.gif"></td>
													</tr>
												</table>
											</div>
										</td>
									</tr>
								</table>
							</td>
							<td width="10" background="images/bg_bar.gif"></td>
						</tr>
						<tr></tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="10">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="10"><img src="images/bottom_bg1.gif"></td>
							<td width="100%" background="images/bottom_bg2.gif"></td>
							<td width="10"><img src="images/bottom_bg3.gif"></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td><jsp:include page="../../common/footer.jsp" /></td>
			</tr>
		</table> --%>
	</form:form>
</body>
</html>