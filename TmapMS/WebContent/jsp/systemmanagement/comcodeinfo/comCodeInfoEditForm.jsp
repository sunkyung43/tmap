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
<script>
	
	//수정
	function save() {
	
		if(!validate()){
	        return;
	    }
		
		if( confirm("수정하시겠습니까?")){
			ContentsForm.action="comCodeInfoUpdate.do";
			ContentsForm.submit();
		}
	}
	
	//삭제
	function del(state) {
		if(state == 'N'){
		if( confirm("삭제하시겠습니까?")){
			ContentsForm.action="comCodeInfoDelete.do";
			ContentsForm.submit();
		}
		}else{
			alert('사용중인 코드는 삭제할 수없습니다.');
		}
	}
	
</script>
</head>
<body>
	<form name="ContentsForm" method="post" id="ContentsForm">
		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td width="530px;"><img src="images/h3_ico.gif"><span>공통코드관리 수정</span></td>
							<td class="btn"><a href="javascript:save();"
								onFocus="blur()"><img src="images/btn/btn_apply6.gif"
									border="0"></a> <a href="javascript:del('${comCodeInfoDetail.useState}');" onFocus="blur()"><img
									src="images/btn/delete7.gif" border="0"></a> <a
								href="comCodeInfoList.do" onFocus="blur()"><img
									src="images/btn/btn_list.gif" border="0"></a></td>
						</tr>
					</table>
					<table class="srvRegi">
						<colgroup>
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<tr>
							<th class="first">코드</th>
							<td class="first"><input type="text" name="comCode" id="comCode" value="${comCodeInfoDetail.comCode}"
								class="textbox" style="width: 550px" title="코드" maxlength="10" />
								<a id="anchIdDup"><img src="images/btn/checkid.gif"
									align="absmiddle" style="cursor: hand"></a></td>
						</tr>
						<tr>
							<th>코드명</th>
							<td><input type="text" name="codeName" value="${comCodeInfoDetail.codeName}"
								class="textbox validate-req" style="width: 620px" title="코드명"
								maxlength="20" /></td>
						</tr>
						<tr>
							<th>코드설명</th>
							<td><input type="text" name="codeRemark" class="textbox" value="${comCodeInfoDetail.codeRemark}"
								style="width: 620px" title="코드설명" maxlength="100" /></td>
						</tr>
						<tr>
							<th>사용여부</th>
							<td>
							<input type="radio" name="useState" value="Y"
											<c:if test="${comCodeInfoDetail.useState == 'Y'}">checked="checked"</c:if> />
											사용 &nbsp;&nbsp; <input type="radio" name="useState" value="N"
											<c:if test="${comCodeInfoDetail.useState == 'N'}">checked="checked"</c:if> />
											미사용</td>
						</tr>
					</table>
					<%-- <table width="750" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="btn"><a href="javascript:save();"
								onFocus="blur()"><img src="images/btn/btn_apply6.gif"
									border="0"></a> <a href="javascript:del();" onFocus="blur()"><img
									src="images/btn/delete7.gif" border="0"></a> <a
								href="comCodeInfoList.do" onFocus="blur()"><img
									src="images/btn/btn_list.gif" border="0"></a></td>
						</tr>
					</table>
					<table width="750" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td><img src="images/box1.gif"></td>
						</tr>
						<tr>
							<td align="center" background="images/box2.gif"><table
									width="748" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="130" class="ttl4">코드</td>
										<td width="1" bgcolor="#f3961d"></td>
										<td width="10"></td>
										<td><input type="text" name="comCode"
											value="${comCodeInfoDetail.comCode}" class="invisible"
											style="width: 600px" title="코드" maxbyte="10"
											readonly="readonly" /></td>
									</tr>
									<tr>
										<td height="1" colspan="4" bgcolor="#f3961d"></td>
									</tr>
								</table>
								<table width="748" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="130" class="ttl4">코드명</td>
										<td width="1" bgcolor="#f3961d"></td>
										<td width="10"></td>
										<td><input type="text" name="codeName"
											value="${comCodeInfoDetail.codeName}" class="textbox"
											style="width: 600px" title="코드명" maxbyte="20" /></td>
									</tr>
									<tr>
										<td height="1" colspan="4" bgcolor="#f3961d"></td>
									</tr>
								</table>
								<table width="748" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="130" class="ttl4">코드설명</td>
										<td width="1" bgcolor="#f3961d"></td>
										<td width="10"></td>
										<td><input type="text" name="codeRemark"
											value="${comCodeInfoDetail.codeRemark}" class="textbox"
											style="width: 600px" title="코드설명" maxbyte="100" /></td>
									</tr>
									<tr>
										<td height="1" colspan="4" bgcolor="#f3961d"></td>
									</tr>
								</table>
								<table width="748" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="130" class="ttl4">사용여부</td>
										<td width="1" bgcolor="#f3961d"></td>
										<td width="10"></td>
										<td><select name="useState" class="textbox"
											style="width: 100px;">
												<option value="Y"
													<c:if test="${comCodeInfoDetail.useState == 'Y'}"> selected</c:if>>사용</option>
												<option value="N"
													<c:if test="${comCodeInfoDetail.useState == 'N'}"> selected</c:if>>미사용</option>
										</select></td>
									</tr>
									<tr>
										<td height="1" colspan="4" bgcolor="#f3961d"></td>
									</tr>
								</table></td>
						</tr>
						<tr>
							<td><img src="images/box3.gif"></td>
						</tr>
					</table> --%>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />

		<%-- <table width="100%" height="100%" border="0" cellspacing="0"
			cellpadding="0">
			<tr>
				<td height="70" align="center" background="images/top_bg.gif">
					<jsp:include page="../../common/header2.jsp" />
				</td>
			</tr>
			<tr>
				<td height="5" background="images/top_bg2.gif"></td>
			</tr>
			<tr>
				<td height="35"><table width="100%" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td width="10"><img src="images/top_bg31.gif"></td>
							<td align="left" background="images/top_bg3.gif"
								style="padding: 0 0 7 0"><jsp:include
									page="../../common/date.jsp" /></td>
							<td width="10"><img src="images/top_bg31.gif"></td>
						</tr>
					</table></td>
			</tr>
			<tr>
				<td height="100%"><table width="100%" height="100%" border="0"
						cellspacing="0" cellpadding="0">
						<tr>
							<td width="10" background="images/bg_bar.gif"></td>
							<td height="100%" valign="top" class="contents"><table
									width="100%" height="100%" border="0" cellspacing="0"
									cellpadding="20">
									<tr>
										<td valign="top" bgcolor="#FFFFFF">

											<div id="contents" style="width: 850px">
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td><img src="images/title/title518.gif"></td>
														<td width="30"></td>
													</tr>
													<tr>
														<td height="10"></td>
														<td></td>
														<td></td>
														<td></td>
													</tr>
												</table>
												<table width="750" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td class="btn"><a href="javascript:save();"
															onFocus="blur()"><img src="images/btn/btn_apply6.gif"
																border="0"></a> <a href="javascript:del();"
															onFocus="blur()"><img src="images/btn/delete7.gif"
																border="0"></a> <a href="comCodeInfoList.do"
															onFocus="blur()"><img src="images/btn/btn_list.gif"
																border="0"></a></td>
													</tr>
												</table>
												<table width="750" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td><img src="images/box1.gif"></td>
													</tr>
													<tr>
														<td align="center" background="images/box2.gif"><table
																width="748" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="130" class="ttl4">코드</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="10"></td>
																	<td><input type="text" name="comCode"
																		value="${comCodeInfoDetail.comCode}" class="invisible"
																		style="width: 600px" title="코드" maxbyte="10"
																		readonly="readonly" /></td>
																</tr>
																<tr>
																	<td height="1" colspan="4" bgcolor="#f3961d"></td>
																</tr>
															</table>
															<table width="748" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="130" class="ttl4">코드명</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="10"></td>
																	<td><input type="text" name="codeName"
																		value="${comCodeInfoDetail.codeName}" class="textbox"
																		style="width: 600px" title="코드명" maxbyte="20" /></td>
																</tr>
																<tr>
																	<td height="1" colspan="4" bgcolor="#f3961d"></td>
																</tr>
															</table>
															<table width="748" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="130" class="ttl4">코드설명</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="10"></td>
																	<td><input type="text" name="codeRemark"
																		value="${comCodeInfoDetail.codeRemark}"
																		class="textbox" style="width: 600px" title="코드설명"
																		maxbyte="100" /></td>
																</tr>
																<tr>
																	<td height="1" colspan="4" bgcolor="#f3961d"></td>
																</tr>
															</table>
															<table width="748" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="130" class="ttl4">사용여부</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="10"></td>
																	<td><select name="useState" class="textbox"
																		style="width: 100px;">
																			<option value="Y"
																				<c:if test="${comCodeInfoDetail.useState == 'Y'}"> selected</c:if>>사용</option>
																			<option value="N"
																				<c:if test="${comCodeInfoDetail.useState == 'N'}"> selected</c:if>>미사용</option>
																	</select></td>
																</tr>
																<tr>
																	<td height="1" colspan="4" bgcolor="#f3961d"></td>
																</tr>
															</table></td>
													</tr>
													<tr>
														<td><img src="images/box3.gif"></td>
													</tr>
												</table>
											</div>
										</td>
									</tr>
								</table></td>
							<td width="10" background="images/bg_bar.gif"></td>
						</tr>
						<tr></tr>
					</table></td>
			</tr>
			<tr>
				<td height="10"><table width="100%" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td width="10"><img src="images/bottom_bg1.gif"></td>
							<td width="100%" background="images/bottom_bg2.gif"></td>
							<td width="10"><img src="images/bottom_bg3.gif"></td>
						</tr>
					</table></td>
			</tr>
			<tr>
				<td><jsp:include page="../../common/footer.jsp" /></td>
			</tr>
		</table> --%>
	</form>
</body>
</html>