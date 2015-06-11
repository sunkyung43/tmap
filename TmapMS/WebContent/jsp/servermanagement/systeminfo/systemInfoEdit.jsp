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
<link rel="stylesheet" href="css/jquery-ui.css" type="text/css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.9.2.min.js"></script>
<script type="text/javascript" src="js/formValidate.js"></script>
<script type="text/javascript">

	//중복체크 버튼 클릭 여부
	var checkValueName = "";
	var checkChange = "";
	//이벤트 등록
	$(document).ready(function() {

		$("#accordion").accordion({
			heightStyle : "content"
		});
	
		$("#systemName").keyup(function() {
			checkChange = "N";
			executeModify();
			//서버명 중복 체크
			$("#anchNameDup").click(function() {
				checkValueName = "T";
				processNameDuplication();
			}); 
		});
	});
	
	//통식방식명 중복 체크
	function processNameDuplication() {

		//아이디 유효성 검증
		if ($("#systemName").val() == "") {
			alert("서버명을 입력하세요.");
			$("#systemName").val("");
			$("#systemName").focus();
			return;
		}

		//호출 및 메시지 출력
		$.post("processNameDuplication.do", $("#ContentsForm").serialize(), function(data) {

			if (data.json.checkName == "success") {
				alert("사용하실 수 있는 서버명 입니다.");
			} else {
				alert("사용하실 수 없는 서버명 입니다.");
			}
		});
	}
	
	function initLoad() {
		var serverTypeName = '${serverTypeName}';

		if (serverTypeName == 'DS') {
			$("#comTypeDiv").hide();
			$("#comTypeContainer").hide();
		} else {
			
		}
	}


	function executeModify(systemId) {
		if(checkChange != ""){
			 if (checkValueName != "T") {
				alert("서버명 중복체크를 하세요.");
				$("#anchNameDup").focus();
				return;
			} 
		}
			if (ContentsForm.serverTypeCode.value == "서버구분") {
				alert("서버를 선택하세요.");
				return;
			}

			var re = /^[0-9]+$/;
			if (!re.test(systemMemory.value)) {
				alert("메모리 정보는 숫자만 넣으셔야 합니다.");
				systemMemory.value = "";
				systemMemory.focus();
				return;
			}
			if (!re.test(systemCpuCount.value)) {
				alert("CPU 갯수는 숫자만 넣으셔야 합니다.");
				systemCpuCount.value = "";
				systemCpuCount.focus();
				return;
			}
			
			var re_ = /^(1|2)?[0-9]?[0-9]([.](1|2)?[0-9]?[0-9]){3}$/;
			var portcheck = /^[0-9]+$/;
			if (!re_.test(systemIpOut.value)) {
				alert("올바른 IP를 입력해주세요.");
				systemIpOut.value = "";
				systemIpOut.focus();
				return;
			}
			if (!portcheck.test(systemPortOut.value)) {
				alert("숫자만 입력가능합니다.");
				systemPortOut.value = "";
				systemPortOut.focus();
				return;
			}
			if (!re_.test(systemIpIn.value)) {
				alert("올바른 IP를 입력해주세요.");
				systemIpIn.value = "";
				systemIpIn.focus();
				return;
			}
			if (!portcheck.test(systemPortIn.value)) {
			  alert("숫자만 입력가능합니다.");
				systemPortIn.value = "";
				systemPortIn.focus();
				return;
			}

		$("#systemId").val(systemId);

		if (confirm("수정하시겠습니까?")) {
			$.post("systemInfoUpdate.do", $("#ContentsForm").serialize(), function(data) {

				if (data.json.systemInfoUpdate == "success") {
					alert("수정완료 되었습니다.");
				} else {
					alert("수정실패 하였습니다.");
				}
				location.replace('systemInfoList.do');
			});
		}
	}

	function executeDel(systemId, state) {

		$("#systemId").val(systemId);

		if (confirm("삭제하시겠습니까?")) {
			if (state == 'Y') {
				alert("사용중인 서버기기는 삭제할 수 없습니다.\n미사용으로 전환 후 삭제하십시요.");
				return;
			} else {
				$.post("systemInfoDelete.do", $("#ContentsForm").serialize(), function(data) {
					alert("삭제되었습니다.");
					$("#systemName").val("");
					location.replace('systemInfoList.do');
				});
			}
		}
	}
	
	function system_sync(){
		$.post("systemSync.do", $("#ContentsForm").serialize(), function(data) {
			if (data.json.result == "success") {
				alert("동기화 요청 성공.");
			} else {
				alert("동기화 요청 실패.");
			}
		});
	}
	
</script>
</head>
<body>
	<form:form commandName="ContentsForm" id="ContentsForm" name="ContentsForm">
		<form:hidden path="systemId" />
		<input type="hidden" name="mapdownManageId" value="${mapdownManageInfo.mapdownManageId}" />
		<input type="hidden" name="oldServerTypeName" value="${serverTypeName}" />
		<input type="hidden" name="serverTypeCode" value="${systemInfo.serverTypeCode}" />

		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td width="500">
								<img src="images/h3_ico.gif">
									<span>서버 기기 관리 수정</span>
							</td>
							<td class="btn">
								<c:set var="state" value="${systemInfo.serverTypeName}"/>
								<c:if test="${state == 'DS'}" >
									<input type="button" value="동기화" style="height: 24; margin-bottom: 15; margin-right: 5;" onclick="javascript:system_sync();"/>
								</c:if>
								<a href="javascript:executeDel('${systemInfo.systemId}','${systemInfo.systemState}');" onFocus="blur()">
									<img src="images/btn/delete7.gif" border="0">
								</a>&nbsp; 
								<a href="javascript:executeModify('${systemInfo.systemId}');" onFocus="blur()">
									<img src="images/btn/modify7.gif" border="0">
								</a>&nbsp; 
								<a href="systemInfoList.do" onFocus="blur()">
									<img src="images/btn/btn_list.gif" border="0">
								</a>
							</td>
						</tr>
					</table>
					<div id="accordion">
						<h2>서버 정보</h2>
						<div>
							<table class="srvRegiEdit">
								<colgroup>
									<col width="100px" />
									<col width="*" />
								</colgroup>
								<tr>
									<th>서버명</th>
									<td>
										<input type="text" id="systemName" name="systemName" value="${systemInfo.systemName}" style="width: 450px" class="regiInput" maxlength="50" /> 
											<a id="anchNameDup">
												<img src="images/btn/checkid.gif" id="anchNameDup" align="absmiddle" style="cursor: hand">
											</a>
									</td>
								</tr>
								<tr>
									<th>서버구분</th>
									<td id="srvName">
										<input type="text" id="serverTypeName" name="serverTypeName" value="${systemInfo.serverTypeName}" style="width: 510px" class="td04" maxlength="2" readonly="readonly" />
									</td>
								</tr>
								<tr>
									<th>서버 등록 번호</th>
									<td>
										<input type="text" id="systemNum" name="systemNum" value="${systemInfo.systemNum}" style="width: 510px" class="td04" maxlength="50" readonly="readonly" />
									</td>
								</tr>
								<tr>
									<th>Memory정보</th>
									<td>
										<input type="text" id="systemMemory" name="systemMemory" value="${systemInfo.systemMemory}" title="Memory정보" style="width: 480px" class="regiInput">&nbsp; MB
									</td>
								</tr>
								<tr>
									<th>CPU갯수</th>
									<td>
										<input type="text" id="systemCpuCount" name="systemCpuCount" value="${systemInfo.systemCpuCount}" title="CPU갯수" style="width: 480px" class="regiInput">&nbsp; 개
									</td>
								</tr>
								<tr>
									<th>사용여부</th>
									<td>
										<input type="radio" name="systemState" value="Y" <c:if test="${systemInfo.systemState == 'Y'}">checked="checked"</c:if> title=""> 
											<label for="systemState" class="MR20">사용</label>
										<input type="radio" name="systemState" value="N" title="" <c:if test="${systemInfo.systemState == 'N'}">checked="checked"</c:if>>
											<label for="systemState" class="MR20">미사용</label
									></td>
								</tr>
							</table>
						</div>
						<h3>IP/Port 정보</h3>
						<div>
							<table class="srvRegiEdit">
								<colgroup>
									<col width="100px" />
									<col width="*" />
								</colgroup>
								<tr>
									<th>IP정보 (외부)</th>
									<td>
										<input type="text" id="systemIpOut" name="systemIpOut" value="${systemInfo.systemIpOut}" title="" IP정보(외부)" style="width: 520px" class="regiInput">
									</td>
								</tr>
								<tr>
									<th>Port정보 (외부)</th>
									<td>
										<input type="text" id="systemPortOut" name="systemPortOut" value="${systemInfo.systemPortOut}" title="Memory정보" style="width: 520px" class="regiInput">
									</td>
								</tr>
								<tr>
									<th>IP정보 (내부)</th>
									<td>
										<input type="text" name="systemIpIn" id="systemIpIn" value="${systemInfo.systemIpIn}" title="Memory정보" style="width: 520px" class="regiInput">
									</td>
								</tr>
								<tr>
									<th>Port정보 (내부)</th>
									<td>
										<input type="text" name="systemPortIn" id="systemPortIn" value="${systemInfo.systemPortIn}" title="Memory정보" style="width: 520px" class="regiInput">
									</td>
								</tr>
								<tr>
									<th>내용</th>
									<td>
										<input type="text" name="etc" id="etc" value="${systemInfo.etc}" title="Memory정보" style="width: 520px" class="regiInput">
									</td>
								</tr>
							</table>
						</div>
						<c:choose>
							<c:when test="${systemInfo.serverTypeName == 'DS'}">
								<h3>DS/RS 설정</h3>
								<div>
									<span>
										<h2>통신방식</h2>
									</span>
									<table class="sub_0601_table" id="comTypeTbl">
										<colgroup>
											<col width="9%">
											<col width="*">
											<col width="40%">
										</colgroup>
										<tbody>
											<tr>
												<th>번호</th>
												<th>통신방식명</th>
												<th>동시접속자수</th>
											</tr>
											<tr>
												<c:forEach var="list" items="${comTypeInfo}" varStatus="state">
													<tr>
														<td class="td03">
															<input id="${list.comSetId}" class="td04" type="text" name="comTypeCodes" class="reg_input" style="width: 15px" value="${list.comTypeCode}" readonly="readonly" />
														</td>
														<td class="td03">${list.comTypeName}</td>
														<td class="td03">
															<input type="text" name="comSetCnts" class="reg_input" style="width: 110px" value="${list.comSetCnt}" readonly="readonly" />명
														</td>
													</tr>
												</c:forEach>
											</tr>
										</tbody>
									</table>
									<span>
										<h2>서비스 운영 정보</h2>
									</span>
									<table class="sub_0601_table">
										<colgroup>
											<col width="33%">
											<col width="33%">
											<col width="*">
										</colgroup>
										<tbody>
											<tr>
												<th>세선 유지 시간(초)</th>
												<th>세션별 최대 대역폭</th>
												<th>전체 대역폭</th>
											</tr>
											<tr>
												<td>
													<input type="text" name="sessionMaxIdletime" id="sessionMaxIdletime" value="${mapdownManageInfo.sessionMaxIdletime}" title="세션 유지 시간" readonly="readonly" /> 초
												</td>
												<td>
													<input type="text" name="sessionMaxBandwidth" id="sessionMaxBandwidth" value="${mapdownManageInfo.sessionMaxBandwidth}" title="세션별 최대 대역폭" readonly="readonly" /> Mbps
												</td>
												<td>
													<input type="text" name="totalMaxBandwidth" id="totalMaxBandwidth" value="${mapdownManageInfo.totalMaxBandwidth}" title="전체 대역폭" readonly="readonly" /> Mbps
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</c:when>
						</c:choose>
					</div>
					<div>
						<div>
							<table>
								<colgroup>
									<col width="">
									<col width="">
									<col width="">
									<col width="">
									<col width="">
								</colgroup>
							</table>
						</div>
					</div>
					<div>
						<table>
						</table>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />
		<!--        <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0"> -->
		<!--       <tr> -->
		<!--         <td height="100%"> -->
		<!--           <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0"> -->
		<!--             <tr> -->
		<!--               <td height="100%" valign="top" class="contents"> -->
		<!--                 <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="20"> -->
		<!--                   <tr> -->
		<!--                     <td valign="top" bgcolor="#FFFFFF"> -->
		<!--                       <div id="contents" style="width: 850px"> -->
		<!--                         <table border="0" cellspacing="0" cellpadding="0"> -->
		<!--                           <tr> -->
		<!--                             <td><img src="images/title/title44.gif"></td> -->
		<!--                             <td width="30"></td> -->
		<!--                           </tr> -->
		<!--                           <tr> -->
		<!--                             <td height="10"></td> -->
		<!--                             <td></td> -->
		<!--                             <td></td> -->
		<!--                             <td></td> -->
		<!--                           </tr> -->
		<!--                         </table> -->
		<!--                         <table width="100%" border="0" cellspacing="0" cellpadding="0"> -->
		<!--                           <tr> -->
		<!--                             <td style="font-size: 13;"><b></b></td> -->
		<%--                             <td class="btn"><a href="javascript:executeDel('${systemInfo.systemId}','${systemInfo.systemState}');" onFocus="blur()"><img src="images/btn/delete7.gif" border="0"></a>&nbsp; <a href="javascript:executeModify('${systemInfo.systemId}');" onFocus="blur()"><img src="images/btn/modify7.gif" border="0"></a>&nbsp; <a href="systemInfoList.do" onFocus="blur()"><img src="images/btn/btn_list.gif" border="0"></a></td> --%>
		<!--                           </tr> -->
		<!--                         </table> -->
		<!--                         <table width="100%" border="0" cellpadding="10" cellspacing="1" bgcolor="#FF8200"> -->
		<!--                           <tr> -->
		<!--                             <td width="404" valign="top" bgcolor="#FFFFFF" style="padding-bottom: 30" colspan="2"> -->
		<!--                               <table width="404" border="0" cellspacing="0" cellpadding="0"> -->
		<!--                                 <tr> -->
		<!--                                   <td class="ttl7">[서버기기 정보]</td> -->
		<!--                                 </tr> -->
		<!--                                 <tr> -->
		<!--                                   <td height="5"></td> -->
		<!--                                 </tr> -->
		<!--                               </table> -->
		<!--                               <table border="0" cellspacing="0" cellpadding="0"> -->
		<!--                                 <tr> -->
		<!--                                   <td> -->
		<!--                                     <table width="404" border="0" cellspacing="0" cellpadding="0"> -->
		<!--                                       <tr> -->
		<!--                                         <td><img src="images/box404_1.png"></td> -->
		<!--                                       </tr> -->
		<!--                                       <tr> -->
		<!--                                         <td align="center" background="images/box404_2.png"> -->
		<!--                                           <table width="404" border="0" cellspacing="0" cellpadding="0"> -->
		<!--                                             <tr> -->
		<!--                                               <td width="100" height="35" class="ttl4">서버명</td> -->
		<!--                                               <td width="1" bgcolor="#f3961d"></td> -->
		<!--                                               <td width="5"></td> -->
		<%--                                               <td class="ttl7">&nbsp;&nbsp;${systemInfo.systemName}</td> --%>
		<!--                                             </tr> -->
		<!--                                             <tr> -->
		<!--                                               <td height="1" colspan="4" bgcolor="#f3961d"></td> -->
		<!--                                             </tr> -->
		<!--                                           </table> -->
		<!--                                           <table width="404" border="0" cellspacing="0" cellpadding="0"> -->
		<!--                                             <tr> -->
		<!--                                               <td width="100" height="35" class="ttl4">서버구분</td> -->
		<!--                                               <td width="1" bgcolor="#f3961d"></td> -->
		<%--                                               <td width="5">${systemInfo.serverTypeCode}</td> --%>
		<!--                                               <td width="10"></td> -->
		<!--                                               <td width="1" bgcolor="#f3961d"></td> -->
		<!--                                               <td width="60" class="ttl4">사용여부</td> -->
		<!--                                               <td width="1" bgcolor="#f3961d"></td> -->
		<!--                                               <td width="5"></td> -->
		<%--                                               <td><input type="radio" style="cursor: hand;" name="systemState" value="Y" <c:if test="${systemInfo.systemState == 'Y'}">checked="checked"</c:if> /> 사용&nbsp; <input type="radio" style="cursor: hand;" name="systemState" value="N" <c:if test="${systemInfo.systemState == 'N'}">checked="checked"</c:if> /> 미사용</td> --%>
		<!--                                             </tr> -->
		<!--                                             <tr> -->
		<!--                                               <td height="1" colspan="15" bgcolor="#f3961d"></td> -->
		<!--                                             </tr> -->
		<!--                                           </table> -->
		<!--                                           <table width="404" border="0" cellspacing="0" cellpadding="0"> -->
		<!--                                             <tr> -->
		<!--                                               <td width="100" class="ttl4">Memory정보</td> -->
		<!--                                               <td width="1" bgcolor="#f3961d"></td> -->
		<!--                                               <td width="5"></td> -->
		<%--                                               <td class="ttl4"><input type="text" name="systemMemory" class="textbox validate-req" style="width: 95%" title="Memory정보" value="${systemInfo.systemMemory}" /></td> --%>
		<!--                                             </tr> -->
		<!--                                             <tr> -->
		<!--                                               <td height="1" colspan="4" bgcolor="#f3961d"></td> -->
		<!--                                             </tr> -->
		<!--                                           </table> -->
		<!--                                           <table width="404" border="0" cellspacing="0" cellpadding="0"> -->
		<!--                                             <tr> -->
		<!--                                               <td width="100" class="ttl4">CPU갯수</td> -->
		<!--                                               <td width="1" bgcolor="#f3961d"></td> -->
		<!--                                               <td width="5"></td> -->
		<%--                                               <td class="ttl4"><input type="text" name="systemCpuCount" class="textbox validate-req" style="width: 95%" title="CPU갯수" value="${systemInfo.systemCpuCount}" /></td> --%>
		<!--                                             </tr> -->
		<!--                                             <tr> -->
		<!--                                               <td height="1" colspan="4" bgcolor="#f3961d"></td> -->
		<!--                                             </tr> -->
		<!--                                           </table> -->
		<!--                                           <table width="404" border="0" cellspacing="0" cellpadding="0"> -->
		<!--                                             <tr> -->
		<!--                                               <td width="100" height="45" class="ttl4">서버 등록 번호</td> -->
		<!--                                               <td width="1" bgcolor="#f3961d"></td> -->
		<!--                                               <td width="5"></td> -->
		<%--                                               <td class="ttl4" colspan="4"><input type="text" name="systemNum" class="invisible" style="width: 95%" value="${systemInfo.systemNum}" readonly="readonly" /></td> --%>
		<!--                                             </tr> -->
		<!--                                           </table> -->
		<!--                                         </td> -->
		<!--                                       </tr> -->
		<!--                                       <tr> -->
		<!--                                         <td><img src="images/box404_3.png"></td> -->
		<!--                                       </tr> -->
		<!--                                     </table> -->
		<!--                                   </td> -->
		<!--                                   <td> -->
		<!--                                     <table width="404" border="0" cellspacing="0" cellpadding="0"> -->
		<!--                                       <tr> -->
		<!--                                         <td><img src="images/box404_1.png"></td> -->
		<!--                                       </tr> -->
		<!--                                       <tr> -->
		<!--                                         <td align="center" background="images/box404_2.png"> -->
		<!--                                           <table width="404" border="0" cellspacing="0" cellpadding="0"> -->
		<!--                                             <tr> -->
		<!--                                               <td width="100" class="ttl4">IP정보(외부)</td> -->
		<!--                                               <td width="1" bgcolor="#f3961d"></td> -->
		<!--                                               <td width="5"></td> -->
		<%--                                               <td class="ttl4"><input type="text" name="systemIpOut" class="textbox validate-req" style="width: 95%" title="IP정보(외부)" maxlength="15" value="${systemInfo.systemIpOut}" /></td> --%>
		<!--                                             </tr> -->
		<!--                                             <tr> -->
		<!--                                               <td height="1" colspan="4" bgcolor="#f3961d"></td> -->
		<!--                                             </tr> -->
		<!--                                           </table> -->
		<!--                                           <table width="404" border="0" cellspacing="0" cellpadding="0"> -->
		<!--                                             <tr> -->
		<!--                                               <td width="100" class="ttl4">Port정보(외부)</td> -->
		<!--                                               <td width="1" bgcolor="#f3961d"></td> -->
		<!--                                               <td width="5"></td> -->
		<%--                                               <td class="ttl4"><input type="text" name="systemPortOut" class="textbox validate-req" style="width: 95%" title="Port정보(외부)" value="${systemInfo.systemPortOut}" /></td> --%>
		<!--                                             </tr> -->
		<!--                                             <tr> -->
		<!--                                               <td height="1" colspan="4" bgcolor="#f3961d"></td> -->
		<!--                                             </tr> -->
		<!--                                           </table> -->
		<!--                                           <table width="404" border="0" cellspacing="0" cellpadding="0"> -->
		<!--                                             <tr> -->
		<!--                                               <td width="100" class="ttl4">IP정보(내부)</td> -->
		<!--                                               <td width="1" bgcolor="#f3961d"></td> -->
		<!--                                               <td width="5"></td> -->
		<%--                                               <td class="ttl4"><input type="text" name="systemIpIn" class="textbox" style="width: 95%" title="IP정보(내부)" maxlength="15" value="${systemInfo.systemIpIn}" /></td> --%>
		<!--                                             </tr> -->
		<!--                                             <tr> -->
		<!--                                               <td height="1" colspan="4" bgcolor="#f3961d"></td> -->
		<!--                                             </tr> -->
		<!--                                           </table> -->
		<!--                                           <table width="404" border="0" cellspacing="0" cellpadding="0"> -->
		<!--                                             <tr> -->
		<!--                                               <td width="100" class="ttl4">Port정보(내부)</td> -->
		<!--                                               <td width="1" bgcolor="#f3961d"></td> -->
		<!--                                               <td width="5"></td> -->
		<%--                                               <td class="ttl4"><input type="text" name="systemPortIn" class="textbox" style="width: 95%" title="Port정보(내부)" value="${systemInfo.systemPortIn}" /></td> --%>
		<!--                                             </tr> -->
		<!--                                             <tr> -->
		<!--                                               <td height="1" colspan="4" bgcolor="#f3961d"></td> -->
		<!--                                             </tr> -->
		<!--                                           </table> -->
		<!--                                           <table width="404" border="0" cellspacing="0" cellpadding="0"> -->
		<!--                                             <tr> -->
		<!--                                               <td width="100" class="ttl4">내용</td> -->
		<!--                                               <td width="1" bgcolor="#f3961d"></td> -->
		<!--                                               <td width="5"></td> -->
		<%--                                               <td class="ttl4"><textarea name="etc" class="textbox" style="width: 95%; height: 30" title="내용">${systemInfo.etc}</textarea></td> --%>
		<!--                                               <td width="5"></td> -->
		<!--                                             </tr> -->
		<!--                                           </table> -->
		<!--                                         </td> -->
		<!--                                       </tr> -->
		<!--                                       <tr> -->
		<!--                                         <td><img src="images/box404_3.png"></td> -->
		<!--                                       </tr> -->
		<!--                                     </table> -->
		<!--                                   </td> -->
		<!--                                 </tr> -->
		<!--                                 <tr> -->
		<!--                                   <td width="404" valign="top" bgcolor="#FFFFFF"> -->
		<!--                                     <div id="mapView" style="display: none;"> -->
		<!--                                       <table> -->
		<!--                                         <tr> -->
		<!--                                           <td height="30"></td> -->
		<!--                                         </tr> -->
		<!--                                       </table> -->
		<!--                                       <table width="404" border="0" cellspacing="0" cellpadding="0"> -->
		<!--                                         <tr> -->
		<!--                                           <td height="7"></td> -->
		<!--                                         </tr> -->
		<!--                                         <tr> -->
		<!--                                           <td class="ttl7">[통식방식]</td> -->
		<!--                                         </tr> -->
		<!--                                         <tr> -->
		<!--                                           <td height="6"></td> -->
		<!--                                         </tr> -->
		<!--                                       </table> -->
		<!--                                       <table width="380" border="0" cellspacing="0" cellpadding="0"> -->
		<!--                                         <tr> -->
		<!--                                           <td width="3"><img src="images/ttl_bar1.gif"></td> -->
		<!--                                           <td width="60" background="images/ttl_bar2.gif" class="ttl"></td> -->
		<!--                                           <td width="1" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td> -->
		<!--                                           <td background="images/ttl_bar2.gif" class="ttl">통식방식명</td> -->
		<!--                                           <td width="1" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td> -->
		<!--                                           <td width="80" background="images/ttl_bar2.gif" class="ttl">동시접속자수</td> -->
		<!--                                           <td width="3"><img src="images/ttl_bar3.gif"></td> -->
		<!--                                         </tr> -->
		<!--                                       </table> -->
		<!--                                       <div style="overflow: auto; height: 150px;" id="showComType"> -->
		<!--                                         <table width="380" border="0" cellspacing="0" cellpadding="0"> -->
		<%--                                           <c:forEach var="list" items="${comType}" varStatus="state"> --%>
		<!--                                             <tr> -->
		<!--                                               <td width="3"></td> -->
		<%--                                               <td width="60" class="ttl4"><input type="checkbox" style="cursor: hand;" id="comTypeIds" name="comTypeIds" value="${list.comTypeId}" disabled="disabled" /></td> --%>
		<!--                                               <td width="1"></td> -->
		<%--                                               <td class="ttl4">${list.comTypeName}</td> --%>
		<!--                                               <td width="1"></td> -->
		<!--                                               <td width="80" height="30" class="ttl4"><input type="text" class="invisible" style="width: 70%" readonly="readonly" /></td> -->
		<!--                                               <td width="3"></td> -->
		<!--                                             </tr> -->
		<!--                                             <tr> -->
		<!--                                               <td height="1" colspan="9" bgcolor="#f3961d"></td> -->
		<!--                                             </tr> -->
		<%--                                           </c:forEach> --%>
		<!--                                         </table> -->
		<!--                                       </div> -->
		<%--                                       <c:if test="${serverTypeName != 'DS'}"> --%>
		<!--                                         <div style="overflow: auto; height: 150px; display: none;" id="hideComType"> -->
		<!--                                           <table width="380" border="0" cellspacing="0" cellpadding="0"> -->
		<%--                                             <c:forEach var="list" items="${comType}" varStatus="state"> --%>
		<!--                                               <tr> -->
		<!--                                                 <td width="3"></td> -->
		<%--                                                 <td width="60" class="ttl4"><input type="checkbox" style="cursor: hand;" id="comTypeIds${list.comTypeId}" name="comTypeIds" value="${list.comTypeId}" onclick="javascript:selected(${list.comTypeId})" /></td> --%>
		<!--                                                 <td width="1"></td> -->
		<%--                                                 <td class="ttl4">${list.comTypeName}</td> --%>
		<!--                                                 <td width="1"></td> -->
		<%--                                                 <td width="80" class="ttl4"><input type="text" id="comSetCnt${list.comTypeId}" name="comSetCnts" class="invisible" style="width: 70%" title="동시접속자수" /></td> --%>
		<!--                                                 <td width="3"></td> -->
		<!--                                               </tr> -->
		<!--                                               <tr> -->
		<!--                                                 <td height="1" colspan="9" bgcolor="#f3961d"></td> -->
		<!--                                               </tr> -->
		<%--                                             </c:forEach> --%>
		<!--                                           </table> -->
		<!--                                         </div> -->
		<%--                                       </c:if> --%>
		<%--                                       <c:if test="${serverTypeName == 'DS'}"> --%>
		<!--                                         <div style="overflow: auto; height: 150px; display: none;" id="hideComType"> -->
		<!--                                           <table width="380" border="0" cellspacing="0" cellpadding="0"> -->
		<%--                                             <c:forEach var="list" items="${comTypeInfo}" varStatus="state"> --%>
		<%--                                               <tr bgcolor="${list.color}"> --%>
		<!--                                                 <td width="3"></td> -->
		<%--                                                 <td width="60" class="ttl4"><input type="checkbox" style="cursor: hand;" id="comTypeIds${list.comTypeId}" name="comTypeIds" value="${list.comTypeId}" onclick="javascript:selected(${list.comTypeId})" <c:if test="${list.comSetState == 'Y'}">checked="checked"</c:if> /></td> --%>
		<!--                                                 <td width="1"></td> -->
		<%--                                                 <td class="ttl4">${list.comTypeName}</td> --%>
		<!--                                                 <td width="1"></td> -->
		<%--                                                 <td width="80" class="ttl4"><c:if test="${list.comSetState == 'Y'}"> --%>
		<%--                                                     <input type="text" id="comSetCnt${list.comTypeId}" name="comSetCnts" class="textbox validate-req" style="width: 70%" title="동시접속자수" value="${list.comSetCnt}" /> --%>
		<%--                                                   </c:if> <c:if test="${list.comSetState != 'Y'}"> --%>
		<%--                                                     <input type="text" id="comSetCnt${list.comTypeId}" name="comSetCnts" class="invisible" style="width: 70%" title="동시접속자수" /> --%>
		<%--                                                   </c:if></td> --%>
		<!--                                                 <td width="3"></td> -->
		<!--                                               </tr> -->
		<!--                                               <tr> -->
		<!--                                                 <td height="1" colspan="9" bgcolor="#f3961d"></td> -->
		<!--                                               </tr> -->
		<%--                                             </c:forEach> --%>
		<!--                                           </table> -->
		<!--                                         </div> -->
		<%--                                       </c:if> --%>
		<!--                                   </td> -->
		<!--                                   <td width="404" valign="top" bgcolor="#FFFFFF"> -->
		<!--                                     <div id="mapDownDiv" style="display: none;"> -->
		<!--                                       <table> -->
		<!--                                         <tr> -->
		<!--                                           <td height="30"></td> -->
		<!--                                         </tr> -->
		<!--                                       </table> -->
		<!--                                       <table width="404" border="0" cellspacing="0" cellpadding="0"> -->
		<!--                                         <tr> -->
		<!--                                           <td height="7"></td> -->
		<!--                                         </tr> -->
		<!--                                         <tr> -->
		<!--                                           <td class="ttl7">[서비스운영 정보]</td> -->
		<!--                                         </tr> -->
		<!--                                         <tr> -->
		<!--                                           <td height="6"></td> -->
		<!--                                         </tr> -->
		<!--                                       </table> -->
		<!--                                       <table width="404" border="0" cellspacing="0" cellpadding="0"> -->
		<!--                                         <tr> -->
		<!--                                           <td><img src="images/box404_1.png"></td> -->
		<!--                                         </tr> -->
		<!--                                         <tr> -->
		<!--                                           <td align="center" background="images/box404_2.png"> -->
		<!--                                             <table width="404" border="0" cellspacing="0" cellpadding="0"> -->
		<!--                                               <tr align="center"> -->
		<!--                                                 <td width="150" height="40" class="ttl4" style="font-weight: bold;">세션 유지 시간(초)</td> -->
		<!--                                                 <td width="2" bgcolor="#f3961d"></td> -->
		<!--                                                 <td width="3"></td> -->
		<%--                                                 <td width="200" height="45" class="ttl4"><input type="text" name="sessionMaxIdletime" id="sessionMaxIdletime" style="width: 95%" title="세션 유지 시간" value="${mapdownManageInfo.sessionMaxIdletime}" /></td> --%>
		<!--                                                 <td>초</td> -->
		<!--                                               </tr> -->
		<!--                                               <tr> -->
		<!--                                                 <td height="1" colspan="10" bgcolor="#f3961d"></td> -->
		<!--                                               </tr> -->
		<!--                                             </table> -->
		<!--                                             <table width="404" border="0" cellspacing="0" cellpadding="0"> -->
		<!--                                               <tr align="center"> -->
		<!--                                                 <td width="150" height="40" class="ttl4" style="font-weight: bold;">세션별 최대 대역폭</td> -->
		<!--                                                 <td width="2" bgcolor="#f3961d"></td> -->
		<!--                                                 <td width="3"></td> -->
		<%--                                                 <td width="200" height="45" class="ttl4"><input type="text" name="sessionMaxBandwidth" id="sessionMaxBandwidth" style="width: 95%" title="세션별 최대 대역폭" value="${mapdownManageInfo.sessionMaxBandwidth}" /></td> --%>
		<!--                                                 <td>Mbps</td> -->
		<!--                                               </tr> -->
		<!--                                               <tr> -->
		<!--                                                 <td height="1" colspan="10" bgcolor="#f3961d"></td> -->
		<!--                                               </tr> -->
		<!--                                             </table> -->
		<!--                                             <table width="404" border="0" cellspacing="0" cellpadding="0"> -->
		<!--                                               <tr align="center"> -->
		<!--                                                 <td width="150" height="40" class="ttl4" style="font-weight: bold;">전체 대역폭</td> -->
		<!--                                                 <td width="2" bgcolor="#f3961d"></td> -->
		<!--                                                 <td width="3"></td> -->
		<%--                                                 <td width="200" height="45" class="ttl4"><input type="text" name="totalMaxBandwidth" id="totalMaxBandwidth" style="width: 95%" title="전체 대역폭" value="${mapdownManageInfo.totalMaxBandwidth}" /></td> --%>
		<!--                                                 <td>Mbps</td> -->
		<!--                                               </tr> -->
		<!--                                             </table> -->
		<!--                                           </td> -->
		<!--                                         </tr> -->
		<!--                                         <tr> -->
		<!--                                           <td><img src="images/box404_3.png"></td> -->
		<!--                                         </tr> -->
		<!--                                       </table> -->
		<!--                                     </div> -->
		<!--                                   </td> -->
		<!--                                 </tr> -->
		<!--                               </table> -->
		<!--                             </td> -->
		<!--                           </tr> -->
		<!--                         </table> -->
		<!--                       </div> -->
		<!--                     </td> -->
		<!--                   </tr> -->
		<!--                 </table> -->
		<!--               </td> -->
		<!--             </tr> -->
		<!--           </table> -->
		<!--         </td> -->
		<!--       </tr> -->
		<!--     </table> -->
	</form:form>
</body>
</html>