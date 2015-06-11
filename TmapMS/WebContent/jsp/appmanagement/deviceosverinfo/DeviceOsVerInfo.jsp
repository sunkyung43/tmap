<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% 
	response.setHeader("cache-control","no-cache"); 
	response.setHeader("expires","0"); 
	response.setHeader("pragma","no-cache"); 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tmap Managerment Site</title>
<!--  Stylesheet		-------------------------------------------------------------------------->
<!-- <link rel="stylesheet" href="css/tmap.css" type="text/css" /> -->
<link rel="stylesheet" href="css/common.css" type="text/css" />
<link rel="stylesheet" href="css/layout_contents.css" type="text/css" />
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<link rel="stylesheet" href="/resources/demos/style.css" />
<link rel="stylesheet" href="http://www.tmap.co.kr/tmap2/css/layout_contents.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/earlyaccess/nanumgothic.css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/paging.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript"src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
<script type="text/javascript">

	$(function() {
		$("#tabs").tabs({
			active : "${activeId}"
		});
		
			$("#accordion").accordion({
				heightStyle : "content",
				active : Number($("#phNameId").val())
		});
	});
	//이벤트 등록
	$(document).ready(function() {

		fnPaging();

		//조회 버튼 클릭 이벤트 처리
		$("#btnSearch").bind("click", function() {
			searchPage(0);
		});

		//조회 버튼 엔터 이벤트 처리
		$("#phName").bind("keydown", function(event) {
			if (event.keyCode == 13) {
				searchPage(0);
			}
		});

		var phMadeVal = $("#phMade").val();
		
		if(phMadeVal != '' || phMadeVal != ''){
			$("li[id='"+phMadeVal+"']").attr('class', 'on');
			$("#전체").attr('class', '');	
		}else{
			$("#전체").attr('class', 'on');	
		}
		
	});

	function selectRow(seq) {
		parent.document.ContentsForm.phModelInfoSeq.value = seq;
	}

	function phModelNew() {

	}

	function executeDelete(){
		
		$.post("PhModelInfoDelete.do", $("#ContentsForm").serialize(),
				function(data) {
					if (data.json.result == true) {
						alert("삭제 되었습니다.");
						location.replace('DeviceOsVerInfo.do');
					} else {
						alert("삭제 실패했습니다.");
					}
				});
	}
	
	function changeState(state) {

		if (isChecked("ContentsForm", "phModelInfoSeqs")) {
			if (state == "D") {
				if (!confirm("삭제 하시겠습니까?"))
					return;
			} else if (state == "Y") {
				if (!confirm("선택한 단말모델을 사용하시겠습니까?"))
					return;
			} else if (state == "N") {
				if (!confirm("선택한 단말모델을 미사용하시겠습니까?"))
					return;
			}

			$("#phModelState").val(state);
			$("#ContentsForm").attr('action', 'PhModelChangeState.do');
			$("#ContentsForm").submit();
		} else {
			alert("단말모델을 선택해 주세요.");
		}
	}

	function executeDetail(phModelInfoSeq) {
		$("#phModelInfoSeq").val(phModelInfoSeq);
		$("#ContentsForm").attr('action', 'PhModelInfoDetail.do');
		$("#ContentsForm").submit();
	}

	//리스트조회
	function searchPage(page) {
		if (page == "" || page == 0) {
			$("#currentPage").val(1);
		} else {
			$("#currentPage").val(page);
		}

		$("#startRowNum").val((page - 1) * ($('#countPerPage').val()));
		$("#ContentsForm").attr('action', 'DeviceOsVerInfo.do');
		$("#ContentsForm").submit();
	};

	function executeNew() {
		$("#ContentsForm").attr('action', 'PhModelInfoNew.do');
		$("#ContentsForm").submit();
	}
	
	function search(phMade, phDivision) {
		$("#phMade").val(phMade);
		$("#phDivision").val(phDivision);
		$("#ContentsForm").attr('action', 'DeviceOsVerInfo.do');
		$("#ContentsForm").submit();
	}
	
	function executeChangeOsType(osDivision, index) {
		$("#activeId").val(index);
		$("#phDivision").val(osDivision);
		$("#ContentsForm").attr('action', 'DeviceOsVerInfo.do');
		$("#ContentsForm").submit();
	}
	
	function executeChangePhMade(phName, index) {
		$("#phNameId").val(index);
		$("#phName").val(phName);
		$("#ContentsForm").attr('action', 'DeviceOsVerInfo.do');
		$("#ContentsForm").submit();
	} 
</script>
</head>
<body>
	<form:form commandName="ContentsForm" id="ContentsForm"
		name="ContentsForm">
		<form:hidden path="currentPage" />
		<form:hidden path="startRowNum" />
		<form:hidden path="countPerPage" />
		<form:hidden path="pageCount" />
		<form:hidden path="totalCount" />
		<form:hidden path="phModelState" />
		<form:hidden path="phModelInfoSeq" />
		<form:hidden path="phMade" />
		<form:hidden path="phDivision" />
		<form:hidden path="activeId" value="${activeId}" />
		<form:hidden path="phNameId" value="${phNameId}" />

		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<img src="images/h3_ico.gif"><span>단말 - OS 조합 관리</span><br></br>
					<div id="tabs">
					<ul>
						<c:forEach var="osType" items="${osTypeList}" varStatus="status">
							<li onclick="executeChangeOsType('${osType.comCode}','${status.index}');">
								<a href="#tabs-${osType.comCode}">${osType.codeName}</a>
							</li>
						</c:forEach>
					</ul>
					<form:select path="keywordTp" style="width:85px; margin-left: 285;margin-top: 13; font-size: 13px;" >
								<form:option value="1" label="단말명" />
							</form:select>
							<form:input type="text" path="phName" style="margin-top: 13;"/>
							<img src="images/btn/search5.gif" id="btnSearch" name="btnSearch" style="vertical-align: bottom; width: 40px;"> 
							<a href="DeviceInfoFrame.do" onFocus="blur()"><img
								src="images/btn/btn_apply2.gif"
								style="vertical-align: bottom; width: 75px;"></a>
					<c:forEach var="osType" items="${osTypeList}" varStatus="status">
						<div id="tabs-${osType.comCode}">
						<div class="phoneSearch">
							<dl>
							<dd>
								<ul class="phoneManufacturer">
								<li id="전체" style="font-size: 13px; cursor:pointer;" onclick="javascript:search('', 'AND');" class="on">전체</li>
								<c:forEach var="phMadeList" items="${phMadeList}" varStatus="status">
								<li id="${phMadeList.phMade}" style="font-size: 13px; cursor:pointer;" class="" onclick="javascript:search('${phMadeList.phMade}', '');">${phMadeList.phMade}</li>
								</c:forEach>
								</ul>
							</dd>
							</dl>
						</div>
						
						<c:choose>
					<c:when test="${empty phModelList}">
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
									<th>선택</th>
									<th>단말정보</th>
									<th>OS버전명</th>
									<th>OS버전정보</th>
									<th>상태</th>
								</tr>
										<tr>
											<td colspan="5" height="100" class="td03">등록된 게시물이 없습니다.</td>
										</tr>
							</tbody>
						</table>
						</c:when>
						<c:otherwise>
						<div id="accordion">
						<c:forEach var="phModelName" items="${phModelNameList}" varStatus="status">
						<h3 onclick="javascript:executeChangePhMade('${phModelName.phName}','${status.index}');">${phModelName.phName}</h3>
							<div>
							<img src="images/btn/btn_delPhModel.gif" border="0" style="cursor: hand; margin-left:295px;" onclick="javascript:changeState('D')" /> 
							<img src="images/btn/btn_usePhModel.gif" border="0" style="cursor: hand" onclick="javascript:changeState('Y')" /> 
							<img src="images/btn/btn_unUsePhModel.gif" border="0" style="cursor: hand" onclick="javascript:changeState('N')" />
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
											<th>단말정보</th>
											<th>OS버전명</th>
											<th>OS버전정보</th>
											<th>상태</th>
										</tr>
										<c:choose>
											<c:when test="${empty phModelList}">
												<tr>
													<td colspan="5" height="100" class="td03">등록된 게시물이 없습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach var="phModelList" items="${phModelList}">
												 <c:set var="phName" value="${phModelList.phName}" />
												<c:if test="${phName == phModelName.phName}"> 
													<tr onmouseover="rowOnMouseOver(this);" onMouseOut="rowOnMouseOut(this);">
														<td class="td03">
															<input type="checkbox" class="radio" id="phModelInfoSeqs" name="phModelInfoSeqs" value="${phModelList.phModelInfoSeq}" />
														</td>
														<td class="td03" onclick="javascript:executeDetail('${phModelList.phModelInfoSeq}')">${phModelList.phName}</td>
														<td class="td03" onclick="javascript:executeDetail('${phModelList.phModelInfoSeq}')">${phModelList.osVerName}</td>
														<td class="td03" onclick="javascript:executeDetail('${phModelList.phModelInfoSeq}')">${phModelList.osVerContent}</td>
														<td class="td03" onclick="javascript:executeDetail('${phModelList.phModelInfoSeq}')">
															<c:if test="${phModelList.phModelState == 'Y'}"> 사용 </c:if> 
															<c:if test="${phModelList.phModelState == 'N'}"> 미사용</c:if>
														</td>
													</tr>
												 </c:if>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table> 
								 <c:if test="${phName == phModelName.phName}">
									<div id="paging"></div>
							 </c:if> 
							</div>
						</c:forEach>
						</div>
						</c:otherwise>
						</c:choose>
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