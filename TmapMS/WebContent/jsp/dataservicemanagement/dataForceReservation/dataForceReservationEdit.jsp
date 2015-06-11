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
		$("#ContentsForm").attr('action', 'forceReservationUpdate.do');
		$("#ContentsForm").submit();
	}
	
	function executeDelete() {
		$("#ContentsForm").attr('action', 'forceReservationDelete.do');
		$("#ContentsForm").submit();
	}
</script>
</head>
<body>
	<form name="ContentsForm" method="post" id="ContentsForm">
		<input type="hidden" name="upgradeType" value="D" /> <input
			type="hidden" name="upAppId" value="${detailInfo.upAppId }" /> <input
			type="hidden" name="upAppName" value="${detailInfo.upAppName }" /> <input
			type="hidden" name="upAppVerId" value="${detailInfo.upAppVerId }" />
		<input type="hidden" name="upAppVerName"
			value="${detailInfo.upAppVerName }" /> <input type="hidden"
			name="selectTargetAppId" value="${selectTargetAppId}" /> <input
			type="hidden" name="selectTargetAppVerId"
			value="${selectTargetAppVerId}" /> <input type="hidden"
			name="upDataFileServId" value="${detailInfo.upDataFileServId }" /> <input
			type="hidden" name="upDataFileServName"
			value="${detailInfo.upDataFileServName }" /> <input type="hidden"
			name="upgradeDataId" value="${detailInfo.upgradeDataId}" />
		<jsp:include page="../../common/menu.jsp" />

		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td><img src="images/h3_ico.gif"><span>강제 예약
									업데이트 수정</span></td>
						</tr>
					</table>
					<br>



					<div style="text-align: right; margin-right: 15px">
						<a href="javascript:executeSave();" onFocus="blur()"><img
							src="images/btn/btn_apply2.gif" border="0"></a><a href="javascript:executeDelete();"
							onFocus="blur()"> <img src="images/btn/delete7.gif"
							border="0"></a> <a href="forceReservationList.do"
							onFocus="blur()"><img src="images/btn/btn_list.gif"
							alt="목록으로" border="0" style="cursor: hand"></a>
					</div>
					<br>
					<table class="srvRegi">
						<colgroup>
							<col width="150px" />
							<col width="*" />
						</colgroup>
						<tr>
							<th style="border-top: 2px solid #b0b0b0;">대상 앱</th>
							<td style="border-top: 2px solid #b0b0b0;">${detailInfo.upAppName}</td>
						</tr>
						<tr>
							<th>앱 버전</th>
							<td>${detailInfo.upAppVerName}</td>
						</tr>

						<tr>
							<th>데이터 서비스 네임</th>
							<td>${detailInfo.upDataFileServName}</td>
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
								<c:when test="${empty phLIst}">
									<tr>
										<td colspan="3" height="100" align="center">등록된 게시물이
											없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="list" items="${phLIst}">
										<tr onmouseover="rowOnMouseOver(this);"
											onMouseOut="rowOnMouseOut(this);">
											<td class="td06"><input type="checkbox" class="checkbox"
												name="choiceCurrent" value="${list.phModelId}"
												<c:if test="${list.checkYn == 'Y'}">checked="checked"</c:if> /></td>
											<td class="td06">${list.phName}</td>
											<td class="td06">${list.osVerName}</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
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
								type="radio" name="upgradeDataState" class="radio" value="Y"
								<c:if test="${detailInfo.upgradeDataState == 'Y'}"> checked="checked" </c:if> />
								사용 &nbsp;&nbsp; <input type="radio" name="upgradeDataState"
								class="radio" value="N"
								<c:if test="${detailInfo.upgradeDataState == 'N'}"> checked="checked" </c:if> />
								미사용</td>
						</tr>
						<tr>
							<th>강제여부</th>
							<td><input type="radio" name="upgradeDivision" class="radio"
								value="S"
								<c:if test="${detailInfo.upgradeDivision == 'S'}"> checked="checked" </c:if> />일반&nbsp;&nbsp;
								<input type="radio" name="upgradeDivision" class="radio"
								value="F"
								<c:if test="${detailInfo.upgradeDivision == 'F'}"> checked="checked" </c:if> />
								강제</td>
						</tr>

						<tr>
							<th>코멘트</th>
							<td><input type="text" name="Comment" class="textbox"
								style="width: 600px; resize: none;" title="비고"
								value="${detailInfo.comment }" /> &nbsp; <label
								style="color: red;">*</Label></td>
						</tr>
						<tr>
							<th>비고</th>
							<td><input type="text" name="etc" class="textbox"
								style="width: 600px; resize: none;" title="비고"
								value="${detailInfo.etc}" /> &nbsp; <label style="color: red;">*</Label></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />
	</form>
</body>
</html>