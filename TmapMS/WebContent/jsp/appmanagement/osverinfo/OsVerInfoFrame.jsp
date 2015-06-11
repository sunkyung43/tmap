<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="css/common.css" type="text/css" />
<link rel="stylesheet" href="css/layout_contents.css" type="text/css" />
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<link rel="stylesheet" href="/resources/demos/style.css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/paging.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript"src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript">
	$(function() {
		$("#tabs").tabs({
			active : "${activeId}"
		});
	});
	//이벤트 등록
	$(document).ready(function() {

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
		$("#osVerName").bind("keydown", function(event) {
			if (event.keyCode == 13) {
				searchPage(0);
			}
		});


	});

	//검색 조건 변경
	function searchCondChange(keywordTp) {
		if ($("#keywordTp").val() == "1") {
			$("#osVerName").show();

		} else {
			$("#osVerName").val("");
			$("#osVerName").hide();

		}
	};

	//리스트조회
	function searchPage(page) {
		if (page == "" || page == 0) {
			$("#currentPage").val(1);
		} else {
			$("#currentPage").val(page);
		}

		$("#startRowNum").val((page - 1) * ($('#countPerPage').val()));
		$("#ContentsForm").attr('action', 'OsVerInfoFrame.do');
		$("#ContentsForm").submit();
	};

	function selectRow(seq, name) {
		parent.document.ContentsForm.osVerInfoSeq.value = seq;
		parent.document.ContentsForm.osVerName.value = name;
	}

	function executeNew() {
		$("#ContentsForm").attr('action', 'OsVerInfoNewForm.do');
		$("#ContentsForm").submit();
	}

	function executeDetail(osVerInfoSeq) {
		$("#osVerInfoSeq").val(osVerInfoSeq);
		$("#ContentsForm").attr('action', 'OsVerInfoEditForm.do');
		$("#ContentsForm").submit();
	}

	function executeChangeOsType(osDivision, index) {
		$("#activeId").val(index);
		$("#osDivision").val(osDivision);
		$("#ContentsForm").attr('action', 'OsVerInfoFrame.do');
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
		<form:hidden path="osVerInfoSeq" />
		<form:hidden path="osDivision" />
		<form:hidden path="activeId" value="${activeId}" />

		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
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
								<img src="images/h3_ico.gif"><span>OS버전 정보</span>
								<table class="sub_0601_table">
									<colgroup>
										<col width="" />
										<col width="" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th>OS버전명</th>
											<th>OS버전정보</th>
											<th>OS버전상태</th>
										</tr>
										<c:choose>
											<c:when test="${empty osVerInfoFrame}">
												<tr>
													<td colspan="4" height="100" class="td03">등록된 게시물이 없습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach var="list" items="${osVerInfoFrame}">
													<tr onmouseover="rowOnMouseOver(this);this.style.cursor='hand';" onMouseOut="rowOnMouseOut(this);">
														<td class="td03" onclick="javascript:executeDetail('${list.osVerInfoSeq}')">${list.osVerName}</td>
														<td class="td03" onclick="javascript:executeDetail('${list.osVerInfoSeq}')">${list.osVerContent}</td>
														<td class="td03" onclick="javascript:executeDetail('${list.osVerInfoSeq}')">
															<c:if test="${list.osVerState == 'Y' }"> 사용</c:if> 
															<c:if test="${list.osVerState == 'N' }"> 미사용</c:if>
														</td>
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
						</div>
					</c:forEach>
						<div id="paging"></div>
						<div id="search" style="font-size: 13px; width:100%">
							<fieldset>
								<form:select path="keywordTp" style="width:85px;">
									<form:option value="1" label="OS버전명" />
								</form:select>
								<form:input type="text" size="15" path="osVerName" />
								<img src="images/btn/search5.gif" id="btnSearch" name="btnSearch" style="vertical-align: bottom; width: 40px;">
								<img src="images/btn/btn_apply2.gif" style="cursor: hand; vertical-align: bottom; width: 70px;" onclick="javascript:executeNew();" alt="등록하기" />
							</fieldset>
						</div>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />
	</form:form>
</body>
</html>