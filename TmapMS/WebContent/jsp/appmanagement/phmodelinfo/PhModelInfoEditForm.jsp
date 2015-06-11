<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/formValidate.js"></script>
<script type="text/javascript">
	function executeList() {
		document.ContentsForm.action = 'DeviceOsVerInfo.do';
		document.ContentsForm.submit();
	}
</script>
</head>
<body>
	<form name="ContentsForm" method="post">
		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td width="665px"><img src="images/h3_ico.gif"><span>단말모델
									정보 상세</span></td>
							<td><img src="images/btn/btn_list.gif" border="0"
								style="cursor: hand" onClick="javascript:executeList();" /></td>
						</tr>
					</table>
					<br>
					<table class="srvRegi">
						<colgroup>
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<tr>
							<th class="td06">단말명</th>
							<td class="td06">${detail.phName}</td>
							<th class="td06">OS버전명</th>
							<td class="td06">${detail.osVerName}</td>
						</tr>
						<tr>
							<th class="td06">단말모델명</th>
							<td class="td06">${detail.phModelName}</td>
							<th class="td06">개발사</th>
							<td class="td06">${detail.osVerName}</td>
						</tr>
						<tr>
							<th>단말정보</th>
							<td><textarea name="osVerContent" rows="5" cols="40"
									rows="5" class="textbox" style="width: 95%; height: 40; resize:none;"
									readonly="readonly">${detail.phContent}</textarea></td>
							<th>OS버전정보</th>
							<td><textarea name="osVerContent" rows="5" cols="40"
									rows="5" class="textbox" style="width: 95%; height: 40; resize:none;"
									readonly="readonly" >${detail.osVerContent}</textarea></td>
						</tr>
						<tr>
							<th>등록일</th>
							<td>${detail.phModelStoreDate}</td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<th>사용여부</th>
							<td><c:if test="${detail.phModelState == 'Y'}">사용중</c:if> <c:if
									test="${detail.phModelState == 'N'}">미사용</c:if></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<th>OS버전</th>
							<td><c:if test="${detail.phDivision == 'IO'}">IOS</c:if> <c:if
									test="${detail.phDivision == 'AN'}">Android</c:if></td>
							<td></td>
							<td></td>
						</tr>

					</table>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />
	</form>
</body>
</html>