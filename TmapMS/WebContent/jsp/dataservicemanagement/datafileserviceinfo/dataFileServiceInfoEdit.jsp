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
<link rel="stylesheet" href="css/tmap.css" type="text/css" />
<link rel="stylesheet" href="css/layout_contents.css" type="text/css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript"  src="js/common.js"></script>
<script type="text/javascript"  src="js/script.js"></script>
<script type="text/javascript"  src="js/jquery.js"></script>
<script type="text/javascript" 	src="js/formValidate.js"></script>
<script type="text/javascript">
	
	//이벤트 등록
	$(document).ready(function() {
		
		//사용여부 사용 선택시
		$("#use").click(function() { 
			$("#typeTd").show();
			$("#nonTypeTd").hide();
			$("#distributeTd").show();
			$("#nonDistributeTd").hide();
		});
		
		//사용여부 미사용 선택시
		$("#unuse").click(function() { 
			$("#typeTd").hide();
			$("#nonTypeTd").show();
			$("#distributeTd").hide();
			$("#nonDistributeTd").show();
		});
		
	});
	
	function executeDetail(fileVerId, fileVerName){
		
		$("#fileVerId").val(fileVerId);
		document.getElementById('pop_wrap').style.display='none';
		
		
		//호출 및 메시지 출력
	    $.post("verDetail.do", $("#ContentsForm").serialize(), function(data) {
	    	
	    	var verDetail ="";
	    	
	    	if(data.json.verDetail != ""){
		    	$.each(data.json.verDetail, function(idx, list) {
		    		verDetail += "<tr>";
		    		verDetail += "<td>"+list.file_name+"</td>";
	           		verDetail += "<td>"+list.file_size+"</td>";
	           		verDetail += "<td>"+list.file_sdate+"</td>";
	           		verDetail += "<td>"+list.file_state+"</td>";
	           		verDetail += "<td>"+list.file_update+"</td>";
	           		verDetail += "</tr>";
		    	});
		    	}else{
		    		verDetail += "<tr>";
		    		verDetail += "<td height=\"100\" align=\"center\" colspan=\"5\">등록된 데이터 파일이 없습니다.</td>";
		    		verDetail += "</tr>";
		    	}
	    		$("#popupTbody").html(verDetail);
	    		$("#verName").html("Ver Name : "+fileVerName);
	    		document.getElementById('pop_wrap').style.display='';
	    });
	}

	function executeModify(fileServId, dataFileServiceId){
		
		$("#fileServId").val(fileServId);
		$("#dataFileServiceId").val(dataFileServiceId);
		
		if(!validate()){
	        return;
	    }
		
		if($("#radioCheck input:checked").length < 1){
			alert("사용여부는 반드시 선택하셔야 합니다.");
			return;
		}
		
		if(confirm("파일서비스 배포 정보를 수정하시겠습니까?")){
			 
			$.post("dataFileServiceUpdate.do", $("#ContentsForm").serialize(), function(data) {
				alert("수정되었습니다.");
				$("#appMappingId").val(data.json.dataFileServiceId);
				$("#ContentsForm").attr('action','dataFileServiceInfoEdit.do');
	    	    $("#ContentsForm").submit();
			});
		}
	}
	
	function executeDel(dataFileServiceId, state){
		
		$("#dataFileServiceId").val(dataFileServiceId);
		
		if(confirm("삭제하시겠습니까?")){
			if(state == 'Y'){
				alert("사용중인 파일서비스 배포 정보는 삭제할 수 없습니다.\n미사용으로 전환 후 삭제하십시요.");
				return;
			}else{
				$.post("dataFileServiceDelete.do", $("#ContentsForm").serialize(), function(data) {
					alert("삭제되었습니다.");
					$("#dataFileName").val("");
		    		$("#dataTypeId").val("");
					$("#ContentsForm").attr('action','dataFileServiceInfoList.do');
					$("#ContentsForm").submit();
				});
			}
		}
	}
	
	function fileServiceGo(fileServId){
		$("#fileServId").val(fileServId);
		$("#ContentsForm").attr('action','fileServiceInfoEdit.do');
	    $("#ContentsForm").submit();
	}
	
</script>
</head>
<body>
	<!-- 레이어 팝업 -->
	<div id="pop_wrap" style="display: none; position: absolute;">
		<div id="pop_container" style="width: 600px; top: 190; left: 490">
			<iframe src="about:blank" scrolling="no" frameborder="0" title="팝업 아이프레임 영역"></iframe>
			<div style="overflow: auto; height: 250px;">
			<table style="width : 580px;">
				<tr>
					<td colspan="11" align="right">
						<a onclick="document.getElementById('pop_wrap').style.display='none'; document.body.className='';">
							<input type="button" value="닫기" />
						</a>
					</td>
					</tr>
				</table>
				<table class="sub_0601_table">
					<colgroup>
						<col width="" />
						<col width="" />
						<col width="" />
						<col width="" />
						<col width="" />
					</colgroup>
					<tbody>
						<tr>
							<th class="td03">파일명</th>
							<th class="td03">크기</th>
							<th class="td03">등록일</th>
							<th class="td03">상태</th>
							<th class="td03">업데이트</th>
						</tr>
					<tbody id="popupTbody">
					</tbody>
				</table>

				<!-- <table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td id="verName" style="font-weight: bold; font-size: 12;"
							colspan="9"></td>
						<td align="right"><a
							onclick="document.getElementById('pop_wrap').style.display='none'; document.body.className='';">
								<input type="button" value="닫기" />
						</a></td>
					</tr>
					<tr>
						<td height="5"></td>
					</tr>
					<tr>
						<td width="3"><img src="images/ttl_bar1.gif"></td>
						<td width="25%" background="images/ttl_bar2.gif" class="ttl">파일명</td>
						<td width="1" background="images/ttl_bar2.gif"><img
							src="images/ttl_line.gif"></td>
						<td width="15%" background="images/ttl_bar2.gif" class="ttl">크기</td>
						<td width="1" background="images/ttl_bar2.gif"><img
							src="images/ttl_line.gif"></td>
						<td width="25%" background="images/ttl_bar2.gif" class="ttl">등록일</td>
						<td width="1" background="images/ttl_bar2.gif"><img
							src="images/ttl_line.gif"></td>
						<td width="17%" background="images/ttl_bar2.gif" class="ttl">사용여부</td>
						<td width="1" background="images/ttl_bar2.gif"><img
							src="images/ttl_line.gif"></td>
						<td width="18%" background="images/ttl_bar2.gif" class="ttl">업데이트</td>
						<td width="3"><img src="images/ttl_bar3.gif"></td>
					</tr>
					<tbody id="popupTbody">
					</tbody>
					<tr>
						<td height="5"></td>
					</tr>
					<tr>
						<td colspan="11" align="right"><a
							onclick="document.getElementById('pop_wrap').style.display='none'; document.body.className='';">
								<input type="button" value="닫기" />
						</a></td>
					</tr>
				</table> -->
			</div>
		</div>
	</div>
	<!--// 레이어 팝업 -->

	<form:form commandName="ContentsForm" id="ContentsForm" name="ContentsForm">
		<form:hidden path="dataTypeId" />
		<form:hidden path="dataFileId" />
		<form:hidden path="fileServId" />
		<form:hidden path="fileVerId" />
		<form:hidden path="dataFileServiceId" />

		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td width="450">
								<img src="images/h3_ico.gif"><span>파일서비스 배포 정보 수정</span>
							</td>
							<td>
								<a href="javascript:fileServiceGo('${dataFileServiceInfo.fileServId}');" onFocus="blur()">
									<img src="images/btn/modify6.gif" border="0">
								</a>&nbsp; 
<%-- 								<c:if test="${!empty serviceDetail.dataFileServiceId}"> --%>
<%-- 									<a href="javascript:executeDel('${serviceDetail.dataFileServiceId}','${serviceDetail.fileServiceState}');" onFocus="blur()"> --%>
<!-- 										<img src="images/btn/delete7.gif" border="0"> -->
<!-- 									</a>&nbsp; -->
<%-- 	                  			</c:if>  --%>
		                  		<a href="javascript:executeModify('${dataFileServiceInfo.fileServId}', '${serviceDetail.dataFileServiceId}');" onFocus="blur()">
									<img src="images/btn/modify7.gif" border="0">
								</a>&nbsp; 
								<a href="dataFileServiceInfoList.do" onFocus="blur()">
									<img src="images/btn/btn_list.gif" border="0">
								</a>
							</td>
						</tr>
					</table>
					<br>
					<table class="srvRegi">
						<colgroup>
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th class="td06">타입명</th>
								<td class="td06">${dataFileServiceInfo.dataTypeName}</td>
								<th class="td06">파일명</th>
								<td class="td06">${dataFileServiceInfo.dataFileName}</td>
							</tr>
							<tr>
								<th>파일서비스 등록일</th>
								<td>${dataFileServiceInfo.fileServSdate}</td>
							</tr>
							<tr>
								<th>파일서비스 내용</th>
								<td colspan="3">
									<input type="text" name="etc" class="textbox" style="width: 95%;" readonly="readonly" value="${dataFileServiceInfo.etc}" />
								</td>
							</tr>
							<tr>
								<th>서비스명</th>
								<td colspan="3">
									<c:if test="${empty serviceDetail.dataFileServiceId}">
										<input type="text" id="sName" name="fileServiceName" class="text validate-req" title="서비스명" style="width: 75%; ime-mode: inactive;" maxlength="100" />
											<a id="anchIdDup"><img src="images/btn/checkid.gif" align="absmiddle" style="cursor: hand"></a>
									</c:if> 
									<c:if test="${! empty serviceDetail.dataFileServiceId}">
										${serviceDetail.fileServiceName}
									</c:if>
								</td>
							</tr>
							<tr>
								<th>사용여부</th>
								<td colspan="3" id="radioCheck">
									<input type="radio" style="cursor: hand;" name="fileServiceState" id="use" value="Y"
										<c:if test="${serviceDetail.fileServiceState == 'Y'}">checked="checked"</c:if> />사용 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
									<input type="radio" style="cursor: hand;" name="fileServiceState" id="unuse" value="N"
										<c:if test="${serviceDetail.fileServiceState == 'N'}">checked="checked"</c:if> />미사용
								</td>
							</tr>
							<tr>
								<th>배포타입</th>
									<c:if test="${serviceDetail.fileServiceState != 'N'}">
										<td colspan="3" id="typeTd">
											<input type="radio" style="cursor: hand;" name="fileServiceType" value="T" <c:if test="${serviceDetail.fileServiceType == 'T'}">checked="checked"</c:if> />테스트배포 &nbsp; 
											<input type="radio" style="cursor: hand;" name="fileServiceType" value="R" <c:if test="${serviceDetail.fileServiceType == 'R'}">checked="checked"</c:if> />배포
										</td>
										<td colspan="3" id="nonTypeTd" style="display: none;">
											<input type="radio" style="cursor: hand;" name="fileServiceType" value="T" disabled="disabled" />테스트배포 &nbsp; 
											<input type="radio" style="cursor: hand;" name="fileServiceType" value="R" disabled="disabled" />배포
										</td>
									</c:if>
									<c:if test="${serviceDetail.fileServiceState == 'N'}">
										<td colspan="3" id="nonTypeTd">
											<input type="radio" style="cursor: hand;" name="fileServiceType" value="T" disabled="disabled" />테스트배포 &nbsp; 
											<input type="radio" style="cursor: hand;" name="fileServiceType" value="R" disabled="disabled" />배포
										</td>
										<td colspan="3" id="typeTd" style="display: none;">
											<input type="radio" style="cursor: hand;" name="fileServiceType" value="T" <c:if test="${serviceDetail.fileServiceType == 'T'}">checked="checked"</c:if> />테스트배포 &nbsp; 
											<input type="radio" style="cursor: hand;" name="fileServiceType" value="R" <c:if test="${serviceDetail.fileServiceType == 'R'}">checked="checked"</c:if> />배포
										</td>
									</c:if>
							</tr>
							<tr>
								<th>배포여부</th>
									<c:if test="${serviceDetail.fileServiceState != 'N'}">
										<td colspan="3" class="ttl5" id="distributeTd">
											<input type="radio" style="cursor: hand;" name="fileServiceDistribute" value="P" <c:if test="${serviceDetail.fileServiceDistribute == 'P'}">checked="checked"</c:if> />배포 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
											<input type="radio" style="cursor: hand;" name="fileServiceDistribute" value="S" <c:if test="${serviceDetail.fileServiceDistribute == 'S'}">checked="checked"</c:if> />배포중지
										</td>
										<td colspan="3" class="ttl5" id="nonDistributeTd" style="display: none;">
											<input type="radio" style="cursor: hand;" name="fileServiceDistribute" value="P" disabled="disabled" />배포 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
											<input type="radio" style="cursor: hand;" name="fileServiceDistribute" value="S" disabled="disabled" />배포중지
										</td>
									</c:if>
									<c:if test="${serviceDetail.fileServiceState == 'N'}">
										<td colspan="3" class="ttl5" id="nonDistributeTd">
											<input type="radio" style="cursor: hand;" name="fileServiceDistribute" value="P" disabled="disabled" />배포 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
											<input type="radio" style="cursor: hand;" name="fileServiceDistribute" value="S" disabled="disabled" />배포중지
										</td>
										<td colspan="3" class="ttl5" id="distributeTd" style="display: none;">
											<input type="radio" style="cursor: hand;" name="fileServiceDistribute" value="P" <c:if test="${serviceDetail.fileServiceDistribute == 'P'}">checked="checked"</c:if> />배포 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
											<input type="radio" style="cursor: hand;" name="fileServiceDistribute" value="S" <c:if test="${serviceDetail.fileServiceDistribute == 'S'}">checked="checked"</c:if> />배포중지
										</td>
									</c:if>
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
								<th>
									<input type="checkbox" name="chkCtrl" onclick="javascript:checkAll('ContentsForm', this.name, 'dataFileIds');" disabled="disabled" />
								</th>
								<th>버전명</th>
								<th>버전순위</th>
								<th>등록일</th>
							</tr>
							<c:choose>
								<c:when test="${empty versionInfo}">
									<tr>
										<td colspan="4" height="100" align="center">등록된 데이터 버전이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="list" items="${versionInfo}">
										<tr bgcolor="${list.color}" onmouseover="rowOnMouseOver(this);" onMouseOut="rowOnMouseOutColor(this, '${list.color}')">
											<td>
												<input type="checkbox" class="checkbox" id="dataFileIds" name="dataFileIds" value="${list.fileVerId}" <c:if test="${list.state == 'Y'}">checked="checked"</c:if> disabled="disabled" />
											</td>
											<td onclick="javascript:executeDetail(${list.fileVerId},'${list.fileVerName}')">${list.fileVerName}</td>
											<td onclick="javascript:executeDetail(${list.fileVerId},'${list.fileVerName}')">${list.fileVerRank}</td>
											<td onclick="javascript:executeDetail(${list.fileVerId},'${list.fileVerName}')">${list.fileVerSdate}</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						<tbody id="verTbody" style="display: none;">
						</tbody>

						<%-- <table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td><img src="images/h3_ico.gif"><span>파일서비스 배포
									정보 수정</span></td>
							<td width="30"></td>
						</tr>
						<tr>
							<td height="10"></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</table>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td style="font-size: 13;"><b></b></td>
							<td class="btn"><a
								href="javascript:fileServiceGo('${dataFileServiceInfo.fileServId}');"
								onFocus="blur()"><img src="images/btn/modify6.gif"
									border="0"></a>&nbsp; <c:if
									test="${!empty serviceDetail.dataFileServiceId}">
									<a
										href="javascript:executeDel('${serviceDetail.dataFileServiceId}','${serviceDetail.fileServiceState}');"
										onFocus="blur()"><img src="images/btn/delete7.gif"
										border="0"></a>&nbsp;
		                  		</c:if> <a
								href="javascript:executeModify('${dataFileServiceInfo.fileServId}', '${serviceDetail.dataFileServiceId}');"
								onFocus="blur()"><img src="images/btn/modify7.gif"
									border="0"></a>&nbsp; <a href="dataFileServiceInfoList.do"
								onFocus="blur()"><img src="images/btn/btn_list.gif"
									border="0"></a></td>
						</tr>
					</table>
					<table width="100%" border="0" cellpadding="10" cellspacing="1"
						bgcolor="#FF8200">
						<tr>
							<!-- 파일 서비스 정보 입력 수정 -->
							<td width="404" valign="top" bgcolor="#FFFFFF">
								<table width="404" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td class="ttl7">[파일서비스 배포 정보]</td>
									</tr>
									<tr>
										<td height="5"></td>
									</tr>
								</table>
								<table width="404" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td><img src="images/box404_1.png"></td>
									</tr>
									<tr>
										<td align="center" background="images/box404_2.png">
											<table width="404" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="113" height="2" class="ttl4">타입명</td>
													<td width="1" bgcolor="#f3961d"></td>
													<td width="5"></td>
													<td width="82" class="ttl4"><input type="text"
														id="sTypeName" class="invisible" style="width: 95%;"
														value="${dataFileServiceInfo.dataTypeName}"
														readonly="readonly" /></td>
													<td width="1" bgcolor="#f3961d"></td>
													<td width="5"></td>
													<td width="80" height="2" class="ttl4">파일명</td>
													<td width="1" bgcolor="#f3961d"></td>
													<td width="5"></td>
													<td width="110" class="ttl4"><input type="text"
														id="sName" class="invisible" style="width: 95%;"
														value="${dataFileServiceInfo.dataFileName}"
														readonly="readonly" /></td>
												</tr>
												<tr>
													<td height="1" colspan="11" bgcolor="#f3961d"></td>
												</tr>
											</table>
											<table width="404" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="113" height="2" class="ttl4">파일서비스 등록일</td>
													<td width="1" bgcolor="#f3961d"></td>
													<td width="5"></td>
													<td class="ttl4"><input type="text" class="invisible"
														style="width: 95%;"
														value="${dataFileServiceInfo.fileServSdate}"
														readonly="readonly" /></td>
													<td width="5"></td>
												</tr>
												<tr>
													<td height="1" colspan="5" bgcolor="#f3961d"></td>
												</tr>
											</table>
											<table width="404" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="113" class="ttl4">파일서비스 내용</td>
													<td width="1" bgcolor="#f3961d"></td>
													<td width="5"></td>
													<td class="ttl4"><textarea name="etc" rows="5"
															class="textbox" style="width: 95%; height: 40"
															readonly="readonly">${dataFileServiceInfo.etc}</textarea>
													</td>
													<td width="5"></td>
												</tr>
												<tr>
													<td height="1" colspan="5" bgcolor="#f3961d"></td>
												</tr>
											</table>
											<table width="404" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="113" height="2" class="ttl4">서비스명</td>
													<td width="1" bgcolor="#f3961d"></td>
													<td width="5"></td>
													<td class="ttl4"><c:if
															test="${empty serviceDetail.dataFileServiceId}">
															<input type="text" id="sName" name="fileServiceName"
																class="text validate-req" title="서비스명"
																style="width: 75%; ime-mode: inactive;" maxlength="100" />
															<a id="anchIdDup"><img src="images/btn/checkid.gif"
																align="absmiddle" style="cursor: hand"></a>
														</c:if> <c:if test="${! empty serviceDetail.dataFileServiceId}">
															<input type="text" id="sName" class="invisible"
																title="서비스명" style="width: 95%;"
																value="${serviceDetail.fileServiceName}"
																readonly="readonly" />
														</c:if></td>
													<td width="5"></td>
												</tr>
												<tr>
													<td height="1" colspan="5" bgcolor="#f3961d"></td>
												</tr>
											</table>
											<table width="404" height="40" border="0" cellspacing="0"
												cellpadding="0">
												<tr>
													<td width="113" height="15" class="ttl4">사용여부</td>
													<td width="1" bgcolor="#f3961d"></td>
													<td width="5"></td>
													<td class="ttl5" id="radioCheck"><input type="radio"
														style="cursor: hand;" name="fileServiceState" id="use"
														value="Y"
														<c:if test="${serviceDetail.fileServiceState == 'Y'}">checked="checked"</c:if> />사용
														&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input type="radio"
														style="cursor: hand;" name="fileServiceState" id="unuse"
														value="N"
														<c:if test="${serviceDetail.fileServiceState == 'N'}">checked="checked"</c:if> />미사용
													</td>
													<td width="5"></td>
												</tr>
												<tr>
													<td height="1" colspan="5" bgcolor="#f3961d"></td>
												</tr>
											</table>
											<table width="404" height="40" border="0" cellspacing="0"
												cellpadding="0">
												<tr>
													<td width="113" height="15" class="ttl4">배포타입</td>
													<td width="1" bgcolor="#f3961d"></td>
													<td width="5"></td>
													<c:if test="${serviceDetail.fileServiceState != 'N'}">
														<td class="ttl5" id="typeTd"><input type="radio"
															style="cursor: hand;" name="fileServiceType" value="T"
															<c:if test="${serviceDetail.fileServiceType == 'T'}">checked="checked"</c:if> />테스트배포
															&nbsp; <input type="radio" style="cursor: hand;"
															name="fileServiceType" value="R"
															<c:if test="${serviceDetail.fileServiceType == 'R'}">checked="checked"</c:if> />배포
														</td>
														<td class="ttl5" id="nonTypeTd" style="display: none;">
															<input type="radio" style="cursor: hand;"
															name="fileServiceType" value="T" disabled="disabled" />테스트배포
															&nbsp; <input type="radio" style="cursor: hand;"
															name="fileServiceType" value="R" disabled="disabled" />배포
														</td>
													</c:if>
													<c:if test="${serviceDetail.fileServiceState == 'N'}">
														<td class="ttl5" id="nonTypeTd"><input type="radio"
															style="cursor: hand;" name="fileServiceType" value="T"
															disabled="disabled" />테스트배포 &nbsp; <input type="radio"
															style="cursor: hand;" name="fileServiceType" value="R"
															disabled="disabled" />배포</td>
														<td class="ttl5" id="typeTd" style="display: none;">
															<input type="radio" style="cursor: hand;"
															name="fileServiceType" value="T"
															<c:if test="${serviceDetail.fileServiceType == 'T'}">checked="checked"</c:if> />테스트배포
															&nbsp; <input type="radio" style="cursor: hand;"
															name="fileServiceType" value="R"
															<c:if test="${serviceDetail.fileServiceType == 'R'}">checked="checked"</c:if> />배포
														</td>
													</c:if>
													<td width="5"></td>
												</tr>
												<tr>
													<td height="1" colspan="5" bgcolor="#f3961d"></td>
												</tr>
											</table>
											<table width="404" height="40" border="0" cellspacing="0"
												cellpadding="0">
												<tr>
													<td width="113" height="15" class="ttl4">배포여부</td>
													<td width="1" bgcolor="#f3961d"></td>
													<td width="5"></td>
													<c:if test="${serviceDetail.fileServiceState != 'N'}">
														<td class="ttl5" id="distributeTd"><input
															type="radio" style="cursor: hand;"
															name="fileServiceDistribute" value="P"
															<c:if test="${serviceDetail.fileServiceDistribute == 'P'}">checked="checked"</c:if> />배포
															&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input type="radio"
															style="cursor: hand;" name="fileServiceDistribute"
															value="S"
															<c:if test="${serviceDetail.fileServiceDistribute == 'S'}">checked="checked"</c:if> />배포중지
														</td>
														<td class="ttl5" id="nonDistributeTd"
															style="display: none;"><input type="radio"
															style="cursor: hand;" name="fileServiceDistribute"
															value="P" disabled="disabled" />배포 &nbsp; &nbsp; &nbsp;
															&nbsp; &nbsp; <input type="radio" style="cursor: hand;"
															name="fileServiceDistribute" value="S"
															disabled="disabled" />배포중지</td>
													</c:if>
													<c:if test="${serviceDetail.fileServiceState == 'N'}">
														<td class="ttl5" id="nonDistributeTd"><input
															type="radio" style="cursor: hand;"
															name="fileServiceDistribute" value="P"
															disabled="disabled" />배포 &nbsp; &nbsp; &nbsp; &nbsp;
															&nbsp; <input type="radio" style="cursor: hand;"
															name="fileServiceDistribute" value="S"
															disabled="disabled" />배포중지</td>
														<td class="ttl5" id="distributeTd" style="display: none;">
															<input type="radio" style="cursor: hand;"
															name="fileServiceDistribute" value="P"
															<c:if test="${serviceDetail.fileServiceDistribute == 'P'}">checked="checked"</c:if> />배포
															&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input type="radio"
															style="cursor: hand;" name="fileServiceDistribute"
															value="S"
															<c:if test="${serviceDetail.fileServiceDistribute == 'S'}">checked="checked"</c:if> />배포중지
														</td>
													</c:if>
													<td width="5"></td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td><img src="images/box404_3.png"></td>
									</tr>
								</table>
								<table>
									<tr>
										<td height="20"></td>
									</tr>
								</table>
							</td>
							<!-- 파일 서비스 정보 수정 끝 -->

							<!-- 데이터 버전 시작 -->
							<td width="50%" valign="top" bgcolor="#FFFFFF"
								style="padding-bottom: 30"> --%>
						<%-- <table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td class="ttl7">[데이터 버전]</td>
										</tr>
										<tr>
											<td height="5"></td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="3"><img src="images/ttl_bar1.gif"></td>
											<td width="10%" background="images/ttl_bar2.gif" class="ttl"><input
												type="checkbox" name="chkCtrl"
												onclick="javascript:checkAll('ContentsForm', this.name, 'dataFileIds');"
												disabled="disabled" /></td>
											<td width="2" background="images/ttl_bar2.gif"><img
												src="images/ttl_line.gif"></td>
											<td width="30%" background="images/ttl_bar2.gif" class="ttl">버전명</td>
											<td width="2" background="images/ttl_bar2.gif"><img
												src="images/ttl_line.gif"></td>
											<td width="25%" background="images/ttl_bar2.gif" class="ttl">버전순위</td>
											<td width="2" background="images/ttl_bar2.gif"><img
												src="images/ttl_line.gif"></td>
											<td width="35%" background="images/ttl_bar2.gif" class="ttl">등록일</td>
											<td width="3"><img src="images/ttl_bar3.gif"></td>
										</tr>
									</table>
									<div style="overflow: auto; height: 170px;">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<c:choose>
												<c:when test="${empty versionInfo}">
													<tr>
														<td height="50" align="center">등록된 데이터 버전이 없습니다.</td>
													</tr>
													<tr>
														<td height="1" class="line"></td>
													</tr>
												</c:when>
												<c:otherwise>
													<c:forEach var="list" items="${versionInfo}">
														<tr bgcolor="${list.color}"
															onmouseover="rowOnMouseOver(this);"
															onMouseOut="rowOnMouseOutColor(this, '${list.color}')">
															<td width="3"></td>
															<td width="10%" align="center" style="padding: 7 0 7 0">
																<input type="checkbox" class="checkbox" id="dataFileIds"
																name="dataFileIds" value="${list.fileVerId}"
																<c:if test="${list.state == 'Y'}">checked="checked"</c:if>
																disabled="disabled" />
															</td>
															<td width="2"></td>
															<td width="30%" class="ttl4" align="center"
																style="padding: 7 0 7 0; cursor: hand;"
																onclick="javascript:executeDetail(${list.fileVerId},'${list.fileVerName}')">${list.fileVerName}</td>
															<td width="2"></td>
															<td width="25%" class="ttl4" align="center"
																style="padding: 7 0 7 0; cursor: hand;"
																onclick="javascript:executeDetail(${list.fileVerId},'${list.fileVerName}')">${list.fileVerRank}</td>
															<td width="2"></td>
															<td width="35%" class="ttl4" align="center"
																style="padding: 7 0 7 0; cursor: hand;"
																onclick="javascript:executeDetail(${list.fileVerId},'${list.fileVerName}')">${list.fileVerSdate}</td>
															<td width="3"></td>
														</tr>
														<tr>
															<td height="1" colspan="12" bgcolor="#f3961d"></td>
														</tr>
													</c:forEach>
												</c:otherwise>
											</c:choose>
											<tbody id="verTbody" style="display: none;">
											</tbody>
										</table>
									</div>
								</td>
							</tr>
							<tr>
								<td height="10"></td>
							</tr>
						</table> --%>
						<!-- </td>
						데이터 버전 끝
						</tr> -->
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
														<td><font style="font-weight: bold;">&nbsp;파일서비스
																배포 정보 수정하기</font> <!-- <img src="images/title/title17.gif"> --></td>
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
															href="javascript:fileServiceGo('${dataFileServiceInfo.fileServId}');"
															onFocus="blur()"><img src="images/btn/modify6.gif"
																border="0"></a>&nbsp; <c:if
																test="${!empty serviceDetail.dataFileServiceId}">
																<a
																	href="javascript:executeDel('${serviceDetail.dataFileServiceId}','${serviceDetail.fileServiceState}');"
																	onFocus="blur()"><img src="images/btn/delete7.gif"
																	border="0"></a>&nbsp;
		                  		</c:if> <a
															href="javascript:executeModify('${dataFileServiceInfo.fileServId}', '${serviceDetail.dataFileServiceId}');"
															onFocus="blur()"><img src="images/btn/modify7.gif"
																border="0"></a>&nbsp; <a
															href="dataFileServiceInfoList.do" onFocus="blur()"><img
																src="images/btn/btn_list.gif" border="0"></a></td>
													</tr>
												</table>
												<table width="100%" border="0" cellpadding="10"
													cellspacing="1" bgcolor="#FF8200">
													<tr>
														<!-- 파일 서비스 정보 입력 수정 -->
														<td width="404" valign="top" bgcolor="#FFFFFF">
															<table width="404" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td class="ttl7">[파일서비스 배포 정보]</td>
																</tr>
																<tr>
																	<td height="5"></td>
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
																			<tr>
																				<td width="113" height="2" class="ttl4">타입명</td>
																				<td width="1" bgcolor="#f3961d"></td>
																				<td width="5"></td>
																				<td width="82" class="ttl4"><input type="text"
																					id="sTypeName" class="invisible"
																					style="width: 95%;"
																					value="${dataFileServiceInfo.dataTypeName}"
																					readonly="readonly" /></td>
																				<td width="1" bgcolor="#f3961d"></td>
																				<td width="5"></td>
																				<td width="80" height="2" class="ttl4">파일명</td>
																				<td width="1" bgcolor="#f3961d"></td>
																				<td width="5"></td>
																				<td width="110" class="ttl4"><input type="text"
																					id="sName" class="invisible" style="width: 95%;"
																					value="${dataFileServiceInfo.dataFileName}"
																					readonly="readonly" /></td>
																			</tr>
																			<tr>
																				<td height="1" colspan="11" bgcolor="#f3961d"></td>
																			</tr>
																		</table>
																		<table width="404" border="0" cellspacing="0"
																			cellpadding="0">
																			<tr>
																				<td width="113" height="2" class="ttl4">파일서비스
																					등록일</td>
																				<td width="1" bgcolor="#f3961d"></td>
																				<td width="5"></td>
																				<td class="ttl4"><input type="text"
																					class="invisible" style="width: 95%;"
																					value="${dataFileServiceInfo.fileServSdate}"
																					readonly="readonly" /></td>
																				<td width="5"></td>
																			</tr>
																			<tr>
																				<td height="1" colspan="5" bgcolor="#f3961d"></td>
																			</tr>
																		</table>
																		<table width="404" border="0" cellspacing="0"
																			cellpadding="0">
																			<tr>
																				<td width="113" class="ttl4">파일서비스 내용</td>
																				<td width="1" bgcolor="#f3961d"></td>
																				<td width="5"></td>
																				<td class="ttl4"><textarea name="etc" rows="5"
																						class="textbox" style="width: 95%; height: 40"
																						readonly="readonly">${dataFileServiceInfo.etc}</textarea>
																				</td>
																				<td width="5"></td>
																			</tr>
																			<tr>
																				<td height="1" colspan="5" bgcolor="#f3961d"></td>
																			</tr>
																		</table>
																		<table width="404" border="0" cellspacing="0"
																			cellpadding="0">
																			<tr>
																				<td width="113" height="2" class="ttl4">서비스명</td>
																				<td width="1" bgcolor="#f3961d"></td>
																				<td width="5"></td>
																				<td class="ttl4"><c:if
																						test="${empty serviceDetail.dataFileServiceId}">
																						<input type="text" id="sName"
																							name="fileServiceName" class="text validate-req"
																							title="서비스명"
																							style="width: 75%; ime-mode: inactive;"
																							maxlength="100" />
																						<a id="anchIdDup"><img
																							src="images/btn/checkid.gif" align="absmiddle"
																							style="cursor: hand"></a>
																					</c:if> <c:if
																						test="${! empty serviceDetail.dataFileServiceId}">
																						<input type="text" id="sName" class="invisible"
																							title="서비스명" style="width: 95%;"
																							value="${serviceDetail.fileServiceName}"
																							readonly="readonly" />
																					</c:if></td>
																				<td width="5"></td>
																			</tr>
																			<tr>
																				<td height="1" colspan="5" bgcolor="#f3961d"></td>
																			</tr>
																		</table>
																		<table width="404" height="40" border="0"
																			cellspacing="0" cellpadding="0">
																			<tr>
																				<td width="113" height="15" class="ttl4">사용여부</td>
																				<td width="1" bgcolor="#f3961d"></td>
																				<td width="5"></td>
																				<td class="ttl5" id="radioCheck"><input
																					type="radio" style="cursor: hand;"
																					name="fileServiceState" id="use" value="Y"
																					<c:if test="${serviceDetail.fileServiceState == 'Y'}">checked="checked"</c:if> />사용
																					&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input
																					type="radio" style="cursor: hand;"
																					name="fileServiceState" id="unuse" value="N"
																					<c:if test="${serviceDetail.fileServiceState == 'N'}">checked="checked"</c:if> />미사용
																				</td>
																				<td width="5"></td>
																			</tr>
																			<tr>
																				<td height="1" colspan="5" bgcolor="#f3961d"></td>
																			</tr>
																		</table>
																		<table width="404" height="40" border="0"
																			cellspacing="0" cellpadding="0">
																			<tr>
																				<td width="113" height="15" class="ttl4">배포타입</td>
																				<td width="1" bgcolor="#f3961d"></td>
																				<td width="5"></td>
																				<c:if
																					test="${serviceDetail.fileServiceState != 'N'}">
																					<td class="ttl5" id="typeTd"><input
																						type="radio" style="cursor: hand;"
																						name="fileServiceType" value="T"
																						<c:if test="${serviceDetail.fileServiceType == 'T'}">checked="checked"</c:if> />테스트배포
																						&nbsp; <input type="radio" style="cursor: hand;"
																						name="fileServiceType" value="R"
																						<c:if test="${serviceDetail.fileServiceType == 'R'}">checked="checked"</c:if> />배포
																					</td>
																					<td class="ttl5" id="nonTypeTd"
																						style="display: none;"><input type="radio"
																						style="cursor: hand;" name="fileServiceType"
																						value="T" disabled="disabled" />테스트배포 &nbsp; <input
																						type="radio" style="cursor: hand;"
																						name="fileServiceType" value="R"
																						disabled="disabled" />배포</td>
																				</c:if>
																				<c:if
																					test="${serviceDetail.fileServiceState == 'N'}">
																					<td class="ttl5" id="nonTypeTd"><input
																						type="radio" style="cursor: hand;"
																						name="fileServiceType" value="T"
																						disabled="disabled" />테스트배포 &nbsp; <input
																						type="radio" style="cursor: hand;"
																						name="fileServiceType" value="R"
																						disabled="disabled" />배포</td>
																					<td class="ttl5" id="typeTd" style="display: none;">
																						<input type="radio" style="cursor: hand;"
																						name="fileServiceType" value="T"
																						<c:if test="${serviceDetail.fileServiceType == 'T'}">checked="checked"</c:if> />테스트배포
																						&nbsp; <input type="radio" style="cursor: hand;"
																						name="fileServiceType" value="R"
																						<c:if test="${serviceDetail.fileServiceType == 'R'}">checked="checked"</c:if> />배포
																					</td>
																				</c:if>
																				<td width="5"></td>
																			</tr>
																			<tr>
																				<td height="1" colspan="5" bgcolor="#f3961d"></td>
																			</tr>
																		</table>
																		<table width="404" height="40" border="0"
																			cellspacing="0" cellpadding="0">
																			<tr>
																				<td width="113" height="15" class="ttl4">배포여부</td>
																				<td width="1" bgcolor="#f3961d"></td>
																				<td width="5"></td>
																				<c:if
																					test="${serviceDetail.fileServiceState != 'N'}">
																					<td class="ttl5" id="distributeTd"><input
																						type="radio" style="cursor: hand;"
																						name="fileServiceDistribute" value="P"
																						<c:if test="${serviceDetail.fileServiceDistribute == 'P'}">checked="checked"</c:if> />배포
																						&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input
																						type="radio" style="cursor: hand;"
																						name="fileServiceDistribute" value="S"
																						<c:if test="${serviceDetail.fileServiceDistribute == 'S'}">checked="checked"</c:if> />배포중지
																					</td>
																					<td class="ttl5" id="nonDistributeTd"
																						style="display: none;"><input type="radio"
																						style="cursor: hand;" name="fileServiceDistribute"
																						value="P" disabled="disabled" />배포 &nbsp; &nbsp;
																						&nbsp; &nbsp; &nbsp; <input type="radio"
																						style="cursor: hand;" name="fileServiceDistribute"
																						value="S" disabled="disabled" />배포중지</td>
																				</c:if>
																				<c:if
																					test="${serviceDetail.fileServiceState == 'N'}">
																					<td class="ttl5" id="nonDistributeTd"><input
																						type="radio" style="cursor: hand;"
																						name="fileServiceDistribute" value="P"
																						disabled="disabled" />배포 &nbsp; &nbsp; &nbsp;
																						&nbsp; &nbsp; <input type="radio"
																						style="cursor: hand;" name="fileServiceDistribute"
																						value="S" disabled="disabled" />배포중지</td>
																					<td class="ttl5" id="distributeTd"
																						style="display: none;"><input type="radio"
																						style="cursor: hand;" name="fileServiceDistribute"
																						value="P"
																						<c:if test="${serviceDetail.fileServiceDistribute == 'P'}">checked="checked"</c:if> />배포
																						&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input
																						type="radio" style="cursor: hand;"
																						name="fileServiceDistribute" value="S"
																						<c:if test="${serviceDetail.fileServiceDistribute == 'S'}">checked="checked"</c:if> />배포중지
																					</td>
																				</c:if>
																				<td width="5"></td>
																			</tr>
																		</table>
																	</td>
																</tr>
																<tr>
																	<td><img src="images/box404_3.png"></td>
																</tr>
															</table>
															<table>
																<tr>
																	<td height="20"></td>
																</tr>
															</table>
														</td>
														<!-- 파일 서비스 정보 수정 끝 -->

														<!-- 데이터 버전 시작 -->
														<td width="50%" valign="top" bgcolor="#FFFFFF"
															style="padding-bottom: 30">
															<table width="100%" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td>
																		<table width="100%" border="0" cellspacing="0"
																			cellpadding="0">
																			<tr>
																				<td class="ttl7">[데이터 버전]</td>
																			</tr>
																			<tr>
																				<td height="5"></td>
																			</tr>
																		</table>
																		<table width="100%" border="0" cellspacing="0"
																			cellpadding="0">
																			<tr>
																				<td width="3"><img src="images/ttl_bar1.gif"></td>
																				<td width="10%" background="images/ttl_bar2.gif"
																					class="ttl"><input type="checkbox"
																					name="chkCtrl"
																					onclick="javascript:checkAll('ContentsForm', this.name, 'dataFileIds');"
																					disabled="disabled" /></td>
																				<td width="2" background="images/ttl_bar2.gif"><img
																					src="images/ttl_line.gif"></td>
																				<td width="30%" background="images/ttl_bar2.gif"
																					class="ttl">버전명</td>
																				<td width="2" background="images/ttl_bar2.gif"><img
																					src="images/ttl_line.gif"></td>
																				<td width="25%" background="images/ttl_bar2.gif"
																					class="ttl">버전순위</td>
																				<td width="2" background="images/ttl_bar2.gif"><img
																					src="images/ttl_line.gif"></td>
																				<td width="35%" background="images/ttl_bar2.gif"
																					class="ttl">등록일</td>
																				<td width="3"><img src="images/ttl_bar3.gif"></td>
																			</tr>
																		</table>
																		<div style="overflow: auto; height: 170px;">
																			<table width="100%" border="0" cellspacing="0"
																				cellpadding="0">
																				<c:choose>
																					<c:when test="${empty versionInfo}">
																						<tr>
																							<td height="50" align="center">등록된 데이터 버전이
																								없습니다.</td>
																						</tr>
																						<tr>
																							<td height="1" class="line"></td>
																						</tr>
																					</c:when>
																					<c:otherwise>
																						<c:forEach var="list" items="${versionInfo}">
																							<tr bgcolor="${list.color}"
																								onmouseover="rowOnMouseOver(this);"
																								onMouseOut="rowOnMouseOutColor(this, '${list.color}')">
																								<td width="3"></td>
																								<td width="10%" align="center"
																									style="padding: 7 0 7 0"><input
																									type="checkbox" class="checkbox"
																									id="dataFileIds" name="dataFileIds"
																									value="${list.fileVerId}"
																									<c:if test="${list.state == 'Y'}">checked="checked"</c:if>
																									disabled="disabled" /></td>
																								<td width="2"></td>
																								<td width="30%" class="ttl4" align="center"
																									style="padding: 7 0 7 0; cursor: hand;"
																									onclick="javascript:executeDetail(${list.fileVerId},'${list.fileVerName}')">${list.fileVerName}</td>
																								<td width="2"></td>
																								<td width="25%" class="ttl4" align="center"
																									style="padding: 7 0 7 0; cursor: hand;"
																									onclick="javascript:executeDetail(${list.fileVerId},'${list.fileVerName}')">${list.fileVerRank}</td>
																								<td width="2"></td>
																								<td width="35%" class="ttl4" align="center"
																									style="padding: 7 0 7 0; cursor: hand;"
																									onclick="javascript:executeDetail(${list.fileVerId},'${list.fileVerName}')">${list.fileVerSdate}</td>
																								<td width="3"></td>
																							</tr>
																							<tr>
																								<td height="1" colspan="12" bgcolor="#f3961d"></td>
																							</tr>
																						</c:forEach>
																					</c:otherwise>
																				</c:choose>
																				<tbody id="verTbody" style="display: none;">
																				</tbody>
																			</table>
																		</div>
																	</td>
																</tr>
																<tr>
																	<td height="10"></td>
																</tr>
															</table>
														</td>
														<!-- 데이터 버전 끝 -->
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
		</table> --%>
	</form:form>
</body>
</html>