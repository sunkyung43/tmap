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
<link type="text/css" rel="stylesheet" href="css/jquery.stepy.css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script language="JavaScript" src="js/common.js"></script>
<script language="JavaScript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script language="JavaScript" src="js/formValidate.js"></script>
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="js/jquery.stepy.min.js"></script>
<script type="text/javascript">
	//이벤트 등록
	$(document).ready(function() {

		$("#stepContainer").stepy({
			back : function(index) {
			},
			next : function(index) {
				changeStep(index);
				return false;
			},
			select : function(index) {
			},
			finish : function(index) {
				save();
			},
			titleClick : false,
			backLabel : '< 이전',
		  	nextLabel:'다음 >'
		});

		//조회 버튼 클릭 이벤트 처리
		$("#btnSearch").bind("click", function() {
			fileInType();
		});

		$("#btnSearch2").bind("click", function() {
			verInFile();
		});

		//조회 버튼 엔터 이벤트 처리
		$("#searchDataFileName").bind("keydown", function(event) {
			if (event.keyCode == 13) {
				fileInType();
			}
		});

		$("#searchFileVerName").bind("keydown", function(event) {
			if (event.keyCode == 13) {
				verInFile();
			}
		});

	});

	function changeStep(index) {
		if (index == 2) {
			$('#stepContainer').stepy('step', 2);
		}
		if (index == 3) {
			$('#stepContainer').stepy('step', 3);
		}
		if (index == 4) {
			$('#stepContainer').stepy('step', 4);
		}
	}

	function save() {

		if (confirm("등록하시겠습니까?")) {
			//호출 및 메시지 출력
			$.post("fileServiceInsert.do", $("#ContentsForm").serialize(),
					function(data) {

						if (data.json.SUCCESS == "SUCCESS") {
							alert("등록완료.");
							$("#fileServId").val(data.json.servId);
							location.replace('fileServiceInfoList.do');
						} else {
							alert("등록실패.");
							return;
						}
					});

		}
	}

	function typeDetail(dataTypeId, dataTypeName) {
		$("#dataTypeId").val(dataTypeId);
		$("#sTypeName").val(dataTypeName);
		$("#sName").val("");
		$("#sContent").val("");
		$("#sStore").val("");
		fileInType();
	}

	function fileInType() {

		//호출 및 메시지 출력
		$
				.post(
						"fileInType.do",
						$("#ContentsForm").serialize(),
						function(data) {

							var fileInType = "";

							if (data.json.fileInType != "") {
								$
										.each(
												data.json.fileInType,
												function(idx, list) {
													fileInType += "<tr onmouseover=\"rowOnMouseOver(this);this.style.cursor='hand'\" onMouseOut=\"rowOnMouseOut(this);\" onclick=\"javascript:fileDetail("
															+ list.dataFileId
															+ ");\">";
													/* fileInType += "<td width=\"3\"></td>"; */
													fileInType += "<td>"
															+ list.rownum
															+ "</td>";
													/* fileInType += "<td width=\"1\"></td>"; */
													fileInType += "<td>"
															+ list.dataFileName
															+ "</td>";
													/* fileInType += "<td width=\"1\"></td>"; */
													fileInType += "<td>"
															+ list.storageName
															+ "</td>";
													/* fileInType += "<td width=\"1\"></td>"; */
													fileInType += "<td>"
															+ list.dataFileSdate
															+ "</td>";
													/* fileInType += "<td width=\"3\"></td>"; */
													fileInType += "</tr>";
													/* fileInType += "<tr>";
													fileInType += "<td height=\"1\" colspan=\"12\" bgcolor=\"#f3961d\"></td>";
													fileInType += "</tr>"; */
												});
							} else {
								fileInType += "<tr>";
								fileInType += "<td col height=\"100\" align=\"center\">등록된 데이터 파일이 없습니다.</td>";
								fileInType += "</tr>";
							}
							$("#verBasicTbody").show();
							$("#verTbody").hide();
							$("#fileBasicTbody").hide();
							$("#fileTbody").html(fileInType);
							$("#fileTbody").show();
						});

	}

	function fileDetail(dataFileId) {
		$("#dataFileId").val(dataFileId);
		verInFile();
	}

	function verInFile() {

		//호출 및 메시지 출력
		$
				.post(
						"fileSerVerInFile.do",
						$("#ContentsForm").serialize(),
						function(data) {

							var verInFile = "";

							if (data.json.verInFile != "") {
								$
										.each(
												data.json.verInFile,
												function(idx, list) {
													verInFile += "<tr onmouseover=\"rowOnMouseOver(this);this.style.cursor='hand'\" onMouseOut=\"rowOnMouseOut(this);\">";
													/* verInFile += "<td width=\"3\"></td>"; */
													verInFile += "<td>";
													if (list.state == "Y") {
														verInFile += "<input type=\"checkbox\" class=\"checkbox\" id=\"dataFileIds\" name=\"dataFileIds\" value=\""+list.fileVerId+"\" checked=\"checked\"/>";
													} else {
														verInFile += "<input type=\"checkbox\" class=\"checkbox\" id=\"dataFileIds\" name=\"dataFileIds\" value=\""+list.fileVerId+"\"/>";
													}
													verInFile += "</td>";
													/* verInFile += "<td width=\"2\"></td>"; */
													verInFile += "<td onclick=\"javascript:executeDetail("
															+ list.fileVerId
															+ ",'"
															+ list.fileVerName
															+ "')\">"
															+ list.fileVerName
															+ "</td>";
													/* verInFile += "<td width=\"2\"></td>"; */
													verInFile += "<td onclick=\"javascript:executeDetail("
															+ list.fileVerId
															+ ",'"
															+ list.fileVerName
															+ "')\">"
															+ list.fileVerRank
															+ "</td>";
													/* verInFile += "<td width=\"2\"></td>"; */
													verInFile += "<td onclick=\"javascript:executeDetail("
															+ list.fileVerId
															+ ",'"
															+ list.fileVerName
															+ "')\">"
															+ list.fileVerSdate
															+ "</td>";
													/* verInFile += "<td width=\"3\"></td>"; */
													verInFile += "</tr>";
													/* verInFile += "<tr>";
													verInFile += "<td height=\"1\" colspan=\"12\" bgcolor=\"#f3961d\"></td>";
													verInFile += "</tr>"; */
												});
							} else {
								verInFile += "<tr>";
								verInFile += "<td colspan='4' height=\"100\" align=\"center\">등록된 데이터 파일이 없습니다.</td>";
								verInFile += "</tr>";
								/* verInFile += "<tr>";
								verInFile += "<td height=\"1\" class=\"line\"></td>";
								verInFile += "</tr>"; */
							}
							$.each(data.json.fileDetail, function(idx, list) {
								$("#sName").val(list.dataFileName);
								$("#sContent").val(list.dataFileContent);
								$("#sStore").val(list.dataFileStore);
							});
							$("#verBasicTbody").hide();
							$("#verTbody").html(verInFile);
							$("#verTbody").show();
						});
	}

	function executeDetail(fileVerId, fileVerName) {

		$("#fileVerId").val(fileVerId);
		document.getElementById('pop_wrap').style.display = 'none';

		//호출 및 메시지 출력
		$
				.post(
						"verDetail.do",
						$("#ContentsForm").serialize(),
						function(data) {

							var verDetail = "";

							if (data.json.verDetail != "") {
								$
										.each(
												data.json.verDetail,
												function(idx, list) {
													verDetail += "<tr>";
													/* verDetail += "<td width=\"3\"></td>"; */
													verDetail += "<td>"
															+ list.file_name
															+ "</td>";
													/* verDetail += "<td width=\"1\"></td>"; */
													verDetail += "<td>"
															+ list.file_size
															+ "</td>";
													/* verDetail += "<td width=\"1\"></td>"; */
													verDetail += "<td>"
															+ list.file_sdate
															+ "</td>";
													/* verDetail += "<td width=\"1\"></td>"; */
													verDetail += "<td>"
															+ list.file_state
															+ "</td>";
													/* verDetail += "<td width=\"1\"></td>"; */
													verDetail += "<td>"
															+ list.file_update
															+ "</td>";
													/* verDetail += "<td width=\"3\"></td>"; */
													verDetail += "</tr>";
													/* verDetail += "<tr>";
													verDetail += "<td height=\"1\" colspan=\"12\" bgcolor=\"#f3961d\"></td>";
													verDetail += "</tr>"; */
												});
							} else {
								verDetail += "<tr>";
								verDetail += "<td height=\"100\" align=\"center\" colspan=\"5\">등록된 데이터 파일이 없습니다.</td>";
								verDetail += "</tr>";
								/* verDetail += "<tr>";
								verDetail += "<td height=\"1\" class=\"line\" colspan=\"12\"></td>";
								verDetail += "</tr>"; */
							}
							$("#popupTbody").html(verDetail);
							$("#verName").html("Ver Name : " + fileVerName);
							document.getElementById('pop_wrap').style.display = '';
						});

	}
</script>
</head>
<body>
	<!-- 레이어 팝업 -->
	<div id="pop_wrap" style="display: none;">
		<div id="pop_container" style="width: 400px; left:50% margin-left: -200px; top:70px;">
			<!-- <iframe src="about:blank" scrolling="no" frameborder="0"
				title="팝업 아이프레임 영역"></iframe> -->
			<div class="pop_contents">
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
							<th>파일명</th>
							<th>크기</th>
							<th>등록일</th>
							<th>상태</th>
							<th>업데이트</th>
						</tr>
					<tbody id="popupTbody">
					</tbody>
					<tr>
						<td colspan="10" align="right"><a
							onclick="document.getElementById('pop_wrap').style.display='none'; document.body.className='';">
								<input type="button" value="닫기" />
						</a></td>
					</tr>
				</table>





				<!-- <table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td id="verName" style="font-weight: bold; font-size: 12;"
							colspan="9"></td>
						<td align="right"><a
							onclick="document.getElementById('pop_wrap').style.display='none'; document.body.className='';">
								<input type="button" value="닫기" />
						</a></td>
					</tr>
					<tr>
						<td height="5"></td>
					</tr>
					<tr>
						<td width="3"><img src="images/ttl_bar1.gif"></td>
						<td width="25%" background="images/ttl_bar2.gif" class="ttl">파일명</td>
						<td width="1" background="images/ttl_bar2.gif"><img
							src="images/ttl_line.gif"></td>
						<td width="15%" background="images/ttl_bar2.gif" class="ttl">크기</td>
						<td width="1" background="images/ttl_bar2.gif"><img
							src="images/ttl_line.gif"></td>
						<td width="25%" background="images/ttl_bar2.gif" class="ttl">등록일</td>
						<td width="1" background="images/ttl_bar2.gif"><img
							src="images/ttl_line.gif"></td>
						<td width="17%" background="images/ttl_bar2.gif" class="ttl">사용여부</td>
						<td width="1" background="images/ttl_bar2.gif"><img
							src="images/ttl_line.gif"></td>
						<td width="18%" background="images/ttl_bar2.gif" class="ttl">업데이트</td>
						<td width="3"><img src="images/ttl_bar3.gif"></td>
					</tr>
					<tbody id="popupTbody">
					</tbody>
					<tr>
						<td height="5"></td>
					</tr>
					<tr>
						<td colspan="10" align="right"><a
							onclick="document.getElementById('pop_wrap').style.display='none'; document.body.className='';">
								<input type="button" value="닫기" />
						</a></td>
					</tr>
				</table> -->
			</div>
		</div>
	</div>
	<!--// 레이어 팝업 -->

	<form:form commandName="ContentsForm" id="ContentsForm"
		name="ContentsForm">
		<form:hidden path="dataTypeId" />
		<form:hidden path="dataFileId" />
		<form:hidden path="fileVerId" />
		<form:hidden path="fileServId" />
		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td width="650"><img src="images/h3_ico.gif"><span>파일
									서비스 등록</span></td>
							<td>
								<!-- <a href="javascript:save()" onFocus="blur()"><img
									src="images/btn/btn_apply2.gif" border="0"></a>&nbsp;  --> <a
								href="fileServiceInfoList.do" onFocus="blur()"><img
									src="images/btn/btn_list.gif" border="0"></a>
							</td>
						</tr>
					</table>
					<div id="stepContainer">
						<fieldset title="Step 1">
							<legend style="display: none;">데이터 타입 선택</legend>
							<table class="sub_0601_table">
								<colgroup>
									<col width="" />
									<col width="" />
								</colgroup>
								<tbody>
									<tr>
										<th>데이터 타입명</th>
										<th>내용</th>
									</tr>
									<c:forEach var="list" items="${dataTypeInfo}">
										<tr
											onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
											onMouseOut="rowOnMouseOut(this);"
											onclick="javascript:typeDetail('${list.dataTypeId}', '${list.dataTypeName}');">
											<td class="td03">${list.dataTypeName}</td>
											<td class="td03">${list.dataTypeContent}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</fieldset>
						<fieldset title="Step 2">
							<legend style="display: none;">데이터 파일 선택</legend>
							<table class="sub_0601_table">
								<colgroup>
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
								</colgroup>
								<tbody>
									<tr>
										<th>번호</th>
										<th>데이터 파일명</th>
										<th>저장공간</th>
										<th>등록일</th>
									</tr>
								
								<tbody id="fileBasicTbody">
									<tr>
										<td colspan="4" height="100" align="center">데이터 타입을
											선택해주세요.</td>
									</tr>
								</tbody>
								<tbody id="fileTbody" style="display: none;">
								</tbody>
								</tbody>
							</table>
							<div id="search">
								<fieldset>
									<form:select path="keywordTp">
										<form:option value="1" label="파일명" />
									</form:select>
									<form:input type="text" size="15" path="searchDataFileName" />
									<img src="images/btn/search5.gif" id="btnSearch"
										style="vertical-align: bottom; width: 40px;">
								</fieldset>
							</div>
						</fieldset>
						<fieldset title="Step 3">
							<legend style="display: none;">데이터 버전 선택</legend>
							<table class="sub_0601_table">
								<colgroup>
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
								</colgroup>
								<tbody>
									<tr>
										<th><input type="checkbox" name="chkCtrl"
											onclick="javascript:checkAll('ContentsForm', this.name, 'dataFileIds');" />
										</th>
										<th>버전명</th>
										<th>버전순위</th>
										<th>등록일</th>
									</tr>
								
								<tbody id="verBasicTbody">
									<tr>
										<td colspan="4" height="100" align="center">데이터 버전을
											선택해주세요.</td>
									</tr>
								</tbody>
								<tbody id="verTbody" style="display: none;">
								</tbody>
							</table>
							<div id="search">
								<fieldset>
									<form:select path="keywordTp">
										<form:option value="1" label="버전명" />
									</form:select>
									<form:input type="text" size="15" path="searchFileVerName" />
									<img src="images/btn/search5.gif" id="btnSearch2"
										style="vertical-align: bottom; width: 40px;">
								</fieldset>
							</div>
						</fieldset>
						<fieldset title="Step 4">
							<legend style="display: none;">파일 서비스 정보</legend>
							<table class="srvRegi">
								<colgroup>
									<col width="100px" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th>타입명</th>
										<td><input type="text" id="sTypeName" class="invisible"
											title="타입명" style="width: 95%;" readonly="readonly" /></td>
									</tr>
									<tr>
										<th>파일명</th>
										<td><input type="text" id="sName" class="invisible"
											title="파일명" style="width: 95%;" readonly="readonly" /></td>
									</tr>
									<tr>
										<th>파일내용</th>
										<td><input type="text" id="sContent" class="invisible"
											title="파일내용" style="width: 95%;" readonly="readonly" /></td>
									</tr>
									<tr>
										<th>파일등록 상태</th>
										<td><input type="text" id="sStore" class="invisible"
											title="file등록 유무" style="width: 95%;" readonly="readonly" /></td>
									</tr>
									<tr>
										<th>파일서비스 상태</th>
										<td><input type="radio" name="fileServState" value="Y" />
											사용 &nbsp;&nbsp; <input type="radio" name="fileServState"
											value="N" checked="checked" /> 미사용</td>
									</tr>
									<tr>
										<th>파일서비스 내용</th>
										<td><textarea name="etc" rows="5" class="textbox"
												style="width: 95%; height: 40" title="내용"></textarea></td>
									</tr>
								</tbody>
							</table>
						</fieldset>
						<input type="button" class="finish" value="완료" />







						<%-- <table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><img src="images/h3_ico.gif"><span>파일 서비스
										등록</span> <!-- <img src="images/title/title17.gif"> --></td>
								<td width="30"></td>
							</tr>
							<tr>
								<td height="10"></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td style="font-size: 13;"><b></b></td>
								<td class="btn"><a href="javascript:save()"
									onFocus="blur()"><img src="images/btn/btn_apply2.gif"
										border="0"></a>&nbsp; <a href="fileServiceInfoList.do"
									onFocus="blur()"><img src="images/btn/btn_list.gif"
										border="0"></a></td>
							</tr>
						</table>
						<table width="100%" border="0" cellpadding="10" cellspacing="1"
							bgcolor="#FF8200">
							<tr>
								<!-- 파일 서비스 정보 입력 시작 -->
								<td width="404" valign="top" bgcolor="#FFFFFF">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td height="4"></td>
													</tr>
													<tr>
														<td class="ttl7">[데이터 타입]</td>
													</tr>
													<tr>
														<td height="7"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td width="3"><img src="images/ttl_bar1.gif"></td>
														<td width="40%" background="images/ttl_bar2.gif"
															class="ttl">데이터 타입명</td>
														<td width="1" background="images/ttl_bar2.gif"><img
															src="images/ttl_line.gif"></td>
														<td width="60%" background="images/ttl_bar2.gif"
															class="ttl">내용</td>
														<td width="3"><img src="images/ttl_bar3.gif"></td>
													</tr>
												</table>
												<div style="overflow: auto; height: 170px;">
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0">
														<c:forEach var="list" items="${dataTypeInfo}">
															<tr
																onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
																onMouseOut="rowOnMouseOut(this);"
																onclick="javascript:typeDetail('${list.dataTypeId}', '${list.dataTypeName}');">
																<td width="3"></td>
																<td width="40%" class="ttl4">${list.dataTypeName}</td>
																<td width="1"></td>
																<td width="60%" class="ttl4">${list.dataTypeContent}</td>
																<td width="3"></td>
															</tr>
															<tr>
																<td height="1" colspan="12" bgcolor="#f3961d"></td>
															</tr>
														</c:forEach>
													</table>
												</div>
											</td>
										</tr>
										<tr>
											<td height="10"></td>
										</tr>
									</table>
								</td>
								<!-- 파일 서비스 정보 입력 끝 -->

								<!-- 데이터 타입 시작 -->
								<td width="50%" valign="top" bgcolor="#FFFFFF"
									style="padding-bottom: 30">
									<table width="404" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="4"></td>
										</tr>
										<tr>
											<td class="ttl7">[데이터 서비스 정보 입력]</td>
										</tr>
										<tr>
											<td height="7"></td>
										</tr>
									</table>
									<table width="404" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td><img src="images/box404_1.png"></td>
										</tr>
										<tr>
											<td align="center" background="images/box404_2.png">
												<table width="404" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td width="113" height="2" class="ttl4">타입명</td>
														<td width="1" bgcolor="#f3961d"></td>
														<td width="5"></td>
														<td class="ttl4"><input type="text" id="sTypeName"
															class="invisible" title="타입명" style="width: 95%;"
															readonly="readonly" /></td>
														<td width="5"></td>
													</tr>
													<tr>
														<td height="1" colspan="5" bgcolor="#f3961d"></td>
													</tr>
												</table>
												<table width="404" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td width="113" height="2" class="ttl4">파일명</td>
														<td width="1" bgcolor="#f3961d"></td>
														<td width="5"></td>
														<td class="ttl4"><input type="text" id="sName"
															class="invisible" title="파일명" style="width: 95%;"
															readonly="readonly" /></td>
														<td width="5"></td>
													</tr>
													<tr>
														<td height="1" colspan="5" bgcolor="#f3961d"></td>
													</tr>
												</table>
												<table width="404" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td width="113" height="2" class="ttl4">파일내용</td>
														<td width="1" bgcolor="#f3961d"></td>
														<td width="5"></td>
														<td class="ttl4"><input type="text" id="sContent"
															class="invisible" title="파일내용" style="width: 95%;"
															readonly="readonly" /></td>
														<td width="5"></td>
													</tr>
													<tr>
														<td height="1" colspan="5" bgcolor="#f3961d"></td>
													</tr>
												</table>
												<table width="404" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td width="113" height="2" class="ttl4">file등록 유무</td>
														<td width="1" bgcolor="#f3961d"></td>
														<td width="5"></td>
														<td class="ttl4"><input type="text" id="sStore"
															class="invisible" title="file등록 유무" style="width: 95%;"
															readonly="readonly" /></td>
														<td width="5"></td>
													</tr>
													<tr>
														<td height="1" colspan="5" bgcolor="#f3961d"></td>
													</tr>
												</table>
												<table width="404" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td width="113" height="2" class="ttl4">파일서비스 사용여부</td>
														<td width="1" bgcolor="#f3961d"></td>
														<td width="5"></td>
														<td class="ttl5"><input type="radio"
															name="fileServState" value="Y" /> 사용 &nbsp;&nbsp; <input
															type="radio" name="fileServState" value="N"
															checked="checked" /> 미사용</td>
														<td width="5"></td>
													</tr>
													<tr>
														<td height="1" colspan="5" bgcolor="#f3961d"></td>
													</tr>
												</table>
												<table width="404" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td width="113" class="ttl4">파일서비스 내용</td>
														<td width="1" bgcolor="#f3961d"></td>
														<td width="5"></td>
														<td class="ttl4"><textarea name="etc" rows="5"
																class="textbox" style="width: 95%; height: 40"
																title="내용"></textarea></td>
														<td width="5"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td><img src="images/box404_3.png"></td>
										</tr>
									</table>
								</td>
								<!-- 데이터 타입 끝 -->
							</tr>
							<tr>
								<!-- 데이터 파일 시작 -->
								<td width="404" valign="top" bgcolor="#FFFFFF"
									style="padding-bottom: 30">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td class="ttl7">[데이터 파일]</td>
														<td align="right"><form:select path="keywordTp">
																<form:option value="1" label="파일명" />
															</form:select> <form:input type="text" size="15"
																path="searchDataFileName" /> <img
															src="images/btn/search5.gif" id="btnSearch"
															style="vertical-align: bottom; width: 40px;"></td>
													</tr>
													<tr>
														<td height="5"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td width="3"><img src="images/ttl_bar1.gif"></td>
														<td width="10%" background="images/ttl_bar2.gif"
															class="ttl">번호</td>
														<td width="1" background="images/ttl_bar2.gif"><img
															src="images/ttl_line.gif"></td>
														<td width="30%" background="images/ttl_bar2.gif"
															class="ttl">데이터 파일명</td>
														<td width="1" background="images/ttl_bar2.gif"><img
															src="images/ttl_line.gif"></td>
														<td width="25%" background="images/ttl_bar2.gif"
															class="ttl">저장공간</td>
														<td width="1" background="images/ttl_bar2.gif"><img
															src="images/ttl_line.gif"></td>
														<td width="35%" background="images/ttl_bar2.gif"
															class="ttl">등록일</td>
														<td width="3"><img src="images/ttl_bar3.gif"></td>
													</tr>
												</table>
												<div style="overflow: auto; height: 170px;">
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0">
														<tbody id="fileBasicTbody">
															<tr>
																<td width="3"></td>
																<td colspan="13" width="100%" class="ttl4">데이터 타입을
																	선택해주세요.</td>
																<td width="3"></td>
															</tr>
															<tr>
																<td height="1" colspan="13" class="line"></td>
															</tr>
														</tbody>
														<tbody id="fileTbody" style="display: none;">
														</tbody>
													</table>
												</div>
											</td>
										</tr>
										<tr>
											<td height="10"></td>
										</tr>
									</table>
								</td>
								<!-- 데이터 파일 끝 -->

								<!-- 데이터 버전 시작 -->
								<td width="50%" valign="top" bgcolor="#FFFFFF"
									style="padding-bottom: 30">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td class="ttl7">[데이터 버전]</td>
														<td align="right"><form:select path="keywordTp">
																<form:option value="1" label="버전명" />
															</form:select> <form:input type="text" size="15"
																path="searchFileVerName" /> <img
															src="images/btn/search5.gif" id="btnSearch2"
															style="vertical-align: bottom; width: 40px;"></td>
													</tr>
													<tr>
														<td height="5"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td width="3"><img src="images/ttl_bar1.gif"></td>
														<td width="10%" background="images/ttl_bar2.gif"
															class="ttl"><input type="checkbox" name="chkCtrl"
															onclick="javascript:checkAll('ContentsForm', this.name, 'dataFileIds');" />
														</td>
														<td width="2" background="images/ttl_bar2.gif"><img
															src="images/ttl_line.gif"></td>
														<td width="30%" background="images/ttl_bar2.gif"
															class="ttl">버전명</td>
														<td width="2" background="images/ttl_bar2.gif"><img
															src="images/ttl_line.gif"></td>
														<td width="25%" background="images/ttl_bar2.gif"
															class="ttl">버전순위</td>
														<td width="2" background="images/ttl_bar2.gif"><img
															src="images/ttl_line.gif"></td>
														<td width="35%" background="images/ttl_bar2.gif"
															class="ttl">등록일</td>
														<td width="3"><img src="images/ttl_bar3.gif"></td>
													</tr>
												</table>
												<div style="overflow: auto; height: 170px;">
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0">
														<tbody id="verBasicTbody">
															<tr>
																<td width="3"></td>
																<td colspan="13" width="100%" class="ttl4">데이터 버전을
																	선택해주세요.</td>
																<td width="3"></td>
															</tr>
															<tr>
																<td height="1" colspan="13" class="line"></td>
															</tr>
														</tbody>
														<tbody id="verTbody" style="display: none;">
														</tbody>
													</table>
												</div>
											</td>
										</tr>
										<tr>
											<td height="10"></td>
										</tr>
									</table>
								</td>
								<!-- 데이터 버전 끝 -->
							</tr>
						</table> --%>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />


		<%-- <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  	<tr>
    	<td height="100%">
    	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
	    	<tr>
        		<td width="10" background="images/bg_bar.gif"></td>
        		<td height="100%" valign="top" class="contents">
        		<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="20">
            		<tr>
              			<td valign="top" bgcolor="#FFFFFF">
	            		<div id="contents" style="width: 850px">
              			<table border="0" cellspacing="0" cellpadding="0">
                  			<tr>
                    			<td><img src="images/h3_ico.gif"><span>파일 서비스 등록</span>
                    			<!-- <img src="images/title/title17.gif"> --></td>
                    			<td width="30"></td>
                  			</tr>
                  			<tr>
                    			<td height="10"></td>
                    			<td></td>
                    			<td></td>
                    			<td></td>
                  			</tr>
		                </table>
		              	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		                	<tr>
		                  		<td style="font-size: 13;"><b></b></td>
		                  		<td class="btn">
		                  		<a href="javascript:save()" onFocus="blur()"><img src="images/btn/btn_apply2.gif" border="0"></a>&nbsp;
		                  		<a href="fileServiceInfoList.do" onFocus="blur()"><img src="images/btn/btn_list.gif" border="0"></a></td>
		                	</tr>
		              	</table>
		              	<table width="100%" border="0" cellpadding="10" cellspacing="1" bgcolor="#FF8200">
		                	<tr>
		                		<!-- 파일 서비스 정보 입력 시작 -->
		                  		<td width="404" valign="top" bgcolor="#FFFFFF">
		                  		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		                        	<tr>
		                          		<td>
		                              	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		                                	<tr>
		                                		<td height="4"></td>
		                                	</tr>
		                                	<tr>
		                                  		<td class="ttl7">[데이터 타입]</td>
		                                  	</tr>
		                                  	<tr>
				                				<td height="7"></td>
				                			</tr>
		                              	</table>
		                            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		                                	<tr>
		                                  		<td width="3"><img src="images/ttl_bar1.gif"></td>
		                                  		<td width="40%" background="images/ttl_bar2.gif" class="ttl">데이터 타입명</td>
		                                  		<td width="1" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
		                                  		<td width="60%" background="images/ttl_bar2.gif" class="ttl">내용</td>
		                                  		<td width="3"><img src="images/ttl_bar3.gif"></td>
		                                	</tr>
		                              	</table>
										<div style="overflow:auto;height: 170px;" >
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<c:forEach var="list" items="${dataTypeInfo}">
											<tr onmouseover="rowOnMouseOver(this);this.style.cursor='hand'" onMouseOut="rowOnMouseOut(this);" onclick="javascript:typeDetail('${list.dataTypeId}', '${list.dataTypeName}');">
									    		<td width="3"></td>
									    		<td width="40%" class="ttl4">${list.dataTypeName}</td>
									    		<td width="1"></td>
									    		<td width="60%" class="ttl4">${list.dataTypeContent}</td>
									    		<td width="3"></td>
									    	</tr>
	    									<tr>
	    										<td height="1" colspan="12" bgcolor="#f3961d"></td>
											</tr>
									    	</c:forEach>
									    </table>
										</div>
		                            	</td>
		                        	</tr>
		                        	<tr>
		                          		<td height="10"></td>
		                        	</tr>
		                      	</table>
								</td>
				            	<!-- 파일 서비스 정보 입력 끝 -->
		                      	
		                      	<!-- 데이터 타입 시작 -->
		                  		<td width="50%" valign="top" bgcolor="#FFFFFF" style="padding-bottom:30">
		                  		<table width="404" border="0" cellspacing="0" cellpadding="0">
				              		<tr>
		                            	<td height="4"></td>
		                            </tr>
				                	<tr>	
										<td class="ttl7">[데이터 서비스 정보 입력]</td>
									</tr>
				                	<tr>
				                		<td height="7"></td>
				                	</tr>
								</table>
								<table width="404" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td><img src="images/box404_1.png"></td>
									</tr>
									<tr>
										<td align="center" background="images/box404_2.png">
										<table width="404" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="113" height="2" class="ttl4">타입명</td>
												<td width="1" bgcolor="#f3961d"></td>
												<td width="5"></td>
												<td class="ttl4">
												<input type="text" id="sTypeName" class="invisible" title="타입명" style="width: 95%;" readonly="readonly"/>
												</td>
												<td width="5"></td>
											</tr>
											<tr>
												<td height="1" colspan="5" bgcolor="#f3961d"></td>
											</tr>
										</table>
										<table width="404" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="113" height="2" class="ttl4">파일명</td>
												<td width="1" bgcolor="#f3961d"></td>
												<td width="5"></td>
												<td class="ttl4">
												<input type="text" id="sName" class="invisible" title="파일명" style="width: 95%;" readonly="readonly"/>
												</td>
												<td width="5"></td>
											</tr>
											<tr>
												<td height="1" colspan="5" bgcolor="#f3961d"></td>
											</tr>
										</table>
										<table width="404" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="113" height="2" class="ttl4">파일내용</td>
												<td width="1" bgcolor="#f3961d"></td>
												<td width="5"></td>
												<td class="ttl4">
												<input type="text" id="sContent" class="invisible" title="파일내용" style="width: 95%;" readonly="readonly"/>
												</td>
												<td width="5"></td>
											</tr>
											<tr>
												<td height="1" colspan="5" bgcolor="#f3961d"></td>
											</tr>
										</table>
										<table width="404" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="113" height="2" class="ttl4">file등록 유무</td>
												<td width="1" bgcolor="#f3961d"></td>
												<td width="5"></td>
												<td class="ttl4">
												<input type="text" id="sStore" class="invisible" title="file등록 유무" style="width: 95%;" readonly="readonly"/>
												</td>
												<td width="5"></td>
											</tr>
											<tr>
												<td height="1" colspan="5" bgcolor="#f3961d"></td>
											</tr>
										</table>
										<table width="404" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="113" height="2" class="ttl4">파일서비스 사용여부</td>
												<td width="1" bgcolor="#f3961d"></td>
												<td width="5"></td>
												<td class="ttl5">
												<input type="radio" name="fileServState" value="Y" /> 사용 &nbsp;&nbsp; 
												<input type="radio" name="fileServState" value="N" checked="checked" /> 미사용</td>
												<td width="5"></td>
											</tr>
											<tr>
												<td height="1" colspan="5" bgcolor="#f3961d"></td>
											</tr>
										</table>
										<table width="404" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="113" class="ttl4">파일서비스 내용</td>
												<td width="1" bgcolor="#f3961d"></td>
												<td width="5"></td>
												<td class="ttl4">
												<textarea name="etc" rows="5" class="textbox" style="width: 95%; height: 40" title="내용" ></textarea>
												</td>
												<td width="5"></td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td><img src="images/box404_3.png"></td>
									</tr>
								</table>
		                  		</td>
		                    	<!-- 데이터 타입 끝 -->
		                    </tr>
		                	<tr>
	                      		<!-- 데이터 파일 시작 -->
	                      		<td width="404" valign="top" bgcolor="#FFFFFF" style="padding-bottom:30">
		                  		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		                        	<tr>
		                          		<td>
		                              	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		                                	<tr>
		                                  		<td class="ttl7">[데이터 파일]</td>
		                                  		<td align="right">
		                                  		<form:select path="keywordTp" >
			        								<form:option value="1" label="파일명"/>
												</form:select>
												<form:input type="text" size="15" path="searchDataFileName" />
												<img src="images/btn/search5.gif" id="btnSearch" style="vertical-align: bottom; width: 40px;">
		                                  		</td>
		                                  	</tr>
		                                  	<tr>
				                				<td height="5"></td>
				                			</tr>
		                              	</table>
		                              	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		                                	<tr>
		                                  		<td width="3"><img src="images/ttl_bar1.gif"></td>
		                                  		<td width="10%" background="images/ttl_bar2.gif" class="ttl">번호</td>
		                                  		<td width="1" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
		                                  		<td width="30%" background="images/ttl_bar2.gif" class="ttl">데이터 파일명</td>
		                                  		<td width="1" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
		                                  		<td width="25%" background="images/ttl_bar2.gif" class="ttl">저장공간</td>
		                                  		<td width="1" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
		                                  		<td width="35%" background="images/ttl_bar2.gif" class="ttl">등록일</td>
		                                  		<td width="3"><img src="images/ttl_bar3.gif"></td>
		                                	</tr>
		                              	</table>
										<div style="overflow:auto;height: 170px;" >
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tbody id="fileBasicTbody">
											<tr>
												<td width="3"></td>
												<td colspan="13" width="100%" class="ttl4" >데이터 타입을 선택해주세요.</td>
												<td width="3"></td>
											</tr>
											<tr>
		                        				<td height="1" colspan="13" class="line"></td>
		                      				</tr>
											</tbody>
											<tbody id="fileTbody" style="display: none;">
											</tbody>
										</table>
										</div>
		                            	</td>
		                        	</tr>
		                        	<tr>
		                          		<td height="10"></td>
		                        	</tr>
		                      	</table>
		                    	</td>
		                    	<!-- 데이터 파일 끝 -->
		                    	
		                    	<!-- 데이터 버전 시작 -->
		                    	<td width="50%" valign="top" bgcolor="#FFFFFF" style="padding-bottom:30">
		                  		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		                        	<tr>
		                          		<td>
		                              	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		                                	<tr>
		                                  		<td class="ttl7">[데이터 버전]</td>
		                                  		<td align="right">
		                                  		<form:select path="keywordTp" >
			        								<form:option value="1" label="버전명"/>
												</form:select>
												<form:input type="text" size="15" path="searchFileVerName" />
												<img src="images/btn/search5.gif" id="btnSearch2" style="vertical-align: bottom; width: 40px;">
		                                  		</td>
		                                  	</tr>
		                                  	<tr>
				                				<td height="5"></td>
				                			</tr>
		                              	</table>
		                            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		                                	<tr>
		                                  		<td width="3"><img src="images/ttl_bar1.gif"></td>
		                                  		<td width="10%" background="images/ttl_bar2.gif" class="ttl">
													<input type="checkbox" name="chkCtrl" onclick="javascript:checkAll('ContentsForm', this.name, 'dataFileIds');"/>
												</td>
		                                  		<td width="2" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
		                                  		<td width="30%" background="images/ttl_bar2.gif" class="ttl">버전명</td>
		                                  		<td width="2" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
		                                  		<td width="25%" background="images/ttl_bar2.gif" class="ttl">버전순위</td>
		                                  		<td width="2" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
		                                  		<td width="35%" background="images/ttl_bar2.gif" class="ttl">등록일</td>
		                                  		<td width="3"><img src="images/ttl_bar3.gif"></td>
		                                	</tr>
		                              	</table>
										<div style="overflow:auto;height: 170px;" >
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tbody id="verBasicTbody">
											<tr>
												<td width="3"></td>
												<td colspan="13" width="100%" class="ttl4" >데이터 버전을 선택해주세요.</td>
												<td width="3"></td>
											</tr>
											<tr>
		                        				<td height="1" colspan="13" class="line"></td>
		                      				</tr>
											</tbody>
											<tbody id="verTbody" style="display: none;">
											</tbody>
										</table>
										</div>
		                            	</td>
		                        	</tr>
		                        	<tr>
		                          		<td height="10"></td>
		                        	</tr>
		                      	</table>
		                    	</td>
		                    	<!-- 데이터 버전 끝 -->
		                    </tr>
              			</table>
              			</div>
              			</td>
            		</tr>
        		</table>
        		</td>
			</tr>
    	</table>
    	</td>
	</tr>
</table> --%>
	</form:form>
</body>
</html>