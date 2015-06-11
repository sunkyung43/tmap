<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<link rel="stylesheet" href="/resources/demos/style.css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript">
	$(function() {
		var activeId = $("#activeId").val();
		$("#tabs").tabs({
			active : activeId
		});
		$("#tabs1").tabs();
	});

	function executeRe(systemId, index) {
		$("#systemId").val(systemId);
		$("#activeId").val(index);
		$("#ContentsForm").attr('action', 'mapDownServiceList.do');
		$("#ContentsForm").attr('target', '_parent');
		$("#ContentsForm").submit();
	}

	function executeDsDetail(systemId) {

		$("#systemId").val(systemId);
		$("#ContentsForm").attr('action', 'mapDownServiceEdit.do');
		$("#ContentsForm").attr('target', '_parent');
		$("#ContentsForm").submit();
	}

	function executeConnectDetail(systemId, index) {
		$("#systemId").val(systemId);
		$("#activeId").val(index);
		$("#ContentsForm").attr('action', 'mapDownServiceList.do');
		$("#ContentsForm").submit();
	}
</script>
</head>
<body>
	<form:form commandName="ContentsForm">
		<form:hidden path="systemId" />
		<input type="hidden" name="activeId" id="activeId" value="${activeId}" />
		<jsp:include page="../../common/menu.jsp" />

		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<img src="images/h3_ico.gif"> <span>서비스운영 정보</span><br></br>
					<div id="tabs">
						<ul>
							<c:forEach var="list" items="${systemInfo}" varStatus="status">
								<input type="hidden" value="${list.systemId}" />
								<li
									onclick="javascript:executeConnectDetail('${list.systemId}','${status.index}');"><a
									href="#tabs-${list.systemId}">${list.systemName}</a></li>
							</c:forEach>
						</ul>
						<c:forEach var="list" items="${systemInfo}" varStatus="status">
							<div id="tabs-${list.systemId}">
								<table>
									<tr style="font-size: 12;">
										<td>서버명&nbsp;</td>
										<td>[ ${systemDetailInfo.systemName} ]&nbsp;</td>
										<td>&nbsp;IP&nbsp;</td>
										<td>[ ${systemDetailInfo.systemIpOut} ]&nbsp;</td>
										<%-- <td>접속자&nbsp;</td>
						    		<td>[ <font color="red">${list.userCount}</font> 명 ]&nbsp;</td> --%>
										<td class="btn"><img src="images/btn/refresh3.gif"
											border="0"
											onclick="javascript:executeRe('${list.systemId}','${status.index}');" />
										</td>
									</tr>
								</table>
								<table>
									<tr style="font-size: 12;">
										<td>세션 유지 시간&nbsp;</td>
										<td>[ ${mapManageInfo.sessionMaxIdletime}초 ]&nbsp;</td>
										<td>&nbsp;세션별 최대 대역폭&nbsp;</td>
										<td>[ ${mapManageInfo.sessionMaxBandwidth}Mbps ]&nbsp;</td>
										<td>&nbsp;전체 대역폭&nbsp;</td>
										<td>[ ${mapManageInfo.totalMaxBandwidth}Mbps ]&nbsp;</td>
									</tr>
								</table>

								<table>
									<tr style="font-size: 12;">
										<td>전체&nbsp;</td>
										<td>[ ${systemDetailInfo.sumCount}명 ]&nbsp;</td>
										<c:forEach var="list" items="${comSetInfo}" varStatus="state">
											<td>${list.comTypeName}&nbsp;</td>
											<td>[ ${list.comSetCnt}명 ]&nbsp;</td>
										</c:forEach>
									</tr>
								</table>
							</div>
						</c:forEach>
					</div>
					<div id="tabs1">
						<ul>
							<li><a href="#tabs-전체">전체
									(${systemDetailInfo.userCount})</a></li>
							<c:forEach var="list" items="${comSetInfo}">
								<li><a href="#tabs-${list.comTypeName}">${list.comTypeName}
										(${fn:length(list.loginInfoList)})</a></li>
							</c:forEach>
						</ul>
						<div id="tabs-전체">

							<table class="sub_0601_table">
								<colgroup>
									<col width="25%" />
									<col width="15%" />
									<col width="25%" />
									<col width="20%" />
									<col width="15%" />
								</colgroup>
								<tbody>
									<tr>
										<th>Deivice ID</th>
										<th>접속 Type</th>
										<th>접속 시간</th>
										<th>전송 속도</th>
										<th><fmt:formatNumber value="${currentTotalBandWidth}"
												type="number" /> Kbps</th>
									</tr>
								</tbody>
							</table>
							<div style="overflow: auto; overflow-x: hidden; height: 245px;">
								<table class="sub_0601_table">
									<colgroup>
										<col width="25%" />
										<col width="15%" />
										<col width="25%" />
										<col width="20%" />
										<col width="15%" />
									</colgroup>
									<tbody>
										<c:choose>
											<c:when test="${empty connUser}">
												<tr>
													<td colspan="5" height="150px;">접속중인 사용자가 없습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach var="list" items="${connUser}">
													<tr
														onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
														onMouseOut="rowOnMouseOut(this);"
														onclick="javascript:executeDetail();">
														<td class="td03">${list.mdn}</td>
														<td class="td03">${list.networkType.type}</td>
														<td class="td03">${list.connTime}</td>
														<td class="td03" style="text-align: right;"><fmt:formatNumber
																value="${list.downloadThroughput}" type="number" />
															Kbps &nbsp;&nbsp;&nbsp;&nbsp;</td>
														<td class="td03"><input type="button" value="강제 종료" />
														</td>
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
						</div>
						<c:forEach var="list" items="${comSetInfo}">
							<div id="tabs-${list.comTypeName}">
								<table class="sub_0601_table">
									<colgroup>
										<col width="25%" />
										<col width="15%" />
										<col width="25%" />
										<col width="20%" />
										<col width="15%" />
									</colgroup>
									<tbody>
										<tr>
											<th>Deivice ID</th>
											<th>접속 Type</th>
											<th>접속 시간</th>
											<th>전송 속도</th>
											<th><fmt:formatNumber value="${list.currentBandWidth}"
													type="number" /> Kbps</th>
										</tr>
									</tbody>
								</table>
								<div style="overflow: auto; overflow-x: hidden; height: 245px;">
									<table class="sub_0601_table">
										<colgroup>
											<col width="25%" />
											<col width="15%" />
											<col width="25%" />
											<col width="20%"/>
											<col width="15%" />
										</colgroup>
										<tbody>
											<c:choose>
												<c:when test="${empty list.loginInfoList}">
													<tr>
														<td colspan="5">접속중인 사용자가 없습니다.</td>
													</tr>
												</c:when>
												<c:otherwise>
													<c:forEach var="data" items="${list.loginInfoList}">
														<tr
															onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
															onMouseOut="rowOnMouseOut(this);"
															onclick="javascript:executeDetail();">
															<td class="td03">${data.mdn}</td>
															<td class="td03">${data.networkType.type}</td>
															<td class="td03">${data.connTime}</td>
															<td class="td03" style="text-align: right;"><fmt:formatNumber
																	value="${data.downloadThroughput}" type="number" />
																kbps &nbsp;&nbsp;&nbsp;&nbsp;</td>
															<td class="td03"><input type="button" value="강제 종료" /></td>
														</tr>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</tbody>
									</table>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />
	</form:form>
</body>
</html>