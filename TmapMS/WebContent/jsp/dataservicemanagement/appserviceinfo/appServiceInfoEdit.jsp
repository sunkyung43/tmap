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
<script language="JavaScript" src="js/common.js"></script>
<script language="JavaScript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script language="JavaScript" src="js/formValidate.js"></script>
<script language="JavaScript" src="js/appMappingInfo/edit.js"></script>
<script type="text/javascript">
	//중복체크 버튼 클릭 여부
	var checkValue = "";

	//이벤트 등록
	$(document).ready(function() {

		//사용여부 사용 선택시
		$("#use").click(function() {
			$("#typeTd").show();
			$("#nonTypeTd").hide();
			$("#distributeTd").show();
			$("#nonDistributeTd").hide();
		});

		//사용여부 미사용 선택시
		$("#unuse").click(function() {
			$("#typeTd").hide();
			$("#nonTypeTd").show();
			$("#distributeTd").hide();
			$("#nonDistributeTd").show();
		});

		//아이디 중복 체크 클릭시 이벤트 처리
		$("#anchIdDup").click(function() {
			checkValue = "T";
			processIdDuplication();
		});
	});

	//아이디 중복 체크
	function processIdDuplication() {

		//아이디 유효성 검증
		if ($("#appServiceName").val() == "") {
			alert("배포명을 입력하세요.");
			$("#appServiceName").val("");
			$("#appServiceName").focus();
			return;
		}

		//검증조건 값 할당
		$("#checkServiceName").val($("#appServiceName").val());

		//호출 및 메시지 출력
		$.post("processSerIdDuplication.do", $("#ContentsForm").serialize(),
				function(data) {
					if (data.json.check == "success") {
						alert("사용하실 수 없는 배포명 입니다.");
					} else {
						alert("사용하실 수 있는 배포명 입니다.");
					}

				});
	}

	function typeAndFile(dataFileId, dataTypeName) {

		$("#dataFileId").val(dataFileId);
		$("#oType").val(dataTypeName);

		//호출 및 메시지 출력
		$.post("verInFile.do", $("#ContentsForm").serialize(), function(data) {
			$.each(data.json.fileDetail, function(idx, list) {
				$("#oName").val(list.dataFileName);
				$("#oContent").val(list.dataFileContent);
				$("#oStore").val(list.dataFileStore);
				$("#oSdate").val(list.dataFileSdate);
			});
		});
	}

	function executeModify(appServiceId, appMappingId) {

		if (!validate()) {
			return;
		}

		/* if (appServiceId == "") {

			//중복체크사용 여부 검사
			if (checkValue != "T") {
				alert("아이디 중복체크를 하세요.");
				$("#anchIdDup").focus();
				return;
			}
		}
 */
		/* if ($("#radioCheck input:checked").length < 1) {
			alert("사용여부는 반드시 선택하셔야 합니다.");
			return;
		}
 */
		$("#appServiceId").val(appServiceId);
		$("#appMappingId").val(appMappingId);

		if (confirm("수정하시겠습니까?")) {

			$.post("appServiceInfoUpdate.do", $("#ContentsForm").serialize(),
					function(data) {
						alert("수정되었습니다.");
						$("#appMappingId").val(data.json.appMappingId);
						location.replace('appServiceInfoList.do');
				});
		}
	}

	function executeDel(appServiceId, state) {

		$("#appServiceId").val(appServiceId);

		if (confirm("삭제하시겠습니까?")) {
			if (state == 'Y') {
				alert("사용중인 배포정보는 삭제할 수 없습니다.\n미사용으로 전환 후 삭제하십시요.");
				return;
			} else {
				$.post("appServiceInfoDelete.do", $("#ContentsForm")
						.serialize(), function(data) {
					alert("삭제되었습니다.");
					$("#appMappingName").val("");
					location.replace('appServiceInfoList.do');
				});
			}
		}
	}

	function mappingGo(appMappingId) {
		$("#appMappingId").val(appMappingId);
		$("#ContentsForm").attr('action', 'appMappingInfoEdit.do');
		$("#ContentsForm").submit();
	}

	function getAppVerId(appVerId) {
		$("#appVerId").val(appVerId);
		showTable();
		$.post("verTypeAndFile.do", $("#ContentsForm").serialize(), function(
				data) {
			$("#verTypeFile").html(data);
		});
	}

	function showTable() {
		$("#verInTypeInfoTable").show();
		$("#typeInFileDiv").hide();

	}
</script>
</head>
<body>
	<form:form commandName="ContentsForm" id="ContentsForm"
		name="ContentsForm">
		<form:hidden path="dataFileId" />
		<form:hidden path="appServiceId" />
		<form:hidden path="appMappingId" />
		<form:hidden path="checkServiceName" />
		<form:hidden path="appVerId" />

		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td width="550"><img src="images/h3_ico.gif"><span>데이터
									배포 정보 수정</span></td>
							<td><a
								href="javascript:executeDel('${serviceDetail.appServiceId}', '${serviceDetail.appServiceState}');"
								onFocus="blur()"><img src="images/btn/delete7.gif"
									border="0"></a>&nbsp; <a
								href="javascript:executeModify('${serviceDetail.appServiceId}', '${mappingDetail.appMappingId}');"
								onFocus="blur()"><img src="images/btn/modify7.gif"
									border="0"></a>&nbsp; <a href="appServiceInfoList.do"
								onFocus="blur()"><img src="images/btn/btn_list.gif"
									border="0"></a></td>
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
								<th class="first">데이터 배포 명</th>
								<td class="first"><input type="text" name="appServiceName"
									class="invisible" style="width: 450px;"
									value="${serviceDetail.appServiceName}" /> <!-- <a id="anchIdDup"><img
										src="images/btn/checkid.gif" style="cursor: pointer;"></a> --></td>
							</tr>
							<tr>
								<th>사용여부</th>
								<td><input type="radio" style="cursor: hand;"
									style="cursor: hand;" name="appServiceState" id="use" value="Y"
									<c:if test="${serviceDetail.appServiceState == 'Y'}">checked="checked"</c:if> />사용
									&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input type="radio"
									style="cursor: hand;" style="cursor: hand;"
									name="appServiceState" id="unuse" value="N"
									<c:if test="${serviceDetail.appServiceState == 'N'}">checked="checked"</c:if> />미사용
									&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input type="radio"
									style="cursor: hand;" style="cursor: hand;"
									name="appServiceState" id="waiting" value="W"
									<c:if test="${serviceDetail.appServiceState == 'W'}">checked="checked"</c:if> />대기중
								</td>
							</tr>
							<tr>
								<th>배포타입</th>
								<c:if test="${serviceDetail.appServiceState != 'N'}">
									<td id="typeTd"><input type="radio" style="cursor: hand;"
										style="cursor: hand;" name="appServiceType" value="T"
										<c:if test="${serviceDetail.appServiceType == 'T'}">checked="checked"</c:if> />테스트배포
										&nbsp; <input type="radio" style="cursor: hand;"
										name="appServiceType" value="R"
										<c:if test="${serviceDetail.appServiceType == 'R'}">checked="checked"</c:if> />배포
										&nbsp; <input type="radio" style="cursor: hand;"
										name="appServiceType" value="W"
										<c:if test="${serviceDetail.appServiceType == 'W'}">checked="checked"</c:if> />대기중</td>
									<td id="nonTypeTd" style="display: none;"><input
										type="radio" style="cursor: hand;" style="cursor: hand;"
										name="appServiceType" value="T" disabled="disabled" />테스트배포
										&nbsp; <input type="radio" style="cursor: hand;"
										style="cursor: hand;" name="appServiceType" value="R"
										disabled="disabled" />배포</td>
								</c:if>
								<c:if test="${serviceDetail.appServiceState == 'N'}">
									<td id="nonTypeTd"><input type="radio"
										style="cursor: hand;" name="appServiceType" value="T"
										disabled="disabled" />테스트배포 &nbsp; <input type="radio"
										style="cursor: hand;" name="appServiceType" value="R"
										disabled="disabled" />배포</td>
									<td id="typeTd" style="display: none;"><input type="radio"
										style="cursor: hand;" name="appServiceType" value="T"
										<c:if test="${serviceDetail.appServiceType == 'T'}">checked="checked"</c:if> />테스트배포
										&nbsp; <input type="radio" style="cursor: hand;"
										name="appServiceType" value="R"
										<c:if test="${serviceDetail.appServiceType == 'R'}">checked="checked"</c:if> />배포
										&nbsp; <input type="radio" style="cursor: hand;"
										name="appServiceType" value="W"
										<c:if test="${serviceDetail.appServiceType == 'W'}">checked="checked"</c:if> />대기중</td>
								</c:if>
							</tr>
							<tr>
								<th>배포여부</th>
								<c:if test="${serviceDetail.appServiceState != 'N'}">
									<td class="ttl5" id="distributeTd"><input type="radio"
										style="cursor: hand;" name="appServiceDistribute" value="P"
										<c:if test="${serviceDetail.appServiceDistribute == 'P'}">checked="checked"</c:if> />배포
										&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input type="radio"
										style="cursor: hand;" name="appServiceDistribute" value="S"
										<c:if test="${serviceDetail.appServiceDistribute == 'S'}">checked="checked"</c:if> />배포중지
										&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input type="radio"
										style="cursor: hand;" name="appServiceDistribute" value="W"
										<c:if test="${serviceDetail.appServiceDistribute == 'W'}">checked="checked"</c:if> />대기중</td>
									<td class="ttl5" id="nonDistributeTd" style="display: none;"><input
										type="radio" style="cursor: hand;" name="appServiceDistribute"
										value="P" disabled="disabled" />배포 &nbsp; &nbsp; &nbsp;
										&nbsp; &nbsp; <input type="radio" style="cursor: hand;"
										name="appServiceDistribute" value="S" disabled="disabled" />배포중지</td>
								</c:if>
								<c:if test="${serviceDetail.appServiceState == 'N'}">
									<td class="ttl5" id="nonDistributeTd"><input type="radio"
										style="cursor: hand;" name="appServiceDistribute" value="P"
										disabled="disabled" />배포 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input
										type="radio" style="cursor: hand;" name="appServiceDistribute"
										value="S" disabled="disabled" />배포중지</td>
									<td class="ttl5" id="distributeTd" style="display: none;"><input
										type="radio" style="cursor: hand;" name="appServiceDistribute"
										value="P"
										<c:if test="${serviceDetail.appServiceDistribute == 'P'}">checked="checked"</c:if> />배포
										&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input type="radio"
										style="cursor: hand;" name="appServiceDistribute" value="S"
										<c:if test="${serviceDetail.appServiceDistribute == 'S'}">checked="checked"</c:if> />배포중지
										&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input type="radio"
										style="cursor: hand;" name="appServiceDistribute" value="W"
										<c:if test="${serviceDetail.appServiceDistribute == 'W'}">checked="checked"</c:if> />대기중</td>
								</c:if>
							</tr>
							<tr>
								<th>등록일</th>
								<td>${serviceDetail.appServiceSdate}</td>
							</tr>
						</tbody>
					</table>
					<br>
					<table class="srvRegi">
						<colgroup>
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th class="first">App 명</th>
								<td class="first">${mappingDetail.appName}</td>
							</tr>
							<tr>
								<th>매핑 데이터 명</th>
								<td>${mappingDetail.appMappingName}</td>
							</tr>
							<tr>
								<th>상태</th>
								<td><input type="radio" name="appMappingState" value="Y"
									<c:if test="${mappingDetail.appMappingState == 'Y'}">checked="checked"</c:if>
									disabled="disabled" /> 사용 &nbsp;&nbsp; <input type="radio"
									name="appMappingState" value="N"
									<c:if test="${mappingDetail.appMappingState == 'N'}">checked="checked"</c:if>
									disabled="disabled" /> 미사용</td>
							</tr>
							<tr>
								<th>내용</th>
								<td>${mappingDetail.appMappingContent}</td>
							</tr>
						</tbody>
					</table>
					<br>
					<!--  <img src="images/btn/btn_apply2.gif"
						style="cursor: hand; vertical-align: bottom; width: 75px;"
						onclick="javascript:appVerAdd();" alt="등록하기" /> -->
					<table class="sub_0601_table" id="appVersionInfoList">
						<colgroup>
							<col width="*" />
							<col width="*" />
							<col width="*" />
						</colgroup>
						<thead>
							<tr>
								<th>버전명</th>
								<th>내용</th>
								<th>버전상태</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty MappingDetailList}">
									<tr>
										<td height="100" colspan="4">등록된 APP 버전이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="list" items="${MappingDetailList}">
										<tr onmouseover="rowOnMouseOver(this);this.style.cursor='hand';" onMouseOut="rowOnMouseOut(this);" onclick="getAppVerId('${list.appVerId}');">
											<%-- <td><input type="radio" style="cursor: hand;"
												name="sort"
												onclick="getAppVerId('${list.appVerId}', '${list.appVerName }');" />
											</td> --%>
											<td>${list.appVerName}</td>
											<td>${list.appVerContent}</td>
											<td><c:if test="${list.appVerState == 'Y'}">
						사용
						</c:if> <c:if test="${list.appVerState == 'N'}">
						미사용
						</c:if></td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
							<tr>
						</tbody>
					</table>
					<br>
					<div id="verInTypeInfoTable" style="display: none;">
						<table class="srvRegi">
							<colgroup>
								<col width="100px">
								<col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th class="first">타입명</th>
									<td class="first"><input type="text" class="noBorder"
										id="oType" readonly="readonly"></td>
									<th class="first">파일명</th>
									<td class="first"><input type="text" class="noBorder"
										id="oName" readonly="readonly"></td>
								</tr>
								<tr>
									<th>내용</th>
									<td colspan="3"><input type="text" class="noBorder"
										id="oContent" readonly="readonly"></td>
								</tr>
								<tr>
									<th>file등록</th>
									<td><input type="text" class="noBorder" id="oStore"
										readonly="readonly"></td>
									<th>등록일</th>
									<td><input type="text" class="noBorder" id="oSdate"
										readonly="readonly"></td>
								</tr>
							</tbody>
						</table>
						<br>
						<table class="sub_0601_table">
							<colgroup>
								<col width="35%">
								<col width="*">
							</colgroup>
							<thead>
								<tr>
									<th>데이터 타입명</th>
									<th>데이터 파일명</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${empty typeAndFile}">
										<tr>
											<td colspan="2" align="center">등록된 게시물이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:set var="prevAppName" value="" />
										<c:set var="rowSpanNumber" value="0" />
										<c:set var="line" value="1" />
										<c:forEach var="list" items="${typeAndFile}">
											<c:set var="currentAppName" value="${list.dataTypeName}" />
											<c:set var="rowDraw" value="false" />
											<c:if test="${prevAppName == '' || currentAppName != prevAppName}">
												<c:set var="prevAppName" value="${list.dataTypeName}" />
												<c:set var="rowDraw" value="true" />
											</c:if>
											<tr>
												<c:choose>
													<c:when test="${rowInfo[list.dataTypeName] == 1}">
														<td>${list.dataTypeName}</td>
													</c:when>
													<c:otherwise>
														<c:if test="${rowDraw}">
															<c:set var="rowSpanNumber" value="${(rowInfo[list.dataTypeName] * 2) - 1}" />
															<td rowspan="${rowSpanNumber}" style="border-bottom: 1px solid #CFCFCF; border-right: 1px solid #CFCFCF;">${list.dataTypeName}</td>
														</c:if>
													</c:otherwise>
												</c:choose>
												<c:choose>
													<c:when test="${list.dataFileName == null}">
														<td colspan="2">등록된 데이터 파일이 없습니다.</td>
													</c:when>
													<c:otherwise>
														<td onmouseover="rowOnMouseOver(this);this.style.cursor='hand'" onMouseOut="rowOnMouseOut(this);" onclick="javascript:typeAndFile('${list.dataFileId}', '${list.dataTypeName}');">${list.dataFileName}</td>
													</c:otherwise>
												</c:choose>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
							<tbody id="verTbody" style="display: none;">
							</tbody>
						</table>
					</div>
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
														<td><font style="font-weight: bold;">&nbsp;데이터
																배포 정보 수정하기</font> <!-- <img src="images/title/title17.gif"> --></td>
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
														<td style="font-size: 13;"><b></b></td>
														<td class="btn">
															<a href="javascript:mappingGo('${mappingDetail.appMappingId}');" onFocus="blur()"><img src="images/btn/modify6.gif" border="0"></a>&nbsp;
															<a
															href="javascript:executeDel('${serviceDetail.appServiceId}', '${serviceDetail.appServiceState}');"
															onFocus="blur()"><img src="images/btn/delete7.gif"
																border="0"></a>&nbsp; <a
															href="javascript:executeModify('${serviceDetail.appServiceId}', '${mappingDetail.appMappingId}');"
															onFocus="blur()"><img src="images/btn/modify7.gif"
																border="0"></a>&nbsp; <a href="appServiceInfoList.do"
															onFocus="blur()"><img src="images/btn/btn_list.gif"
																border="0"></a>
														</td>
													</tr>
												</table>
												<table width="100%" border="0" cellpadding="10"
													cellspacing="1" bgcolor="#FF8200">
													<tr>
														<!-- 매핑 데이터 타입 시작 -->
														<td width="404" style="" valign="top" bgcolor="#FFFFFF">
															<table width="100%" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td class="ttl7">[데이터 배포 정보]</td>
																</tr>
																<tr>
																	<td height="5"></td>
																</tr>
															</table>
															<table width="404" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td><img src="images/box404_1.png"></td>
																</tr>
																<tr>
																	<td align="center" background="images/box404_2.png">
																		<table width="404" height="40" border="0"
																			cellspacing="0" cellpadding="0">
																			<tr>
																				<td width="113" height="5" class="ttl4">데이터 배포
																					명</td>
																				<td width="1" bgcolor="#f3961d"></td>
																				<td width="5"></td>
																				<td class="ttl4"><c:if
																						test="${empty serviceDetail.appServiceId}">
																						<input type="text" id="appServiceName"
																							name="appServiceName" class="text validate-req"
																							title="데이터 배포 명"
																							style="width: 75%; ime-mode: inactive;"
																							maxlength="100" />
																						<a id="anchIdDup"><img
																							src="images/btn/checkid.gif" align="absmiddle"
																							style="cursor: hand"></a>
																					</c:if> <c:if test="${! empty serviceDetail.appServiceId}">
																						<input type="text" name="appServiceName"
																							class="invisible" title="데이터 배포 명"
																							style="width: 95%;" readonly="readonly"
																							value="${serviceDetail.appServiceName}" />
																					</c:if></td>
																				<td width="5"></td>
																			</tr>
																			<tr>
																				<td height="1" colspan="5" bgcolor="#f3961d"></td>
																			</tr>
																		</table>
																		<table width="404" height="40" border="0"
																			cellspacing="0" cellpadding="0">
																			<tr>
																				<td width="113" height="15" class="ttl4">사용여부</td>
																				<td width="1" bgcolor="#f3961d"></td>
																				<td width="5"></td>
																				<td class="ttl5" id="radioCheck"><input
																					type="radio" style="cursor: hand;"
																					style="cursor: hand;" name="appServiceState"
																					id="use" value="Y"
																					<c:if test="${serviceDetail.appServiceState == 'Y'}">checked="checked"</c:if> />사용
																					&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input
																					type="radio" style="cursor: hand;"
																					style="cursor: hand;" name="appServiceState"
																					id="unuse" value="N"
																					<c:if test="${serviceDetail.appServiceState == 'N'}">checked="checked"</c:if> />미사용
																				</td>
																				<td width="5"></td>
																			</tr>
																			<tr>
																				<td height="1" colspan="5" bgcolor="#f3961d"></td>
																			</tr>
																		</table>
																		<table width="404" height="40" border="0"
																			cellspacing="0" cellpadding="0">
																			<tr>
																				<td width="113" height="15" class="ttl4">배포타입</td>
																				<td width="1" bgcolor="#f3961d"></td>
																				<td width="5"></td>
																				<c:if test="${serviceDetail.appServiceState != 'N'}">
																					<td class="ttl5" id="typeTd"><input
																						type="radio" style="cursor: hand;"
																						style="cursor: hand;" name="appServiceType"
																						value="T"
																						<c:if test="${serviceDetail.appServiceType == 'T'}">checked="checked"</c:if> />테스트배포
																						&nbsp; <input type="radio" style="cursor: hand;"
																						name="appServiceType" value="R"
																						<c:if test="${serviceDetail.appServiceType == 'R'}">checked="checked"</c:if> />배포
																					</td>
																					<td class="ttl5" id="nonTypeTd"
																						style="display: none;"><input type="radio"
																						style="cursor: hand;" style="cursor: hand;"
																						name="appServiceType" value="T"
																						disabled="disabled" />테스트배포 &nbsp; <input
																						type="radio" style="cursor: hand;"
																						style="cursor: hand;" name="appServiceType"
																						value="R" disabled="disabled" />배포</td>
																				</c:if>
																				<c:if test="${serviceDetail.appServiceState == 'N'}">
																					<td class="ttl5" id="nonTypeTd"><input
																						type="radio" style="cursor: hand;"
																						name="appServiceType" value="T"
																						disabled="disabled" />테스트배포 &nbsp; <input
																						type="radio" style="cursor: hand;"
																						name="appServiceType" value="R"
																						disabled="disabled" />배포</td>
																					<td class="ttl5" id="typeTd" style="display: none;">
																						<input type="radio" style="cursor: hand;"
																						name="appServiceType" value="T"
																						<c:if test="${serviceDetail.appServiceType == 'T'}">checked="checked"</c:if> />테스트배포
																						&nbsp; <input type="radio" style="cursor: hand;"
																						name="appServiceType" value="R"
																						<c:if test="${serviceDetail.appServiceType == 'R'}">checked="checked"</c:if> />배포
																					</td>
																				</c:if>
																				<td width="5"></td>
																			</tr>
																			<tr>
																				<td height="1" colspan="5" bgcolor="#f3961d"></td>
																			</tr>
																		</table>
																		<table width="404" height="40" border="0"
																			cellspacing="0" cellpadding="0">
																			<tr>
																				<td width="113" height="15" class="ttl4">배포여부</td>
																				<td width="1" bgcolor="#f3961d"></td>
																				<td width="5"></td>
																				<c:if test="${serviceDetail.appServiceState != 'N'}">
																					<td class="ttl5" id="distributeTd"><input
																						type="radio" style="cursor: hand;"
																						name="appServiceDistribute" value="P"
																						<c:if test="${serviceDetail.appServiceDistribute == 'P'}">checked="checked"</c:if> />배포
																						&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input
																						type="radio" style="cursor: hand;"
																						name="appServiceDistribute" value="S"
																						<c:if test="${serviceDetail.appServiceDistribute == 'S'}">checked="checked"</c:if> />배포중지
																					</td>
																					<td class="ttl5" id="nonDistributeTd"
																						style="display: none;"><input type="radio"
																						style="cursor: hand;" name="appServiceDistribute"
																						value="P" disabled="disabled" />배포 &nbsp; &nbsp;
																						&nbsp; &nbsp; &nbsp; <input type="radio"
																						style="cursor: hand;" name="appServiceDistribute"
																						value="S" disabled="disabled" />배포중지</td>
																				</c:if>
																				<c:if test="${serviceDetail.appServiceState == 'N'}">
																					<td class="ttl5" id="nonDistributeTd"><input
																						type="radio" style="cursor: hand;"
																						name="appServiceDistribute" value="P"
																						disabled="disabled" />배포 &nbsp; &nbsp; &nbsp;
																						&nbsp; &nbsp; <input type="radio"
																						style="cursor: hand;" name="appServiceDistribute"
																						value="S" disabled="disabled" />배포중지</td>
																					<td class="ttl5" id="distributeTd"
																						style="display: none;"><input type="radio"
																						style="cursor: hand;" name="appServiceDistribute"
																						value="P"
																						<c:if test="${serviceDetail.appServiceDistribute == 'P'}">checked="checked"</c:if> />배포
																						&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input
																						type="radio" style="cursor: hand;"
																						name="appServiceDistribute" value="S"
																						<c:if test="${serviceDetail.appServiceDistribute == 'S'}">checked="checked"</c:if> />배포중지
																					</td>
																				</c:if>
																				<td width="5"></td>
																			</tr>
																			<tr>
																				<td height="1" colspan="5" bgcolor="#f3961d"></td>
																			</tr>
																		</table>
																		<table width="404" height="40" border="0"
																			cellspacing="0" cellpadding="0">
																			<tr>
																				<td width="113" height="5" class="ttl4">등록일</td>
																				<td width="1" bgcolor="#f3961d"></td>
																				<td width="5"></td>
																				<td class="ttl4"><input type="text"
																					name="appServiceSdate" class="invisible"
																					title="등록일" style="width: 95%;" readonly="readonly"
																					value="${serviceDetail.appServiceSdate}" /></td>
																				<td width="5"></td>
																			</tr>
																			<tr>
																				<td height="1" colspan="5"></td>
																			</tr>
																		</table>
																	</td>
																</tr>
																<tr>
																	<td><img src="images/box404_3.png"></td>
																</tr>
															</table>
														</td>
														<!-- 매핑 데이터 타입 끝 -->
														<td width="404" valign="top" bgcolor="#FFFFFF">
															<table width="100%" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td class="ttl7">[데이터 타입]</td>
																</tr>
																<tr>
																	<td height="5"></td>
																</tr>
															</table>
															<table width="404" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td><img src="images/box404_1.png"></td>
																</tr>
																<tr>
																	<td align="center" background="images/box404_2.png">
																		<table width="404" border="0" cellspacing="0"
																			cellpadding="0">
																			<tr>
																				<td width="113" height="5" class="ttl4">App 명</td>
																				<td width="1" bgcolor="#f3961d"></td>
																				<td width="5"></td>
																				<td class="ttl4"><input type="text"
																					name="appName" class="invisible" title="App 명"
																					style="width: 95%; ime-mode: disabled;"
																					readonly="readonly"
																					value="${mappingDetail.appName}" /></td>
																				<td width="5"></td>
																			</tr>
																			<tr>
																				<td height="1" colspan="5" bgcolor="#f3961d"></td>
																			</tr>
																		</table>
																		<table width="404" border="0" cellspacing="0"
																			cellpadding="0">
																			<tr>
																				<td width="113" height="5" class="ttl4">매핑 데이터
																					명</td>
																				<td width="1" bgcolor="#f3961d"></td>
																				<td width="5"></td>
																				<td class="ttl4"><input type="text"
																					id="appMappingName" name="appMappingName"
																					class="invisible" title="매핑 데이터 명"
																					style="width: 95%; ime-mode: disabled;"
																					readonly="readonly"
																					value="${mappingDetail.appMappingName}" /></td>
																				<td width="5"></td>
																			</tr>
																			<tr>
																				<td height="1" colspan="5" bgcolor="#f3961d"></td>
																			</tr>
																		</table>
																		<table width="404" border="0" cellspacing="0"
																			cellpadding="0">
																			<tr>
																				<td width="113" height="15" class="ttl4">사용여부</td>
																				<td width="1" bgcolor="#f3961d"></td>
																				<td width="5"></td>
																				<td class="ttl5"><input type="radio"
																					name="appMappingState" value="Y"
																					<c:if test="${mappingDetail.appMappingState == 'Y'}">checked="checked"</c:if>
																					disabled="disabled" /> 사용 &nbsp;&nbsp; <input
																					type="radio" name="appMappingState" value="N"
																					<c:if test="${mappingDetail.appMappingState == 'N'}">checked="checked"</c:if>
																					disabled="disabled" /> 미사용</td>
																				<td width="5"></td>
																			</tr>
																			<tr>
																				<td height="1" colspan="5" bgcolor="#f3961d"></td>
																			</tr>
																		</table>
																		<table width="404" border="0" cellspacing="0"
																			cellpadding="0">
																			<tr>
																				<td width="113" class="ttl4">내용</td>
																				<td width="1" bgcolor="#f3961d"></td>
																				<td width="5"></td>
																				<td class="ttl4"><textarea
																						name="appMappingContent" rows="5" class="textbox"
																						style="width: 95%; height: 40" title="내용"
																						readonly="readonly">${mappingDetail.appMappingContent}</textarea>
																				</td>
																				<td width="5"></td>
																			</tr>
																		</table>
																	</td>
																</tr>
																<tr>
																	<td><img src="images/box404_3.png"></td>
																</tr>
															</table>
															<table width="100%" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td height="5"></td>
																</tr>
																<tr>
																	<td class="ttl7">[매핑 데이터 정보]</td>
																</tr>
																<tr>
																	<td height="5"></td>
																</tr>
																<tr>
																	<td>
																		<table width="100%" border="0" cellspacing="1"
																			cellpadding="1" bgcolor="#FF8200">
																			<tr height="20">
																				<td width="15%" bgcolor="#FFFFFF" class="ttl">타입명</td>
																				<td width="35%" bgcolor="#FFFFFF"><input
																					type="text" class="invisiblebox" id="oType"
																					readonly="readonly" style="width: 120"></td>
																				<td width="15%" bgcolor="#FFFFFF" class="ttl">파일명</td>
																				<td width="35%" bgcolor="#FFFFFF"><input
																					type="text" class="invisiblebox" id="oName"
																					readonly="readonly" style="width: 120"></td>
																			</tr>
																			<tr height="20">
																				<td bgcolor="#FFFFFF" class="ttl">내용</td>
																				<td bgcolor="#FFFFFF" colspan="3"><input
																					type="text" class="invisiblebox" id="oContent"
																					readonly="readonly"></td>
																			</tr>
																			<tr height="20">
																				<td bgcolor="#FFFFFF" class="ttl">file등록</td>
																				<td bgcolor="#FFFFFF"><input type="text"
																					class="invisiblebox" id="oStore"
																					readonly="readonly" style="width: 120"></td>
																				<td bgcolor="#FFFFFF" class="ttl">등록일</td>
																				<td bgcolor="#FFFFFF"><input type="text"
																					class="invisiblebox" id="oSdate"
																					readonly="readonly" style="width: 120"></td>
																			</tr>
																		</table>
																	</td>
																</tr>
																<tr>
																	<td height="5"></td>
																</tr>
															</table>
															<table width="100%" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="3"><img src="images/ttl_bar1.gif"></td>
																	<td width="40%" background="images/ttl_bar2.gif"
																		class="ttl">데이터 타입명</td>
																	<td width="1" background="images/ttl_bar2.gif"><img
																		src="images/ttl_line.gif"></td>
																	<td width="60%" background="images/ttl_bar2.gif"
																		class="ttl">데이터 파일명</td>
																	<td width="3"><img src="images/ttl_bar3.gif"></td>
																</tr>
															</table> <c:choose>
																<c:when test="${empty typeAndFile}">
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
																	<c:set var="prevAppName" value="" />
																	<c:set var="rowSpanNumber" value="0" />
																	<c:set var="line" value="1" />
																	<table width="100%" border="0" cellspacing="0"
																		cellpadding="0">
																		<c:forEach var="list" items="${typeAndFile}">
																			<c:set var="currentAppName"
																				value="${list.dataTypeName}" />
																			<c:set var="rowDraw" value="false" />

																			<c:if
																				test="${prevAppName == '' || currentAppName != prevAppName}">
																				<c:set var="prevAppName"
																					value="${list.dataTypeName}" />
																				<c:set var="rowDraw" value="true" />
																			</c:if>

																			<tr>

																				<c:choose>
																					<c:when test="${rowInfo[list.dataTypeName] == 1}">
																						<td width="3" background="images/ttl_blank.gif"><img
																							src="images/ttl_blank.gif"></td>
																						<td width="40%" class="ttl4">${list.dataTypeName}</td>
																					</c:when>
																					<c:otherwise>
																						<c:if test="${rowDraw}">
																							<c:set var="rowSpanNumber"
																								value="${(rowInfo[list.dataTypeName] * 2) - 1}" />
																							<td width="3" background="images/ttl_blank.gif"
																								rowspan="${rowSpanNumber}"><img
																								src="images/ttl_blank.gif"></td>
																							<td width="40%" class="ttl4"
																								rowspan="${rowSpanNumber}">${list.dataTypeName}</td>
																						</c:if>
																					</c:otherwise>
																				</c:choose>
																				<td width="1" background="images/ttl_line2.gif"><img
																					src="images/ttl_line2.gif"></td>
																				<c:choose>
																					<c:when test="${list.dataFileName == null}">
																						<td width="60%" class="ttl4" colspan="3">등록된
																							데이터 파일이 없습니다.</td>
																					</c:when>
																					<c:otherwise>
																						<td width="60%" class="ttl4"
																							onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
																							onMouseOut="rowOnMouseOut(this);"
																							onclick="javascript:typeAndFile('${list.dataFileId}', '${list.dataTypeName}');">
																							${list.dataFileName}</td>
																					</c:otherwise>
																				</c:choose>
																				<td width="3" background="images/ttl_blank.gif"><img
																					src="images/ttl_blank.gif"></td>
																			</tr>
																			<c:choose>
																				<c:when test="${rowInfo[list.dataTypeName] == line}">
																					<c:set var="line" value="1" />
																					<tr>
																						<td height="1" colspan="6" class="line"></td>
																					</tr>
																				</c:when>
																				<c:otherwise>
																					<c:set var="line" value="${line+1}" />
																					<tr>
																						<td height="1" colspan="6" class="line"></td>
																					</tr>
																				</c:otherwise>
																			</c:choose>
																		</c:forEach>
																	</table>
																</c:otherwise>
															</c:choose>
														</td>
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
		</table> --%>
	</form:form>
</body>
</html>