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
<link rel="stylesheet" href="css/tmap.css" type="text/css" />
<link rel="stylesheet" href="css/common.css" type="text/css" />
<link rel="stylesheet" href="css/layout_contents.css" type="text/css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/formValidate.js"></script>
<script type="text/javascript">
	function executeSave() {
		var form = document.ContentsForm;
		var updateApp = form.upgradeApp;
		var currentApp = form.currentApp;
		var currentVersion = form.currentVersion;
		var upgradeVersion = form.upgradeVersion;

		if (currentApp.value == '') {
			alert('현재 어플리케이션이 선택되지 않았습니다.');
			return;
		}
		if (updateApp.value == '') {
			alert('업데이트 할 어플리케이션이 선택되지 않았습니다.');
			return;
		}
		if (currentVersion.value == upgradeVersion.value) {
			alert('동일한 어플리케이션을 선택 할 수 없습니다.');
			return;
		}
		if (!isChecked('ContentsForm', 'choiceCurrent')) {
			alert('현재 어플리케이션의 단말모델은 한개 이상 선택해야 합니다.');
			return;
		}

		if (!validate()) {
			return;
		}
		executeCurrentAppSetting();
		form.action = 'appServiceInsert.do';
		form.submit();

	}

	function executeCurrentAppSetting() {
		var form = document.ContentsForm;
		var selectedIndex = form.currentApp.selectedIndex;
		var selectedVerIndex = form.currentVersion.selectedIndex;
		var upSelectedIndex = form.upgradeApp.selectedIndex;
		var upSelectedVerIndex = form.upgradeVersion.selectedIndex;

		//현재앱 정보 정리
		form.appName.value = form.currentApp.options[selectedIndex].text;
		form.appInfoSeq.value = form.currentApp.value;
		form.appVerId.value = form.currentVersion.value;
		form.appVerName.value = form.currentVersion.options[selectedVerIndex].text;

		//업그레이드 앱 정보 정리
		selectedIndex = form.upgradeApp.selectedIndex;
		form.appUpName.value = form.upgradeApp.options[upSelectedIndex].text;
		form.appUpSeq.value = form.upgradeApp.value;
		form.appUpVerId.value = form.upgradeVersion.value;
		form.appUpVerName.value = form.upgradeVersion.options[upSelectedVerIndex].text;
		
	}

	var backupApp = '';
	function exeBackupApp(selectObj) {
		backupApp = selectObj.value;
	}

	var backupAppVer = '';
	function exeBackupAppVer(selectObj) {
		backupAppVer = selectObj.value;
	}
	function exeCurrentApp(selectObj) {
		if (document.ContentsForm.upgradeApp.value == selectObj.value) {
			alert('동일한 어플리케이션을 선택 할 수 없습니다.');
			document.ContentsForm.currentApp.value = backupApp;
			return;
		}
		
		document.ContentsForm.selectCurrentAppSeq.value = selectObj.value;
		document.ContentsForm.action = "appServiceNew.do";
		document.ContentsForm.submit();
	}
	
	function exeCurrentAppVer(selectObj) {
 		if (document.ContentsForm.upgradeVersion.value == selectObj.value) {
 			alert('동일한 App 버전을 선택 할 수 없습니다.');
 			document.ContentsForm.currentVersion.value = backupAppVer;
 			return;
 		}
		
		
		document.ContentsForm.selectCurrentAppVerId.value = selectObj.value;
		document.ContentsForm.action = "appServiceNew.do";
		document.ContentsForm.submit();
	}
	

	function exeUpgradeApp(selectObj) {
		var currentAppSize = '${currentOsPhsSize}';
		if (currentAppSize == '' || currentAppSize == '0') {
			alert('등록된 단말OS가 있는 현재 어플리케이션을 선택 하세요.');
			document.ContentsForm.upgradeApp.value = backupApp;
			document.ContentsForm.currentApp.focus();
			return;
		}

		document.ContentsForm.selectUpgradeAppSeq.value = selectObj.value;
		document.ContentsForm.action = "appServiceNew.do";
		document.ContentsForm.submit();
	}
	
	function exeUpgradeAppVer(selectObj) {
			if (document.ContentsForm.currentVersion.value == selectObj.value) {
				alert('동일한 App 버전을 선택 할 수 없습니다.');
				document.ContentsForm.upgradeAppVer.value = backupAppVer;
				return;
			}

			var currentAppSize = '${currentOsPhsSize}';
			if (currentAppSize == '' || currentAppSize == '0') {
				alert('등록된 단말OS가 있는 현재 어플리케이션을 선택 하세요.');
				document.ContentsForm.selectUpgradeAppVer.value = backupApp;
				document.ContentsForm.currentApp.focus();
				return;
			}

			document.ContentsForm.selectUpgradeAppVerId.value = selectObj.value;
			document.ContentsForm.action = "appServiceNew.do";
			document.ContentsForm.submit();
		}
	
	

	function exeChecked() {
		document.ContentsForm.choiceCurrentAll.checked = 'checked';
	}
</script>
</head>
<body>
	<form name="ContentsForm" method="post" id="ContentsForm">
		<input type="hidden" name="phModelInfoSeq" /> 
		<input type="hidden" name="DeviceModel" /> 
		<input type="hidden" name="DeviceOs" /> 
		<input type="hidden" name="ServicePhInfoSeq" />  
		<input type="hidden" name="appName" /> 
		<input type="hidden" name="appInfoSeq" />
		<input type="hidden" name="appVerId" />
		<input type="hidden" name="appVerName" />
		<input type="hidden" name="appUpName" /> 
		<input type="hidden" name="appUpSeq" />
		<input type="hidden" name="appUpVerId" />
		<input type="hidden" name="appUpVerName" /> 
		<input type="hidden" name="selectCurrentAppSeq" value="${selectCurrentAppSeq}" /> 
		<input type="hidden" name="selectCurrentAppVerId" value="${selectCurrentAppVerId}" /> 
		<input type="hidden" name="selectUpgradeAppSeq" value="${selectUpgradeAppSeq}" />
		<input type="hidden" name="selectUpgradeAppVerId" value="${selectUpgradeAppVerId}" />
		<jsp:include page="../../common/menu.jsp" />

		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td><img src="images/h3_ico.gif"><span>APP 강제 업그레이드 등록</span></td>
						</tr>
					</table>
					<br>
					<table>
						<tr>
							<td><b>[</b></td>
							<td bgcolor="#dcdcdc">등록 가능한 단말OS</td>
							<td width="5"></td>
							<td bgcolor="#ffffff">등록할 수 없는 단말OS</td>
							<td style="width: 290px;"><b>]</b></td>
							<td class="btn"><a href="javascript:executeSave();"
								onFocus="blur()"><img src="images/btn/btn_apply2.gif"
									border="0"></a> <a href="appServiceList.do" onFocus="blur()"><img
									src="images/btn/btn_list.gif" alt="목록으로" border="0"
									style="cursor: hand"></a></td>
						</tr>
					</table>
					<br>
					<table>
						<tr>
							<td>
								<table style="border-top: 2px solid #b0b0b0; width: 748">
									<tr>
										<td width="3" class="ttl3"></td>
										<td width="49%" class="ttl3"><B>현재 어플리케이션</B></td>
										<td width="1"></td>
										<td class="ttl3"><B>업데이트 할 어플리케이션</B></td>
										<td width="3" class="ttl3"></td>
									</tr>
									<tr>
										<td width="3"></td>
										<td class="ttl4"
											style="padding-left: 5; padding-right: 5; font-size: 13px; vertical-align: top;">
											<!-- 현재 APP --> 현재 APP : <select class="textbox"
											name="currentApp" onclick="javascript:exeBackupApp(this);"
											onchange="javascript:exeCurrentApp(this);">
												<option value="">=== 선택 ===</option>
												<c:forEach var="list" items="${currentAppList}">
													<option value="${list.appInfoSeq}"
														<c:if test="${list.appInfoSeq == selectCurrentAppSeq}">selected="selected"</c:if>>${list.appName}</option>
												</c:forEach>
										</select> 버전 : <select class="textbox" name="currentVersion"
											onclick="javascript:exeBackupAppVer(this);"
											onchange="javascript:exeCurrentAppVer(this);">
												<option value="">=== 선택 ===</option>
												<c:forEach var="verList" items="${currentAppVerList}">
													<option value="${verList.appVerId}"
														<c:if test="${verList.appVerId == selectCurrentAppVerId}">selected="selected"</c:if>>${verList.appVerName}</option>
												</c:forEach>
										</select>
											<table>
												<tr>
													<td height="5"></td>
												</tr>
											</table>
											<table class="sub_0601_table">
												<colgroup>
													<col width="" />
													<col width="" />
													<col width="" />
												</colgroup>
												<tbody>
													<tr>
														<th><input type="checkbox" name="choiceCurrentAll"
															onclick="checkAll('ContentsForm','choiceCurrentAll', 'choiceCurrent');" /></th>
														<th>단말명</th>
														<th>OS명</th>
													</tr>
													<c:choose>
														<c:when test="${empty currentOsPhs}">
															<tr>
																<td colspan="3" height="100" align="center">등록된
																	게시물이 없습니다.</td>
															</tr>
														</c:when>
														<c:otherwise>
															<!-- <div style="overflow: auto; width: 100%; height: 200;"> -->
															<c:forEach var="list" items="${currentOsPhs}">
																<tr
																	<c:choose><c:when test="${list.duplicate == 'Y'}">bgcolor="#DCDCDC"</c:when>
									  <c:otherwise>onmouseover="rowOnMouseOver(this);" onMouseOut="rowOnMouseOut(this);"</c:otherwise></c:choose>>
																	<td class="td06"><c:if
																			test="${list.checkYn == 'Y'}">
																			<input type="checkbox" class="checkbox"
																				name="choiceCurrent"
																				value="${list.phModelInfoSeq}"
																				checked="checked" />
																		</c:if></td>
																	<td class="td06">${list.phName}</td>
																	<td class="td06">${list.osVerName}</td>
																</tr>
															</c:forEach>
														</c:otherwise>
													</c:choose>
												</tbody>
											</table>
										</td>
										<td bgcolor="#ddd"></td>
										<td class="ttl4"
											style="padding-left: 5; padding-right: 5; font-size: 13px; vertical-align: top;">
											<!-- 업데이트 할 APP --> 업데이트 APP : <select class="textbox"
											name="upgradeApp" onchange="javascript:exeUpgradeApp(this);">
												<option value="">=== 선택 ===</option>
												<c:forEach var="list" items="${upgradeAppList}">
													<option value="${list.appInfoSeq}"
														<c:if test="${list.appInfoSeq == selectUpgradeAppSeq}">selected="selected"</c:if>>${list.appName}</option>
												</c:forEach>
										</select> 버전 : <select class="textbox" name="upgradeVersion"
											onclick="javascript:exeBackupAppVer(this);" onchange="javascript:exeUpgradeAppVer(this);">
												<option value="">=== 선택 ===</option>
												<c:forEach var="list" items="${upgradeAppVerList}">
													<option value="${list.appVerId}"
														<c:if test="${list.appVerId == selectUpgradeAppVerId}">selected="selected"</c:if>>${list.appVerName}</option>
												</c:forEach>
										</select>
											<table>
												<tr>
													<td height="5"></td>
												</tr>
											</table>
											<table class="sub_0601_table">
												<colgroup>
													<col width="" />
													<col width="" />
													<col width="" />
												</colgroup>
												<tbody>
													<tr>
														<th><input type="checkbox" name="choiceCurrentAll"
															onclick="checkAll('ContentsForm','choiceCurrentAll', 'choiceCurrent');" /></th>
														<th>단말명</th>
														<th>OS명</th>
													</tr>
													<c:choose>
														<c:when test="${empty upgradeOsPhs}">
															<tr>
																<td colspan="3" height="100" align="center">등록된
																	게시물이 없습니다.</td>
															</tr>
														</c:when>
														<c:otherwise>
															<!-- <div style="overflow: auto; width: 100%; height: 200;"> -->
															<c:forEach var="list" items="${upgradeOsPhs}">
																<tr onmouseover="rowOnMouseOver(this);"
																	onMouseOut="rowOnMouseOut(this);">
																	<td></td>
																	<td>${list.phName}</td>
																	<td>${list.osVerName}</td>
																</tr>
															</c:forEach>
															<!-- </div> -->
														</c:otherwise>
													</c:choose>
												</tbody>
											</table>
										</td>
										<td width="3"></td>
									</tr>
								</table>
					</table>
					<br>
					<table class="srvRegi">
						<colgroup>
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<tr>
							<th style="border-top: 2px solid #b0b0b0;">사용여부</th>
							<td style="border-top: 2px solid #b0b0b0;"><input
								type="radio" name="appInfoServiceState" class="radio" value="Y" />
								사용 &nbsp;&nbsp; <input type="radio" name="appInfoServiceState"
								class="radio" value="N" checked="checked" /> 미사용</td>
						</tr>
						<tr>
							<th>강제여부</th>
							<td><input type="radio" name="upgradeDivision" class="radio"
								value="S" />일반&nbsp;&nbsp; <input type="radio"
								name="upgradeDivision" class="radio" value="F" checked="checked" />
								강제</td>
						</tr>

						<tr>
							<th>팝업 표시여부</th>
							<td><input type="radio" name="introPopup" class="radio"
								value="Y" /> 사용 &nbsp;&nbsp; <input type="radio"
								name="introPopup" class="radio" value="N" checked="checked" />
								미사용</td>
						</tr>
						<tr>
							<th>메뉴 표시여부</th>
							<td><input type="radio" name="menuDisplay" class="radio"
								value="Y" /> 사용 &nbsp;&nbsp; <input type="radio"
								name="menuDisplay" class="radio" value="N" checked="checked" />
								미사용</td>
						</tr>
						<tr>
							<th>업그레이드 후 맵 다운로드 필수 유무</th>
							<td><input type="radio" name="mapDownload" class="radio"
								value="Y" /> 사용 &nbsp;&nbsp; <input type="radio"
								name="mapDownload" class="radio" value="N" checked="checked" />
								미사용</td>
						</tr>
						<tr>
							<th>코멘트</th>
							<td><input type="text" name="upgradeComment"
								class="textbox" style="width: 600px; resize: none;" title="비고" />
								&nbsp; <label style="color: red;">*</Label></td>
						</tr>
						<tr>
							<th>Download URL</th>
							<td><input type="text" name="appDownUrl" class="invisible"
								style="width: 600px" readonly="readonly" value="${appDownURL}" />
								&nbsp; <label style="color: red;">*</Label></td>
						</tr>
						<tr>
							<th>비고</th>
							<td><input type="text" name="appInfoServiceRemark"
								class="textbox" style="width: 600px; resize: none;" title="비고" />
								&nbsp; <label style="color: red;">*</Label></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />
	</form>
</body>
</html>