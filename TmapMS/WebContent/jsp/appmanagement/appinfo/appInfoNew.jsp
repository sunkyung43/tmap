<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%
	response.setHeader("Pragma", "No-cache"); // HTTP1.0
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "no-cache"); // HTTP1.1
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tmap Managerment Site</title>
<!--  Stylesheet		-------------------------------------------------------------------------->
<link rel="stylesheet" href="css/common.css" type="text/css" />
<link rel="stylesheet" href="css/layout_contents.css" type="text/css" />
<link rel="stylesheet" href="css/jquery.stepy.css" type="text/css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/appInfojs/appInfoNew.js"></script>
</head>
<body>
	<form:form commandName="ContentsForm" id="ContentsForm"
		name="ContentsForm">
		<form:hidden path="templetModelId" />
		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="headline">
					<img src="images/h3_ico.gif"> <span>App 정보 </span>
				</div>
				<div id="appInfoContainer">
					<table class="srvRegi">
						<colgroup>
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th>이름</th>
								<td><input type="text" style="width: 580px" id="appName"
									name="appName" title="어플리케이션 이름" class="regiInput required" /><label
									style="color: red;">*</Label></td>
							</tr>
							<tr>
								<th>사용여부</th>
								<td><input type="radio" name="appState" value="Y"
									checked="checked" /> <label for="appState" class="MR20">사용</label>
									<input type="radio" name="appState" value="N" /><label
									for="appState" class="MR20">미사용</label></td>
							</tr>
							<tr>
								<th>Download URL</th>
								<td><input type="text" id="appDownURL" name="appDownURL"
									style="width: 580px" title="Down URL" maxlength="200"
									class="regiInput" /></td>
							</tr>
							<tr>
								<th>개발사</th>
								<td><input type="text" id="appMade" name="appMade"
									style="width: 580px" maxlength="100" class="regiInput" /></td>
							</tr>
							<tr>
								<th>내용</th>
								<td><input type="text" name="appContent" class="regiInput"
									style="width: 580px;" title="내용" /></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="headline" style="margin-top: 20px">
					<img src="images/h3_ico.gif"> <span>Version 정보 </span>
				</div>
				<div id="versionInfoContainer">
					<table class="srvRegi">
						<colgroup>
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th>버전명</th>
								<td><input type="text" id="appVerName" name="appVerName"
									title="어플리케이션 이름" style="width: 580px;" class="regiInput" />&nbsp;<label
									style="color: red;">*</Label></td>
							</tr>
							<tr>
								<th>사용여부</th>
								<td><input type="radio" name="appVerState" value="Y"
									checked="checked" /> <label for="app_ver_state" class="MR20">사용</label>
									<input type="radio" name="appVerState" value="N" /><label
									for="appVerState" class="MR20">미사용</label></td>
							</tr>
							<tr>
								<th>버전내용</th>
								<td><input type="text" name="appVerContent"
									class="regiInput" style="width: 580px;" title="내용" /></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div style="text-align: right; margin-top: 10px">
					<a href="javascript:excuteSave();" onfocus="blur()"> <img
						src="images/btn/btn_apply2.gif" border="0">
					</a> <a href="appInfoList.do" onFocus="blur()"> <img
						src="images/btn/btn_list.gif" border="0"></a>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />
	</form:form>
</body>
</html>