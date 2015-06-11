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
<script language="JavaScript" src="js/common.js"></script>
<script language="JavaScript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script language="JavaScript" src="js/formValidate.js"></script>
<script type="text/javascript">
	//수정
	function save() {
		$.post("OsVerInfoUpdate.do", $("#ContentsForm").serialize(),
				function(data) {

					var result = data.json.result;
					if (result == true) {
						alert("수정 되었습니다.");
						location.replace('OsVerInfoFrame.do');
					} else {
						alert("수정 실패했습니다.");
					}
				});
	}

	//삭제
	function del(osVerId, state) {
		if(state == 'N'){
		$.post("OsVerInfoDelete.do", $("#ContentsForm").serialize(),
				function(data) {
					var result = data.json.result;
					if (result == true) {
						alert("삭제 되었습니다.");
						location.replace('OsVerInfoFrame.do');
					} else {
						alert("삭제 실패했습니다.");
					}
				});
		}else {
			alert('사용중인 버전은 삭제할 수 없습니다.');
		}
	}
</script>
</head>
<body>
	<jsp:include page="../../common/menu.jsp" />
	<div id="bodyDiv">
		<div class="contentsDiv">
			<div class="contentDiv">
				<form name="ContentsForm" method="post" id="ContentsForm">
					<input type="hidden" name="osVerInfoSeq"
						value="${modifyInfo.osVerInfoSeq}">
					<table>
						<tr>
							<td width="565"><img src="images/h3_ico.gif"><span>OS버전
									정보 상세</span></td>
							<td class="td03"><a href="javascript:save();"
								onFocus="blur()"><img src="images/btn/modify7.gif"
									border="0"></a> <a href="javascript:del('${modifyInfo.osVerInfoSeq}','${modifyInfo.osVerState}');" onFocus="blur()"><img
									src="images/btn/delete7.gif" border="0"></a> <a
								href="OsVerInfoFrame.do" onFocus="blur()"><img
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
							<th class="first">OS구분</th>
							<td class="first">
							<c:forEach var="osType" items="${osTypeList}" varStatus="status">
								<input type="radio" name="osDivision" value="${osType.comCode}" <c:if test="${modifyInfo.osDivision == osType.comCode}">checked="checked"</c:if> /> ${osType.codeName}&nbsp;&nbsp; 
							</c:forEach>
							</td>
						</tr>
						<tr>
							<th>OS버전명</th>
							<td>${modifyInfo.osVerName}</td>
						</tr>
						<tr>
							<th>사용여부</th>
							<td><input type="radio" name="osVerState" value="Y"
								<c:if test="${modifyInfo.osVerState == 'Y'}">checked="checked"</c:if> />
								사용&nbsp;&nbsp; <input type="radio" name="osVerState" value="N"
								<c:if test="${modifyInfo.osVerState == 'N'}">checked="checked"</c:if> />
								미사용</td>
						</tr>
						<tr>
							<th>OS버전정보</th>
							<td><input type="text" name="osVerContent"
									title="내용" class="textbox"
									style="width: 620px;" value="${modifyInfo.osVerContent}"/>
							</td>
						</tr>
						<tr>
							<th>등록일</th>
							<td>${modifyInfo.osVerStoreDate}</td>
						</tr>
					</table>

				</form>
			</div>
		</div>
	</div>
	<jsp:include page="../../common/footer.jsp" />

</body>
</html>