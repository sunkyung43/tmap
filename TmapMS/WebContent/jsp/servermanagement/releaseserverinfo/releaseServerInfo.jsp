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
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script language="javascript">
	var ipPort = "";

	//이벤트 등록
	$(document).ready(function() {

		$("#rsSelect").change(function() {

			ipPort = $("#rsSelect").val();
		});

	});
	//타겟을 지정해주면 새창으로 뜬다.
	function setPage(menuid, page, menu, terminate) {
		ContentsForm.menu.value = menu;
		//ContentsForm.action = "http://101.79.62.58:8080/TmapRS/" + menu;
		if (ipPort == "") {
			alert("Release Server를 선택해주세요.");
			return;
		}
		ContentsForm.action = "http://" + ipPort + "/TmapRS/" + menu;
		ContentsForm.target = "contents";
		ContentsForm.submit();
	}

	function removeCache() {
		$(function() {
			$.ajaxSetup({
				contentType : "application/x-www-form-urlencoded",
				dataType : "text",
				/* success:function() {
					alert("Success");
				},
				 */
				error : function(xhr, status, error) {
					alert(error);
				}
			});
			$.post("../CacheDataRemoveCall.do", {
				cacheType : $("#cacheType").val()
			}, function(data, resultStatus) {
			});
		});
	}
</script>
</head>
<body>
	<form name="ContentsForm" method="post">
		<input type="hidden" name="menu" value="menu" />
		<jsp:include page="../../common/menu.jsp" />

		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<div id="search" style="width: 800px; height: 50px;">
						<fieldset>
							RS 선택 : <select id="rsSelect" name="">
								<option value="">= 선택 =</option>
								<c:forEach var="list" items="${rsServerList}">
									<option value="${list.systemIpOut}:${list.systemPortOut}">${list.systemName}</option>
								</c:forEach>
							</select> Cache Type :&nbsp; <select id="cacheType" style="width: 120px;">
								<option value="certtime" label="Certtime">Certtime</option>
								<option value="errorcode" label="ErrorCode">ErrorCode</option>
								<option value="rmversioncheck" label="RmVersionCheck">RmVersionCheck</option>
								<option value="securitycode" label="SecurityCode">SecurityCode</option>
								<option value="testphone" label="TestPhone">TestPhone</option>
							</select> <input type="button" value="서버요청" onclick="removeCache()"
								style="cursor: hand; color: #FF4500; width: 70;"><br>
							정보(어플리케이션, 어플버전, 맵버전)입력 >> 요청전문생성 >> 서버요청
						</fieldset>
					</div>





					<%-- <table width="100%" bgcolor="e6e6fa" height="30">
						<tr>
							<td width="200px">RS 선택 : <select id="rsSelect" name="">
									<option value="">= 선택 =</option>
									<c:forEach var="list" items="${rsServerList}">
										<option value="${list.systemIpOut}:${list.systemPortOut}">${list.systemName}</option>
									</c:forEach>
							</select>
							</td>
							<td width="400px">Cache Type :&nbsp; <select id="cacheType"
								style="width: 120px;">
									<option value="certtime" label="Certtime">Certtime</option>
									<option value="errorcode" label="ErrorCode">ErrorCode</option>
									<option value="rmversioncheck" label="RmVersionCheck">RmVersionCheck</option>
									<option value="securitycode" label="SecurityCode">SecurityCode</option>
									<option value="testphone" label="TestPhone">TestPhone</option>
							</select> <input type="button" value="서버요청" onclick="removeCache()"
								style="cursor: hand; color: #FF4500; width: 70;">
							</td>
							<td width="400px">정보(어플리케이션, 어플버전, 맵버전)입력 >> 요청전문생성 >> 서버요청</td>
						</tr>
					</table> --%>

					<table>
						<tr>
							<td valign="top" rowspan="2">
								<div style="height: 900px; width: 330px;">
									<table>
										<c:forEach var="list" items="${rsInterfaceList}">
											<tr>
												<td>
													<table>
														<tr>
															<td colspan="2">${list.rownum}.
																${list.interfaceName}</td>
														</tr>
														<tr onclick="menu_reload();" style="cursor: hand;">
															<!-- <tr onclick="setPage('menu001','IFRS_TMAP_VERSION/IFRS_TMAP_VERSION_REQUEST.jsp','IFRS_TMAP_VERSION/IFRS_TMAP_VERSION_REQUEST.do','1');" style="cursor:hand;"> -->
														<tr
															onclick="setPage('menu001','${list.interfaceProtocol}_REQUEST.jsp','${list.interfaceProtocol}_REQUEST.do','1');"
															style="cursor: hand;">
															<td width="11"></td>
															<td>${list.interfaceProtocol}</td>
														</tr>
													</table>
												</td>
											</tr>
										</c:forEach>
									</table>
								</div>
							</td>
							<td valign="top" rowspan="2">
								<div>
									<table class="srvRegi" style="width: 470px;">
										<colgroup>
											<col width="100px" />
											<col width="*" />
										</colgroup>
										<tbody>
											<tr>
												<th class="td06">상태</th>
												<td class="td06"><input type="radio"
													name="interfaceSetState" value="Y">사용 &nbsp; <input
													type="radio" name="interfaceSetState" value="N"
													checked="checked">미사용</td>
												<!-- </tr>
											<tr> -->
												<th class="td06">스킵여부</th>
												<td class="td06"><input type="radio"
													name="interfaceRmState" value="Y">사용 &nbsp; <input
													type="radio" name="interfaceRmState" value="N"
													checked="checked">미사용</td>
											</tr>
										</tbody>
									</table>
									<table class="srvRegi" style="width: 470px;">
										<colgroup>
											<col width="100px" />
											<col width="*" />
										</colgroup>
										<tbody>
											<tr>
												<th>메세지</th>
												<td><select style="width: 250px">
														<option value="">===== 메세지를 선택하세요. =====</option>
														<c:forEach var="list" items="${messageList}">
															<c:if test="${list.messageContent != ''}">
																<option value="${list.messageSeq}">${list.messageContent}</option>
															</c:if>
														</c:forEach>
												</select></td>
											</tr>
										</tbody>
									</table>





									<%-- <table width="100%" border="0" cellpadding="10" cellspacing="1"
										class="line">
										<tr>
											<td width="15%" bgcolor="#FFFFFF" class="ttl4">사용여부</td>
											<td bgcolor="#FFFFFF"><input type="radio"
												name="interfaceSetState" value="Y">사용 &nbsp; <input
												type="radio" name="interfaceSetState" value="N"
												checked="checked">미사용</td>
											<td width="15%" bgcolor="#FFFFFF" class="ttl4">스킵여부</td>
											<td bgcolor="#FFFFFF"><input type="radio"
												name="interfaceRmState" value="Y">사용 &nbsp; <input
												type="radio" name="interfaceRmState" value="N"
												checked="checked">미사용</td>
										</tr>
										<tr>
											<td bgcolor="#FFFFFF" class="ttl4">메세지</td>
											<td bgcolor="#FFFFFF" colspan="3"><select
												style="width: 90%">
													<option value="">== 메세지를 선택하세요. ==</option>
													<c:forEach var="list" items="${messageList}">
														<c:if test="${list.messageContent != ''}">
															<option value="${list.messageSeq}">${list.messageContent}</option>
														</c:if>
													</c:forEach>
											</select></td>
										</tr>
									</table> --%>
								</div>
							</td>
						</tr>
						<tr>
							<td width="65%" valign="top" bgcolor="#FFFFFF"><iframe
									marginwidth="-10" width="99%" height="350px" id="contents"
									name="contents" src="jsp/releaseserver/contents.jsp"
									scrolling="no" frameborder="0"></iframe></td>
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
							<td height="100%" valign="top" style="padding: 5 10 10 10">
								<table width="100%" height="100%" border="0" cellspacing="0"
									cellpadding="20">
									<tr>
										<td valign="top" bgcolor="#FFFFFF">
											<div id="contents" style="width: 850px">
												<table width="100%" bgcolor="e6e6fa" height="30">
													<tr>
														<td width="16%">RS 선택 : <select id="rsSelect" name="">
																<option value="">= 선택 =</option>
																<c:forEach var="list" items="${rsServerList}">
																	<option
																		value="${list.systemIpOut}:${list.systemPortOut}">${list.systemName}</option>
																</c:forEach>
														</select>
														</td>
														<td width="35%">Cache Type :&nbsp; <select
															id="cacheType" style="width: 120px;">
																<option value="certtime" label="Certtime">Certtime</option>
																<option value="errorcode" label="ErrorCode">ErrorCode</option>
																<option value="rmversioncheck" label="RmVersionCheck">RmVersionCheck</option>
																<option value="securitycode" label="SecurityCode">SecurityCode</option>
																<option value="testphone" label="TestPhone">TestPhone</option>
														</select> <input type="button" value="서버요청" onclick="removeCache()"
															style="cursor: hand; color: #FF4500; width: 70;">
														</td>
														<td align="right">정보(어플리케이션, 어플버전, 맵버전)&nbsp;입력
															&nbsp; >> &nbsp; 요청전문생성 &nbsp; >> &nbsp; 서버요청</td>
													</tr>
												</table>
												<table width="100%">
													<tr>
														<td height="5"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellpadding="10"
													cellspacing="1" class="line">
													<tr>
														<td width="35%" valign="top" bgcolor="#FFFFFF" rowspan="2">
															<div style="overflow: auto; height: 500px;">
																<table border="0" bordercolor="FFFFFF">
																	<c:forEach var="list" items="${rsInterfaceList}">
																		<tr>
																			<td>
																				<table>
																					<tr>
																						<td colspan="2">${list.rownum}.
																							${list.interfaceName}</td>
																					</tr>
																					<tr onclick="menu_reload();" style="cursor: hand;">
																						<!-- <tr onclick="setPage('menu001','IFRS_TMAP_VERSION/IFRS_TMAP_VERSION_REQUEST.jsp','IFRS_TMAP_VERSION/IFRS_TMAP_VERSION_REQUEST.do','1');" style="cursor:hand;"> -->
																					<tr
																						onclick="setPage('menu001','${list.interfaceProtocal}_REQUEST.jsp','${list.interfaceProtocal}_REQUEST.do','1');"
																						style="cursor: hand;">
																						<td width="11"></td>
																						<td>${list.interfaceProtocal}</td>
																					</tr>
																				</table>
																			</td>
																		</tr>
																	</c:forEach>
																</table>
															</div>
														</td>
														<td height="70px;" bgcolor="#FFFFFF">
															<div>
																<table width="100%" border="0" cellpadding="10"
																	cellspacing="1" class="line">
																	<tr>
																		<td width="15%" bgcolor="#FFFFFF" class="ttl4">사용여부</td>
																		<td bgcolor="#FFFFFF"><input type="radio"
																			name="interfaceSetState" value="Y">사용 &nbsp;
																			<input type="radio" name="interfaceSetState"
																			value="N" checked="checked">미사용</td>
																		<td width="15%" bgcolor="#FFFFFF" class="ttl4">스킵여부</td>
																		<td bgcolor="#FFFFFF"><input type="radio"
																			name="interfaceRmState" value="Y">사용 &nbsp; <input
																			type="radio" name="interfaceRmState" value="N"
																			checked="checked">미사용</td>
																	</tr>
																	<tr>
																		<td bgcolor="#FFFFFF" class="ttl4">메세지</td>
																		<td bgcolor="#FFFFFF" colspan="3"><select
																			style="width: 90%">
																				<option value="">== 메세지를 선택하세요. ==</option>
																				<c:forEach var="list" items="${messageList}">
																					<c:if test="${list.messageContent != ''}">
																						<option value="${list.messageSeq}">${list.messageContent}</option>
																					</c:if>
																				</c:forEach>
																		</select></td>
																	</tr>
																</table>
															</div>
														</td>
													</tr>
													<tr>
														<td width="65%" valign="top" bgcolor="#FFFFFF"><iframe
																marginwidth="-10" width="99%" height="350px"
																id="contents" name="contents"
																src="jsp/releaseserver/contents.jsp" scrolling="no"
																frameborder="0"></iframe></td>
													</tr>
												</table>
											</div>
										</td>
									</tr>
								</table>
							</td>
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
	</form>
</body>
</html>