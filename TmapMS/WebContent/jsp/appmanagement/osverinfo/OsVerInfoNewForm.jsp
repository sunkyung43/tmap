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
	function save() {

		$.post("OsVerInfoInsert.do", $("#ContentsForm").serialize(),
				function(data) {
					var result = data.json.result;
					if (result == true) {
						alert("등록 되었습니다.");
						location.replace('OsVerInfoFrame.do');
					} else {
						alert("등록 실패했습니다.");
					}
				});
	}
</script>
</head>
<body>
	<jsp:include page="../../common/menu.jsp" />
	<div id="bodyDiv">
		<div class="contentsDiv">
			<div class="contentDiv">
				<form name="ContentsForm" method="post" id="ContentsForm">
					<table>
						<tr>
							<td width="590"><img src="images/h3_ico.gif"><span>OS 버전 정보 등록</span></td>
							<td><a href="javascript:save();" onFocus="blur()"><img
									src="images/btn/btn_apply2.gif" border="0"></a> <a
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
							<th class="first">OS 구분</th>
							<td class="first">
								
								<c:forEach var="osType" items="${osTypeList}" varStatus="status">
									<input type="radio" name="osDivision" value="${osType.comCode}" <c:if test="${status.index == 0}">checked="checked"</c:if>  /> ${osType.codeName}&nbsp;&nbsp; 
								</c:forEach>
					
							</td>
						</tr>
						<tr>
							<th >OS버전명</th>
							<td class="td03"><input type="text" name="osVerName"
								size="50" title="OS버전명" maxlength="100"
								class="textbox validate-req"
								style="width: 590px; ime-mode: disabled;"> &nbsp; <label
										style="color: red;">*</Label></td>
						</tr>
						<tr>
							<th>사용여부</th>
							<td class="td03"><input type="radio" name="osVerState"
								value="Y" /> 사용&nbsp;&nbsp; <input type="radio"
								name="osVerState" value="N" checked="checked" /> 미사용</td>
						</tr>
						<tr>
							<th>OS 버전정보</th>
							<td class="td03"><input type="text" name="osVerContent" title="내용" class="textbox"
									style="width: 590px;"/> &nbsp; <label
										style="color: red;">*</Label></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	<jsp:include page="../../common/footer.jsp" />

</body>
</html>