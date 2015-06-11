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
<!-- <link rel="stylesheet" href="css/tmap.css" type="text/css" /> -->
<link rel="stylesheet" href="css/common.css" type="text/css" />
<link rel="stylesheet" href="css/layout_contents.css" type="text/css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/paging.js"></script>
<script type="text/javascript">
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

	});

	function selectRow(seq) {
		parent.document.ContentsForm.phModelInfoSeq.value = seq;
	}

	function phModelNew() {

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
		$("#ContentsForm").attr('action', 'PhModelInfoList.do');
		$("#ContentsForm").submit();
	};

	function executeNew() {
		$("#ContentsForm").attr('action', 'PhModelInfoNew.do');
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
		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<img src="images/h3_ico.gif"><span>단말모델 정보</span><br></br>
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
								<th>단말명</th>
								<th>단말정보</th>
								<th>OS버전명</th>
								<th>OS버전정보</th>
								<th>상태</th>
							</tr>
							<c:choose>
								<c:when test="${empty phModelList}">
									<tr>
										<td colspan="6" height="100" align="center">등록된 게시물이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="list" items="${phModelList}">
										<tr onmouseover="rowOnMouseOver(this);"
											onMouseOut="rowOnMouseOut(this);">
											<td class="td03"><input type="checkbox" class="radio"
												id="phModelInfoSeqs" name="phModelInfoSeqs"
												value="${list.phModelInfoSeq}" /></td>
											<td class="td03"
												onclick="javascript:executeDetail('${list.phModelInfoSeq}')">
												${list.phName}</td>
											<td class="td03"
												onclick="javascript:executeDetail('${list.phModelInfoSeq}')">
												${list.phContent}</td>
											<td class="td03"
												onclick="javascript:executeDetail('${list.phModelInfoSeq}')">
												${list.osVerName}</td>
											<td class="td03"
												onclick="javascript:executeDetail('${list.phModelInfoSeq}')">
												${list.osVerContent}</td>
											<td class="td03"
												onclick="javascript:executeDetail('${list.phModelInfoSeq}')">
												<c:if test="${list.phModelState == 'Y'}">
														사용
													</c:if> <c:if test="${list.phModelState == 'N'}">
														미사용
													</c:if>
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
							<form:select path="keywordTp" style="width:85px;">
								<form:option value="1" label="단말명" />
							</form:select>
							<form:input type="text" size="10" path="phName" />
							<img src="images/btn/search5.gif" id="btnSearch" name="btnSearch"
								style="vertical-align: bottom; width: 40px;"> <img
								src="images/btn/btn_delPhModel.gif" border="0"
								style="cursor: hand; vertical-align: bottom; width: 100px;"
								onclick="javascript:changeState('D')" /> <img
								src="images/btn/btn_usePhModel.gif" border="0"
								style="cursor: hand; vertical-align: bottom; width: 100px;"
								onclick="javascript:changeState('Y')" /> <img
								src="images/btn/btn_unUsePhModel.gif" border="0"
								style="cursor: hand; vertical-align: bottom; width: 110px;"
								onclick="javascript:changeState('N')" />
							<!--  <a
					href="javascript:executeNew();" onFocus="blur()"><img
					src="images/btn/btn_newPhModel.gif"
					style="vertical-align: bottom; width: 70px;"></a>
					<a href="DeviceInfoFrame.do" onFocus="blur()"><img
					src="images/btn/btn_apply2.gif"
					style="vertical-align: bottom; width: 70px;"></a> -->
							<a href="DeviceInfoFrame.do" onFocus="blur()"><img
								src="images/btn/btn_apply2.gif"
								style="vertical-align: bottom; width: 75px;"></a>
						</fieldset>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />

		<%-- <div id="contents">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="ttl7">[단말모델 정보]</td>
				</tr>
				<tr>
					<td><form:select path="keywordTp" style="width:85px;">
							<form:option value="1" label="단말명" />
						</form:select> <form:input type="text" size="30" path="phName" /> <img
						src="images/btn/search5.gif" id="btnSearch" name="btnSearch"
						style="vertical-align: bottom; width: 40px;"></td>
					<td align="right" style="padding: 0 0 5 0"><img
						src="images/btn/btn_delPhModel.gif" border="0"
						style="cursor: hand" onclick="javascript:changeState('D')" /> <img
						src="images/btn/btn_usePhModel.gif" border="0"
						style="cursor: hand" onclick="javascript:changeState('Y')" /> <img
						src="images/btn/btn_unUsePhModel.gif" border="0"
						style="cursor: hand" onclick="javascript:changeState('N')" /></td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="3"><img src="images/ttl_bar1.gif"></td>
					<td width="6%" background="images/ttl_bar2.gif" class="ttl"><input
						type="checkbox" name="chkCtrl"
						onclick="javascript:checkAll('ContentsForm', this.name, 'phModelInfoSeqs');" />
					</td>
					<td width="2" background="images/ttl_bar2.gif"><img
						src="images/ttl_line.gif"></td>
					<td width="20%" background="images/ttl_bar2.gif" class="ttl">단말
						명</td>
					<td width="2" background="images/ttl_bar2.gif"><img
						src="images/ttl_line.gif"></td>
					<td width="22%" background="images/ttl_bar2.gif" class="ttl">단말
						정보</td>
					<td width="2" background="images/ttl_bar2.gif"><img
						src="images/ttl_line.gif"></td>
					<td width="20%" background="images/ttl_bar2.gif" class="ttl">OS버전
						명</td>
					<td width="2" background="images/ttl_bar2.gif"><img
						src="images/ttl_line.gif"></td>
					<td width="22%" background="images/ttl_bar2.gif" class="ttl">OS버전
						정보</td>
					<td width="2" background="images/ttl_bar2.gif"><img
						src="images/ttl_line.gif"></td>
					<td width="10%" background="images/ttl_bar2.gif" class="ttl">상태</td>
					<td width="3"><img src="images/ttl_bar3.gif"></td>
				</tr>
			</table>
			<c:choose>
				<c:when test="${empty phModelList}">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td height="100" align="center">등록된 게시물이 없습니다.</td>
						</tr>
						<tr>
							<td height="1" class="line"></td>
						</tr>
					</table>
				</c:when>
				<c:otherwise>
					<c:forEach var="list" items="${phModelList}">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr onmouseover="rowOnMouseOver(this);"
								onMouseOut="rowOnMouseOut(this);">
								<td width="3"></td>
								<td width="6%" align="center" style="padding: 7 0 7 0"><input
									type="checkbox" class="radio" id="phModelInfoSeqs"
									name="phModelInfoSeqs" value="${list.phModelInfoSeq}" /></td>
								<td width="2"></td>
								<td width="20%" align="center" style="padding: 7 0 7 0"
									onclick="javascript:executeDetail('${list.phModelInfoSeq}')">
									<input type="text" class="invisiblebox" style="width: 160px"
									value="${list.phName}" readonly="readonly" />
								</td>
								<td width="2"></td>
								<td width="22%" align="center" style="padding: 7 0 7 0"
									onclick="javascript:executeDetail('${list.phModelInfoSeq}')">
									<input type="text" class="invisiblebox" style="width: 175px"
									value="${list.phContent}" readonly="readonly" />
								</td>
								<td width="2"></td>
								<td width="20%" align="center" style="padding: 7 0 7 0"
									onclick="javascript:executeDetail('${list.phModelInfoSeq}')">
									<input type="text" class="invisiblebox" style="width: 160px"
									value="${list.osVerName}" readonly="readonly" />
								</td>
								<td width="2"></td>
								<td width="22%" align="center" style="padding: 7 0 7 0"
									onclick="javascript:executeDetail('${list.phModelInfoSeq}')">
									<input type="text" class="invisiblebox" style="width: 175px"
									value="${list.osVerContent}" readonly="readonly" />
								</td>
								<td width="2"></td>
								<td width="10%" align="center" style="padding: 7 0 7 0"
									onclick="javascript:executeDetail('${list.phModelInfoSeq}')">
									<c:if test="${list.phModelState == 'Y'}">
										<img src="images/state/ic_map1.gif">
									</c:if> <c:if test="${list.phModelState == 'N'}">
										<img src="images/state/ic_map4.gif">
									</c:if>
								</td>
								<td width="3"></td>
							</tr>
							<tr>
								<td height="1" colspan="13" class="line"></td>
							</tr>
						</table>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<br> <br>
			<div id="divPageing" class="paging"></div>
		</div> --%>
	</form:form>
</body>
</html>