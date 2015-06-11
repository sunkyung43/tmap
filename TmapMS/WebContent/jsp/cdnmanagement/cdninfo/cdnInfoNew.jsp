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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Tmap Managerment Site</title>
<!--  Stylesheet		---------------------------------------------------------------------->
<link rel="stylesheet" href="css/common.css" type="text/css" />
<link rel="stylesheet" href="css/tmap.css" type="text/css" />
<link rel="stylesheet" href="css/layout_contents.css" type="text/css" />
<link rel="stylesheet" href="css/jquery.stepy.css" type="text/css"/>
<!--  JavaScript    -------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="js/jquery.stepy.min.js"></script>
<script type="text/javascript" src="js/formValidate.js"></script>
<script type="text/javascript" src="js/calendar.js"></script>
<script type="text/javascript">

	//중복체크 버튼 클릭 여부
	var checkValue = "";
	
	$(document).ready(function() {
		
		//아이디 중복 체크 클릭시 이벤트 처리
		  $("#anchIdDup").click(function() {
		    checkValue = "T";
		    processIdDuplication();
		  });
		
		/* $("#stepContainer").stepy({
			back : function(index) {
			},
			next : function(index) {
				excute(index);
				return false;
			},
			select : function(index) {
			},
			finish : function(index) {
				executeDetailSave();
			},
			titleClick : false,
			backLabel : '< 이전',
			nextLabel:'다음 >'
		}); */
		$("#dataOpen").click(function() {
			$("#fileServiceInfoDiv").show();
			$("#AppMappingTypeDiv").hide();
		});

		$("#appOpen").click(function() {
			$("#fileServiceInfoDiv").hide();
			$("#AppMappingTypeDiv").show();
		});
		
		//var obj = document.getElementById('startdt');
		//var value = obj.options[obj.selectedlndex].value;
		
		//alert(value);
	});

	/* function excute() {		
		//if (index == 2) {
			//유효성 체크
			if ($("#cdnPromoContent").val() == "") {
				alert("제목을 입력하세요.");
				$("#cdnPromoContent").val("");
				$("#cdnPromoContent").focus();
				return;
			}else{
				executeSave();			
			}
			//DB 저장
		//}
		/* if (index == 3) {
			 executeDetailSave(); 
			$('#stepContainer').stepy('step', 3);
		}
		if (index == 4) {
			$('#stepContainer').stepy('step', 4);
		} 
	} */
	
	// 1단계 저장
	/* function executeSave() {
	$.post("cdnInfoInsert.do", $("#ContentsForm").serialize(),
			function(data) {
		
		 	alert(data.json.MESSAGE);
		 	
	        //$("#cdnPromoId").val(data.json.cdnPromoId);
	        $("#startdt").val(data.json.startdt);
	        $("#enddt").val(data.json.enddt);
	        
	        //$('#stepContainer').stepy('step', 2);
	});
	} */
	
	//아이디 중복 체크
	function processIdDuplication() {
	
	  //아이디 유효성 검증
	  if ($("#cdnPromoContent").val() == "") {
	    alert("제목을 입력하세요.");
	    $("#cdnPromoContent").val("");
	    $("#cdnPromoContent").focus();
	    return;
	  }
	
	  //검증조건 값 할당
	  $("#checkId").val($("#cdnPromoContent").val());
	
	  //호출 및 메시지 출력
	  $.post("processSerId.do", $("#ContentsForm").serialize(), 
	  	function(data) {
				if (data.json.check == "success") {
	     		 	alert("사용하실 수 있는 제목입니다.");
	   		 } else {
	      		alert("사용하실 수 없는 제목입니다.");
	    		 }
	  });
	}
	
	function executeDetailSave() {
		
		if ($("#cdnPromoContent").val() == "") {
			alert("제목을 입력하세요.");
			$("#cdnPromoContent").val("");
			$("#cdnPromoContent").focus();
			return;
		}else{
			$.post("cdnInfoInsert.do", $("#ContentsForm").serialize(),
					function(data) {
				
				 	//alert(data.json.MESSAGE);
				 	
			        //$("#cdnPromoId").val(data.json.cdnPromoId);
			        $("#startdt").val(data.json.startdt);
			        $("#enddt").val(data.json.enddt);
			        
			        //$('#stepContainer').stepy('step', 2);
			        
			        $.post("cdnDetailInsert.do", $("#ContentsForm").serialize(),
							function(data) {
						 	alert(data.json.MESSAGE);
						 	location.replace('cdnInfoList.do');
						 	/*$("#cdnPromoId").val(data.json.cdnPromoId);
					         $("#dataFileId").val(data.json.dataFileId); */
					});
			});
		}
	}
	
	function cdnDetail(id, type){
		
	  $("#cdnServiceId").val(id);
	  $("#cdnServiceType").val(type);
	 
	}
	
	function appDetail(type, id){
	  alert(seq);
	  $("#dataFileId").val(seq);
	  $.post("appServiceInfoList.do", $("#AppMappingListForm").serialize(), function(d){
	    alert(d.json);
	  });
	}
	
	/* function execute(appMappingId){
		
		$("#appMappingId").val(appMappingId);
		document.getElementById("appVerId").value;
		
		$.post("appMappingVer.do", $("#AppMappingListForm").serialize(), function(data){
			
			var mappingInfo ="";
	    
	   	if(data.json.MappingDetailList != ""){
	    	$.each(data.json.MappingDetailList, function(idx, list) {
	    		mappingInfo += "<tr onmouseover=\"rowOnMouseOver(this);this.style.cursor='hand';\" onMouseOut=\"rowOnMouseOut(this);\" onclick=\"getAppVerId('${list.appVerId}');\">";
	    		mappingInfo += "<td>"+list.appVerName+"</td>";
	    		mappingInfo += "<td>"+list.appVerContent+"</td>";
	    		mappingInfo += "<td>";
	    		if (list.state == 'Y') {
	    			mappingInfo += "사용";
	    		}else{
	    			mappingInfo += "미사용";
	    		}
	    		mappingInfo += "</td>";
	    		mappingInfo += "</tr>";
	    	});
	}
	    	else{
				mappingInfo += "<tr>";
				mappingInfo += "<td height=\"50\" align=\"center\">등록된 APP 버전이 없습니다.</td>";
				mappingInfo += "</tr>";
	}
			$("#popup2").html(mappingInfo);
			document.getElementById('pop_wrap').style.display='';
});
	} */
	
	function appExecuteDetail(appMappingId) {
		
		$("#appMappingId").val(appMappingId);
		
		$.post("appMappingInfo.do", $("#AppMappingListForm").serialize(), function(data){
			
			var appMappingInfo ="";
	    	
	    	if(data.json.appMappingDetailList != ""){
	    	$.each(data.json.appMappingDetailList, function(idx, list){
	    		appMappingInfo += "<input type='hidden' value="+list.appInfoSeq+"/>";
	    		appMappingInfo += "<tr onmouseover=\"rowOnMouseOver(this);this.style.cursor='hand';\" onMouseOut=\"rowOnMouseOut(this);\" onclick=\"getAppVerId('${list.appVerId}');\">";
	    		appMappingInfo += "<td onclick=\"javascript:cdnDetail("+list.appVerId+",'A');\"><input type='radio' class='radio' id='appId' name='appId' value=\""+list.appVerId+"\"/></td>";
	    		appMappingInfo += "<td>"+list.appVerName+"</td>";
	    		appMappingInfo += "<td>"+list.appVerContent+"</td>";
	    		appMappingInfo += "<td>";
	    		if (list.appVerState == 'Y') {
	    			appMappingInfo += "사용";
	    		}else{
	    			appMappingInfo += "미사용";	
	    			}
	    		appMappingInfo += "</tr>";
	    	});
	    	}else{
	    		appMappingInfo += "<tr>";
	    		appMappingInfo += "<td height=\"50\" align=\"center\">등록된 데이터 파일이 없습니다.</td>";
	    		appMappingInfo += "</tr>";
	    	}
	    	$("#popup_1").html(appMappingInfo);
	    	document.getElementById('pop_wrap2').style.display='';
	    	document.getElementById('pop_container2').style.display='';
	    });
	}
	
	function executeDetail(fileServId, dataFileId) {
		
		$("#fileServId").val(fileServId);
		$("#dataFileId").val(dataFileId);
	
		$.post("fileVerInfo.do", $("#fileServiceInfoForm").serialize(), function(data){
			
			var versionInfo ="";
	    
	    	if(data.json.versionInfo != ""){
	    	$.each(data.json.versionInfo, function(idx, list){
	    		versionInfo += "<tr bgcolor='${list.color}' onmouseover='rowOnMouseOver(this);' onMouseOut='rowOnMouseOutColor(this, '${list.color}')'>";
	    		versionInfo += "<td onclick=\"javascript:cdnDetail("+list.fileVerId+",'D');\"><input type='radio' class='radio' id='serviceId' name='serviceId' value=\""+list.fileVerId+"\"/></td>";
	    		versionInfo += "<td>"+list.fileVerName+"</td>";
	    		versionInfo += "<td>"+list.fileVerRank+"</td>";
	    		versionInfo += "<td>"+list.fileVerSdate+"</td>";
	    		versionInfo += "</tr>";
	    		/* versionInfo += "<tr onMouseOver=\"rowOnMouseOver(this);this.style.cursor='hand'\" onMouseOut=\"rowOnMouseOut(this);\" >";
	    		versionInfo += "<td>";
	    		if (list.state == 'Y') {
	    		versionInfo += "<input type=\"checkbox\" class=\"checkbox\" id=\"dataFileIds\" name=\"dataFileIds\" value=\"${list.fileVerId}\" checked=\"checked\" disabled=\"disabled\" />";
	    		}else{
	    			versionInfo += "<input type=\"checkbox\" class=\"checkbox\" id=\"dataFileIds\" name=\"dataFileIds\" value=\"${list.fileVerId}\"/>";
	    		}
	    		versionInfo += "</td>";
	    		versionInfo += "<td>"+list.fileVerName+"</td>";
	    		versionInfo += "<td>"+list.fileVerRank+"</td>";
	    		versionInfo += "<td>"+list.fileVerSdate+"</td>";
	    		versionInfo += "</tr>"; */
	    	});
	    	}else{
	    		versionInfo += "<tr>";
	    		versionInfo += "<td height=\"50\" align=\"center\">등록된 데이터 파일이 없습니다.</td>";
	    		versionInfo += "</tr>";
	    	}
	    	$("#popup").html(versionInfo);
	    	document.getElementById('pop_wrap').style.display='';
	    	document.getElementById('pop_container').style.display='';
	    });
	}
	
		function getAppVerId(appVerId) {
			
			$("#appVerId").val(appVerId);
			$("#verInTypeInfoTable").show();
		}

</script>
</head>
<body>
	<!-- 레이어 팝업 -->
	<div id="pop_wrap" style="display: none; position: absolute;">
		<div id="pop_container" style="overflow: auto; height: 250px; width: 600; left:650; top:100;">
			<!-- <div style="overflow: auto;"> -->
			<table>
				<tr>
					<td>
						<a onclick="document.getElementById('pop_wrap').style.display='none'; document.body.className='';">
							<input type="button" value="닫기" style="margin-left: 570px;" />
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
				</colgroup>
				<tbody>
					<tr>
						<th></th>
						<th>버전명</th>
						<th>버전순위</th>
						<th>등록일</th>
					</tr>
				<tbody id="popup"></tbody>
			</table>
			<table>
					<tr>
						<td>
							<a onclick="document.getElementById('pop_wrap').style.display='none'; document.body.className='';">
									<input type="button" value="확인" style="margin-left: 570px;" />
							</a>
						</td>
					</tr>
				</table>
		</div>
		</div>
		<%-- <div id="pop_container" style="overflow: auto; height: 250px; width: 600;">
			<table>
				<tr>
					<td><a
						onclick="document.getElementById('pop_wrap').style.display='none'; document.body.className='';">
							<input type="button" value="닫기" style="margin-left: 520px;" />
					</a></td>
				</tr>
			</table>
			<table class="sub_0601_table" id="appVersionInfoList">
				<colgroup>
					<col width="*" />
					<col width="*" />
					<col width="*" />
				</colgroup>
				<tbody>
					<tr>
						<th>버전명</th>
						<th>내용</th>
						<th>버전상태</th>
					</tr>
				<tbody id="popup2">
				</tbody>
			</table>
		</div> --%>
		<div id="pop_wrap2" style="display: none; position: absolute;">
			<div id="pop_container2" style="overflow: auto; height: 250px; width: 600; left:650; top:100;">
				<table>
					<tr>
						<td>
							<a onclick="document.getElementById('pop_wrap2').style.display='none'; document.body.className='';">
									<input type="button" value="닫기" style="margin-left: 570px;" />
							</a>
						</td>
					</tr>
				</table>
				<table class="sub_0601_table" id="appVersionInfoList">
					<colgroup>
						<col width="*" />
						<col width="*" />
						<col width="*" />
						<col width="*" />
					</colgroup>
					<thead>
						<tr>
							<th></th>
							<th>버전명</th>
							<th>내용</th>
							<th>버전상태</th>
						</tr>
					</thead>
					<tbody id="popup_1"></tbody>
				</table>
				<table>
					<tr>
						<td>
							<a onclick="document.getElementById('pop_wrap2').style.display='none'; document.body.className='';">
									<input type="button" value="확인" style="margin-left: 570px;" />
							</a>
						</td>
					</tr>
				</table>
				</div>
			</div>
	<%-- <div id="verInTypeInfoTable">
		<div id="pop_container" style="overflow: auto; height: 250px; width: 600;">
					<table class="sub_0601_table">
							<colgroup>
								<col width="35%">
								<col width="*">
							</colgroup>
							<thead>
								<tr>
									<th>데이터 타입명</th>
									<th>데이터 파일명</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${empty typeAndFile}">
										<tr>
											<td colspan="2" align="center">등록된 게시물이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:set var="prevAppName" value="" />
										<c:set var="rowSpanNumber" value="0" />
										<c:set var="line" value="1" />
										<c:forEach var="list" items="${typeAndFile}">
											<c:set var="currentAppName" value="${list.dataTypeName}" />
											<c:set var="rowDraw" value="false" />

											<c:if
												test="${prevAppName == '' || currentAppName != prevAppName}">
												<c:set var="prevAppName" value="${list.dataTypeName}" />
												<c:set var="rowDraw" value="true" />
											</c:if>

											<tr>
												<c:choose>
													<c:when test="${rowInfo[list.dataTypeName] == 1}">
														<td>${list.dataTypeName}</td>
													</c:when>
													<c:otherwise>
														<c:if test="${rowDraw}">
															<c:set var="rowSpanNumber"
																value="${(rowInfo[list.dataTypeName] * 2) - 1}" />
															<td rowspan="${rowSpanNumber}"
																style="border-bottom: 1px solid #CFCFCF; border-right: 1px solid #CFCFCF;">${list.dataTypeName}</td>
														</c:if>
													</c:otherwise>
												</c:choose>
												<c:choose>
													<c:when test="${list.dataFileName == null}">
														<td colspan="2">등록된 데이터 파일이 없습니다.</td>
													</c:when>
													<c:otherwise>
														<td
															onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
															onMouseOut="rowOnMouseOut(this);"
															onclick="javascript:typeAndFile('${list.dataFileId}', '${list.dataTypeName}');">
															${list.dataFileName}</td>
													</c:otherwise>
												</c:choose>
											</tr>

										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
							<tbody id="verTbody" style="display: none;">
							</tbody>
						</table>
</div>
</div> --%>

	<jsp:include page="../../common/menu.jsp" />
	<div id="bodyDiv">
		<div class="contentsDiv">
			<div class="contentDiv">
				<table>
					<tr>
						<td width="600px">
							<img src="images/h3_ico.gif"><span>CDN 등록</span>
						</td>
						<td>
						<a href="javascript:executeDetailSave();" onFocus="blur()">
						<img src="images/btn/btn_apply2.gif" border="0">
						</a> 
						<a href="cdnInfoList.do" onFocus="blur()">
							<img src="images/btn/btn_list.gif" border="0">
						</a>
						</td>
					</tr>
				</table>
				<br>
						<form:form commandName="ContentsForm" id="ContentsForm" name="ContentsForm">
							<form:hidden path="cdnServiceId" />
							<form:hidden path="cdnServiceType" />
							<form:hidden path="cdnPromoId"/>
							<!-- CDN Info 등록폼 -->
							<table class="srvRegi">
								<tbody>
									<tr>
										<th class="first">제목</th>
										<td class="first">
											<input type="text" id="cdnPromoContent"	name="cdnPromoContent" style="width: 550px;" class="regiInput" maxlength="150" />
											<a id="anchIdDup"><img src="images/btn/checkid.gif" align="absmiddle" style="cursor: hand"></a>
										</td>
									</tr>
									<tr>
										<th>사용여부</th>
										<td>
											<input type="radio" name="cdnPromoState" value="Y" checked="checked"> 
												<label for="cdnPromoState" class="MR20">사용</label> 
											<input type="radio" name="cdnPromoState" value="N"> 
												<label for="cdnPromoState" class="MR20">미사용</label>
										</td>
									</tr>
									<tr>
										<th>기간</th>
										<td>
											<input type="text" name="cdnPromoSdate" value="${cdnInfo.cdnPromoSdate}" class="textbox" maxlength="10" style="width: 92;" readonly="readonly" ONCLICK="Calendar(this);"> 
											<select name="startdt">
											<%
											for(int i = 0; i < 24; i++){
												String hour = String.format("%02d", i);
											%>
												 <option value="<%=hour %>"><%=hour %></option>
											<%}   %>
											</select> 시
											~ <input type="text" name="cdnPromoEdate" value="${cdnInfo.cdnPromoEdate}" class="textbox" maxlength="10" style="width: 92;" readonly="readonly" ONCLICK="Calendar(this);">&nbsp;&nbsp;
											<select name="enddt">
											<%
											for(int i = 0; i < 24; i++){
												String hour = String.format("%02d", i);
											%>
												 <option value="<%=hour %>"><%=hour %></option>
											<%}   %>
											</select> 시
										</td>
									</tr>
								</tbody>
							</table>
							<!-- <a href="javascript:excute();" onFocus="blur()">
								<img src="images/btn/btn_apply2.gif" border="0">
							</a>  -->
						</form:form>
						<br>
						<div>
							<span style="cursor: hand; font-size: 11pt" id="dataOpen">[데이터 정보]</span> 
							<span style="cursor: hand; font-size: 11pt" id="appOpen">[APP 정보]</span>
						</div>
						<div id="fileServiceInfoDiv">
							<form:form commandName="fileServiceInfoForm">
								<form:hidden path="currentPage" />
								<form:hidden path="startRowNum" />
								<form:hidden path="countPerPage" />
								<form:hidden path="pageCount" />
								<form:hidden path="totalCount" />
								<form:hidden path="fileServId" />
								<form:hidden path="dataFileId" />
								<table class="sub_0601_table">
									<colgroup>
										<col width="" />
										<col width="" />
										<col width="" />
										<col width="" />
										<col width="" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th></th>
											<th>파일명(타입명)</th>
											<th>서비스명</th>
											<th>배포정보</th>
											<th>배포타입</th>
											<th>배포여부</th>
										</tr>
										<c:choose>
											<c:when test="${empty dataFileServiceList}">
												<tr>
													<td colspan="6" height="100" class="td03">등록된 게시물이 없습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach var="list" items="${dataFileServiceList}">
													<tr onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"	onMouseOut="rowOnMouseOut(this);" onclick="javascript:executeDetail(${list.fileServId}, ${list.dataFileId});">
														<td class="td03">
															<input type="radio" disabled="disabled"/>
														</td>
														<td class="td03">${list.dataFileName} (${list.dataTypeName})</td>
														<td class="td03">
															<c:if test="${! empty list.fileServiceName}">${list.fileServiceName}</c:if>
															<c:if test="${list.fileServiceState != 'Y' && list.fileServiceState != 'N'}">미등록</c:if>
														</td>
														<td class="td03">
															<c:if test="${list.fileServiceState == 'Y'}">사용</c:if> 
															<c:if test="${list.fileServiceState == 'N'}">미사용</c:if>
														</td>
														<td class="td03">
															<c:if test="${list.fileServiceType == 'T'}">테스트배포</c:if> 
															<c:if test="${list.fileServiceType == 'R'}">배포</c:if>
														</td>
														<td class="td03">
															<c:if test="${list.fileServiceDistribute == 'P'}">배포중</c:if> 
															<c:if test="${list.fileServiceDistribute == 'S'}">배포중지</c:if>
														</td>
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
								<div id="paging"></div>
								<div id="search">
									<fieldset>
										<form:select path="dataTypeId">
											<form:option value="" label="== 선택 ==" />
											<c:forEach var="typeList" items="${typeList}">
												<form:option value="${typeList.dataTypeId}" label="${typeList.dataTypeName}" />
											</c:forEach>
										</form:select>
										<form:select path="keywordTp">
											<form:option value="1" label="파일명" />
										</form:select>
										<form:input type="text" size="30" path="dataFileName" />
											<img src="images/btn/search3.gif" id="btnSearch" name="btnSearch" style="vertical-align: bottom; width: 70px;">
									</fieldset>
								</div>
							</form:form>
						</div>
						<div id="AppMappingTypeDiv" style="display: none;">
							<form:form commandName="AppMappingListForm">
								<form:hidden path="currentPage" />
								<form:hidden path="startRowNum" />
								<form:hidden path="countPerPage" />
								<form:hidden path="pageCount" />
								<form:hidden path="totalCount" />
								<form:hidden path="appMappingId" />
								<form:hidden path="appVerId" />
								<table class="sub_0601_table">
									<colgroup>
										<col width="" />
										<col width="" />
										<col width="" />
										<col width="" />
										<col width="" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th></th>
											<th>매핑데이터명</th>
											<th>내용</th>
											<th>배포정보</th>
											<th>배포타입</th>
											<th>배포여부</th>
										</tr>
										<c:choose>
											<c:when test="${empty appServiceInfoList}">
												<tr>
													<td colspan="6" height="100" class="td03">등록된 게시물이 없습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach var="list" items="${appServiceInfoList}">
													<tr onmouseover="rowOnMouseOver(this);this.style.cursor='hand'" onMouseOut="rowOnMouseOut(this);" onclick="javascript:appExecuteDetail(${list.appMappingId});">
														<td class="td03">
															<input type="radio" name="choice" disabled="disabled" />
														</td>
														<td class="td03">${list.appMappingName}</td>
														<td class="td03">${list.appMappingContent}</td>
														<td class="td03">
															<c:if test="${list.appServiceState == 'Y'}">사용</c:if> 
															<c:if test="${list.appServiceState == 'N'}">미사용</c:if> 
															<c:if test="${list.appServiceState != 'Y' && list.appServiceState != 'N'}">미등록</c:if>
														</td>
														<td class="td03">
															<c:if test="${list.appServiceType == 'T'}">테스트배포</c:if> 
															<c:if test="${list.appServiceType == 'R'}">배포</c:if>
														</td>
														<td class="td03">
															<c:if test="${list.appServiceDistribute == 'P'}">배포중</c:if> 
															<c:if test="${list.appServiceDistribute == 'S'}">배포중지</c:if>
														</td>
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
								<div id="paging"></div>
								<div id="search">
									<fieldset>
										<form:select path="keywordTp">
											<form:option value="1" label="매핑데이터명" />
										</form:select>
										<form:input type="text" size="30" path="appMappingName" />
											<img src="images/btn/search3.gif" id="btnSearch" name="btnSearch" style="vertical-align: bottom; width: 70px;">
										<a href="javascript:executeNew()" onFocus="blur()"> 
											<img src="images/btn/btn_apply2.gif" style="vertical-align: bottom; width: 70px;"></a>
									</fieldset>
								</div>
							</form:form>
						</div>
					<!-- <input type="button" class="finish" value="완료" /> -->
					<!-- CDN 상세정보입력 -->
					<!-- 서비스타입<br /> 등록일<br /> cdn_data_sync_state<br /> cdn_promo_id<br /> -->
				</div>
			</div>
		</div>
	<jsp:include page="../../common/footer.jsp" />
</body>
</html>