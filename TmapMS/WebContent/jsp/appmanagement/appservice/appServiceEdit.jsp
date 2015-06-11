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

		if (!validate()) {
			return;
		}
		exeDeleteHidden();
		document.ContentsForm.action = 'appServiceUpdate.do';
		document.ContentsForm.submit();

	}

	function exeDeleteHidden() {
		var form = document.ContentsForm;
		if (!form.choiceCurrent) {
			return;
		}
		var loop = form.choiceCurrent.length;
		if (loop) {
			for ( var i = 0; i < loop; i++) {
				if (!form.choiceCurrent[i].checked) {
					var delObj = document.createElement('input');
					delObj.setAttribute('type', 'hidden');
					delObj.setAttribute('value', form.choiceCurrent[i].value);
					delObj.setAttribute('name', 'deleteOsPhs');
					delObj.setAttribute('id', 'deleteOsPhs');

					form.appendChild(delObj);
				}
			}

		} else {
			if (!form.choiceCurrent.checked) {
				var delObj = document.createElement('input');
				delObj.setAttribute('type', 'hidden');
				delObj.setAttribute('value', form.choiceCurrent.value);
				delObj.setAttribute('name', 'deleteOsPhs');
				delObj.setAttribute('id', 'deleteOsPhs');

				form.appendChild(delObj);
			}
		}
	}

	function executeDel() {
		var state = '${editList.appInfoServiceState}';
		if (state == 'Y') {
			alert('사용중인 서비스는 삭제할 수 없습니다.\n미사용으로 상태 변경 후 삭제하십시요.');
			return;
		}
		if (confirm('삭제하시겠습니까?')) {
			document.ContentsForm.appInfoServiceState.value = 'D';
			document.ContentsForm.action = 'appServiceDelete.do';
			document.ContentsForm.submit();
		}
	}
</script>
</head>
<body>
	<form name="ContentsForm" method="post" id="ContentsForm">
		<input type="hidden" name="selectedServiceSeq"
			value="${editList.appInfoServiceSeq}" /> <input type="hidden"
			name="appInfoServiceSeq" value="${editList.appInfoServiceSeq}" /> <input
			type="hidden" name="appName" value="${editList.appName}" /> <input
			type="hidden" name="appUpName" value="${editList.appUpName}" /> <input
			type="hidden" name="appInfoSeq" value="${editList.appInfoSeq}" /> <input
			type="hidden" name="appUpSeq" value="${editList.appUpSeq}" /> <input
			type="hidden" name="selectCurrentAppSeq"
			value="${selectCurrentAppSeq}" /> <input type="hidden"
			name="selectUpgradeAppSeq" value="${selectUpgradeAppSeq}" />
		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td><img src="images/h3_ico.gif"><span>APP 강제 업그레이드 수정</span></td>
						</tr>
					</table>
					<br>
					<table>
						<tr>
							<td><b>[</b></td>
							<td width="110px;" bgcolor="#E6E6FA">등록된 단말OS</td>
							<td width="165px;" bgcolor="#fffacd">추가 할 수 있는 단말OS</td>
							<td width="155px;" bgcolor="#ffffff">등록할 수 없는 단말OS</td>
							<td width="130px;"><b>]</b></td>
							<td><a href="javascript:executeDel();" onFocus="blur()"><img
									src="images/btn/delete7.gif" border="0"></a>&nbsp; <a
								href="javascript:executeSave();" onFocus="blur()"><img
									src="images/btn/modify7.gif" border="0"></a> <a
								href="appServiceList.do" onFocus="blur()"><img
									src="images/btn/btn_list.gif" border="0" style="cursor: hand"></a>
							</td>
						</tr>
					</table>
					<div>
						<div style="width: 360px; float: left;">
							<table class="sub_0601_table">
								<colgroup>
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
								</colgroup>
								<tbody>
									<tr>
										<th></th>
										<th>단말명</th>
										<th>OS버전명</th>
									</tr>
									<c:choose>
										<c:when test="${empty currentOsPhs}">
											<tr>
												<td colspan="4" height="100" align="center">등록된 게시물이
													없습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach var="currentOsPhs" items="${currentOsPhs}">
												<tr style="height: 37px;"
													bgcolor="${currentOsPhs.stateColor}"
													onMouseOut="rowOnMouseOutColor(this, '${currentOsPhs.stateColor}');"
													onmouseover="rowOnMouseOver(this);">
													<td><c:choose>
															<c:when test="${currentOsPhs.state == 'A'}">
																<input type="checkbox" class="checkbox"
																	name="choiceCurrent"
																	value="${currentOsPhs.phModelInfoSeq}"
																	checked="checked" />
															</c:when>
															<c:when test="${currentOsPhs.state == 'N'}">
																<input type="checkbox" class="checkbox"
																	name="choiceCurrent"
																	value="${currentOsPhs.phModelInfoSeq}" />
															</c:when>
															<c:when test="${currentOsPhs.state == 'X'}">
															</c:when>
														</c:choose></td>
													<td><input type="text" class="invisiblebox"
														style="background-color: transparent; border: 0px; text-align: center"
														value="${currentOsPhs.phName}" readonly="readonly"
														style="width: 120" /></td>
													<td><input type="text" class="invisiblebox"
														style="background-color: transparent; border: 0px; text-align: center"
														value="${currentOsPhs.osVerName}" readonly="readonly"
														style="width: 70px;border:0px" /></td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
						<div style="width: 360px; float: left">
							<table class="sub_0601_table">
								<colgroup>
									<col width="" />
									<col width="" />
								</colgroup>
								<tbody>
									<tr>
										<th>단말명</th>
										<th>OS버전명</th>
									</tr>
									<c:choose>
										<c:when test="${empty upgradeOsPhs}">
											<tr>
												<td colspan="2" height="100" align="center">등록된 게시물이
													없습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach var="upgradeOsPhs" items="${upgradeOsPhs}">
												<tr onmouseover="rowOnMouseOver(this);"
													onMouseOut="rowOnMouseOut(this);">
													<td>${upgradeOsPhs.phName}</td>
													<td>${upgradeOsPhs.osVerName}</td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
					</div>
					<table class="srvRegi">
						<colgroup>
							<col width="40%" />
							<col width="*" />
						</colgroup>
						<tr>
							<th style="border-top: 2px solid #b0b0b0;">사용여부</th>
							<td style="border-top: 2px solid #b0b0b0;"><input
								type="radio" name="appInfoServiceState" value="Y"
								<c:if test="${editList.appInfoServiceState == 'Y'}">checked="checked"</c:if> />
								사용 &nbsp;&nbsp; <input type="radio" name="appInfoServiceState"
								value="N"
								<c:if test="${editList.appInfoServiceState == 'N'}">checked="checked"</c:if> />
								미사용</td>
						</tr>
						<tr>
							<th>강제여부</th>
							<td><input type="radio" name="upgradeDivision" class="radio"
								value="S"
								<c:if test="${editList.upgradeDivision == 'S'}"> checked="checked" </c:if> />일반&nbsp;&nbsp;
								<input type="radio" name="upgradeDivision" class="radio"
								value="F"
								<c:if test="${editList.upgradeDivision == 'F'}"> checked="checked" </c:if> />
								강제</td>
						</tr>
						<tr>
							<th>팝업 표시여부</th>
							<td><input type="radio" name="introPopup" class="radio"
								value="Y"
								<c:if test="${editList.introPopup == 'Y'}"> checked="checked" </c:if> />
								사용 &nbsp;&nbsp; <input type="radio" name="introPopup"
								class="radio" value="N"
								<c:if test="${editList.introPopup == 'N'}"> checked="checked" </c:if> />
								미사용</td>
						</tr>
						<tr>
							<th>메뉴 표시여부</th>
							<td><input type="radio" name="menuDisplay" class="radio"
								value="Y"
								<c:if test="${editList.menuDisplay == 'Y'}"> checked="checked" </c:if> />
								사용 &nbsp;&nbsp; <input type="radio" name="menuDisplay"
								class="radio" value="N"
								<c:if test="${editList.menuDisplay == 'N'}"> checked="checked" </c:if> />
								미사용</td>
						</tr>
						<tr>
							<th>업그레이드 후 맵 다운로드 필수 유무</th>
							<td><input type="radio" name="mapDownload" class="radio"
								value="Y"
								<c:if test="${editList.mapDownload == 'Y'}"> checked="checked" </c:if> />
								사용 &nbsp;&nbsp; <input type="radio" name="mapDownload"
								class="radio" value="N"
								<c:if test="${editList.mapDownload == 'N'}"> checked="checked" </c:if> />
								미사용</td>
						</tr>
						<tr>
							<th>코멘트</th>
							<td><input type="text" name="upgradeComment" class="textbox"
								style="width: 600px; resize: none;" title="비고"
								value="${editList.upgradeComment}" /></td>
						</tr>

						<tr>
							<th>Download URL</th>
							<td><input type="text" name="appDownUrl" class="invisible"
								style="width: 610px" value="${editList.appDownUrl}"
								readonly="readonly" /></td>
						</tr>
						<tr>
							<th>비고</th>
							<td><input type="text" name="appInfoServiceRemark"
								class="textbox" style="width: 610px;" title="비고"
								value="${editList.appInfoServiceRemark}"></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />
	</form>
</body>
</html>