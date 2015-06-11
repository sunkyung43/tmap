<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="java.util.Date"%>
<!-- 날짜 관련 import -->
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
<link rel="stylesheet" href="css/tmap.css" type="text/css" />
<link rel="stylesheet" href="css/layout_contents.css" type="text/css" />
<link rel="stylesheet" href="css/base.css" type="text/css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/formValidate.js"></script>
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="js/jquery.fixheadertable.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#dataTypeId").val("${dataFileInfo.dataTypeId}")
				.attr("selected", "true");
		$("#storageId").val("${dataFileInfo.storageId}").attr(
				"selected", "true");

		// Data File 정보 - 적용하기 클릭
		$("#btnDataFileRegister").click(function() {
			if (!formValidate(document.DataFileForm)) {
				return;
			}
			if (!$("input[name=dataFileState]:checked")
					.val()) {
				alert("Data File 사용여부를 선택해 주세요.");
				return;
			}

			$.post("dataFileInfoUpdate.do", $("#DataFileForm").serialize(),	function(data) {
						alert(data.json.MESSAGE);
			});
		});

		// Data File 정보 - 삭제 클릭
		$("#btnDataFileDelete").click(function() {
			if (!confirm("삭제하시겠습니까?")) {
				return;
			}
			$.post("dataFileInfoDelete.do", $("#DataFileForm").serialize(),	function(data) {
				alert(data.json.MESSAGE);

				$("#DataFileForm").attr("action", "dataFileInfoList.do");
				$("#DataFileForm").submit();
			});
		});

		// File Version 정보 - 적용하기 클릭
		$("#btnFileVersionRegister").bind("click",function() {
			if (!formValidate(document.FileVersionForm)) {
				return;
			}
			if (!$("input[name=fileVerState]:checked").val()) {
				alert("File Version 사용여부를 선택해 주세요.");
				return;
			}

			var action;
			if ($("#fileVerId").val() == "") {
				action = "fileVersionInfoInsert.do";
			} else {
				action = "fileVersionInfoUpdate.do";
			}

			$.post(action, $("#FileVersionForm").serialize(), function(data) {
				alert(data.json.MESSAGE);
				if (data.json.fileVerId	&& data.json.fileVerId != '') {
					$("#fileVersionInfoList").append("<option value=\""+data.json.fileVerId+"\">" + $("#fileVerName").val()	+ "</option>");
				}
			});
		});

		// File Version 정보 - 초기화 클릭
		$("#btnFileVersionReset").click(function() {
			reSetPage($("#FileVersionForm"));
		});
		$("#fileAdd").click(function() {
			// 파일 업로드 화면 출력
			$("#pop_wrap").show();
			// 파일 업로드 화면 출력
			$("#dataFileListIFrame").attr("src","dataFileListInfoList.do?dataFileId=${fileVersionInfo.dataFileId}&fileVerId="
        													+ $("#fileVerId").val()
        													+ "&fileVerName="
        													+ $("#fvname").val()
        													+ "&dataFileName="+ $("input[name='dataFileName']").val());
		});

		// File Version 정보 - 등록된 버전 클릭
		$("#fileVersionInfoList").click(function() {
			$("#fvname").val($("#fileVersionInfoList option:selected").text());
			$.post("fileVersionInfo.do", $("#fileVersionInfoList").serialize(), function(data) {
				// 버전 정보 셋팅
				reSetForm($("#FileVersionForm"));
				setFileVersionInfo(data.json.fileVersionInfo);
				// 파일 정보 셋팅
				$("#dataFileListInfo tr").remove();
				gridDataFileListInfoList(data.json.dataFileListInfoList);
			});
		});

		// File Version 정보 - 삭제 클릭
		$("#btnFileVersionDelete").click(function() {
			if (!confirm("삭제하시겠습니까?")) {
				return;
			}
			$.post("fileVersionInfoDelete.do", $("#FileVersionForm").serialize(), function(data) {
				alert(data.json.MESSAGE);

				$("#FileVersionForm").attr("action", "dataFileInfo.do");
				$("#FileVersionForm").submit();
			});
		});

		// 첨부파일 - 삭제 클릭
		$("#btnFileStateUpdate").click(function() {
			if ($("input:checkbox[name=fileListIds]:checked").size() < 1) {
				return;
			}
			var message, action;
			var selectFileAction = $("#selectFileAction").val();
			if (selectFileAction == "D") { // 삭제
				var data = new Array();
				$("input:checkbox[name=fileListIds]:checked").parent().parent().each(
					function(index, item) {
						$(this).find('input:eq(1)').attr('name','fileNames');
					});
				message = "삭제하시겠습니까?";
				action = "fileInfoDelete.do";
			} else if (selectFileAction == "Y") { // 필수
				$("#fileUpdate").val("Y");
				message = "필수 다운로드 파일로 등록 하시겠습니까?";
				action = "fileInfoRequisite.do";
			} else if (selectFileAction == "N") { // 필수해제
				$("#fileUpdate").val("N");
				message = "필수 다운로드 파일을 해제 하시겠습니까?";
				action = "fileInfoNonRequisite.do";
			} else {
				return;
			}

			if (!confirm(message)) {
				return;
			}
			$.post(action, $("#DataFileListForm").serialize(),function(data) {
				alert(data.json.MESSAGE);
				reSetPage($("#DataFileListForm"));
				reSetPage($("#FileVersionForm"));
				$("input[name='fileNames']").removeAttr(name);
			});
		});
	});

	// 첨부파일 - 파일 업로드 후 콜백함수
	function callbackFileUploadUploadSuccess(data) {
		var $dataJson = $.parseJSON(data);
		gridDataFileListInfoList($dataJson.json.dataFileListInfoList);
	}

	// 첨부파일 - 추가 데이터 테이블 그리기
	function gridDataFileListInfoList(dataFileListInfoList) {
		if (dataFileListInfoList == "") {
			return;
		}

		$.each(dataFileListInfoList,function(idx, list) {
			var addTr = "<tr>";
			addTr += "<td>";
			addTr += "<input type='checkbox' id='fileListIds' name='fileListIds' value='"+list.fileListId+"'/>";
			addTr += "</td>";
			addTr += "<td>";
			addTr += list.fileName;
			addTr += "</td>";
			addTr += "<td>";
			addTr += list.fileSize;
			addTr += " byte</td>";
			addTr += "<td>";
			if (list.fileUpdate == "Y") {
				addTr += "필수";
			} else {
				addTr += "-";
			}
			addTr += "</td>";
			$("#dataFileListInfo").append(addTr);
		});
	}

	// 버전 정보 셋팅
	function setFileVersionInfo(fileVersionInfo) {
		$("input[name=fileVerId]").val(fileVersionInfo.fileVerId);
		$("input[name=dataFileId]").val(fileVersionInfo.dataFileId);
		$("#fileVerSdate").val(fileVersionInfo.fileVerSdate);
		$("input[name=fileVerName]").val(fileVersionInfo.fileVerName);
		$("input[name=fileVerState]").filter("input[value=" + fileVersionInfo.fileVerState + "]").attr("checked", "checked");
		$("#etc").val(fileVersionInfo.etc);
	}

	function reSetPage(obj) {
		$("input[name=fileVerId]").val("");
		$("input[name=fileVerName]").val("");
		$("#dataFileListInfo tr").remove();
		$("#dataFileListIFrame").attr("src", "");
		reSetForm(obj);
	}

	function reSetForm(obj) {
		obj.each(function() {
			this.reset();
		});
	}

	function loadnext(divout, divin) {
		$("." + divout).hide();
		$("." + divin).fadeIn("fast");
	}
</script>
</head>
<body>
	<!-- 레이어 팝업 -->
	<div id="pop_wrap" style="display: none; position: absolute;">
		<input type="hidden" id="fvname" name="fvname" value="">
			<div id="pop_container123"
			style="overflow: auto; height: 330px; width: 500;"> 
			<table>
				<tr>
					<td><a
						onclick="document.getElementById('pop_wrap').style.display='none'; document.body.className='';">
							<input type="button" value="닫기" style="margin-left: 420px;" />
					</a></td>
				</tr>
			</table>
		<div id="dataFileListIFrameDiv">
			<iframe id="dataFileListIFrame" name="dataFileListIFrame"
				width="100%" height="300px" src="" frameborder="0" scrolling="yes"></iframe>
		</div>
		</div> 
	</div>
	<jsp:include page="../../common/menu.jsp" />
	<div id="bodyDiv">
		<div class="contentsDiv">
			<div class="contentDiv">
				<div id="accordion">
					<div>
						<form:form commandName="DataFileForm" name="DataFileForm">
							<form:hidden path="dataFileId" />
							<form:hidden path="dataTypeId" />
							<form:hidden path="storageId" />
							<table>
								<tr>
									<td width="530px"><img src="images/h3_ico.gif"><span>데이터
											파일정보 수정</span></td>
									<td><a href="#" onFocus="blur()" id="btnDataFileDelete"><img
											src="images/btn/delete7.gif" border="0"></a> <a href="#"
										onFocus="blur();"><img id="btnDataFileRegister"
											name="btnDataFileRegister" src="images/btn/btn_apply6.gif"
											border="0"></a>&nbsp; <a href="dataFileInfoList.do"
										onFocus="blur()"> <img src="images/btn/btn_list.gif"
											border="0">
									</a></td>
								</tr>
							</table>
							<br>
							<table class="srvRegi">
								<colgroup>
									<col width="100px">
									<col width="*">
								</colgroup>
								<tbody>
									<tr>
										<th class="first">등록일</th>
										<td class="first"><input type="text" class="noBorder"
											value="${dataFileInfo.dataFileSdate}" readonly="readonly" /></td>
									</tr>
									<tr>
										<th>File 명</th>
										<td><input type="text" id="username"
											style="width: 620px;" name="dataFileName"
											value="${dataFileInfo.dataFileName}" title="Data File 이름" /></td>
									</tr>
									<tr>
										<th>사용여부</th>
										<td><input type="radio" id="password"
											name="dataFileState" value="Y"
											<c:if test="${dataFileInfo.dataFileState == 'Y'}">checked="checked"</c:if> />
											사용 &nbsp;&nbsp; <input type="radio" id="password"
											name="dataFileState" value="N"
											<c:if test="${dataFileInfo.dataFileState == 'N'}">checked="checked"</c:if> />
											미사용</td>
									</tr>
									<tr>
										<th>Data Type</th>
										<td>${dataFileInfo.dataTypeName}</td>
									</tr>
									<tr>
										<th>저장경로</th>
										<td>${dataFileInfo.storageName}</td>
									</tr>
									<tr>
										<th>내용</th>
										<td><input type="text" name="dataFileContent"
											style="width: 620px;" title="내용"
											value="${dataFileInfo.dataFileContent}" /></td>
									</tr>
								</tbody>
							</table>
						</form:form>
					</div>
					<br>
					<div>
						<form:form commandName="FileVersionForm" name="FileVersionForm">
							<form:hidden path="dataFileId" />
							<form:hidden path="fileVerId" />
							<table style="margin-left: 610px;">
								<tr>
									<td>
										<!--<a href="#" onFocus="blur();" id="btnFileVersionReset">초기화</a> -->
										<a href="#" onFocus="blur();"><img
											id="btnFileVersionDelete" src="images/btn/delete7.gif"
											border="0"></a> <a href="#" onFocus="blur();"><img
											id="btnFileVersionRegister" src="images/btn/btn_apply6.gif"
											border="0"></a>
									</td>
								</tr>
							</table>
							<br>
							<table class="srvRegi">
								<colgroup>
									<col width="100px">
									<col width="*">
								</colgroup>
								<tbody>
									<tr>
										<th class="first">등록된 버전</th>
										<td class="first"><form:select id="fileVersionInfoList"
												name="fileVersionInfoList" path=""
												items="${fileVersionInfoList}" itemValue="fileVerId"
												itemLabel="fileVerName" multiple="false" cssClass="select"
												cssStyle="width: 620px;" size="3" /><br />
											<div class="noti">
												<ul>
													<li>등록된 버전 선택시 상세정보가 표시됩니다.</li>
													<li>파일 추가시 등록된 버전 선택후 사용하세요.</li>
												</ul>
											</div></td>
									</tr>
									<tr>
										<th>등록일</th>
										<td><input type="text" id="fileVerSdate" class="noBorder"
											style="width: 98%;" value="${fileVersionInfo.fileVerSdate}"
											<%--value="${dataFileInfo.dataFileSdate}" --%>
											readonly="readonly" /></td>
									</tr>
									<tr>
										<th>버전명</th>
										<td><input type="text" id="fileVerName"
											name="fileVerName" value="${fileVersionInfo.fileVerName}"
											class="regiInput" title="버전명" /></td>
									</tr>
									<tr>
										<th>사용여부</th>
										<td><input type="radio" id="fileVerState"
											name="fileVerState" value="Y"
											<c:if test="${fileVersionInfo.fileVerState == 'Y'}">checked="checked"</c:if>
											title="사용여부" /> <label class="MR20">사용</label><input
											type="radio" id="fileVerState" name="fileVerState" value="N"
											<c:if test="${fileVersionInfo.fileVerState == 'N'}">checked="checked"</c:if>
											title="사용여부" /> <label class="MR20">미사용</label></td>
									</tr>
									<tr>
										<th>비고</th>
										<td><textarea id="etc" name="etc"
												style="width: 98%; height: 50; resize: none;" title="비고">${fileVersionInfo.etc}</textarea></td>
									</tr>
								</tbody>
								<!-- 								<tr> -->
								<!-- 										<td class="ttl7">[File Version 정보]</td> -->
								<!-- 									<td class="btn"></td> 사용 &nbsp;&nbsp; -->
								<!-- 								</tr> -->
							</table>
						</form:form>
						<form:form commandName="DataFileListForm" name="DataFileListForm">
							<form:hidden path="dataFileId" />
							<form:hidden path="fileVerId" />
							<input type="hidden" id="fileVerName" name="fileVerName" />
							<input type="hidden" id="fileUpdate" name="fileUpdate" />
							<table
								style="text-align: right; margin-right: 10px; margin-top: 10px; margin-bottom: -5px">
								<tr>
									<td><input type="button" id="fileAdd" name="fileAdd"
										value="파일 추가"
										style="margin-left: 510px; width: 65px; height: 23px;" /></td>
									<td width="700px"><select id="selectFileAction">
											<option value="" selected="selected">선택</option>
											<option value="D">삭제</option>
											<option value="Y">필수 파일 등록</option>
											<option value="N">필수 파일 해제</option>
									</select></td>
									<td>&nbsp;&nbsp;<a href="#" onFocus="blur()"
										id="btnFileStateUpdate"><img src="images/btn/apply5.gif"
											style="height: 20px;" /></a></td>
								</tr>
							</table>
							<br>
							<table class="sub_0601_table" id="fileListTable">
								<colgroup>
									<col width="8%">
									<col width="*%">
									<col width="15%">
									<col width="12%">
								</colgroup>
								<thead>
									<tr>
										<th><input type="checkbox" name="fileListIdsAll"
											onclick="checkAll('DataFileListForm','fileListIdsAll', 'fileListIds');" /></th>
										<th>파일명</th>
										<th>사이즈</th>
										<th>필수여부</th>
									</tr>
								</thead>
								<tbody id="dataFileListInfo">
								</tbody>
							</table>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../../common/footer.jsp" />
</body>