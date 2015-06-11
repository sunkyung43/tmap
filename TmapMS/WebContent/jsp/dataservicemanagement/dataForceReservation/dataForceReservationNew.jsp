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
<style>
a.regBtn {
	display: inline-block;
	height: 25px;
	padding: 0 14px 0;
	border: 1px solid #304a8a;
	background-color: #9AA5BE;
	font-size: 13px;
	color: #fff;
	line-height: 25px;
}

a.listBtn {
	display: inline-block;
	height: 25px;
	padding: 0 14px 0;
	border: 1px solid #304a8a;
	background-color: #3f5a9d;
	font-size: 13px;
	color: #fff;
	line-height: 25px;
}

a.listBtn:hover {
	border: 1px solid #091940;
	background-color: #1f326a;
	color: #fff;
}
</style>
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/formValidate.js"></script>

<script type="text/javascript">
	function executeSave() {
		var form = document.ContentsForm;

		if ($("#selectApp").val() == '') {
			alert('대상 어플리케이션이 선택되지 않았습니다.');
			return;
		}
		if ($("#selectVersion").val() == '') {
			alert('대상 어플리케이션 버전이 선택되지 않았습니다.');
			return;
		}
		if ($("#selectData").val() == '') {
			alert('데이터가 선택되지 않았습니다. ');
			return;
		}

		executeCurrentAppSetting();

		form.action = 'forceReservationInsert.do';
		form.submit();
	}

	function executeCurrentAppSetting() {
		var form = document.ContentsForm;
		var upAppId = form.upApp.selectedIndex;
		var upAppVerId = form.upAppVer.selectedIndex;
		//현재앱 정보 정리
		form.upAppName.value = form.upApp.options[upAppId].text;
		form.upAppVerName.value = form.upAppVer.options[upAppVerId].text;
		form.upDataFileServId.value = form.upData.options[form.upData.selectedIndex].value;
		form.upDataFileServName.value = form.upData.options[form.upData.selectedIndex].text;
	}

	function exeTargetApp(selectObj) {

		document.ContentsForm.selectTargetAppId.value = selectObj.value;
		document.ContentsForm.action = "forceReservationNew.do";
		document.ContentsForm.submit();
	}

	function exeTargetAppVersion(selectObj) {

		document.ContentsForm.selectTargetAppVerId.value = selectObj.value;
		document.ContentsForm.action = "forceReservationNew.do";
		document.ContentsForm.submit();
	}

	function exeUpgradeApp(selectObj) {
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
		<input type="hidden" name="upgradeType" value="D" /> <input
			type="hidden" name="upAppId" /> <input type="hidden"
			name="upAppName" /> <input type="hidden" name="upAppVerId" /> <input
			type="hidden" name="upAppVerName" /> <input type="hidden"
			name="selectTargetAppId" value="${selectTargetAppId}" /> <input
			type="hidden" name="selectTargetAppVerId"
			value="${selectTargetAppVerId}" /> <input type="hidden"
			name="upDataFileServId" /> <input type="hidden"
			name="upDataFileServName" />
		<jsp:include page="../../common/menu.jsp" />

		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">

					<div>
						<img src="images/h3_ico.gif"><span>강제 예약 업데이트 관리</span>
					</div>
					<div style="text-align:right;margin:5px">
							<a href="javascript:executeSave();" onFocus="blur()" class="regBtn">등록하기</a>
							<a href="forceReservationList.do" class="listBtn">목록보기</a>
					</div>
					<table>
						<tr>
							<td>
								<table style="border-top: 2px solid #b0b0b0; width: 748">
									<tr>
										<td width="49%" class="ttl3"><B>대상 어플리케이션 / 버전</B></td>
										<td class="ttl3"><B>강제 업데이트 대상</B></td>
									</tr>
									<tr>
										<td class="ttl4"
											style="padding-left: 5; padding-right: 5; font-size: 13px; vertical-align: top;">
											<!-- 현재 APP --> 대상 APP : <select class="textbox" id="selectApp" name="upApp"
											onchange="javascript:exeTargetApp(this);">
												<option value="">=== 선택 ===</option>
												<c:forEach var="list" items="${targetAppList}">
													<option value="${list.upAppId}"
														<c:if test="${list.upAppId == selectTargetAppId}">selected="selected"</c:if>>${list.upAppName}</option>
												</c:forEach>
										</select> 버전 : <select class="textbox" id="selectVersion" name="upAppVer"
											onchange="javascript:exeTargetAppVersion(this);">
												<option value="">=== 선택 ===</option>
												<c:forEach var="verList" items="${targetAppVerList}">
													<option value="${verList.upAppVerId}"
														<c:if test="${verList.upAppVerId == selectTargetAppVerId}">selected="selected"</c:if>>${verList.upAppVerName}</option>
												</c:forEach>
										</select>
										</td>
										<td class="ttl4"
											style="padding-left: 5; padding-right: 5; font-size: 13px; vertical-align: top;">
											<!-- 업데이트 할 APP --> 강제 업데이트 대상 데이터 : <select class="textbox"
											name="upData" id="selectData">
												<option value="">=== 선택 ===</option>
												<c:forEach var="list" items="${targetDataFileServiceList}">
													<option value="${list.upDataFileServId}"
														<c:if test="${list.upDataFileServId == selectUpgradeAppSeq}">selected="selected"</c:if>>${list.upDataFileServName}</option>
												</c:forEach>
										</select>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td>
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
													<td colspan="3" height="100" align="center">등록된 게시물이
														없습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach var="list" items="${currentOsPhs}">
													<tr onmouseover="rowOnMouseOver(this);"
														onMouseOut="rowOnMouseOut(this);">
														<td class="td06"><input type="checkbox"
															class="checkbox" name="choiceCurrent"
															value="${list.phModelInfoSeq}" /></td>
														<td class="td06">${list.phName}</td>
														<td class="td06">${list.osVerName}</td>
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>

							</td>
						</tr>
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
								type="radio" name="upgradeDataState" class="radio" value="Y" />
								사용 &nbsp;&nbsp; <input type="radio" name="upgradeDataState"
								class="radio" value="N" checked="checked" /> 미사용</td>
						</tr>
						<tr>
							<th>강제여부</th>
							<td><input type="radio" name="upgradeDivision" class="radio"
								value="S" checked="checked" />선택&nbsp;&nbsp; <input
								type="radio" name="upgradeDivision" class="radio" value="F" />
								강제</td>
						</tr>

						<tr>
							<th>코멘트</th>
							<td><input type="text" name="Comment" class="textbox"
								style="width: 600px; resize: none;" title="비고" /> &nbsp; <label
								style="color: red;">*</Label></td>
						</tr>
						<tr>
							<th>비고</th>
							<td><input type="text" name="etc" class="textbox"
								style="width: 600px; resize: none;" title="비고" /> &nbsp; <label
								style="color: red;">*</Label></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />
	</form>
</body>
</html>