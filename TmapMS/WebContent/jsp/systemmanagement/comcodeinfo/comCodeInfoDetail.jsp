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
<script>
	function modify() {
		$("#ContentsForm").attr('action', 'comCodeInfoEditForm.do');
		$("#ContentsForm").submit();
	}
	function save() {

		if (!validate(ContentsForm))
			return;

		ContentsForm.action = "comCodeInfoNewCommitAction.action";
		ContentsForm.submit();
	}

	function delComCode(comCode) {
		if (confirm("삭제하시겠습니까?")) {
			ContentsForm.action = "comCodeInfoDelete2Action.action";
			ContentsForm.delCOMCODE.value = comCode;
			ContentsForm.submit();
		}
	}

	function addcode() {
		ContentsForm.action = "comCodeInfoNew2Form.do";
		ContentsForm.upComCode.value = ContentsForm.comCode.value;
		ContentsForm.comCode.value = "";
		ContentsForm.submit();
	}

	function exeChangeUseState(comCode, state, index) {

		$("#sComCode").val(comCode);
		$("#useState").val(state);
		$("#codeName").val($("#codeName_"+index).val());
		$("#CodeRemark").val($("#CodeRemark_"+index).val());
		
		//호출 및 메시지 출력
		$.post("comCodeInfoUseState.do", $("#ContentsForm").serialize(),
				function(data) {

					if (data.json.check == "success") {
						alert("변경 되었습니다.");
						$("#ContentsForm").attr('action',
								'comCodeInfoDetail.do');
						$("#ContentsForm").submit();
					} else {
						alert("변경실패");
					}

				});
	}
</script>
</head>
<body>
	<form name="ContentsForm" method="post" id="ContentsForm">
		<input type="hidden" name="comCode" value="${comCodeInfoDetail.comCode}"> 
		<input type="hidden" name="upComCode" value=""> 
		<input type="hidden" id="useState" name="useState" value=""> 
		<input type="hidden" id="sComCode" name="sComCode" value="">
		<input type="hidden" id="codeName" name="codeName" value=""> 
		<input type="hidden" id="CodeRemark" name="CodeRemark" value="">

		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td width="500"><img src="images/h3_ico.gif"><span>공통코드 상세</span></td>
							<td class="btn"><a href="comCodeInfoList.do"
								onFocus="blur()"><img src="images/btn/btn_list.gif"
									border="0"></a>&nbsp; <a href="javascript:addcode();"
								onFocus="blur()"><img src="images/btn/comcode1.gif"
									border="0"></a>&nbsp; <a href="javascript:modify();"
								onFocus="blur()"><img src="images/btn/modify7.gif"
									border="0"></a></td>
						</tr>
					</table>
					<br>
					<table class="sub_0601_table">
						<colgroup>
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>코드</th>
								<th>코드명</th>
								<th>코드설명</th>
								<th>상태</th>
							</tr>
							<tr>
								<td class="td03">${comCodeInfoDetail.comCode}</td>
								<td class="td03">${comCodeInfoDetail.codeName}</td>
								<td class="td03">${comCodeInfoDetail.codeRemark}</td>
								<td class="td03"><c:if
										test="${comCodeInfoDetail.useState == 'Y'}">사용</c:if> <c:if
										test="${comCodeInfoDetail.useState == 'N'}">미사용</c:if></td>
							</tr>
						</tbody>
					</table>
					<table class="sub_0601_table">
						<colgroup>
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>코드</th>
								<th>코드명</th>
								<th>코드설명</th>
								<th>상태</th>
							</tr>
							<c:choose>
								<c:when test="${empty comCodeDetail}">
									<tr align="center">
										<td colspan="4" height="100" align="center">등록된 소분류코드가
											없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="comCodeDetail" items="${comCodeDetail}" varStatus="status">
										<tr>
											<td class="td03">${comCodeDetail.comCode}</td>
											<td class="td03">
												<input type="text" id="codeName_${status.index}" value="${comCodeDetail.codeName}"/>
											</td>
											<td class="td03">
												<input type="text" id="CodeRemark_${status.index}" value="${comCodeDetail.codeRemark}"/>
											</td>
											<td class="td03"><input type="radio" value="Y"
												onclick="javascript:exeChangeUseState('${comCodeDetail.comCode}','Y','${status.index}');"
												<c:if test="${comCodeDetail.useState == 'Y'}">checked="checked"</c:if> />
												사용 <input type="radio" value="N"
												onclick="javascript:exeChangeUseState('${comCodeDetail.comCode}','N','${status.index}');"
												<c:if test="${comCodeDetail.useState == 'N'}">checked="checked"</c:if> />
												미사용</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />
	</form>
</body>
</html>