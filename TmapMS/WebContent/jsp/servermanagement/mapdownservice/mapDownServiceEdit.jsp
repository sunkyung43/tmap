<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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

	function initLoad() {
		//eval(layerview + '["pageLoading"]' + styleview + 'display="none"');
	}

	function executeModify(systemId) {

		$("#systemId").val(systemId);

		if (!validate()) {
			return;
		}

		if (confirm("수정하시겠습니까?")) {

			pageLoading();

			$.post("mapDownServiceUpdate.do", $("#ContentsForm").serialize(),
					function(data) {

						if (data.json.mapDownServiceUpdate == "success") {
							alert("수정완료 되었습니다.");
						} else {
							alert("수정실패 하였습니다.");
						}
						$("#systemId").val(data.json.systemId);
						$("#ContentsForm").attr('action', 'mapDownServiceEdit.do');
						$("#ContentsForm").submit();
					});
		}
	}
	
</script>
</head>
<body onload="javascript:initLoad();">
	<form:form commandName="ContentsForm" id="ContentsForm" name="ContentsForm">
		<form:hidden path="systemId" />
		<form:hidden path="serverTypeName" />
		<input type="hidden" name="mapdownManageId" value="${mapdownManageInfo.mapdownManageId}" />
		<input type="hidden" name="oldServerTypeName" value="${serverTypeName}" />
		<jsp:include page="../../common/menu.jsp" />

		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td>
								<img src="images/h3_ico.gif"><span>서버기기정보 수정</span>
							</td>
							<td width="10"></td>
							<td>
								<a href="javascript:executeModify('${systemId}');" onFocus="blur()">
									<img src="images/btn/modify7.gif" border="0">
								</a>&nbsp; 
								<a href="mapDownServiceList.do" onFocus="blur()">
									<img src="images/btn/btn_list.gif" border="0">
								</a>
							</td>
						</tr>
					</table>
					<%-- <table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td style="font-size: 13;"><b></b></td>
							<td class="btn"><a
								href="javascript:executeModify('${systemId}');" onFocus="blur()"><img
									src="images/btn/modify7.gif" border="0"></a>&nbsp; <a
								href="mapDownServiceList.do" onFocus="blur()"><img
									src="images/btn/btn_list.gif" border="0"></a></td>
						</tr>
					</table> --%>
					<table width="100%" border="0" cellpadding="10" cellspacing="1" bgcolor="#FF8200">
						<tr>
							<td width="404" valign="top" bgcolor="#FFFFFF" style="padding-bottom: 30" colspan="2">
								<table border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="404" valign="top" bgcolor="#FFFFFF">
											<table width="404" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td height="7"></td>
												</tr>
												<tr>
													<td class="ttl7">[통식방식]</td>
												</tr>
												<tr>
													<td height="6"></td>
												</tr>
											</table>
											<table width="380" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="3">
														<img src="images/ttl_bar1.gif">
													</td>
													<td background="images/ttl_bar2.gif" class="ttl">통식방식명</td>
													<td width="1" background="images/ttl_bar2.gif">
														<img src="images/ttl_line.gif">
													</td>
													<td width="100" background="images/ttl_bar2.gif" class="ttl">동시접속자수</td>
													<td width="3">
														<img src="images/ttl_bar3.gif">
													</td>
												</tr>
											</table>
											<div style="overflow: auto; height: 150px;">
												<table width="380" border="0" cellspacing="0" cellpadding="0">
													<c:forEach var="list" items="${comSetInfo}"
														varStatus="state">
														<tr>
															<td width="3"></td>
															<td class="ttl4">${list.comTypeName}</td>
															<td width="1"></td>
															<td width="100" height="30" class="ttl4">
																<input type="text" id="comSetCnt${list.comTypeId}" name="comSetCnts" class="textbox validate-req" style="width: 70%" title="동시접속자수" value="${list.comSetCnt}" /> 
																<input type="hidden" name="comTypeIds" value="${list.comTypeId}">
															</td>
															<td width="3"></td>
														</tr>
														<tr>
															<td height="1" colspan="9" bgcolor="#f3961d"></td>
														</tr>
													</c:forEach>
												</table>
											</div>
										</td>
										<td width="404" valign="top" bgcolor="#FFFFFF">
											<table width="404" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td height="7"></td>
												</tr>
												<tr>
													<td class="ttl7">[서비스운영 정보]</td>
												</tr>
												<tr>
													<td height="6"></td>
												</tr>
											</table>
											<table width="404" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td><img src="images/box404_1.png"></td>
												</tr>
												<tr>
													<td align="center" background="images/box404_2.png">
														<table width="404" border="0" cellspacing="0" cellpadding="0">
															<tr align="center">
																<td width="150" height="40" class="ttl4" style="font-weight: bold;">세션 유지 시간(초)</td>
																<td width="2" bgcolor="#f3961d"></td>
																<td width="3"></td>
																<td width="200" height="45" class="ttl4">
																	<input type="text" name="sessionMaxIdletime" id="sessionMaxIdletime" class="textbox validate-req" style="width: 95%" title="세션 유지 시간" value="${mapManageInfo.sessionMaxIdletime}" />
																</td>
																<td>초</td>
															</tr>
															<tr>
																<td height="1" colspan="10" bgcolor="#f3961d"></td>
															</tr>
														</table>
														<table width="404" border="0" cellspacing="0" cellpadding="0">
															<tr align="center">
																<td width="150" height="40" class="ttl4" style="font-weight: bold;">세션별 최대 대역폭</td>
																<td width="2" bgcolor="#f3961d"></td>
																<td width="3"></td>
																<td width="200" height="45" class="ttl4">
																	<input type="text" name="sessionMaxBandwidth" id="sessionMaxBandwidth" class="textbox validate-req" style="width: 95%" title="세션별 최대 대역폭" value="${mapManageInfo.sessionMaxBandwidth}" />
																</td>
																<td>Mbps</td>
															</tr>
															<tr>
																<td height="1" colspan="10" bgcolor="#f3961d"></td>
															</tr>
														</table>
														<table width="404" border="0" cellspacing="0" cellpadding="0">
															<tr align="center">
																<td width="150" height="40" class="ttl4" style="font-weight: bold;">전체 대역폭</td>
																<td width="2" bgcolor="#f3961d"></td>
																<td width="3"></td>
																<td width="200" height="45" class="ttl4">
																	<input type="text" name="totalMaxBandwidth" id="totalMaxBandwidth" class="textbox validate-req" style="width: 95%" title="전체 대역폭" value="${mapManageInfo.totalMaxBandwidth}" />
																</td>
																<td>Mbps</td>
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td><img src="images/box404_3.png"></td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />


		<%-- <table width="100%" height="100%" border="0" cellspacing="0"
			cellpadding="0">

			<tr>
				<td height="100%">
					<table width="100%" height="100%" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td width="10" background="images/bg_bar.gif"></td>
							<td height="100%" valign="top" class="contents">
								<table width="100%" height="100%" border="0" cellspacing="0"
									cellpadding="20">
									<tr>
										<td valign="top" bgcolor="#FFFFFF">
											<div id="contents" style="width: 850px">
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td><img src="images/title/title44.gif"></td>
														<td width="30"></td>
													</tr>
													<tr>
														<td height="10"></td>
														<td></td>
														<td></td>
														<td></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td style="font-size: 13;"><b></b></td>
														<td class="btn"><a
															href="javascript:executeModify('${systemId}');"
															onFocus="blur()"><img src="images/btn/modify7.gif"
																border="0"></a>&nbsp; <a href="mapDownServiceList.do"
															onFocus="blur()"><img src="images/btn/btn_list.gif"
																border="0"></a></td>
													</tr>
												</table>
												<table width="100%" border="0" cellpadding="10"
													cellspacing="1" bgcolor="#FF8200">
													<tr>
														<td width="404" valign="top" bgcolor="#FFFFFF"
															style="padding-bottom: 30" colspan="2">
															<table border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="404" valign="top" bgcolor="#FFFFFF">
																		<table width="404" border="0" cellspacing="0"
																			cellpadding="0">
																			<tr>
																				<td height="7"></td>
																			</tr>
																			<tr>
																				<td class="ttl7">[통식방식]</td>
																			</tr>
																			<tr>
																				<td height="6"></td>
																			</tr>
																		</table>
																		<table width="380" border="0" cellspacing="0"
																			cellpadding="0">
																			<tr>
																				<td width="3"><img src="images/ttl_bar1.gif"></td>
																				<td background="images/ttl_bar2.gif" class="ttl">통식방식명</td>
																				<td width="1" background="images/ttl_bar2.gif"><img
																					src="images/ttl_line.gif"></td>
																				<td width="100" background="images/ttl_bar2.gif"
																					class="ttl">동시접속자수</td>
																				<td width="3"><img src="images/ttl_bar3.gif"></td>
																			</tr>
																		</table>
																		<div style="overflow: auto; height: 150px;">
																			<table width="380" border="0" cellspacing="0"
																				cellpadding="0">
																				<c:forEach var="list" items="${comSetInfo}"
																					varStatus="state">
																					<tr>
																						<td width="3"></td>
																						<td class="ttl4">${list.comTypeName}</td>
																						<td width="1"></td>
																						<td width="100" height="30" class="ttl4"><input
																							type="text" id="comSetCnt${list.comTypeId}"
																							name="comSetCnts" class="textbox validate-req"
																							style="width: 70%" title="동시접속자수"
																							value="${list.comSetCnt}" /> <input type="hidden"
																							name="comTypeIds" value="${list.comTypeId}">
																						</td>
																						<td width="3"></td>
																					</tr>
																					<tr>
																						<td height="1" colspan="9" bgcolor="#f3961d"></td>
																					</tr>
																				</c:forEach>
																			</table>
																		</div>
																	</td>
																	<td width="404" valign="top" bgcolor="#FFFFFF">
																		<table width="404" border="0" cellspacing="0"
																			cellpadding="0">
																			<tr>
																				<td height="7"></td>
																			</tr>
																			<tr>
																				<td class="ttl7">[서비스운영 정보]</td>
																			</tr>
																			<tr>
																				<td height="6"></td>
																			</tr>
																		</table>
																		<table width="404" border="0" cellspacing="0"
																			cellpadding="0">
																			<tr>
																				<td><img src="images/box404_1.png"></td>
																			</tr>
																			<tr>
																				<td align="center" background="images/box404_2.png">
																					<table width="404" border="0" cellspacing="0"
																						cellpadding="0">
																						<tr align="center">
																							<td width="150" height="40" class="ttl4"
																								style="font-weight: bold;">세션 유지 시간(초)</td>
																							<td width="2" bgcolor="#f3961d"></td>
																							<td width="3"></td>
																							<td width="200" height="45" class="ttl4"><input
																								type="text" name="sessionMaxIdletime"
																								id="sessionMaxIdletime"
																								class="textbox validate-req" style="width: 95%"
																								title="세션 유지 시간"
																								value="${mapManageInfo.sessionMaxIdletime}" /></td>
																							<td>초</td>
																						</tr>
																						<tr>
																							<td height="1" colspan="10" bgcolor="#f3961d"></td>
																						</tr>
																					</table>
																					<table width="404" border="0" cellspacing="0"
																						cellpadding="0">
																						<tr align="center">
																							<td width="150" height="40" class="ttl4"
																								style="font-weight: bold;">세션별 최대 대역폭</td>
																							<td width="2" bgcolor="#f3961d"></td>
																							<td width="3"></td>
																							<td width="200" height="45" class="ttl4"><input
																								type="text" name="sessionMaxBandwidth"
																								id="sessionMaxBandwidth"
																								class="textbox validate-req" style="width: 95%"
																								title="세션별 최대 대역폭"
																								value="${mapManageInfo.sessionMaxBandwidth}" />
																							</td>
																							<td>Mbps</td>
																						</tr>
																						<tr>
																							<td height="1" colspan="10" bgcolor="#f3961d"></td>
																						</tr>
																					</table>
																					<table width="404" border="0" cellspacing="0"
																						cellpadding="0">
																						<tr align="center">
																							<td width="150" height="40" class="ttl4"
																								style="font-weight: bold;">전체 대역폭</td>
																							<td width="2" bgcolor="#f3961d"></td>
																							<td width="3"></td>
																							<td width="200" height="45" class="ttl4"><input
																								type="text" name="totalMaxBandwidth"
																								id="totalMaxBandwidth"
																								class="textbox validate-req" style="width: 95%"
																								title="전체 대역폭"
																								value="${mapManageInfo.totalMaxBandwidth}" /></td>
																							<td>Mbps</td>
																						</tr>
																					</table>
																				</td>
																			</tr>
																			<tr>
																				<td><img src="images/box404_3.png"></td>
																			</tr>
																		</table>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</div>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td width="10" background="images/bg_bar.gif"></td>
						</tr>
						<tr></tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="10">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="10"><img src="images/bottom_bg1.gif"></td>
							<td width="100%" background="images/bottom_bg2.gif"></td>
							<td width="10"><img src="images/bottom_bg3.gif"></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td><jsp:include page="../../common/footer.jsp" /></td>
			</tr>
		</table> --%>
	</form:form>
</body>
</html>