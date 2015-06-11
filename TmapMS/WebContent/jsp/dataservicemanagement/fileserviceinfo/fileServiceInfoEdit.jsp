<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="css/tmap.css" type="text/css" />
<link rel="stylesheet" href="css/common.css" type="text/css" />
<link rel="stylesheet" href="css/layout_contents.css" type="text/css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script language="JavaScript" src="js/common.js"></script>
<script language="JavaScript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script language="JavaScript" src="js/formValidate.js"></script>
<script type="text/javascript">
	
	//이벤트 등록
	$(document).ready(function() {
	
		//조회 버튼 클릭 이벤트 처리
		$("#btnSearch").bind("click", function() { verInFile(); });
		
		//조회 버튼 엔터 이벤트 처리
	    $("#searchFileVerName").bind("keydown", function(event) {
	        if (event.keyCode == 13) { verInFile(); }
	    });
	   	
	});
	
	function verInFile(){
		
		//호출 및 메시지 출력
	    $.post("verInFile2.do", $("#ContentsForm").serialize(), function(data) {
	    	
	    	var verInFile ="";
	    	
	    	if(data.json.verInFile != ""){
	    	$.each(data.json.verInFile, function(idx, list) {
	    		verInFile += "<tr bgcolor=\""+list.color+"\" onmouseover=\"rowOnMouseOver(this);\" onMouseOut=\"rowOnMouseOutColor(this, '"+list.color+"');\">";
	    		verInFile += "<td width=\"3\"></td>";
	    		verInFile += "<td width=\"10%\" align=\"center\" style=\"padding:7 0 7 0\">";
	    		if(list.state == "Y"){
	    		verInFile += "<input type=\"checkbox\" class=\"checkbox\" id=\"dataFileIds\" name=\"dataFileIds\" value=\""+list.fileVerId+"\" checked=\"checked\"/>";
				}else{
				verInFile += "<input type=\"checkbox\" class=\"checkbox\" id=\"dataFileIds\" name=\"dataFileIds\" value=\""+list.fileVerId+"\"/>";	    			
	    		}
	    		verInFile += "</td>";
	    		verInFile += "<td width=\"2\"></td>";
	    		verInFile += "<td width=\"30%\" class=\"ttl4\" align=\"center\" style=\"padding:7 0 7 0; cursor : hand;\" onclick=\"javascript:executeDetail("+list.fileVerId+",'"+list.fileVerName+"')\">"+list.fileVerName+"</td>";
	    		verInFile += "<td width=\"2\"></td>";
	    		verInFile += "<td width=\"25%\" class=\"ttl4\" align=\"center\" style=\"padding:7 0 7 0; cursor : hand;\" onclick=\"javascript:executeDetail("+list.fileVerId+",'"+list.fileVerName+"')\">"+list.fileVerRank+"</td>";
	    		verInFile += "<td width=\"2\"></td>";
	    		verInFile += "<td width=\"35%\" class=\"ttl4\" align=\"center\" style=\"padding:7 0 7 0; cursor : hand;\" onclick=\"javascript:executeDetail("+list.fileVerId+",'"+list.fileVerName+"')\">"+list.fileVerSdate+"</td>";
	    		verInFile += "<td width=\"3\"></td>";
	    		verInFile += "</tr>";
	    		verInFile += "<tr>";
	    		verInFile += "<td height=\"1\" colspan=\"12\" bgcolor=\"#f3961d\"></td>";
	    		verInFile += "</tr>";
	    	});
	    	}else{
	    		verInFile += "<tr>";
	    		verInFile += "<td height=\"50\" align=\"center\">등록된 데이터 파일이 없습니다.</td>";
	    		verInFile += "</tr>";
	    		verInFile += "<tr>";
	    		verInFile += "<td height=\"1\" class=\"line\"></td>";
	    		verInFile += "</tr>";
	    	}
	    	$("#versionInfo").html(verInFile);
	    });
	}
	
	function executeDetail(fileVerId, fileVerName){
		
		$("#fileVerId").val(fileVerId);
		document.getElementById('pop_wrap').style.display='none';
		
		
		//호출 및 메시지 출력
	    $.post("verDetail.do", $("#ContentsForm").serialize(), function(data) {
	    	
	    	var verDetail ="";
	    	
	    	if(data.json.verDetail != ""){
		    	$.each(data.json.verDetail, function(idx, list) {
		    		verDetail += "<tr>";
		    		/* verDetail += "<td width=\"3\"></td>"; */
		    		verDetail += "<td>"+list.file_name+"</td>";
	           		/* verDetail += "<td width=\"1\"></td>"; */
	           		verDetail += "<td>"+list.file_size+"</td>";
	           		/* verDetail += "<td width=\"1\"></td>"; */
	           		verDetail += "<td>"+list.file_sdate+"</td>";
	           		/* verDetail += "<td width=\"1\"></td>"; */
	           		verDetail += "<td>"+list.file_state+"</td>";
	           		/* verDetail += "<td width=\"1\"></td>"; */
	           		verDetail += "<td>"+list.file_update+"</td>";
	           		/* verDetail += "<td width=\"3\"></td>"; */
	           		verDetail += "</tr>";
	           		/* verDetail += "<tr>";
	           		verDetail += "<td height=\"1\" colspan=\"12\" bgcolor=\"#f3961d\"></td>";
	           		verDetail += "</tr>"; */
		    	});
		    	}else{
		    		verDetail += "<tr>";
		    		verDetail += "<td height=\"100\" align=\"center\" colspan=\"5\">등록된 데이터 파일이 없습니다.</td>";
		    		verDetail += "</tr>";
		    		/* verDetail += "<tr>";
		    		verDetail += "<td height=\"1\" class=\"line\" colspan=\"12\"></td>";
		    		verDetail += "</tr>"; */
		    	}
	    		$("#popupTbody").html(verDetail);
	    		$("#verName").html("Ver Name : "+fileVerName);
	    		document.getElementById('pop_wrap').style.display='';
	    });
	}
	
	function executeModify(fileServId, dataFileId){
		
		$("#fileServId").val(fileServId);
		$("#dataFileId").val(dataFileId);
		if(confirm("파일서비스를 수정하시겠습니까?")){
			 
			$.post("fileServiceUpdate.do", $("#ContentsForm").serialize(), function(data) {
				alert("수정되었습니다.");
				location.replace('fileServiceInfoList.do');
			});
		}
	}
	
	function executeDel(fileServId, state){
		
		$("#fileServId").val(fileServId);
		
		if(confirm("삭제하시겠습니까?")){
			if(state == 'Y'){
				alert("사용중인 파일서비스는 삭제할 수 없습니다.\n미사용으로 전환 후 삭제하십시요.");
				return;
			}else{
				$.post("fileServiceDelete.do", $("#ContentsForm").serialize(), function(data) {
					alert("삭제되었습니다.");
					$("#dataFileName").val("");
		    		$("#dataTypeId").val("");
					$("#ContentsForm").attr('action','fileServiceInfoList.do');
					$("#ContentsForm").submit();
				});
			}
		}
	}
	
	function dataFileServiceGo(fileServId, dataFileId){
		$("#fileServId").val(fileServId);
		$("#dataFileId").val(dataFileId);
		$("#ContentsForm").attr('action','dataFileServiceInfoEdit.do');

	}
</script>
</head>
<body>
	<!-- 레이어 팝업 -->
	<div id="pop_wrap" style="display: none;">
		<div id="pop_container" style="width: 400px; top: 190; left: 490">
			<iframe src="about:blank" scrolling="no" frameborder="0"
				title="팝업 아이프레임 영역"></iframe>
			<div style="overflow: auto; height: 250px;">
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
							<th>파일명</th>
							<th>크기</th>
							<th>등록일</th>
							<th>상태</th>
							<th>업데이트</th>
						</tr>
					<tbody id="popupTbody">
					</tbody>
					<tr>
						<td colspan="11" align="right"><a
							onclick="document.getElementById('pop_wrap').style.display='none'; document.body.className='';">
								<input type="button" value="닫기" />
						</a></td>
					</tr>
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

	<form:form commandName="ContentsForm" id="ContentsForm"
		name="ContentsForm">
		<form:hidden path="dataTypeId" />
		<form:hidden path="dataFileId" />
		<form:hidden path="fileVerId" />
		<form:hidden path="fileServId" />
		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td width="500"><img src="images/h3_ico.gif"><span>파일
									서비스 정보 수정</span></td>
							<td class="btn"><c:if
									test="${fileServiceInfo.fileServState == 'Y'}">
									<a
										href="javascript:dataFileServiceGo(${fileServiceInfo.fileServId}, ${fileServiceInfo.dataFileId});"
										onFocus="blur()"><img src="images/btn/apply6.gif"
										border="0"></a>&nbsp;
		                  		</c:if> <a
								href="javascript:executeDel('${fileServiceInfo.fileServId}','${fileServiceInfo.fileServState}');"
								onFocus="blur()"><img src="images/btn/delete7.gif"
									border="0"></a>&nbsp; <a
								href="javascript:executeModify(${fileServiceInfo.fileServId}, ${fileServiceInfo.dataFileId});"
								onFocus="blur()"><img src="images/btn/modify7.gif"
									border="0"></a>&nbsp; <a href="fileServiceInfoList.do"
								onFocus="blur()"><img src="images/btn/btn_list.gif"
									border="0"></a></td>
						</tr>
					</table>
					<table class="srvRegi">
						<colgroup>
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<tbody style="width: 598px">
							<tr class="td06">
								<th class="td06">타입명</th>
								<td>${fileServiceInfo.dataTypeName}</td>
							</tr>
							<tr>
								<th>파일명</th>
								<td>${fileServiceInfo.dataFileName}</td>
							</tr>
							<tr>
								<th>파일내용</th>
								<td>${fileServiceInfo.dataFileContent}</td>
							</tr>
							<tr>
								<th>파일등록 상태</th>
								<td>${fileServiceInfo.dataFileStore}</td>
							</tr>
							<tr>
								<th>파일서비스 상태</th>
								<td><input type="radio" name="fileServState" value="Y"
									<c:if test="${fileServiceInfo.fileServState == 'Y'}">checked="checked"</c:if> />
									사용 &nbsp;&nbsp; <input type="radio" name="fileServState"
									value="N"
									<c:if test="${fileServiceInfo.fileServState == 'N'}">checked="checked"</c:if> />
									미사용</td>
							</tr>
							<tr>
								<th>파일서비스 등록일</th>
								<td>${fileServiceInfo.fileServSdate}</td>
							</tr>
							<tr>
								<th>파일서비스 내용</th>
								<td><input type="text" name="etc" class="textbox"
										style="width: 100%;" title="내용" value="${fileServiceInfo.etc}"/>
								</td>
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
								<th><input type="checkbox" name="chkCtrl"
									onclick="javascript:checkAll('ContentsForm', this.name, 'dataFileIds');" /></th>
								<th>버전명</th>
								<th>버전순위</th>
								<th>등록일</th>
							</tr>
							<c:choose>
								<c:when test="${empty versionInfo}">
									<tr>
										<td colspan="4" height="100" align="center">등록된 데이터 버전이
											없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<tbody id="versionInfo">
										<c:forEach var="list" items="${versionInfo}">
											<tr bgcolor="${list.color}"
												onmouseover="rowOnMouseOver(this);"
												onMouseOut="rowOnMouseOutColor(this, '${list.color}')">
												<td class="td03"><input type="checkbox"
													class="checkbox" id="dataFileIds" name="dataFileIds"
													value="${list.fileVerId}"
													<c:if test="${list.state == 'Y'}">checked="checked"</c:if> />
												</td>
												<td class="td03"
													onclick="javascript:executeDetail(${list.fileVerId},'${list.fileVerName}')">${list.fileVerName}</td>
												<td class="td03"
													onclick="javascript:executeDetail(${list.fileVerId},'${list.fileVerName}')">${list.fileVerRank}</td>
												<td class="td03"
													onclick="javascript:executeDetail(${list.fileVerId},'${list.fileVerName}')">${list.fileVerSdate}</td>
											</tr>
										</c:forEach>
									</tbody>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<div id="search">
						<fieldset>
							<form:select path="keywordTp">
								<form:option value="1" label="버전명" />
							</form:select>
							<form:input type="text" size="15" path="searchFileVerName" />
							<img src="images/btn/search5.gif" id="btnSearch"
								style="vertical-align: bottom; width: 40px;">
						</fieldset>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />




		<%-- <table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td><img src="images/h3_ico.gif"><span>파일 서비스
									정보 수정하기</span></td>
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
							<td class="btn"><c:if
									test="${fileServiceInfo.fileServState == 'Y'}">
									<a
										href="javascript:dataFileServiceGo(${fileServiceInfo.fileServId}, ${fileServiceInfo.dataFileId});"
										onFocus="blur()"><img src="images/btn/apply6.gif"
										border="0"></a>&nbsp;
		                  		</c:if> <a
								href="javascript:executeDel('${fileServiceInfo.fileServId}','${fileServiceInfo.fileServState}');"
								onFocus="blur()"><img src="images/btn/delete7.gif"
									border="0"></a>&nbsp; <a
								href="javascript:executeModify(${fileServiceInfo.fileServId}, ${fileServiceInfo.dataFileId});"
								onFocus="blur()"><img src="images/btn/modify7.gif"
									border="0"></a>&nbsp; <a href="fileServiceInfoList.do"
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
										<td height="4"></td>
									</tr>
									<tr>
										<td class="ttl7">[데이터 서비스 정보 수정]</td>
									</tr>
									<tr>
										<td height="7"></td>
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
													<td class="ttl4"><input type="text" id="sTypeName"
														class="invisible" title="타입명" style="width: 95%;"
														value="${fileServiceInfo.dataTypeName}"
														readonly="readonly" /></td>
													<td width="5"></td>
												</tr>
												<tr>
													<td height="1" colspan="5" bgcolor="#f3961d"></td>
												</tr>
											</table>
											<table width="404" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="113" height="2" class="ttl4">파일명</td>
													<td width="1" bgcolor="#f3961d"></td>
													<td width="5"></td>
													<td class="ttl4"><input type="text" id="sName"
														class="invisible" title="파일명" style="width: 95%;"
														value="${fileServiceInfo.dataFileName}"
														readonly="readonly" /></td>
													<td width="5"></td>
												</tr>
												<tr>
													<td height="1" colspan="5" bgcolor="#f3961d"></td>
												</tr>
											</table>
											<table width="404" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="113" height="2" class="ttl4">파일내용</td>
													<td width="1" bgcolor="#f3961d"></td>
													<td width="5"></td>
													<td class="ttl4"><input type="text" id="sContent"
														class="invisible" title="파일내용" style="width: 95%;"
														value="${fileServiceInfo.dataFileContent}"
														readonly="readonly" /></td>
													<td width="5"></td>
												</tr>
												<tr>
													<td height="1" colspan="5" bgcolor="#f3961d"></td>
												</tr>
											</table>
											<table width="404" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="113" height="2" class="ttl4">file등록 유무</td>
													<td width="1" bgcolor="#f3961d"></td>
													<td width="5"></td>
													<td class="ttl4"><input type="text" id="sStore"
														class="invisible" title="file등록 유무" style="width: 95%;"
														value="${fileServiceInfo.dataFileStore}"
														readonly="readonly" /></td>
													<td width="5"></td>
												</tr>
												<tr>
													<td height="1" colspan="5" bgcolor="#f3961d"></td>
												</tr>
											</table>
											<table width="404" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="113" height="2" class="ttl4">파일서비스 사용여부</td>
													<td width="1" bgcolor="#f3961d"></td>
													<td width="5"></td>
													<td class="ttl5"><input type="radio"
														name="fileServState" value="Y"
														<c:if test="${fileServiceInfo.fileServState == 'Y'}">checked="checked"</c:if> />
														사용 &nbsp;&nbsp; <input type="radio" name="fileServState"
														value="N"
														<c:if test="${fileServiceInfo.fileServState == 'N'}">checked="checked"</c:if> />
														미사용</td>
													<td width="5"></td>
												</tr>
												<tr>
													<td height="1" colspan="5" bgcolor="#f3961d"></td>
												</tr>
											</table>
											<table width="404" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="113" height="2" class="ttl4">파일서비스 등록일</td>
													<td width="1" bgcolor="#f3961d"></td>
													<td width="5"></td>
													<td class="ttl4"><input type="text" class="invisible"
														title="파일서비스 등록일" style="width: 95%;"
														value="${fileServiceInfo.fileServSdate}"
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
															class="textbox" style="width: 95%; height: 40" title="내용">${fileServiceInfo.etc}</textarea>
													</td>
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
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td> --%>
		<%-- <table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="ttl7">[데이터 버전]</td>
								<td align="right"><form:select path="keywordTp">
										<form:option value="1" label="버전명" />
									</form:select> <form:input type="text" size="15" path="searchFileVerName" />
									<img src="images/btn/search5.gif" id="btnSearch"
									style="vertical-align: bottom; width: 40px;"></td>
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
									onclick="javascript:checkAll('ContentsForm', this.name, 'dataFileIds');" />
								</td>
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
										<tbody id="versionInfo">
											<c:forEach var="list" items="${versionInfo}">
												<tr bgcolor="${list.color}"
													onmouseover="rowOnMouseOver(this);"
													onMouseOut="rowOnMouseOutColor(this, '${list.color}')">
													<td width="3"></td>
													<td width="10%" align="center" style="padding: 7 0 7 0"><input
														type="checkbox" class="checkbox" id="dataFileIds"
														name="dataFileIds" value="${list.fileVerId}"
														<c:if test="${list.state == 'Y'}">checked="checked"</c:if> />
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
										</tbody>
									</c:otherwise>
								</c:choose>
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
					</table> --%>
		<%-- 	</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" /> --%>

		<%-- <table width="100%" height="100%" border="0" cellspacing="0"
			cellpadding="0">
			<tr>
				<td height="100%">
					<table width="100%" height="100%" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td height="100%" valign="top" class="contents">
								<table width="100%" height="100%" border="0" cellspacing="0"
									cellpadding="20">
									<tr>
										<td valign="top" bgcolor="#FFFFFF">
											<div id="contents" style="width: 850px">
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td><font style="font-weight: bold;">&nbsp;파일
																서비스 정보 수정하기</font> <!-- <img src="images/title/title17.gif"> --></td>
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
														<td class="btn"><c:if
																test="${fileServiceInfo.fileServState == 'Y'}">
																<a
																	href="javascript:dataFileServiceGo(${fileServiceInfo.fileServId}, ${fileServiceInfo.dataFileId});"
																	onFocus="blur()"><img src="images/btn/apply6.gif"
																	border="0"></a>&nbsp;
		                  		</c:if> <a
															href="javascript:executeDel('${fileServiceInfo.fileServId}','${fileServiceInfo.fileServState}');"
															onFocus="blur()"><img src="images/btn/delete7.gif"
																border="0"></a>&nbsp; <a
															href="javascript:executeModify(${fileServiceInfo.fileServId}, ${fileServiceInfo.dataFileId});"
															onFocus="blur()"><img src="images/btn/modify7.gif"
																border="0"></a>&nbsp; <a href="fileServiceInfoList.do"
															onFocus="blur()"><img src="images/btn/btn_list.gif"
																border="0"></a></td>
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
																	<td height="4"></td>
																</tr>
																<tr>
																	<td class="ttl7">[데이터 서비스 정보 수정]</td>
																</tr>
																<tr>
																	<td height="7"></td>
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
																				<td class="ttl4"><input type="text"
																					id="sTypeName" class="invisible" title="타입명"
																					style="width: 95%;"
																					value="${fileServiceInfo.dataTypeName}"
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
																				<td width="113" height="2" class="ttl4">파일명</td>
																				<td width="1" bgcolor="#f3961d"></td>
																				<td width="5"></td>
																				<td class="ttl4"><input type="text" id="sName"
																					class="invisible" title="파일명" style="width: 95%;"
																					value="${fileServiceInfo.dataFileName}"
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
																				<td width="113" height="2" class="ttl4">파일내용</td>
																				<td width="1" bgcolor="#f3961d"></td>
																				<td width="5"></td>
																				<td class="ttl4"><input type="text"
																					id="sContent" class="invisible" title="파일내용"
																					style="width: 95%;"
																					value="${fileServiceInfo.dataFileContent}"
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
																				<td width="113" height="2" class="ttl4">file등록
																					유무</td>
																				<td width="1" bgcolor="#f3961d"></td>
																				<td width="5"></td>
																				<td class="ttl4"><input type="text" id="sStore"
																					class="invisible" title="file등록 유무"
																					style="width: 95%;"
																					value="${fileServiceInfo.dataFileStore}"
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
																				<td width="113" height="2" class="ttl4">파일서비스
																					사용여부</td>
																				<td width="1" bgcolor="#f3961d"></td>
																				<td width="5"></td>
																				<td class="ttl5"><input type="radio"
																					name="fileServState" value="Y"
																					<c:if test="${fileServiceInfo.fileServState == 'Y'}">checked="checked"</c:if> />
																					사용 &nbsp;&nbsp; <input type="radio"
																					name="fileServState" value="N"
																					<c:if test="${fileServiceInfo.fileServState == 'N'}">checked="checked"</c:if> />
																					미사용</td>
																				<td width="5"></td>
																			</tr>
																			<tr>
																				<td height="1" colspan="5" bgcolor="#f3961d"></td>
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
																					class="invisible" title="파일서비스 등록일"
																					style="width: 95%;"
																					value="${fileServiceInfo.fileServSdate}"
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
																						title="내용">${fileServiceInfo.etc}</textarea></td>
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
																				<td align="right"><form:select path="keywordTp">
																						<form:option value="1" label="버전명" />
																					</form:select> <form:input type="text" size="15"
																						path="searchFileVerName" /> <img
																					src="images/btn/search5.gif" id="btnSearch"
																					style="vertical-align: bottom; width: 40px;">
																				</td>
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
																					onclick="javascript:checkAll('ContentsForm', this.name, 'dataFileIds');" />
																				</td>
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
																						<tbody id="versionInfo">
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
																										<c:if test="${list.state == 'Y'}">checked="checked"</c:if> />
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
																						</tbody>
																					</c:otherwise>
																				</c:choose>
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
						</tr>
					</table>
				</td>
			</tr>
		</table> --%>
	</form:form>
</body>
</html>