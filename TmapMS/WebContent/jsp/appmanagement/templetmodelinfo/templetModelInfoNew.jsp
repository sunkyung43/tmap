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
<link type="text/css" rel="stylesheet" href="css/jquery.stepy.css" />
<link rel="stylesheet" href="css/common.css" type="text/css" />
<link rel="stylesheet" href="css/layout_contents.css" type="text/css" />
<link rel="stylesheet" href="css/jquery-ui.css" type="text/css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script language="JavaScript" src="js/common.js"></script>
<script language="JavaScript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script language="JavaScript" src="js/formValidate.js"></script>
<script type="text/javascript" src="js/jquery.stepy.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.9.2.min.js"></script>
<script type="text/javascript"src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
<script type="text/javascript">
	//이벤트 등록
	$(document).ready(function() {

		$("#tabs").tabs({
			active : "${activeId}"
		});
		
		$("#accordion_1").accordion({
			heightStyle : "content"
		});
		
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

		$("#stepContainer").stepy({
			back : function(index) {
			},
			next : function(index) {
				excute(index);
				return false;
			},
			select : function(index) {
			},
			finish : function(index) {
				executeSave();
			},
			titleClick : false,
			backLabel : '< 이전',
				nextLabel:'다음 >'
		});

	});

	function excute(index) {
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

	function verInsertOpen(state) {
		if (state == 'open') {
			$("#open").hide();
			$("#close").show();
			$("#verInfo").show();
		} else if (state == 'close') {
			$("#close").hide();
			$("#open").show();
			$("#verInfo").hide();
		}

	}

	function executeSave() {

		if (!validate()) {
			return;
		}

		if (confirm("등록하시겠습니까?")) {
			ContentsForm.action = "templetModelInfoInsert.do";
			ContentsForm.submit();
		}
	}

	function executePhModelDel() {
		if (isChecked('ContentsForm', 'choice')) {
			var resultTable = document.getElementById("addPhModel");
			var phModelTable = document.getElementById("phModelList");
			var obj = document.getElementsByName("choice");
			for ( var i = 0; i < obj.length; i++) {
				if (obj[i].checked) {
					/* var tr = phModelTable.insertRow(-1);
					var td0 = tr.insertCell();
					var td1 = tr.insertCell();
					var td2 = tr.insertCell();
					var td3 = tr.insertCell();
					var td4 = tr.insertCell();
					var td5 = tr.insertCell();
					var td6 = tr.insertCell();
					var td7 = tr.insertCell();
					var td8 = tr.insertCell();
					var td9 = tr.insertCell();
					var td10 = tr.insertCell();
 */
					var selectedValue = (obj[i].value).split('|');
 
					 var resultHtml = "<tr><td class='td03'>";
					resultHtml += "<input type=\"hidden\" name=\"checkboxPhModelInfos\" value=\""+selectedValue[0]+"\"/>";
					resultHtml += "<input type=\"checkbox\" name=\"phModelchoice\" value=\""+obj[i].value+"\"/></td>";
					resultHtml += "<td class='td03'>" + selectedValue[4] + "</td>";
					resultHtml += "<td class='td03'>" + selectedValue[2] + "</td>";
					resultHtml += "<td class='td03'>" + selectedValue[3] + "</td>";
					resultHtml += "<td class='td03'>" + selectedValue[1] + "</td></tr>";
				
					$("#phModelList:last").append(resultHtml);
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
					// 					var tr = resultTable.insertRow(-1);
					// 					var td0 = tr.insertCell();
					// 					var td1 = tr.insertCell();
					// 					var td2 = tr.insertCell();
					// 					var td3 = tr.insertCell();
					// 					var td4 = tr.insertCell();
					// 					var td5 = tr.insertCell();
					// 					var td6 = tr.insertCell();
					// 					var td7 = tr.insertCell();
					// 					var td8 = tr.insertCell();
					var selectedValue = (obj[i].value).split('|');
					var resultHtml = "<tr><td class='td03'>";
					resultHtml += "<input type=\"hidden\" name=\"checkboxPhModelInfos\" value=\""+selectedValue[1]+"\"/>";
					resultHtml += "<input type=\"hidden\" name=\"phIds\" value=\""+selectedValue[6]+"\"/>";
					resultHtml += "<input type=\"hidden\" name=\"osVerIds\" value=\""+selectedValue[7]+"\"/>";
					resultHtml += "<input type=\"checkbox\" name=\"choice\" value=\""+obj[i].value+"\"/></td>";
					resultHtml += "<td class='td03'>" + selectedValue[2] + " "
							+ selectedValue[4] + "</td>";
					resultHtml += "<td class='td03'>" + selectedValue[3] + " "
							+ selectedValue[5] + "</td></tr>";

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
						"searchPhModel.do",
						$("#ContentsForm").serialize(),
						function(data) {

							var searchPhModel = "";

							$
									.each(
											data.json.searchPhModel,
											function(idx, list) {
												if (list.phContent == null) {
													list.phContent = "";
												}
												if (list.osVerContent == null) {
													list.osVerContent = "";
												}
												searchPhModel += "<tr>";
												searchPhModel += "<td width=\"3\"></td>";
												searchPhModel += "<td width=\"4%\" align=\"center\" style=\"padding:0 0 0 3\">";
												searchPhModel += "<input type=\"checkbox\" name=\"phModelchoice\" value=\""+list.rownum+"|"+list.phModelInfoSeq+"|"+list.phName+"|"+list.osVerName+"|"+list.phContent+"|"+list.osVerContent+"|"+list.phId+"|"+list.osVerId+"\"/>";
												searchPhModel += "</td>";
												searchPhModel += "<td width=\"1\"></td>";
												searchPhModel += "<td width=\"20%\" class=\"ttl4\"><input type=\"text\" class=\"invisiblebox\" value=\""+list.phName+"\" readonly=\"readonly\" style=\"width: 150\"/></td>";
												searchPhModel += "<td width=\"1\"></td>";
												searchPhModel += "<td width=\"28%\" class=\"ttl4\">";
												searchPhModel += "<input type=\"text\" class=\"invisiblebox\" value=\""+list.phContent+"\" readonly=\"readonly\" style=\"width: 210\"/>";
												searchPhModel += "</td>";
												searchPhModel += "<td width=\"1\"></td>";
												searchPhModel += "<td width=\"20%\" class=\"ttl4\"><input type=\"text\" class=\"invisiblebox\" value=\""+list.osVerName+"\" readonly=\"readonly\" style=\"width: 150\"/></td>";
												searchPhModel += "<td width=\"1\"></td>";
												searchPhModel += "<td class=\"ttl4\">";
												searchPhModel += "<input type=\"text\" class=\"invisiblebox\" value=\""+list.osVerContent+"\" readonly=\"readonly\" style=\"width: 210\"/>";
												searchPhModel += "</td>";
												searchPhModel += "<td width=\"3\"></td>";
												searchPhModel += "</tr>";

											});

							$("#trsearchPhModel").html(searchPhModel);
						});
	};
	
	function executeChangeOsType(osDivision, index) {
		$("#activeId").val(index);
		$("#phDivision").val(osDivision);
		$("#ContentsForm").attr('action', 'templetModelInfoNew.do');
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
		<form:hidden path="phDivision" />
		<form:hidden path="activeId" value="${activeId}" />
		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td width="700"><img src="images/h3_ico.gif"><span>단말 - OS 조합 템플릿 등록</span>
							<!-- <img src="images/title/title11.gif"> --></td>
							<td><a href="templetModelInfoList.do" onFocus="blur()"><img
									src="images/btn/btn_list.gif" border="0"></a></td>
						</tr>
					</table>
					<br>
					<div id="stepContainer">
						<fieldset title="Step 1">
							<legend style="display: none;">단말조합 정보 입력</legend>
							<table class="srvRegi">
								<colgroup>
									<col width="100px" />
									<col width="*" />
								</colgroup>
								<tr>
									<th class="td06">이름</th>
									<td class="td06"><input type="text"
										name="templetModelName" class="textbox validate-req"
										style="width: 580px;" title="단말정보 이름" maxlength="100" />&nbsp;<label
										style="color: red;">*</Label></td>
								</tr>
								<tr>
									<th>상태</th>
									<td><input type="radio" name="templetModelState" value="Y" />
										사용 &nbsp;&nbsp; <input type="radio" name="templetModelState"
										value="N" checked="checked" /> 미사용</td>
								</tr>
								<tr>
									<th>내용</th>
									<td><input type="text" name="templetModelContent"
										class="textbox" style="width: 580px;" title="내용" />&nbsp;<label
										style="color: red;">*</Label></td>
								</tr>
							</table>
						</fieldset>
						<fieldset title="Step 2">
							<legend style="display: none">단말버전 정보 선택</legend>
							
							<div>
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
						<c:choose>
					<c:when test="${empty templetModelInfoNew}">
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
						<div id="accordion_1">
						<c:forEach var="phModelName" items="${phModelNameList}" varStatus="varIndex">
						<h3>${phModelName.phName}</h3>
							<div>
							<a href="javascript:executeAdd('phModelchoice_${varIndex.index}_${status.index}');" onFocus="blur()"><img
										src="images/btn/add.gif"
										style="vertical-align: bottom; width: 75px; margin-left: 585px;"></a>
							<table id="phModelList" class="sub_0601_table">
								<colgroup>
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
								</colgroup>
								<thead>
									<tr>
										<th><input type="checkbox" name="phModelchoice_${varIndex.index}_${status.index}_All"
											onclick="checkAll('phModelchoice_${varIndex.index}_${status.index}');" /></th>
										<th>단말명</th>
										<th>단말정보</th>
										<th>OS버전명</th>
										<th>OS버전정보</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${empty templetModelInfoNew}">
											<tr>
												<td colspan="5" height="100" align="center">등록된 게시물이
													없습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<!-- <div style="overflow: auto; height: 250px;"> -->
											<tbody id="trsearchPhModel">
												<c:forEach var="list" items="${templetModelInfoNew}"
													varStatus="stat">
													<c:set var="phName" value="${list.phName}" />
												<c:if test="${phName == phModelName.phName}"> 
													<tr>
														<td class="td03"><input type="checkbox"
														name="phModelchoice_${varIndex.index}_${status.index}" id="phModelchoice_${varIndex.index}_${status.index}"
															value="${stat.index+1}|${list.phModelInfoSeq}|${list.phName}|${list.osVerName}|${list.phContent}|${list.osVerContent}|${list.phId}|${list.osVerId}" />
														</td>
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
							</div>
						</c:forEach>
						</div>
						</c:otherwise>
						</c:choose>
						</div>
						</c:forEach>
						</div>
							</div>
						</fieldset>
						<fieldset title="Step 3">
							<legend style="display: none">추가 된 단말버전 정보 확인</legend>
							<table class="sub_0601_table">
								<colgroup>
									<col width="*">
									<col width="*">
									<col width="*">
								</colgroup>
								<thead>
									<tr>
										<th><input type="checkbox" name="choice_All"
											onclick="checkAll('choice');" /></th>
										<th>단말정보</th>
										<th>OS버전정보</th>
									</tr>
								</thead>
								<tbody id="addPhModel">
								</tbody>
							</table>
							<div id="search">
								<fieldset>
									<a href="javascript:executePhModelDel();" onFocus="blur()"><img
										src="images/btn/device2.gif" border="0"></a>
								</fieldset>
							</div>
						</fieldset>
						<input type="button" class="finish" value="완료" />
					</div>
					</div>
					</div>
					</div>
	</form:form>
</body>
</html>