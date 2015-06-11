<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
<!-- <link rel="stylesheet" href="css/tmap.css" type="text/css" /> -->
<link rel="stylesheet" href="css/common.css" type="text/css" />
<link rel="stylesheet" href="css/layout_contents.css" type="text/css" />
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<link rel="stylesheet" href="/resources/demos/style.css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/paging.js"></script>
<script type="text/javascript" src="js/formValidate.js"></script>
<script type="text/javascript" src="js/jquery.stepy.min.js"></script>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript" src="js/formValidate.js"></script>
<script type="text/javascript">
	
	//이벤트 등록
	$(document).ready(function() {
		$("#accordion").accordion({
			heightStyle : "content",
			active : Number($("#activeId").val())
		});
		
		fnPaging();

		//검색 조건 설정
		searchCondChange();

		$("#keywordTp").change(function() {
			searchCondChange();
		});

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

		$("#phMade").bind("keydown", function(event) {
			if (event.keyCode == 13) {
				searchPage(0);
			}
		});
	});

	//검색 조건 변경
	function searchCondChange(keywordTp) {
		if ($("#keywordTp").val() == "1") {
			$("#phMade").val("");
			$("#phMade").hide();
			$("#phName").show();

		} else {
			$("#phName").val("");
			$("#phName").hide();
			$("#phMade").show();

		}
	};

	function executeNew() {
		$("#ContentsForm").attr('action', 'PhInfoNewForm.do');
		$("#ContentsForm").submit();
	}

	function executeDetail(phInfoSeq) {
		$("#phInfoSeq").val(phInfoSeq);
		$("#ContentsForm").attr('action', 'PhInfoEditForm.do');
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
		$("#ContentsForm").attr('action', 'PhInfoFrame.do');
		$("#ContentsForm").submit();
	};

	function selectRow(seq, name) {
		parent.document.ContentsForm.phInfoSeq.value = seq;
		parent.document.ContentsForm.phName.value = name;
	}
	
	 function executeChangePhMade(phMade, index) {
		$("#activeId").val(index);
		$("#phMade").val(phMade);
		$("#ContentsForm").attr('action', 'PhInfoFrame.do');
		$("#ContentsForm").submit();
	} 
</script>
</head>
<body>
	<form:form commandName="ContentsForm">
		<form:hidden path="currentPage" />
		<form:hidden path="startRowNum" />
		<form:hidden path="countPerPage" />
		<form:hidden path="pageCount" />
		<form:hidden path="totalCount" />
		<form:hidden path="phInfoSeq" />
		<form:hidden path="phMade" />
		<form:hidden path="activeId" value="${activeId}" />
		
		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
				<img src="images/h3_ico.gif"><span>단말 모델 관리</span>
				<c:choose>
					<c:when test="${empty phInfoList}">
					 	<table class="sub_0601_table">
							<colgroup>
								<col width="" />
								<col width="" />
								<col width="" />
							</colgroup>
							<tbody>
								<tr>
									<!-- <th>선택</th> -->
									<th>단말명</th>
									<th>단말정보</th>
									<th>단말상태</th>
								</tr>
										<tr>
											<td colspan="3" height="100" class="td03">등록된 게시물이 없습니다.</td>
										</tr>
							</tbody>
						</table>
						<!-- <div id="paging"></div> -->
						<div id="search" style="font-size: 13px; width:100%">
							<fieldset>
								<%-- <form:select path="keywordTp" style="width:85px;">
									<form:option value="1" label="단말명" />
								</form:select>
								<form:input type="text" size="15" path="phName" />
								<img src="images/btn/search3.gif" id="btnSearch" name="btnSearch" style="vertical-align: bottom; width: 75px;">  --%>
								<img src="images/btn/btn_apply2.gif" style="cursor: hand; vertical-align: bottom; width: 75px;" onclick="javascript:executeNew();" alt="등록하기" />
							</fieldset>
						</div> 
						</c:when>
						<c:otherwise>
				 	<div id="accordion">
				 	<c:forEach var="phMadeList" items="${phMadeList}" varStatus="status">
						<h3 onclick="javascript:executeChangePhMade('${phMadeList.phMade}','${status.index}');">${phMadeList.phMade}</h3>
							<div>
								 	<table class="sub_0601_table">
										<colgroup>
											<col width="" />
											<col width="" />
											<col width="" />
										</colgroup>
										<tbody>
											<tr>
												<!-- <th>선택</th> -->
												<th>단말명</th>
												<th>단말정보</th>
												<th>단말상태</th>
											</tr>
											<c:choose>
												<c:when test="${empty phInfoList}">
													<tr>
														<td colspan="3" height="100" class="td03">등록된 게시물이 없습니다.</td>
													</tr>
												</c:when>
												<c:otherwise>
													<c:forEach var="phInfoList" items="${phInfoList}" varStatus="status">
													<c:set var="phMade" value="${phInfoList.phMade}" />
														<c:if test="${phInfoList.phMade == phMadeList.phMade}">
															<tr onmouseover="rowOnMouseOver(this);this.style.cursor='hand';" onMouseOut="rowOnMouseOut(this);">
																<td class="td03" onclick="javascript:executeDetail('${phInfoList.phInfoSeq}')"> ${phInfoList.phName}</td>
																<td class="td03" onclick="javascript:executeDetail('${phInfoList.phInfoSeq}')"> ${phInfoList.phContent}</td>
																<td class="td03" onclick="javascript:executeDetail('${phInfoList.phInfoSeq}')">
																	<c:if test="${phInfoList.phState == 'Y'}"> 사용 </c:if> 
																	<c:if test="${phInfoList.phState == 'N'}"> 미사용 </c:if>
																</td>
															</tr>
														</c:if>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</tbody>
									</table>
									 <c:if test="${phMadeList.phMade == phMade}"> 
									 <div id="paging"></div>
									<div id="search" style="font-size: 13px; width:100%">
										<fieldset>
											<%-- <form:select path="keywordTp" style="width:85px;">
												<form:option value="1" label="단말명" />
											</form:select>
											<form:input type="text" size="15" path="phName" />
											<img src="images/btn/search3.gif" id="btnSearch" name="btnSearch" style="vertical-align: bottom; width: 75px;">  --%>
											<img src="images/btn/btn_apply2.gif" style="cursor: hand; vertical-align: bottom; width: 75px;" onclick="javascript:executeNew();" alt="등록하기" />
										</fieldset>
									</div> 
									</c:if> 
							  </div>
					</c:forEach>
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