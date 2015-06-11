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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Tmap Managerment Site</title>
<!--  Stylesheet		-------------------------------------------------------------------------->
<link rel="stylesheet" href="css/common.css" type="text/css" />
<link rel="stylesheet" href="css/layout_contents.css" type="text/css" />
<!--  Stylesheet    -------------------------------------------------------------------------->
<script type="text/javascript" src="js/paging.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">

//이벤트 등록
$(document).ready(function() {

    fnPaging();
});
	function cdnInfoDetail(cdnPromoId, cdnServiceId, cdnServiceType) {
		$("#cdnPromoId").val(cdnPromoId);
		$("#cdnServiceId").val(cdnServiceId);
		$("#cdnServiceType").val(cdnServiceType);
		
		$("#ContentsForm").attr('action','cdnInfoEdit.do');
		$("#ContentsForm").submit();
	}
	function executeNew() {
		$("#ContentsForm").attr("action", "cdnInfoNew.do");
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
		$("#ContentsForm").attr('action', 'cdnInfoList.do');
		$("#ContentsForm").submit();
	};
</script>
</head>
<body>
	<form:form commandName="ContentsForm" id="ContentsForm"
		sname="ContentsForm">
		<form:hidden path="cdnPromoId" />
		<form:hidden path="cdnServiceId" />
		<form:hidden path="cdnServiceType" />
		<form:hidden path="currentPage" />
		<form:hidden path="startRowNum" />
		<form:hidden path="countPerPage" />
		<form:hidden path="pageCount" />
		<form:hidden path="totalCount" />
		
		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<img src="images/h3_ico.gif"> <span>CDN 정보</span>
					<table class="sub_0601_table">
						<colgroup>
							<col width="8%" />
							<col width="*" />
							<col width="20%" />
							<col width="20%" />
							<col width="12%" />
						</colgroup>
						<tbody>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>시작날짜</th>
								<th>끝난날짜</th>
								<th>상태</th>
							</tr>
							<c:choose>
								<c:when test="${empty cdnInfoList}">
									<tr>
										<td colspan="5" height="100" align="center">등록된 게시물이
											없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="list" items="${cdnInfoList}">
										<tr
											onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
											onMouseOut="rowOnMouseOut(this);"
											onclick="javascript:cdnInfoDetail(${list.cdnPromoId}, ${list.cdnServiceId}, '${list.cdnServiceType}');">
											<td class="td03">${list.rownum}</td>
											<td class="td03">${list.cdnPromoContent}</td>
											<td class="td03">${list.cdnPromoSdate}</td>
											<td class="td03">${list.cdnPromoEdate}</td>
											<td class="td03"><c:if
													test="${list.cdnPromoState == 'Y'}">
                                      						사용중 </c:if> <c:if
													test="${list.cdnPromoState == 'N'}"> 미사용 </c:if></td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<div id="paging"></div>
					<div id="search">
						<fieldset>
							<form:select class="select01" path="keywordTp">
								<form:option value="1" label="제목" />
							</form:select>
							<form:input type="text" size="30" path="cdnPromoContent"
								class="text01" />
							<img src="images/btn/search3.gif" id="btnSearch" name="btnSearch"
								style="vertical-align: bottom; width: 75px;"> <a
								href="javascript:executeNew();" onFocus="blur()"><img
								src="images/btn/btn_apply2.gif"
								style="vertical-align: bottom; width: 75px;"></a>
						</fieldset>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />
	</form:form>
</body>
</html>