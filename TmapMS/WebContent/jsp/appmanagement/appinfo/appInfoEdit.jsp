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
<link rel="stylesheet" href="css/tmap.css" type="text/css" />
<link rel="stylesheet" href="css/common.css" type="text/css" />
<link rel="stylesheet" href="css/layout_contents.css" type="text/css" />
<link rel="stylesheet" href="css/jquery-ui.css" type="text/css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.9.2.min.js"></script>
<script type="text/javascript">
	//이벤트 등록
	$(document).ready(function() {
		$("#ver_accordion").accordion();

	});

	function excuteUpdate() {
		$.post("appInfoUpdate.do", $("#ContentsForm").serialize(), function(
				data) {
			if (data.json.result == 1) {
				alert("수정되었습니다.");
			} else {
				alert("수정 실패하였습니다.");
			}
			$("#ContentsForm").attr('action', 'appInfoEdit.do');
			$("#ContentsForm").submit();
		});
	}

	function excuteNewVersion() {

		$.ajax({
			url : "appVerInsert.do",
			data : $("#VersionForm").serialize(),
			type : "post",
			success : function(data) {
				if (data.json.result == 1) {
					alert("버전이 등록되었습니다.");
				} else {
					alert("버전이 등록이 실패하였습니다.");
				}
				$("#ContentsForm").attr('action', 'appInfoEdit.do');
				$("#ContentsForm").submit();
			}
		});
	}

	//버전 정보 수정
	function excuteVerUpdate(formId) {
		$.ajax({
			url : "appVerUpdate.do",
			data : $("#" + formId).serialize(),
			type : "post",
			success : function(data) {
				if (data.json.result == 1) {
					alert("수정되었습니다.");
				} else {
					alert("수정 실패하였습니다.");
				}
				$("#ContentsForm").attr('action', 'appInfoEdit.do');
				$("#ContentsForm").submit();
			}
		});
	}

	//버전 정보 삭제
	function excuteVerDelete(formId) {
		$.ajax({
			url : "appVerDelete.do",
			data : $("#" + formId).serialize(),
			type : "post",
			success : function(data) {
				if (data.json.result == 1) {
					alert("삭제되었습니다.");
				} else {
					alert("삭제 실패하였습니다.");
				}
				$("#ContentsForm").attr('action', 'appInfoEdit.do');
				$("#ContentsForm").submit();
			}
		});
	}

	function executeDel(state) {
		
		
		
		if (state == 'N') {
			
			$("#ContentsForm").attr('action', 'appInfoDelete.do');
			$("#ContentsForm").submit();
			
			/* $.post("appInfoDelete.do", $("#ContentsForm").serialize(),
					function(data) {
						if (data.json.result == true) {
							alert("삭제 되었습니다.");
							location.replace('appInfoList.do');
						} else {
							alert("삭제 실패했습니다.");
						}
					}); */
		} else {
			alert("사용중인 어플리케이션은 삭제할 수 없습니다.\n미사용으로 전환 후 삭제하십시요.");
		}
	}

	function openVerMapping(formId, id) {
		$.ajax({
			url : "appVerMapping.do",
			data : $("#" + formId).serialize(),
			type : "post",
			success : function(data) {
				$("#phoneModelPop").html(data);
				$("#popAppVerId").val(id);
				layer_open('phoneModelPop');
			}
		});
	}

	function layer_open(el) {
		var temp = $('#' + el);
		if (el)
			$('.layer').fadeIn(); //'bg' 클래스가 존재하면 레이어가 나타나고 배경은 dimmed 된다.

		// 화면의 중앙에 레이어를 띄운다.
		if (temp.outerHeight() < $(document).height())
			temp.css('margin-top', '-' + temp.outerHeight() / 2 + 'px');
		else
			temp.css('top', '0px');
		if (temp.outerWidth() < $(document).width())
			temp.css('margin-left', '-' + temp.outerWidth() / 2 + 'px');
		else
			temp.css('left', '0px');

		temp.fadeIn();

		temp.find('a.closeBtn').click(function(e) {
			if (bg) {
				$('.layer').fadeOut(); //'bg' 클래스가 존재하면 레이어를 사라지게 한다.
				temp.fadeOut();
			} else {
				temp.fadeOut();
			}
			e.preventDefault();
		});
	}

	function delPhModel() {
		if ($("#trsearchPhModel>tr").is(".empty")) {
			$("#trsearchPhModel").find(".empty").remove();
		}
		$("#trsearchPhModel:last").append(
				$("#addPhModel").find("tr").has(":checked"));
		$("#trsearchPhModel>tr").find("input[type=checkbox]").attr("checked",
				false);
		$("#trsearchPhModel>tr").find("input[type=checkbox]").attr("name",
				"phModelchoice");
		$("#trsearchPhModel>tr").find("input[type=hidden]").attr("name",
				"checkboxPhModelInfos_n");
		$("input[name=modelChoiceAll]").attr("checked", false);
	}

	function addPhModel() {
		var temp = null;
		$("#phoneSetDiv > div").each(function() {
			if (!$(this).is(":hidden")) {
				if ($(this).attr("id") != "phmodel_add_btn") {
					temp = $(this);
				}
			}
		});
		if ($(temp).find("table > tbody").find(":checked").length > 0) {
			if ($("#addPhModel > tr > td").hasClass('empty')) {
				$("#addPhModel > tr").remove();
			}
			
			var targetTb = $("#" + $(temp).attr('id') + " > table").find(
					".contentList");
			$("#" + $(targetTb).attr("id") + "> tr")
					.each(
							function(idx, val) {
								if ($(val).find("input[type=checkbox]").is(
										":checked")) {
									//중복체크
									if ($("#addPhModel").find(
											"input[type=checkbox]").length > 0) {
										var cnt = 0;
										$("#addPhModel").find("input[type=checkbox]").each(function(index, value) {
															if (value.value == $(val).find("input[type=checkbox]").val()) {
																cnt++;
															} 
														});
										if(cnt == 0){
											$("#addPhModel:last").append($(val));
										}else{
											$(val).remove();
										}
									}else{
										$("#addPhModel:last").append($(val));
									}
								}
							});
			$("#addPhModel>tr").find("input[type=checkbox]").attr("name",
					"phModelIds");
			$("#addPhModel>tr").find("input[type=hidden]").attr("name",
					"checkboxPhModelInfos");
		} else {
			alert("선택된 단말 모델이 없습니다. ");
		}
	}

	function executePhModelSave() {
		$.ajax({
			url : "versionMappingInsert.do",
			data : $("#PhModelForm").serialize(),
			type : "post",
			success : function(data) {
				alert("수정되었습니다.");
				if (bg) {
					$('.layer').fadeOut(); //'bg' 클래스가 존재하면 레이어를 사라지게 한다.
					temp.fadeOut();
				} else {
					temp.fadeOut();
				}
				e.preventDefault();
			}
		});
	}
	function getTempletDetailModel(templetId) {
		$.ajax({
			url : "searchTempletModel.do",
			data : {
				templetModelId : templetId
			},
			type : "post",
			success : function(data) {
				$("#templetModelDetail").html(data);
				$("#templetNameDiv").hide();
				$("#templetModelDetail").show();
				$("#templetModelTd").show();
				$("#templetNameTd").hide();
			}
		});
	}
</script>
<style>
.layer {
	display: none;
	position: fixed;
	_position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	z-index: 100;
}

.layer .bg {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: #000;
	opacity: .5;
	filter: alpha(opacity =                         50);
}

.pop-layer {
	display: none;
	position: absolute;
	top: 50%;
	left: 50%;
	width: auto;
	height: auto;
	background-color: #fff;
	border: 3px solid #3571B5;
	z-index: 10;
}

a.regBtn {
	display: inline-block;
	height: 25px;
	padding: 0 14px 0;
	border: 1px solid #304a8a;
	background-color: #9AA5BE;
	font-size: 13px;
	color: #fff;
	line-height: 25px;
}

a.closeBtn {
	display: inline-block;
	height: 25px;
	padding: 0 14px 0;
	border: 1px solid #304a8a;
	background-color: #3f5a9d;
	font-size: 13px;
	color: #fff;
	line-height: 25px;
}

a.closeBtn:hover {
	border: 1px solid #091940;
	background-color: #1f326a;
	color: #fff;
}
</style>
</head>
<body>
	<!--popup 영역  -->
	<div id="layer" class="layer">
		<div id="bg" class="bg"></div>
		<div id="version_pop" class="pop-layer"
			style="width: 500px; height: 170px;">
			<div>
				<form:form commandName="VersionForm" id="VersionForm"
					name="VersionForm">
					<input type="hidden" id="appInfoSeq" name="appInfoSeq"
						value="${appInfo.appInfoSeq}">
					<table class="srvRegi" style="width: 500px">
						<colgroup>
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th>버전명</th>
								<td><input type="text" id="appVerName" name="appVerName"
									title="어플리케이션 이름" style="width: 350px;" class="regiInput" />&nbsp;<label
									style="color: red;">*</Label></td>
							</tr>
							<tr>
								<th>사용여부</th>
								<td><input type="radio" name="appVerState" value="Y"
									checked="checked" /> <label for="app_ver_state" class="MR20">사용</label>
									<input type="radio" name="appVerState" value="N" /><label
									for="appVerState" class="MR20">미사용</label></td>
							</tr>
							<tr>
								<th>버전내용</th>
								<td><input type="text" name="appVerContent"
									class="regiInput" style="width: 350px;" title="내용" /></td>
							</tr>
						</tbody>
					</table>
				</form:form>
			</div>
			<div style="margin-top: 5px; margin-right: 10px; text-align: right;">
				<a href="javascript:excuteNewVersion();" class="regBtn">등록</a> <a
					href="#" class="closeBtn">취 소</a>
			</div>
		</div>
		<div id="phoneModelPop" class="pop-layer"
			style="width: 650px; max-height: 600px; overflow: auto;"></div>
	</div>
	<!--popup 영역  -->
	<jsp:include page="../../common/menu.jsp" />
	<div id="bodyDiv">
		<div class="contentsDiv">

			<div class="headline">
				<img src="images/h3_ico.gif"> <span>App 정보 </span>
			</div>
			<div>
				<form:form commandName="ContentsForm" id="ContentsForm"
					name="ContentsForm">
					<input type="hidden" id="appInfoSeq" name="appInfoSeq"
						value="${appInfo.appInfoSeq}">
					<input type="hidden" id="appStoreDate" name="appStoreDate"
						value="${appInfo.appStoreDate}">
					<input type="hidden" id="appVerId" name="appVerId">
					<form:hidden path="templetModelId" />

					<table class="srvRegi">
						<colgroup>
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th>등록일</th>
								<td>${appInfo.appStoreDate}</td>
							</tr>
							<tr>
								<th>이름</th>
								<td><input type="text" name="appName"
									value="${appInfo.appName}" class="invisible"
									style="width: 600px;" title="어플리케이션 이름" /></td>
							</tr>
							<tr>
								<th>사용여부</th>
								<td><input type="radio" name="appState" value="Y"
									<c:if test="${appInfo.appState == 'Y'}">checked="checked"</c:if> />
									사용 &nbsp;&nbsp; <input type="radio" name="appState" value="N"
									<c:if test="${appInfo.appState == 'N'}">checked="checked"</c:if> />
									미사용</td>
							</tr>
							<tr>
								<th>DOWN URL</th>
								<td><input type="text" name="appDownURL"
									value="${appInfo.appDownURL}" class="textbox  validate-req"
									style="width: 600px" title="Down URL" maxlength="200" /></td>
							</tr>
							<tr>
								<th>제조사</th>
								<td><input type="text" name="appMade" class="textbox"
									style="width: 600px" maxlength="100" value="${appInfo.appMade}" />
								</td>
							</tr>
							<tr>
								<th>내용</th>
								<td><input type="text" name="appContent"
									style="width: 600px;" value="${appInfo.appContent}"></td>
							</tr>
						</tbody>
					</table>
					<div style="text-align: right; margin-right: 15px">
						<img src="images/btn/modify7.gif" border="0"
							style="cursor: pointer" onclick="javascript:excuteUpdate();">
						<a href="javascript:executeDel('${appInfo.appState}');" onFocus="blur()"><img src="images/btn/delete7.gif" border="0"></a>
					</div>
				</form:form>
			</div>

			<div class="headline" style="margin-top: 20px">
				<img src="images/h3_ico.gif"> <span>버전 정보 </span> <a
					href="javascript:appVerInfoNew();" onFocus="blur()"> </a>
			</div>
			<c:if test="${empty appVerInfoList}">
				<div>
					<table class="srvRegi">
						<colgroup>
							<col width="*" />
						</colgroup>
						<tbody style="text-align: center">
							<tr>
								<td><label>등록된 App 버전이 없습니다. </Label></td>
							</tr>
							<tr>
								<td><img src="images/btn/btn_apply2.gif"
									onclick="javascript:layer_open('version_pop');" border="0"></td>
							</tr>
						</tbody>
					</table>
				</div>
			</c:if>
			<div id="ver_accordion" style="width: 740px">
				<c:forEach var="list" items="${appVerInfoList}" varStatus="idx">
					<h3>${list.appVerName }</h3>
					<div>
						<form:form commandName="VerForm_${idx.index}"
							id="VerForm_${idx.index}" name="VerForm_${idx.index}">
							<input type="hidden" name="appInfoSeq"
								value="${appInfo.appInfoSeq}">
							<input type="hidden" name="appVerId" value="${list.appVerId}">
							<table class="srvRegi" style="width: 650px">
								<colgroup>
									<col width="100px" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th>버전명</th>
										<td><input type="text" id="" name="appVerName"
											title="어플리케이션 이름" style="width: 500px;" class="regiInput"
											value="${list.appVerName}" /> <label style="color: red;">*</Label></td>
									</tr>
									<tr>
										<th>버전내용</th>
										<td><input type="text" name="appVerContent"
											class="regiInput" style="width: 500px;" title="내용"
											value="${list.appVerContent }" /></td>
									</tr>
									<tr>
										<th>사용여부</th>
										<td><c:choose>
												<c:when test="${list.appVerState == 'Y'}">
													<input type="radio" name="appVerState" value="Y"
														checked="checked" />
													<label for="app_ver_state" class="MR20">사용</label>
													<input type="radio" name="appVerState" value="N" />
													<label for="appVerState" class="MR20">미사용</label>
												</c:when>
												<c:otherwise>
													<input type="radio" name="appVerState" value="Y" />
													<label for="app_ver_state" class="MR20">사용</label>
													<input type="radio" name="appVerState" value="N"
														checked="checked" />
													<label for="appVerState" class="MR20">미사용</label>
												</c:otherwise>
											</c:choose></td>
									</tr>
								</tbody>
							</table>
							<div style="text-align: right; margin: 5 10 0 0;">
								<a href="javascript:excuteVerUpdate('VerForm_${idx.index}')"
									class="regBtn">수정</a> <a
									href="javascript:openVerMapping('VerForm_${idx.index}', '${list.appVerId}')"
									class="regBtn">단말매핑</a> <a
									href="javascript:excuteVerDelete('VerForm_${idx.index}')"
									class="regBtn">삭제</a>
							</div>
						</form:form>
					</div>
				</c:forEach>
			</div>
			<div style="text-align: right; margin-top: 5px">
				<img src="images/btn/btn_apply2.gif"
					onclick="javascript:layer_open('version_pop');" border="0"> <a
					href="appInfoList.do"><img src="images/btn/btn_list.gif"
					border="0"></a>
			</div>
		</div>
	</div>
	<jsp:include page="../../common/footer.jsp" />
</body>
</html>