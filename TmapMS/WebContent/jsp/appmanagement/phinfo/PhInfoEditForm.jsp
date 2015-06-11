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
		
		$.post("PhInfoUpdate.do", $("#ContentsForm").serialize(),
				function(data) {

					var result = data.json.result;
					if (result == true) {
						alert("수정 되었습니다.");
						$("#ContentsForm").attr('action', 'PhInfoEditForm.do');
						$("#ContentsForm").submit();
					} else {
						alert("수정 실패했습니다.");
					}

				});
	}

	//삭제
	function del() {

		$.post("PhInfoDelete.do", $("#ContentsForm").serialize(),
				function(data) {

					var result = data.json.result;
					if (result == true) {
						alert("삭제 되었습니다.");
						$("#ContentsForm").attr('action', 'PhInfoList.do');
						$("#ContentsForm").submit();
					} else {
						alert("삭제 실패했습니다.");
					}
				});
	}
</script>
</head>
<body>
	<form name="ContentsForm" method="post" id="ContentsForm">
		<jsp:include page="../../common/menu.jsp" />
		<input type="hidden" name="phInfoSeq" value="${modifyInfo.phInfoSeq}">
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td width="560"><img src="images/h3_ico.gif"> <span>단말 모델 상세</span></td>
							<td><a href="javascript:save();" onFocus="blur()"><img
									src="images/btn/modify7.gif" border="0"></a> <a
								href="javascript:del();" onFocus="blur()"><img
									src="images/btn/delete7.gif" border="0"></a> <a
								href="PhInfoFrame.do" onFocus="blur()"><img
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
							<th class="first">단말명</th>
							<td class="first">${modifyInfo.phName}</td>
						</tr>
						<tr>
							<th>제조사</th>
							<td>${modifyInfo.phMade}</td>
						</tr>
						<tr>
							<th>사용여부</th>
							<td><input type="radio" name="phState" value="Y"
								<c:if test="${modifyInfo.phState == 'Y'}">checked="checked"</c:if> />
								사용&nbsp;&nbsp; <input type="radio" name="phState" value="N"
								<c:if test="${modifyInfo.phState == 'N'}">checked="checked"</c:if> />
								미사용</td>
						</tr>
						<tr>
							<th>OS구분</th>
							<td>
							<c:forEach var="osType" items="${osTypeList}" varStatus="status">
								<input type="radio" name="phDivision" value="${osType.comCode}" <c:if test="${modifyInfo.phDivision == osType.comCode}">checked="checked"</c:if> /> ${osType.codeName}&nbsp;&nbsp; 
							</c:forEach>
							</td>
						</tr>
						<tr>
							<th>단말정보</th>
							<td><input type="text" name="phContent" title="내용"
									 class="textbox" style="width: 620px;" value="${modifyInfo.phContent}"/>
							</td>
						</tr>
						<tr>
							<th>등록일</th>
							<td>${modifyInfo.phStoreDate}</td>
						</tr>
					</table>


					<%-- <table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<!-- <td><font style="font-weight: bold;">&nbsp;데이터 매핑정보</font> -->
							<!-- <img src="images/title/title11.gif"> -->
							</td>
							<td width="30"></td>
						</tr>
						<tr>
							<td height="10"></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</table>

					<input type="hidden" name="phInfoSeq"
						value="${modifyInfo.phInfoSeq}">

					<div id="contents" align="center">
						<table width="385" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<!-- <td class="ttl7">[단말 정보 상세]</td> -->
								<td align="right" style="padding: 0 0 5 0"><a
									href="javascript:save();" onFocus="blur()"><img
										src="images/btn/modify7.gif" border="0"></a> <a
									href="javascript:del();" onFocus="blur()"><img
										src="images/btn/delete7.gif" border="0"></a> <a
									href="PhInfoFrame.do" onFocus="blur()"><img
										src="images/btn/btn_list.gif" border="0"></a></td>
							</tr>
						</table>
						<table width="385" border="0" cellspacing="0" cellpadding="0"
							background="images/box385_2.gif">
							<tr>
								<td><img src="images/box385_1.gif" /></td>
							</tr>
							<tr>
								<td align="center">
									<table width="99%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="60" height="30" align="center">단말명</td>
											<td width="1" bgcolor="#f3961d"></td>
											<td width="10"></td>
											<td width="*%">${modifyInfo.phName}</td>
										</tr>
										<tr>
											<td height="1" colspan="4" bgcolor="#f3961d"></td>
										</tr>
									</table>
									<table width="99%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="60" height="30" align="center">제조사</td>
											<td width="1" bgcolor="#f3961d"></td>
											<td width="10"></td>
											<td width="*%">${modifyInfo.phMade}</td>
										</tr>
										<tr>
											<td height="1" colspan="4" bgcolor="#f3961d"></td>
										</tr>
									</table>
									<table width="99%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="60" height="30" align="center">사용여부</td>
											<td width="1" bgcolor="#f3961d"></td>
											<td width="10"></td>
											<td width="*%"><input type="radio" name="phState"
												value="Y"
												<c:if test="${modifyInfo.phState == 'Y'}">checked="checked"</c:if> />
												사용&nbsp;&nbsp; <input type="radio" name="phState" value="N"
												<c:if test="${modifyInfo.phState == 'N'}">checked="checked"</c:if> />
												미사용</td>
										</tr>
										<tr>
											<td height="1" colspan="4" bgcolor="#f3961d"></td>
										</tr>
									</table>
									<table width="99%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="60" height="30" align="center">OS 구분</td>
											<td width="1" bgcolor="#f3961d"></td>
											<td width="10"></td>
											<td width="*%"><input type="radio" name="phDivision"
												value="IO"
												<c:if test="${modifyInfo.phDivision == 'Y'}">checked="checked"</c:if> />
												IOS&nbsp;&nbsp; <input type="radio" name="phDivision"
												value="AN"
												<c:if test="${modifyInfo.phDivision == 'N'}">checked="checked"</c:if> />
												Android</td>
										</tr>
										<tr>
											<td height="1" colspan="4" bgcolor="#f3961d"></td>
										</tr>
									</table>
									<table width="99%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="60" height="30" align="center">단말정보</td>
											<td width="1" bgcolor="#f3961d"></td>
											<td width="10"></td>
											<td width="*%" style="padding: 5 0 5 0"><textarea
													name="phContent" rows="5" cols="40" title="내용" rows="5"
													class="textbox" style="width: 95%; height: 40">${modifyInfo.phContent}</textarea>
											</td>
										</tr>
										<tr>
											<td height="1" colspan="4" bgcolor="#f3961d"></td>
										</tr>
									</table>
									<table width="99%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="60" height="30" align="center">등록일</td>
											<td width="1" bgcolor="#f3961d"></td>
											<td width="10"></td>
											<td width="*%" style="padding: 5 0 5 0">${modifyInfo.phStoreDate}</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td><img src="images/box385_3.gif" width="100%" /></td>
							</tr>
						</table> 
					</div>--%>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />



		<%-- <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0"> 
  <tr>
    <td height="100%"><table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="100%" valign="top" class="contents">
        <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="20">
            <tr>
              <td valign="top" bgcolor="#FFFFFF">
              
              <div id="contents" style="width: 850px">
              <table border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td><font style="font-weight: bold;">&nbsp;데이터 매핑정보</font>
                    <!-- <img src="images/title/title11.gif"> --></td>
                    <td width="30"></td>
                  </tr>
                  <tr>
                    <td height="10"></td>
                    <td></td>
                    <td></td>
                    <td></td>
                  </tr>
                </table>
	<form name="ContentsForm" method="post" id="ContentsForm">
		<input type="hidden" name="phInfoSeq" value="${modifyInfo.phInfoSeq}">

		<div id="contents" align="center">
			<table width="385" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="ttl7">[단말 정보 상세]</td>
					<td align="right" style="padding: 0 0 5 0"><a
						href="javascript:save();" onFocus="blur()"><img
							src="images/btn/modify7.gif" border="0"></a> <a
						href="javascript:del();" onFocus="blur()"><img
							src="images/btn/delete7.gif" border="0"></a> <a
						href="PhInfoFrame.do" onFocus="blur()"><img
							src="images/btn/btn_list.gif" border="0"></a></td>
				</tr>
			</table>
			<table width="385" border="0" cellspacing="0" cellpadding="0"
				background="images/box385_2.gif">
				<tr>
					<td><img src="images/box385_1.gif" /></td>
				</tr>
				<tr>
					<td align="center">
						<table width="99%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="60" height="30" align="center">단말명</td>
								<td width="1" bgcolor="#f3961d"></td>
								<td width="10"></td>
								<td width="*%">${modifyInfo.phName}</td>
							</tr>
							<tr>
								<td height="1" colspan="4" bgcolor="#f3961d"></td>
							</tr>
						</table>
						<table width="99%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="60" height="30" align="center">제조사</td>
								<td width="1" bgcolor="#f3961d"></td>
								<td width="10"></td>
								<td width="*%">${modifyInfo.phMade}</td>
							</tr>
							<tr>
								<td height="1" colspan="4" bgcolor="#f3961d"></td>
							</tr>
						</table>
						<table width="99%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="60" height="30" align="center">사용여부</td>
								<td width="1" bgcolor="#f3961d"></td>
								<td width="10"></td>
								<td width="*%"><input type="radio" name="phState" value="Y"
									<c:if test="${modifyInfo.phState == 'Y'}">checked="checked"</c:if> />
									사용&nbsp;&nbsp; <input type="radio" name="phState" value="N"
									<c:if test="${modifyInfo.phState == 'N'}">checked="checked"</c:if> />
									미사용</td>
							</tr>
							<tr>
								<td height="1" colspan="4" bgcolor="#f3961d"></td>
							</tr>
						</table>
						<table width="99%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="60" height="30" align="center">OS 구분</td>
								<td width="1" bgcolor="#f3961d"></td>
								<td width="10"></td>
									<td width="*%"><input type="radio" name="phDivision" value="IO"
									<c:if test="${modifyInfo.phDivision == 'Y'}">checked="checked"</c:if> />
									IOS&nbsp;&nbsp; <input type="radio" name="phDivision" value="AN"
									<c:if test="${modifyInfo.phDivision == 'N'}">checked="checked"</c:if> />
									Android</td>
							</tr>
							<tr>
								<td height="1" colspan="4" bgcolor="#f3961d"></td>
							</tr>
						</table>
						<table width="99%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="60" height="30" align="center">단말정보</td>
								<td width="1" bgcolor="#f3961d"></td>
								<td width="10"></td>
								<td width="*%" style="padding: 5 0 5 0"><textarea
										name="phContent" rows="5" cols="40" title="내용" rows="5"
										class="textbox" style="width: 95%; height: 40">${modifyInfo.phContent}</textarea>
								</td>
							</tr>
							<tr>
								<td height="1" colspan="4" bgcolor="#f3961d"></td>
							</tr>
						</table>
						<table width="99%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="60" height="30" align="center">등록일</td>
								<td width="1" bgcolor="#f3961d"></td>
								<td width="10"></td>
								<td width="*%" style="padding: 5 0 5 0">${modifyInfo.phStoreDate}</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td><img src="images/box385_3.gif" width="100%" /></td>
				</tr>
			</table>
		</div>

	</form>
                   <br><br>
                    <div id="divPageing" class="paging"></div>
              </div>
              </td>
            </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table> --%>
	</form>
</body>
</html>