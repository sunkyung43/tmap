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

	function save(type, srvtype) {
		$formData = '';
		if (srvtype == 'D') {
			
			$formData = $("#ContentsFormDs").serialize();
		} else {
			$formData = $("#ContentsFormCdn").serialize();
		}
		var dbType = '';
		if (type == 'I') {
			dbType = "downloadInfoInsert.do";
		} else {
			dbType = "downloadInfoUpdate.do";
		}

		if (confirm("등록/수정 하시겠습니까?")) {
			$.post(dbType, $formData, function(data) {
				if (data.json.downloadInfoResult == "success") {
					alert("등록/수정 완료 되었습니다.");
					$("#ContentsFormDs").attr("action", "downloadInfo.do");
					$("#ContentsFormDs").submit();
				} else {
					alert("등록/수정 실패 하였습니다.");
				}
			});
		}
	}
	
</script>
</head>
<body>
	<jsp:include page="../../common/menu.jsp" />
	<div id="bodyDiv">
		<div class="contentsDiv">
			<div class="contentDiv">
				<form name="ContentsFormDs" method="post" id="ContentsFormDs">
					<table>
						<tr>
							<td width="690px;">
								<img src="images/h3_ico.gif" /> &nbsp; DS URL INFO
							</td>
							<td class="btn">
								<c:choose>
									<c:when test="${empty dsInfo}">
										<a href="javascript:save('I','D');" onFocus="blur()">
											<img src="images/btn/btn_apply2.gif" border="0">
										</a>
									</c:when>
									<c:otherwise>
										<a href="javascript:save('U','D');" onFocus="blur()">
											<img src="images/btn/modify7.gif" border="0">
										</a>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</table>
					<br>
					<table class="srvRegi">
						<colgroup>
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<tr class="td06">
							<th>URL</th>
							<td>
								<input type="text" name="serverId" value="${dsInfo.serverId}" style="display: none;" />
								<input type="text" name="serverUrl" style="width: 610px" title="다운로드 주소" maxlength="150" value="${dsInfo.serverUrl}" />
							</td>
						</tr>
						<tr>
							<th class="td06">Port</th>
							<td class="td06">
								<input type="text" name="serverPort" class="textbox validate-req" style="width: 610px" title="포트" maxlength="10" value="${dsInfo.serverPort}" />
							</td>
						</tr>
						<tr>
							<th>서버타입</th>
							<td>
								<input type="text" name="serverType" class="noBorder" readonly="readonly" value="DS" />
							</td> 
						</tr>
						<tr>
							<th>상태</th>
							<td>
								<input type="radio" style="cursor: hand;" name="serverState" value="Y" checked="checked" /> 사용 &nbsp;&nbsp; 
								<input type="radio" style="cursor: hand;" name="serverState" value="N" /> 미사용
							</td>
						</tr>
						<tr>
							<th>등록일</th>
							<td>
								<Label>${dsInfo.serverSdate}</Label>
							</td>
						</tr>
						<tr>
							<th>비고</th>
							<td>
								<input type="text" name="serverContent" class="textbox" style="width: 610px;" value="${dsInfo.serverContent}" />
							</td>
						</tr>
					</table>
				</form>

				<form name="ContentsFormCdn" method="post" id="ContentsFormCdn">
					<table style="margin-top: 20;">
						<tr>
							<td width="690px;">
								<img src="images/h3_ico.gif" /> &nbsp; CDN URL INFO 
							</td>
							<td class="btn">
								<c:choose>
									<c:when test="${empty cdnInfo}">
										<a href="javascript:save('I','C');" onFocus="blur()">
											<img src="images/btn/btn_apply2.gif" border="0">
										</a>
									</c:when>
									<c:otherwise>
										<a href="javascript:save('U','C');" onFocus="blur()">
											<img src="images/btn/modify7.gif" border="0">
										</a>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</table>
					<br>
					<table class="srvRegi">
						<colgroup>
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<tr class="td06">
							<th>URL</th>
							<td>
								<input type="text" name="serverId" value="${cdnInfo.serverId}" style="display: none;" />
								<input type="text" name="serverUrl" class="textbox validate-req" style="width: 610px" title="다운로드 주소" maxlength="150" value="${cdnInfo.serverUrl}" />
							</td>
						</tr>
						<tr>
							<th class="td06">Port</th>
							<td class="td06">
								<input type="text" name="serverPort" class="textbox validate-req" style="width: 610px" title="포트" maxlength="10" value="${cdnInfo.serverPort}" />
							</td>
						</tr>
						<tr>
							<th>서버타입</th>
							<td>
								<input type="text" name="serverType" class="noBorder" readonly="readonly" value="CDN" />
							</td>
						</tr>
						<tr>
							<th>상태</th>
							<td>
								<input type="radio" style="cursor: hand;" name="serverState" value="Y" checked="checked" /> 사용&nbsp;&nbsp; 
								<input type="radio" style="cursor: hand;" name="serverState" value="N" /> 미사용</td>
						</tr>
						<tr>
							<th>등록일</th>
							<td>
								<Label>${cdnInfo.serverSdate}</Label>
							</td>
						</tr>
						<tr>
							<th>비고</th>
							<td>
								<input type="text" name="serverContent" class="textbox" style="width: 610px;" value="${cdnInfo.serverContent}" />
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	<jsp:include page="../../common/footer.jsp" />
</body>
</html>