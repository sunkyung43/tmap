<%@page import="java.util.Set"%>
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
<link rel="stylesheet" href="css/layout_contents.css" type="text/css" />
<link rel="stylesheet" href="css/base.css" type="text/css" />
<link rel="stylesheet" href="css/tmap.css" type="text/css" />
<!--  Stylesheet    -------------------------------------------------------------------------->
<script type="text/javascript" src="js/paging.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/calendar.js"></script>
<script type="text/javascript">
	
	//중복체크 버튼 클릭 여부
	var checkValue = "";
	
	//이벤트 등록
	$(document).ready(function() {
	
	  //아이디 중복 체크 클릭시 이벤트 처리
	  $("#anchIdDup").click(function() {
	    checkValue = "T";
	    processIdDuplication();
	  });
	
	});
	
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

	//수정
	function executeUpdate() {
		if (confirm("수정하시겠습니까?")) {
			$.post("cdnInfoUpdate.do", $("#ContentsForm").serialize(),
				function(data) {
					if (data.json.SUCCESS == 'SUCCESS') {
						alert("수정 되었습니다.")
						location.replace('cdnInfoList.do');
					} else {
						alert("수정 실패했습니다.");
					}
			});
		}
	}
	
	//삭제
	function executeDelete() {
		if (confirm("삭제하시겠습니까?")) {
			$.post("cdnInfoDelete.do", $("#ContentsForm").serialize(),
				function(data) {
					if (data.json.SUCCESS == 'SUCCESS') {
						alert("삭제되었습니다.");
						location.replace('cdnInfoList.do');
					} else {
						alert("삭제 실패했습니다.");
					}
			});
		}
	}
	
	
function executeDetail(fileServId, dataFileId) {
		$("#fileServId").val(fileServId);
		$("#dataFileId").val(dataFileId);
	
		$.post("fileVerInfo.do", $("#fileServiceInfoForm").serialize(), 
			function(data){
			
			var versionInfo ="";
	    	
		   	if(data.json.versionInfo != ""){
	    	$.each(data.json.versionInfo, function(idx, list){
	    		versionInfo += "<tr bgcolor='${list.color}' onmouseover='rowOnMouseOver(this);' onMouseOut='rowOnMouseOutColor(this, '${list.color}')'>";
	    		versionInfo += "<td><input type='radio' class='radio' id='serviceId' name='serviceId' /></td>";
	    		versionInfo += "<td>"+versionInfo.fileVerName+"</td>";
	    		versionInfo += "<td>"+list.fileVerRank+"</td>";
	    		versionInfo += "<td>"+list.fileVerSdate+"</td>";
	    		versionInfo += "</tr>";
	    	});
	    	} else {
	    		versionInfo += "<tr>";
	    		versionInfo += "<td height=\"50\" align=\"center\" colspan=\"4\">등록된 데이터 파일이 없습니다.</td>";
	    		versionInfo += "</tr>";
	    	}
	    	$("#popup").html(versionInfo);
	    	document.getElementById('VerInfo').style.display='';
	    });
	}
	
function fileVerDetail(fileVerId, fileVerName){
	
	$("#fileVerId").val(fileVerId);
	document.getElementById('pop_wrap').style.display='none';
	
	
	//호출 및 메시지 출력
    $.post("verDetail.do", $("#ContentsForm").serialize(), function(data) {
    	
    	var verDetail ="";
    	
    	if(data.json.verDetail != ""){
	    	$.each(data.json.verDetail, function(idx, list) {
	    		verDetail += "<tr>";
	    		/* verDetail += "<td width=\"3\"></td>"; */
	    		verDetail += "<td><a href="+list.url+"</a>"+list.url+"</td>";
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
	
</script>
</head>
<body>
<!-- 레이어 팝업 -->
  <div id="pop_wrap" style="display: none; position: absolute;">
    <div id="pop_container" style="height: 370px; top:80px; left:590px;">
    <iframe src="about:blank" scrolling="no" frameborder="0" title="팝업 아이프레임 영역"></iframe>
      <div style="overflow: auto; height: 370px;">
      <table>
        <tr>
          <td>
          	<a onclick="document.getElementById('pop_wrap').style.display='none'; document.body.className='';"> 
          		<input type="button" value="닫기" style="margin-left: 670;" />
          	</a>
          </td>
        </tr>
      </table>
      <table class="sub_0601_table" style="width: 700px;">
        <colgroup>
          <col width="18%" />
          <col width="15%" />
          <col width="20%" />
          <col width="18%" />
          <col width="25%" />
        </colgroup>
        <thead>
          <tr>
            <th>파일명</th>
            <th>크기</th>
            <th>등록일</th>
            <th>사용여부</th>
            <th>업데이트</th>
          </tr>
        </thead>
        <tbody id="popupTbody">
        </tbody>
      </table>
      </div>
    </div>
  </div>

	<form:form commandName="ContentsForm" id="ContentsForm" name="ContentsForm">
		<input type="hidden" name="cdnPromoId" value="${cdnInfo.cdnPromoId}">
		<input type="hidden" id="checkId" name="checkId" value="" />
		<form:hidden path="fileVerId" />
		<jsp:include page="../../common/menu.jsp" />	
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td width="560">
								<img src="images/h3_ico.gif"><span>CDN 수정</span>
							</td>
							<td class="btn">
								<a href="javascript:executeUpdate();" onFocus="blur()">
									<img src="images/btn/modify7.gif" border="0">
								</a> 
								<a href="javascript:executeDelete();" onFocus="blur()">
									<img src="images/btn/delete7.gif" border="0">
								</a> 
								<a href="cdnInfoList.do" onFocus="blur()">
									<img src="images/btn/btn_list.gif" border="0">
								</a>
							</td>
						</tr>
					</table>
					<br>
					<table class="srvRegi">
						<tbody>
							<tr class="td06">
								<th class="first">제목</th>
								<td class="first">
									<input type="text" id="cdnPromoContent" name="cdnPromoContent" value="${cdnInfo.cdnPromoContent}" style="width: 550px" class="regiInput" maxlength="150" />
									<a id="anchIdDup"><img src="images/btn/checkid.gif" align="absmiddle" style="cursor: hand"></a>
								</td>
							</tr>
							<tr>
								<th>사용여부</th>
								<td>
									<input type="radio" name="cdnPromoState" value="Y" <c:if test="${cdnInfo.cdnPromoState == 'Y'}">checked="checked"</c:if> />
										<label for="cdnPromoState" class="MR20">사용 </label>
									<input type="radio" name="cdnPromoState" value="N"<c:if test="${cdnInfo.cdnPromoState == 'N'}">checked="checked"</c:if> />
										<label for="cdnPromoState" class="MR20">미사용</label>
								</td>
							</tr>
							<tr>
								<th>기간</th>
								<td>
									<input type="text" name="cdnPromoSdate" value="${cdnInfo.cdnPromoSdate}" class="textbox" maxlength="10" style="width: 150;" readonly="readonly" ONCLICK="Calendar(this);"> 
									<select name="startdt">
									<% for(int i = 0; i < 24; i++){
										String hour = String.format("%02d", i);%>
										<c:set var="hour_" value="${cdnInfo.cdnStartHour}"/>
										<c:set var="hour__" value="<%=hour %>"/>
											<option value="<%=hour %>" <c:if test="${hour_ == hour__}" >selected</c:if> <c:if test="${hour_ != hour__}" ></c:if>><%=hour %></option>
									<%}%>
									</select> 시
									~ <input type="text" name="cdnPromoEdate" value="${cdnInfo.cdnPromoEdate}" class="textbox" maxlength="10" style="width: 150;"readonly="readonly" ONCLICK="Calendar(this);">
									<select name="enddt">
									<% for(int i = 0; i < 24; i++){
										String hour = String.format("%02d", i);%>
										<c:set var="hour_" value="${cdnInfo.cdnEndHour}"/>
										<c:set var="hour__" value="<%=hour %>"/>
											<option value="<%=hour %>" <c:if test="${hour_ == hour__}" >selected</c:if> <c:if test="${hour_ != hour__}" ></c:if>><%=hour %></option>
									<%}%>
									</select> 시
								</td>
							</tr>
						</tbody>
					</table>
					<c:choose>
						<c:when test="${cdnInfo.cdnServiceType == 'D'}">
							<div id="dataList">
								<table class="sub_0601_table">
									<colgroup>
										<col width="*" />
										<col width="20%" />
										<col width="15%" />
										<col width="8%" />
										<col width="22%" />
									</colgroup>
									<tbody>
										<tr>
											<th>파일명</th>
											<th>버전명</th>
											<th>타입</th>
											<th>버전순위</th>
											<th>등록일</th>
										</tr>
										<c:choose>
											<c:when test="${empty versionInfo}">
												<tr>
													<td colspan="6" height="100" class="td03">등록된 게시물이 	없습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach var="list" items="${versionInfo}">
													<tr onmouseover="rowOnMouseOver(this);this.style.cursor='hand'" onMouseOut="rowOnMouseOut(this);" onclick="javascript:fileVerDetail('${list.fileVerId}','${list.fileVerName}')">
														<td class="td03">${list.dataFileName}</td>
														<td class="td03">${list.fileVerName}</td>
														<td class="td03">Data</td>
														<td class="td03">${list.fileVerRank}</td>
														<td class="td03">${list.fileVerSdate}</td>
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
								</table>
							</div>
						</c:when>
						<c:otherwise>
							<div id="appList">
								<table class="sub_0601_table">
									<colgroup>
										<col width="" />
										<col width="" />
										<col width="" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th>버전명</th>
											<th>app 명</th>
											<th>등록일</th>
											<th>상태</th>
										</tr>
										<c:choose>
											<c:when test="${empty appVerInfo}">
												<tr>
													<td colspan="6" height="100" class="td03">등록된 게시물이
														없습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach var="list" items="${appVerInfo}">
													<tr onmouseover="rowOnMouseOver(this);this.style.cursor='hand'" onMouseOut="rowOnMouseOut(this);" onclick="">
														<td class="td03">${list.appVerName}</td>
														<td class="td03">${list.appName}</td>
														<td class="td03">${list.appVerSdate}</td>
														<td class="td03">
															<c:if test="${list.appVerState == 'Y'}">사용</c:if> 
															<c:if test="${list.appVerState == 'N'}">미사용</c:if> 
														</td>
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />
	</form:form>
</body>
</html>