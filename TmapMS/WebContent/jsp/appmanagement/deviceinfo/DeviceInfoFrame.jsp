<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%
	String msg = (String) request.getAttribute("message");
%>
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
<link type="text/css" rel="stylesheet" href="css/jquery.stepy.css" />
<link rel="stylesheet" href="css/common.css" type="text/css" />
<link rel="stylesheet" href="css/layout_contents.css" type="text/css" />
<link rel="stylesheet" href="css/jquery-ui.css" type="text/css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/paging.js"></script>
<script type="text/javascript" src="js/formValidate.js"></script>
<script type="text/javascript" src="js/jquery.stepy.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.9.2.min.js"></script>
<script type="text/javascript"src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
<script type="text/javascript">

	$(function() {
		$("#accordion").accordion({
			heightStyle : "content",
			active : Number($("#activeId").val())
		});
		
		$("#tabs").tabs({
			active : "${activeId}"
		});
	});

	$(document).ready(function() {
		$("#stepContainer").stepy({
			back : function(index) {
			},
			next : function(index) {
				excute(index);
				return false;
			},
			select : function(index) {
			},
			finish : function(index) {
				executeNew();
			},
			titleClick : false,
			backLabel : '< 이전',
		nextLabel:'다음 >'
		});

	});
	function excute(index) {
		if (index == 2) {
			getOsModelList();
		}
	}
	function getOsModelList(){
		$.post("OSModelInfoList.do", $("#ContentsForm").serialize(),
				function(data){
				$("#osModelDiv").html(data);
				$('#stepContainer').stepy('step', 2);
		});
		
	}
	
	
	function executeNew() {
		if ($('input:checkbox[id="checkOsVerIds"]').is(":checked") == true) {
			if (confirm("등록 하시겠습니까?")) {
				$.post("PhModelInfoNew.do", $("#ContentsForm").serialize(),
						function(data) {
					if(data.json.message == ""){
						alert("등록 되었습니다.");
					} else{
						alert(data.json.message);
					}
					location.replace('DeviceOsVerInfo.do');
						});
			}
		}
		else {
			alert("OS버전을 선택하세요.");
		} 
	}

	function changeState(state) {
		var phModelInfoSeq = document.ContentsForm.phModelInfoSeq.value;

		if (phModelInfoSeq == "") {
			alert("선택된 값이 없습니다.");
			return;
		}
		if (state == "D") {
			if (!confirm("삭제 하시겠습니까?"))
				return;
		}
		document.ContentsForm.phModelState.value = state;
		document.ContentsForm.action = 'PhModelStateEditAction.action';
		//document.ContentsForm.target = 'PhModelInfoList';
		document.ContentsForm.submit();
	}
	function selectRow(seq, os){
		$("#phInfoSeq").val(seq);
		//$("#phName").val(name);
		$("#phDivision").val(os);
	}
	function selectOsModel(seq){
		$("#osVerInfoSeq").val(seq);
	}
	
	function executeChangeOsType(osDivision, index) {
		$("#activeId").val(index);
		$("#phDivision").val(osDivision);
		
		$.post("OSModelInfoList.do", $("#ContentsForm").serialize(),
				function(data){
				$("#osModelDiv").html(data);
				$('#stepContainer').stepy('step', 2);
		});
	}
	
 	 function executeChangePhMade(phMade, index) {
		$("#activeId").val(index);
		$("#phMade").val(phMade);
		$("#ContentsForm").attr('action', 'DeviceInfoFrame.do');
		$("#ContentsForm").submit();
	}  
</script>
</head>
<body>
	<form:form commandName="ContentsForm" name="ContentsForm">
		<form:hidden path="osVerInfoSeq"/>
		<form:hidden path="phInfoSeq"/>
		<form:hidden path="phModelInfoSeq"/>
		<form:hidden path="phModelState"/>
		<form:hidden path="phName"/>
		<form:hidden path="osVerName"/>
		 <form:hidden path="phDivision"/> 
		  <form:hidden path="phMade"/> 
		<form:hidden path="activeId" value="${activeId}" />
		
		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
				<img src="images/h3_ico.gif"><span>모델 버전 등록</span><br></br>
					<div id="stepContainer">
						<fieldset title="Step 1">
							<legend style="display: none;">단말기기 선택</legend>
							<div id="accordion">
								<c:forEach var="phMadeList" items="${phMadeList}" varStatus="status">
								<h3 onclick="javascript:executeChangePhMade('${phMadeList.phMade}','${status.index}');">${phMadeList.phMade}</h3>
								<div>
									<div>
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
													<th>선택</th>
													<th>단말명</th>
													<th>단말정보</th>
													<th>제조사</th>
													<th>단말상태</th>
												</tr>
												<c:choose>
													<c:when test="${empty phInfoList}">
														<tr>
															<td colspan="4" height="100" class="td03">등록된 게시물이 없습니다.</td>
														</tr>
													</c:when>
													<c:otherwise>
														<c:forEach var="phInfoList" items="${phInfoList}" varStatus="status">
														<c:set var="phMade" value="${phInfoList.phMade}" />
															<c:if test="${phInfoList.phMade == phMadeList.phMade}">
																<tr onmouseover="rowOnMouseOver(this);this.style.cursor='hand';" onMouseOut="rowOnMouseOut(this);">
																	<td class="td03">
																		<c:if test="${phInfoList.phState == 'Y'}">
																			<input type="radio" class="radio" id="checkPh" name="checkPh" checked="checked" onclick="selectRow('${phInfoList.phInfoSeq}', '${phInfoList.phDivision}');" />
																		</c:if>
																	</td>
																	<td class="td03">${phInfoList.phName}</td>
																	<td class="td03">${phInfoList.phContent}</td>
																	<td class="td03">${phInfoList.phMade}</td>
																	<td class="td03">
																		<c:if test="${phInfoList.phState == 'Y'}"> 사용</c:if> 
																		<c:if test="${phInfoList.phState == 'N'}"> 미사용</c:if>
																	</td>
																</tr>
															</c:if>
														</c:forEach>
													</c:otherwise>
												</c:choose>
											</tbody>
										</table>
										 <%-- <c:if test="${phMadeList.phMade == phMade}"> 
										 <div id="paging"></div>
										  <div id="search" style="font-size: 13px; width:100%">
											<fieldset>
												<form:select path="keywordTp" style="width:85px;">
													<form:option value="1" label="단말명" />
												</form:select>
												<form:input type="text" size="15" path="phName" />
												<img src="images/btn/search3.gif" id="btnSearch" name="btnSearch" style="vertical-align: bottom; width: 75px;"> 
											</fieldset>
										 </div>  
										 </c:if>  --%>
								    </div>
								</div>
								</c:forEach>
							</div> 
						</fieldset>
						<fieldset title="Step 2">
							<legend style="display: none">OS 버전 선택</legend>
							<div id="tabs">
								<ul>
									<c:forEach var="osType" items="${osTypeList}" varStatus="status">
										<li onclick="executeChangeOsType('${osType.comCode}','${status.index}');">
											<a href="#tabs-${osType.comCode}">${osType.codeName}</a>
										</li>
									</c:forEach>
								</ul>
								<c:forEach var="osType" items="${osTypeList}" varStatus="status">
									<div id="tabs-${osType.comCode}">
										<div class="contentDiv">
										 	<div id="osModelDiv"></div>
										</div>
									</div>
							   </c:forEach> 
							</div>
						</fieldset>
						<input type="button" class="finish" value="완료" />
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />
	</form:form>
</body>
</html>