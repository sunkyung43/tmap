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
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/paging.js"></script>
<script type="text/javascript">
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

	//리스트조회
	function searchPage(page) {
		if (page == "" || page == 0) {
			$("#currentPage").val(1);
		} else {
			$("#currentPage").val(page);
		}

		$("#startRowNum").val((page - 1) * ($('#countPerPage').val()));
		$("#ContentsForm").attr('action', 'PhInfoList.do');
		$("#ContentsForm").submit();
	};

	function selectRow(seq, name, phdivision) {
		parent.document.ContentsForm.phInfoSeq.value = seq;
		parent.document.ContentsForm.phName.value = name;
		parent.document.ContentsForm.phDivision.value = phdivision;
	}
</script>
</head>
<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0">
	<form:form commandName="ContentsForm">
		<form:hidden path="currentPage" />
		<form:hidden path="startRowNum" />
		<form:hidden path="countPerPage" />
		<form:hidden path="pageCount" />
		<form:hidden path="totalCount" />
		<form:hidden path="phInfoSeq" />
		<form:hidden path="phDivision" />
		<table>
			<tr>
				<td align="right"><form:select path="keywordTp"
						style="width:85px;">
						<form:option value="1" label="단말명" />
						<form:option value="2" label="제조사" />
					</form:select> <form:input type="text" size="15" path="phName" /> <form:input
						type="text" size="15" path="phMade" style="display:none;" /> <img
					src="images/btn/search5.gif" id="btnSearch" name="btnSearch"
					style="vertical-align: bottom; width: 40px;"></td>
			</tr>
		</table> 
		
		<!-- List  -->
		<%-- <jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
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
										<td colspan="5" height="100" align="center">등록된 게시물이
											없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="list" items="${phInfoList}">
										<tr
											onmouseover="rowOnMouseOver(this);this.style.cursor='hand';"
											onMouseOut="rowOnMouseOut(this);">
											<td class="td03"><c:if test="${list.phState == 'Y'}">
													<input type="radio" class="radio" name="choice"
														onclick="selectRow('${list.phInfoSeq}', '${list.phName}', '${list.phDivision}');" />
												</c:if></td>
											<td class="td03">${list.phName}</td>
											<td class="td03">${list.phContent}</td>
											<td class="td03">${list.phMade}</td>
											<td width="20%" align="center" style="padding: 7 0 7 0"><input
								type="text" class="invisiblebox" value="${list.phDivision}"
								readonly="readonly" /></td>
											<td class="td03"><c:if test="${list.phState == 'Y'}">
										사용
									</c:if> <c:if test="${list.phState == 'N'}">
										미사용
									</c:if></td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" /> --%>



	 <table width="100%">
			<tr>
				<td width="10%" class="ttl">선택</td>
				<td width="25%" class="ttl">단말 명</td>
				<td width="30%" class="ttl">단말 정보</td>
				<td width="15%" class="ttl">제조사</td>
				<td width="20%" class="ttl">단말 상태</td>
			</tr>
		</table>
		<table width="100%">
			<c:choose>
				<c:when test="${empty phInfoList}">
					<tr>
						<td height="100" align="center">등록된 게시물이 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="list" items="${phInfoList}">
						<tr onmouseover="rowOnMouseOver(this);this.style.cursor='hand';"
							onMouseOut="rowOnMouseOut(this);">
							<td width="10%" align="center" style="padding: 7 0 7 0"><c:if
									test="${list.phState == 'Y'}">
									<input type="radio" class="radio" name="choice"
										onclick="selectRow('${list.phInfoSeq}', '${list.phName}', '${list.phDivision}');" />
								</c:if></td>
							<td width="25%" align="center" style="padding: 7 0 7 0"><input
								type="text" class="invisiblebox" value="${list.phName}"
								readonly="readonly" /></td>
							<td width="30%" align="center" style="padding: 7 0 7 0"><input
								type="text" class="invisiblebox" value="${list.phContent}"
								readonly="readonly" /></td>
							<td width="15%" align="center" style="padding: 7 0 7 0"><input
								type="text" class="invisiblebox" value="${list.phMade}"
								readonly="readonly" /></td>
							<td width="20%" align="center" style="padding: 7 0 7 0"><input
								type="text" class="invisiblebox" value="${list.phDivision}"
								readonly="readonly" /></td>
							<td width="20%" align="center" style="padding: 7 0 7 0"><c:if
									test="${list.phState == 'Y'}">
									<img src="images/state/ic_map1.gif">
								</c:if> <c:if test="${list.phState == 'N'}">
									<img src="images/state/ic_map4.gif">
								</c:if></td>

						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
		<br>
		<div id="divPageing" class="paging"></div> 
	</form:form>
</body>
</html>