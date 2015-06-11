<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="css/jquery-ui.css" type="text/css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/formValidate.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.9.2.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript"src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
<script type="text/javascript">
	$(function() {
		$("#tabs").tabs({
			active : "${activeId}"
		});
		
			$("#accordion").accordion({
				heightStyle : "content"
		});
			
			$("#accordion_1").accordion({
				heightStyle : "content"
		});
	});
	
	//이벤트 등록
	$(document).ready(function() {

		$("#activeId").val(0);
		
		//조회 버튼 클릭 이벤트 처리
		$("#btnSearch").bind("click", function() {
			searchPage();
		});

		//조회 버튼 엔터 이벤트 처리
		$("#phName").bind("keydown", function(event) {
			if (event.keyCode == 13) {
				searchPage();
			}
		});
	});

	function executeSave() {

		if (!validate()) {
			return;
		}

		if (confirm("수정하시겠습니까?")) {
			//createHidden();
			ContentsForm.action = "templetModelInfoUpdate.do";
			ContentsForm.submit();
		}

	}

	function createHidden() {
		var form = document.ContentsForm;
		if (!form.choice) {
			return;
		}
		var loop = form.choice.length;
		if (loop) {
			for ( var i = 0; i < loop; i++) {
				if (!form.choice[i].checked) {
					var delObj = document.createElement('input');
					delObj.setAttribute('type', 'hidden');
					delObj.setAttribute('value', form.choice[i].value);
					delObj.setAttribute('name', 'linkedInfo');
					delObj.setAttribute('id', 'linkedInfo');

					alert(delObj.toString());
					form.appendChild(delObj);
				}
			}

		} else {
			if (!form.choice.checked) {
				var delObj = document.createElement('input');
				delObj.setAttribute('type', 'hidden');
				delObj.setAttribute('value', form.choice.value);
				delObj.setAttribute('name', 'linkedInfo');
				delObj.setAttribute('id', 'linkedInfo');
				alert(delObj.valueOf());
				form.appendChild(delObj);
			}
		}
	}

	function executeDel(state) {

		var mapCount = '${data.mapCount}';
		if (mapCount > 0) {
			alert('맵파일을 등록한 어플리케이션은 삭제할 수 없습니다.');
			return;
		}

		if (state == 'Y') {
			alert('사용중인 어플리케이션은 삭제할 수 없습니다.\n미사용으로 전환 후 삭제하십시요.');
			return;
		}

		if (confirm('삭제하시겠습니까?')) {
			document.ContentsForm.templetModelState[0].value = 'D';
			document.ContentsForm.templetModelState[1].value = 'D';
			document.ContentsForm.action = 'templetModelInfoDelete.do';
			document.ContentsForm.submit();
		}
	}

	function executePhModelDel() {
		if (isChecked('ContentsForm', 'choice')) {
			var resultTable = document.getElementById("addPhModel");
			var phModelTable = document.getElementById("phModelList");
			var obj = document.getElementsByName("choice");
			for ( var i = 0; i < obj.length; i++) {
				if (obj[i].checked) {
		 			var selectedValue = (obj[i].value).split('|');
 
				 	var resultHtml = "<tr><td class='td03'>";
					resultHtml += "<input type=\"hidden\" name=\"checkboxPhModelInfos\" value=\""+selectedValue[0]+"\"/>";
					resultHtml += "<input type=\"hidden\" name=\"phIds\" value=\""+selectedValue[6]+"\"/>";
					resultHtml += "<input type=\"hidden\" name=\"osVerIds\" value=\""+selectedValue[7]+"\"/>";
					resultHtml += "<input type=\"checkbox\" name=\"choice\" value=\""+obj[i].value+"\"/></td>";
					resultHtml += "<td class='td03'>" + selectedValue[1] + "</td>";
					resultHtml += "<td class='td03'>" + selectedValue[3] + "</td>";
					resultHtml += "<td class='td03'>" + selectedValue[2] + "</td>";
					resultHtml += "<td class='td03'>" + selectedValue[4] + "</td></tr>";
					
					$("#trsearchPhModel:last").append(resultHtml);
				}
			} //end add for
			for ( var i = obj.length - 1; i > -1; i--) {
				if (obj[i].checked) {
					resultTable.deleteRow(i);
				}
			}

		}

		if (document.ContentsForm.choiceAll.checked) {
			document.ContentsForm.choiceAll.checked = !document.ContentsForm.choiceAll.checked;
		}
	}

	function executeAdd(phModelchoice) {
		if (isChecked('ContentsForm', phModelchoice)) {
			var resultTable = document.getElementById("addPhModel");
			var phModelTable = document.getElementById("phModelList");
			var obj = document.getElementsByName(phModelchoice);
			for ( var i = 0; i < obj.length; i++) {
				if (obj[i].checked) {
					var selectedValue = (obj[i].value).split('|');
					var resultHtml = "<tr><td class='td03'>";
					resultHtml += "<input type=\"hidden\" name=\"checkboxPhModelInfos\" value=\""+selectedValue[0]+"\"/>";
					resultHtml += "<input type=\"hidden\" name=\"phIds\" value=\""+selectedValue[6]+"\"/>";
					resultHtml += "<input type=\"hidden\" name=\"osVerIds\" value=\""+selectedValue[7]+"\"/>";
					resultHtml += "<input type=\"checkbox\" name=\"choice\" value=\""+obj[i].value+"\"/></td>";
					resultHtml += "<td class='td03'>" + selectedValue[1] + " " + selectedValue[3] + "</td>";
					resultHtml += "<td class='td03'>" + selectedValue[2] + " " + selectedValue[4] + "</td></tr>";
					
					$("#addPhModel:last").append(resultHtml);
				}
			} //end add for

			//end delete for
			for ( var i = obj.length - 1; i > -1; i--) {
				if (obj[i].checked) {
					//phModelTable.deleteRow(i + 1);
					$(obj[i]).parent().parent().remove();
					//$("#trsearchPhModel > tr:eq(" + i + ")").remove();
				}

			}

			if (document.ContentsForm.phModelchoiceAll.checked) {
				document.ContentsForm.phModelchoiceAll.checked = !document.ContentsForm.phModelchoiceAll.checked;
			}
		}
	}

	//리스트조회
	function searchPage() {

		//호출 및 메시지 출력
		$
				.post(
						"searchModifyPhModel.do",
						$("#ContentsForm").serialize(),
						function(data) {

							var searchModifyPhModel = "";

							$
									.each(
											data.json.searchModifyPhModel,
											function(idx, list) {
												searchModifyPhModel += "<tr>";
												searchModifyPhModel += "<td width=\"3\"></td>";
												searchModifyPhModel += "<td width=\"4%\" align=\"center\" style=\"padding:0 0 0 3\">";
												searchModifyPhModel += "<input type=\"checkbox\" name=\"phModelchoice\" value=\""+list.phModelInfoSeq+"|"+list.phName+"|"+list.osVerName+"|"+list.phContent+"|"+list.osVerContent+"|"+list.phId+"|"+list.osVerId+"\"/>";
												searchModifyPhModel += "</td>";
												searchModifyPhModel += "<td width=\"1\"></td>";
												searchModifyPhModel += "<td width=\"20%\" class=\"ttl4\"><input type=\"text\" class=\"invisiblebox\" value=\""+list.phName+"\" readonly=\"readonly\" style=\"width: 150\"/></td>";
												searchModifyPhModel += "<td width=\"1\"></td>";
												searchModifyPhModel += "<td width=\"28%\" class=\"ttl4\">";
												if (list.phContent != null) {
													searchModifyPhModel += "<input type=\"text\" class=\"invisiblebox\" value=\""+list.phContent+"\" readonly=\"readonly\" style=\"width: 210\"/>";
												} else {
													searchModifyPhModel += "<input type=\"text\" class=\"invisiblebox\" value=\"\" readonly=\"readonly\" style=\"width: 210\"/>";
												}
												searchModifyPhModel += "</td>";
												searchModifyPhModel += "<td width=\"1\"></td>";
												searchModifyPhModel += "<td width=\"20%\" class=\"ttl4\"><input type=\"text\" class=\"invisiblebox\" value=\""+list.osVerName+"\" readonly=\"readonly\" style=\"width: 150\"/></td>";
												searchModifyPhModel += "<td width=\"1\"></td>";
												searchModifyPhModel += "<td class=\"ttl4\">";
												if (list.osVerContent != null) {
													searchModifyPhModel += "<input type=\"text\" class=\"invisiblebox\" value=\""+list.osVerContent+"\" readonly=\"readonly\" style=\"width: 210\"/>";
												} else {
													searchModifyPhModel += "<input type=\"text\" class=\"invisiblebox\" value=\"\" readonly=\"readonly\" style=\"width: 210\"/>";
												}
												searchModifyPhModel += "</td>";
												searchModifyPhModel += "<td width=\"3\"></td>";
												searchModifyPhModel += "</tr>";

											});

							$("#trsearchPhModel").html(searchModifyPhModel);
						});
	};
	
	function executeChangeOsType(osDivision, index) {
		$("#activeId").val(index);
		$("#phDivision").val(osDivision);
		$("#ContentsForm").attr('action', 'templetModelInfoEdit.do');
		$("#ContentsForm").submit();
	}
	
	function checkAll(name) {
		if ($("input[name=" + name + "_All]").is(":checked")) {
			$("input[name=" + name + "]").attr("checked", true);
		} else {
			$("input[name=" + name + "]").attr("checked", false);
		}
		;
	}
</script>
</head>
<body>
	<form:form commandName="ContentsForm" id="ContentsForm"
		name="ContentsForm">
		<input type="hidden" name="templetModelId" value="${templetModelInfo.templetModelId}">
		<form:hidden path="phDivision" />
		<form:hidden path="activeId" value="${activeId}" />
			
		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td width="560px"><img src="images/h3_ico.gif"><span>단말 - OS 조합 템플릿 수정</span></td>
							<td><a
								href="javascript:executeDel('${templetModelInfo.templetModelState}');"
								onFocus="blur()"><img src="images/btn/delete7.gif"
									border="0"></a>&nbsp; <a href="javascript:executeSave();"
								onFocus="blur()"><img src="images/btn/modify7.gif"
									border="0"></a>&nbsp; <a href="templetModelInfoList.do"
								onFocus="blur()"><img src="images/btn/btn_list.gif"
									border="0"></a></td>
						</tr>
					</table>
					<br>
					<div id="accordion">
						<h2>단말 정보 입력</h2>
						<div>
							<table class="srvRegiEdit">
								<colgroup>
									<col width="*" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr class="td06">
										<th>이름</th>
										<td><input type="text" name="templetModelName"
											value="${templetModelInfo.templetModelName}"
											class="invisible" style="width: 530px" title="어플리케이션 이름"
											readonly="readonly" /></td>
									</tr>
									<tr>
										<th>상태</th>
										<td><input type="radio" name="templetModelState"
											value="Y"
											<c:if test="${templetModelInfo.templetModelState == 'Y'}">checked="checked"</c:if> />
											사용 &nbsp;&nbsp; <input type="radio" name="templetModelState"
											value="N"
											<c:if test="${templetModelInfo.templetModelState == 'N'}">checked="checked"</c:if> />
											미사용</td>
									</tr>
									<tr>
										<th>내용</th>
										<td><input type="text" name="templetModelContent"
											style="width: 530px;" title="내용"
											value="${templetModelInfo.templetModelContent}" />
									</tr>
									<tr>
										<th>등록일</th>
										<td>${templetModelInfo.templetModelSdate}</td>
									</tr>
								<tbody>
							</table>
						</div>
						<h3>단말 모델</h3>
						<div>
							<table class="sub_0601_table">
								<colgroup>
									<col width="" />
									<col width="" />
									<col width="" />
								</colgroup>
								<thead>
									<tr>
										<th><input type="checkbox" name="choiceAll"
											onclick="checkAll('ContentsForm','choiceAll', 'choice');" />
										</th>
										<th>단말정보</th>
										<th>OS버전정보</th>
									</tr>
								</thead>
								<tbody id="addPhModel">
									<c:forEach var="list" items="${appUseOsPh}">
										<tr>
											<td class="td06"><input type="checkbox" name="choice" id="choice"
												value="${list.phModelInfoSeq}|${list.phName}|${list.osVerName}|${list.phContent}|${list.osVerContent}|${list.phId}|${list.osVerId}" />
												<input type="hidden" name="checkboxPhModelInfos"
												value="${list.phModelInfoSeq}" /> <input type="hidden"
												name="phIds" value="${list.phId}" /> <input type="hidden"
												name="osVerIds" value="${list.osVerId}" /> <input
												type="hidden" name="posibleDelete" value="${posibleDelete}" />
											</td>
											<td class="td06">${list.phName} ${list.phContent}</td>
											<td class="td06">${list.osVerName} ${list.osVerContent}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<div id="search" style="width: 670px;">
								<fieldset>
									<a href="javascript:executePhModelDel();" onFocus="blur()"><img
										src="images/btn/device2.gif" border="0"></a>
								</fieldset>
							</div>
						</div>
						<h3>단말 조합 정보</h3>
						<div>
							<div id="tabs">
								<ul>
									<c:forEach var="osType" items="${osTypeList}" varStatus="status">
										<li onclick="javascript:executeChangeOsType('${osType.comCode}','${status.index}');">
											<a href="#tabs-${osType.comCode}">${osType.codeName}</a>
										</li>
									</c:forEach>
								</ul>
						<c:forEach var="osType" items="${osTypeList}" varStatus="status">
						<div id="tabs-${osType.comCode}">
						<div id="accordion_1">
							<c:choose>
					<c:when test="${empty allOsPhInfo}">
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
										<tr>
											<td colspan="5" height="100" class="td03">등록된 게시물이 없습니다.</td>
										</tr>
							</tbody>
						</table>
						</c:when>
						<c:otherwise>
						<c:forEach var="phModelName" items="${phModelNameList}" varStatus="varIndex">
						<h3>${phModelName.phName}</h3>
							<div>
							 <a href="javascript:executeAdd('phModelchoice_${varIndex.index}_${status.index}');" onFocus="blur()">
								<img src="images/btn/add.gif" border="0" style="margin-left:460px;">
							</a>
								 <table id="phModelList" class="sub_0601_table">
								<colgroup>
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
								</colgroup>
								<tbody>
									<tr>
										<th><input type="checkbox" name="phModelchoice_${varIndex.index}_${status.index}_All"
											onclick="checkAll('phModelchoice_${varIndex.index}_${status.index}');" /></th>
										<th>단말명</th>
										<th>단말정보</th>
										<th>OS버전명</th>
										<th>OS버전정보</th>
									</tr>
									<c:choose>
										<c:when test="${empty allOsPhInfo}">
											<tr>
												<td colspan="5" height="100" align="center">등록된 게시물이
													없습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<tbody id="trsearchPhModel">
												<c:forEach var="list" items="${allOsPhInfo}">
												 <c:set var="phName" value="${list.phName}" />
												<c:if test="${list.phName == phModelName.phName}"> 
													<tr>
														<td class="td03"><input type="checkbox"
															name="phModelchoice_${varIndex.index}_${status.index}" id="phModelchoice_${varIndex.index}_${status.index}"
															value="${list.phModelInfoSeq}|${list.phName}|${list.osVerName}|${list.phContent}|${list.osVerContent}|${list.phId}|${list.osVerId}" />
															<input type="hidden" name="posibleDelete" value="Y" /></td>
														<td class="td03">${list.phName}</td>
														<td class="td03">${list.phContent}</td>
														<td class="td03">${list.osVerName}</td>
														<td class="td03">${list.osVerContent}</td>
													</tr>
												 </c:if> 
												</c:forEach>
											</tbody>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
								  <c:if test="${phName == phModelName.phName}"> 
									<div id="paging"></div>
							  </c:if>   
							</div>
						</c:forEach>
						</c:otherwise>
						</c:choose>
						</div>
						</div>
						</c:forEach>
						</div>
						</div>
					</div>

				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />
	</form:form>
</body>
</html>