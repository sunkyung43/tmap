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
        $("#comTypeName").bind("keydown", function(event) {
            if (event.keyCode == 13) {	
            	searchPage(0);
            }
        });
    
	});
	
	function executeNew() {
		$("#ContentsForm").attr('action','comTypeInfoNew.do');
        $("#ContentsForm").submit();
	}
	
	function executeDetail(comTypeId) {
		$("#comTypeId").val(comTypeId);
		$("#ContentsForm").attr('action','comTypeInfoEdit.do');
        $("#ContentsForm").submit();
	}
	
	//리스트조회
    function searchPage(page) {
    	if (page == "" || page == 0){
	        $("#currentPage").val(1);
	    }else {
	        $("#currentPage").val(page);
	    }
		
	    $("#startRowNum").val((page-1) * ($('#countPerPage').val()));
    	$("#ContentsForm").attr('action','comTypeInfoList.do');
        $("#ContentsForm").submit();
    };
</script>
</head>
<body>
	<form:form commandName="ContentsForm">
		<form:hidden path="currentPage" />
		<form:hidden path="startRowNum" />
		<form:hidden path="countPerPage" />
		<form:hidden path="pageCount" />
		<form:hidden path="totalCount" />
		<form:hidden path="comTypeId" />

		<jsp:include page="../../common/menu.jsp" />

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
								<th>번호</th>
								<th>테스트통신방식</th>
								<th>내용</th>
								<th>등록일</th>
								<th>사용여부</th>
							</tr>
							<c:choose>
								<c:when test="${empty comTypeInfoList}">
									<tr>
										<td>등록된 게시물이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="list" items="${comTypeInfoList}">
										<tr
											onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
											onMouseOut="rowOnMouseOut(this);"
											onclick="javascript:executeDetail(${list.comTypeId});">
											<td class="td03">${list.rownum}</td>
											<td class="td03">${list.comTypeName}</td>
											<td class="td03">${list.comTypeContent}</td>
											<td class="td03">${list.comTypeSdate}</td>
											<td class="td03"><c:if
													test="${list.comTypeState == 'Y'}">사용</c:if> <c:if
													test="${list.comTypeState == 'N'}">미사용</c:if></td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<div id="paging"></div>
					<div id="search">
					<fieldset>
						<form:select path="keywordTp" style="width:100px;">
							<form:option value="1" label="통신방식명" />
						</form:select>
						<form:input type="text" size="30" path="comTypeName" />
						<img src="images/btn/search3.gif" id="btnSearch" name="btnSearch"
							style="vertical-align: bottom; width: 70px;">					
						<a href="javascript:executeNew();"
							onFocus="blur()"><img src="images/btn/btn_apply2.gif"
								style="vertical-align: bottom; width: 70px;"></a>
					</fieldset>
					</div>
				</div>
			</div>
			<div id="divPageing" class="paging"></div>
		</div>

		<jsp:include page="../../common/footer.jsp" />

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
														<td>
															<!-- <img src="images/title/title64.gif"> --> 통신방식 정보
														</td>
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
														<td><form:select path="keywordTp"
																style="width:100px;">
																<form:option value="1" label="통신방식명" />
															</form:select> <form:input type="text" size="30" path="comTypeName" />
															<img src="images/btn/search3.gif" id="btnSearch"
															name="btnSearch"
															style="vertical-align: bottom; width: 70px;"></td>
														<td class="btn"><a href="javascript:executeNew();"
															onFocus="blur()"><img src="images/btn/btn_apply2.gif"
																border="0"></a></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0">
													<tr class="aaa">

														<td width="10%">번호</td>

														<td width="25%">통신방식명</td>

														<td width="25%">내용</td>

														<td width="25%">등록일</td>

														<td width="15%">사용여부</td>

													</tr>
												</table>
												<c:choose>
													<c:when test="${empty comTypeInfoList}">
														<table width="100%" border="0" cellspacing="0"
															cellpadding="0">
															<tr>
																<td height="100" align="center">등록된 게시물이 없습니다.</td>
															</tr>
															<tr>
																<td height="1" class="line"></td>
															</tr>
														</table>
													</c:when>
													<c:otherwise>
														<table width="100%" border="0" cellspacing="0"
															cellpadding="0">
															<c:forEach var="list" items="${comTypeInfoList}">
																<tr
																	onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
																	onMouseOut="rowOnMouseOut(this);"
																	onclick="javascript:executeDetail(${list.comTypeId});">

																	<td width="10%" align="center">${list.rownum}</td>

																	<td width="25%" align="center">${list.comTypeName}</td>

																	<td width="25%" align="center">${list.comTypeContent}</td>

																	<td width="25%" align="center">${list.comTypeSdate}</td>

																	<td width="15%" align="center"><c:if
																			test="${list.comTypeState == 'Y'}">
																			<img src="images/state/ic_map1.gif">
																		</c:if> <c:if test="${list.comTypeState == 'N'}">
																			<img src="images/state/ic_map3.gif">
																		</c:if></td>
																	<td width="3"></td>
																</tr>
																<tr>
																	<!-- <td height="1" colspan="13" class="line"></td> -->
																</tr>
															</c:forEach>
														</table>
													</c:otherwise>
												</c:choose>
												<br> <br>
												<div id="divPageing" class="paging"></div>
											</div>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr></tr>
					</table>
				</td>
			</tr>
		</table> --%>
	</form:form>
</body>
</html>