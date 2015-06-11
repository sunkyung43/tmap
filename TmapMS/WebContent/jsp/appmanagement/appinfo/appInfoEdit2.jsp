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
<link rel="stylesheet" href="css/tmap.css" type="text/css" />
<link rel="stylesheet" href="css/common.css" type="text/css" />
<link rel="stylesheet" href="css/layout_contents.css" type="text/css" />
<link rel="stylesheet" href="css/jquery-ui.css" type="text/css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery-1.4.4.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.9.2.min.js"></script>
<script type="text/javascript" src="js/formValidate.js"></script>
<script type="text/javascript" src="js/appInfojs/appInfojs.js"></script>
<script type="text/javascript">
	//이벤트 등록
	$(document).ready(function() {

		$("#accordion").accordion({
			heightStyle : "content"
		});

		//조회 버튼 클릭 이벤트 처리
		$("#phModelBtn").bind("click", function() {
			phSearchPage();
		});

		$("#templetModelBtn").bind("click", function() {
			templetSearchPage();
		});

		$("#templetNameBtn").bind("click", function() {
			templetSearch();
		});

		//조회 버튼 엔터 이벤트 처리
		$("#phName").bind("keydown", function(event) {
			if (event.keyCode == 13) {
				phSearchPage();
			}
		});

		$("#phName2").bind("keydown", function(event) {
			if (event.keyCode == 13) {
				templetSearchPage();
			}
		});

		$("#templetModelName").bind("keydown", function(event) {
			if (event.keyCode == 13) {
				templetSearch();
			}
		});

		//App정보 등록폼
		$("#appOpen").click(function() {
			$("#appInfo").slideDown("slow");
			$("#verInfo").hide();
		});

		//버전정보 등록폼
		$("#verOpen").click(function() {
			$("#appInfo").hide();
			$("#verInfo").slideDown("slow");
		});

		//단말모델 리스트
		$("#phModelOpen").click(function() {
			$("#templetNameDiv").hide();
			$("#phModelDiv").show();
			$("#templetModelDiv").hide();
			$("#templetNameTd").hide();
			$("#phModelTd").show();
			$("#templetModelTd").hide();
			$("#templetAdd").hide();
			$("#phAdd").show();
			$("#templetDel").hide();
			$("#phDel").show();
		});

		//단말조합 리스트
		$("#templetModelOpen").click(function() {
			$("#phModelDiv").hide();
			$("#templetNameDiv").show();
			$("#templetModelDiv").hide();
			$("#templetNameTd").show();
			$("#phModelTd").hide();
			$("#templetModelTd").hide();
			$("#templetAdd").show();
			$("#phAdd").hide();
			$("#templetDel").show();
			$("#phDel").hide();
		});

	});

	function executeModify() {
		$.post("appVerUpdate.do", $("#ContentsForm").serialize(),
				function(data) {

					var result = data.json.result;
					if (result == true) {
						alert("수정 되었습니다.");
						location.replace('appInfoList.do');
					} else {
						alert("수정 실패했습니다.");
					}

				});
	}

	function executeDelete() {
		$.post("appVerDelete.do", $("#ContentsForm").serialize(),
				function(data) {
					if (data.json.result == true) {
						alert("삭제 되었습니다.");
						location.replace('appInfoList.do');
					} else {
						alert("삭제 실패했습니다.");
					}
				});
	}
	
	function executeDel(state) {
		if(state == 'N'){
		$.post("appInfoDelete.do", $("#ContentsForm").serialize(),
				function(data) {
					if (data.json.result == true) {
						alert("삭제 되었습니다.");
						location.replace('appInfoList.do');
					} else {
						alert("삭제 실패했습니다.");
					}
				});
		}else {
			alert("사용중인 어플리케이션은 삭제할 수 없습니다.\n미사용으로 전환 후 삭제하십시요.");
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

	/* function executeDel(state) {
		$("#appInfoSeq").val(appInfoSeq);

		$.post("appInfoDelete.do", $("#ContentsForm").serialize(), function(
				data) {
			if (data.json.result == true) {
				alert("삭제 되었습니다.");
				$("#ContentsForm").attr('action', 'appInfoEdit.do');
				$("#ContentsForm").submit();
			} else {
				alert("삭제 실패했습니다.");
			}
		});

		/* var mapCount = '${data.mapCount}';
		if (mapCount > 0) {
			alert('맵파일을 등록한 어플리케이션은 삭제할 수 없습니다.');
			return;
		}

		if (state == 'Y') {
			alert('사용중인 어플리케이션은 삭제할 수 없습니다.\n미사용으로 전환 후 삭제하십시요.');
			return;
		}

		if (confirm('삭제하시겠습니까?')) {
			document.ContentsForm.appState[0].value = 'D';
			document.ContentsForm.appState[1].value = 'D';
			document.ContentsForm.action = 'appInfoDelete.do';
			document.ContentsForm.submit();
		} */
	//} 

	function executePhModelDel(state) {
		if (isChecked('ContentsForm', 'choice')) {
			var resultTable = document.getElementById("addPhModel");
			var phModelTable = "";
			var modelchoice = "";
			var trHtml = "";

			var obj = document.getElementsByName("choice");

			if (state == 'P') {
				modelchoice = 'phModelchoice';
				phModelTable = document.getElementById("phModelList");
			}
			if (state == 'T') {/* templetchoiceAll */
				modelchoice = 'templetchoice';
				phModelTable = document.getElementById("templetModelList");
			}

			for ( var i = 0; i < obj.length; i++) {
				if (obj[i].checked) {
					if (document.getElementsByName("posibleDelete")[i]) {
						var posibleDelete = document
								.getElementsByName("posibleDelete")[i].value;
						if (posibleDelete == 'N') {
							alert('어플리케이션 서비스에 등록된 단말모델은 삭제할 수 없습니다.\n어플리케이션 서비스관리에서 등록된 단말모델을 먼저 삭제해주세요.');
							return;
						}
					}
				}
			}

			for ( var i = 0; i < obj.length; i++) {
				if (obj[i].checked) {

					var selectedValue = (obj[i].value).split('|');

					trHtml = "<tr><td><input type='checkbox' name=\""+modelchoice+"\" value=\""+obj[i].value+"\"/></td>";
					trHtml = "<td><input type='text' class='invisiblebox' value="+selectedValue[2]+" readonly='readonly' style='width: 150'/></td>";
					trHtml = "<td>";
					if (selectedValue[4] != "") {
						trHtml = "<input type='text' class='invisiblebox' value="+selectedValue[4]+" readonly='readonly' style='width: 210'/>";
					} else {
						trHtml = "<input type='text' class='invisiblebox' value='' readonly='readonly' style='width: 210'/>";
					}
					trHtml = "</td>";
					trHtml = "<td><input type='text' class='invisiblebox' value="+selectedValue[3]+" readonly='readonly' style='width: 150'/></td>";
					trHtml = "<td>";
					if (selectedValue[5] != "") {
						trHtml = "<input type='text' class='invisiblebox' value="+selectedValue[5]+" readonly='readonly' style='width: 210'/>";
					} else {
						trHtml = "<input type='text' class='invisiblebox' value='' readonly='readonly' style='width: 210'/>";
					}
					trHtml = "</td>";
				}
			} //end add for
			for ( var i = obj.length - 1; i > -1; i--) {
				if (obj[i].checked) {
					resultTable.deleteRow(i);
					// 					$("#trsearchTempletModel > tr:eq(" + i + ")").remove();
				}
			}

		}

		if (document.ContentsForm.choiceAll.checked) {
			document.ContentsForm.choiceAll.checked = !document.ContentsForm.choiceAll.checked;
		}
	}

	function executeAdd(state, choice) {
		if (isChecked('ContentsForm', choice)) {
			var phModelTable = '';
			var obj = '';
			var trHtml = '';

			if (state == 'P') {
				obj = document.getElementsByName("phModelchoice");
				phModelTable = document.getElementById("trsearchPhModel");
			}
			if (state == 'T') {
				obj = document.getElementsByName("templetchoice");
				phModelTable = document.getElementById("trsearchTempletModel");
			}

			var cnt = $("input[name=checkboxPhModelInfos]").size(); 
			
			for ( var i = 0; i < obj.length; i++) {
				if (obj[i].checked) {
					var selectedValue = (obj[i].value).split('|');
					trHtml = "<tr><td class='td03'><input type='hidden' name='checkboxPhModelInfos' value='"+selectedValue[1]+"'/>"
							+ "<input type='hidden' name='phIds' value='"+selectedValue[6]+"'/>"
							+ "<input type='hidden' name='osVerIds' value='"+selectedValue[7]+"'/>"
							+ "<input type='checkbox' name='choice' value='"+obj[i].value+"'/></td>";
					trHtml += "<td class='td03'>"+selectedValue[2]+" "+selectedValue[4]+"</td>";
					trHtml += "<td class='td03'>"+selectedValue[3]+" "+selectedValue[5]+"</tr>";
					 
					if(cnt < 1){
				    	$("#addPhModel:last").append(trHtml);
				    }else{
			        	var count = 0;
			            for(var j=0; j < cnt; j++){
			              if(selectedValue[1] == $("input[name=checkboxPhModelInfos]")[j].value){
			            	  count++;
		           		  }
	            		}
			            if(count == 0){
			            	$("#addPhModel:last").append(trHtml);
			            }
			         }
		          }
	        }//end add for

			//end delete for
			for ( var i = obj.length - 1; i > -1; i--) {
				if (obj[i].checked) {
					phModelTable.deleteRow(i);
					// 					$("#trsearchPhModel > tr:eq(" + i + ")").remove();
				}

			}

			if (document.ContentsForm.phModelchoiceAll.checked) {
				document.ContentsForm.phModelchoiceAll.checked = !document.ContentsForm.phModelchoiceAll.checked;
			}

			if (document.ContentsForm.templetchoiceAll.checked) {
				document.ContentsForm.templetchoiceAll.checked = !document.ContentsForm.templetchoiceAll.checked;
			}

		}
	}

	function phInfoAdd() {

		$("#pop_wrap").show();
		$("#pop_container2").show();
		$("#pop_container").hide();
	}

	function appVerDetail(appVerId) {
		$("#appVerId").val(appVerId);
		$.post("appVerInfoEdit.do", $("#ContentsForm").serialize(), function(data) {
			$("#appVerName").val(data.json.appVerDetail.appVerName);
			$("#appVerSdate").val(data.json.appVerDetail.appVerSdate);

			if (data.json.appVerDetail.appVerState == 'Y') {
				$("input[name=appVerState]:first").prop("checked", "checked");
			} else {
				$("input[name=appVerState]:last").prop("checked", "checked");
			}
			$("#appVerContent").val(data.json.appVerDetail.appVerContent);

			$("#pop_wrap").show();
			$("#pop_container").show();
			$("#pop_container2").hide();
			$("#insert").hide();
			$("#modify").show();
			$("#delete").show();
		});
	}

	function appVerInfoNew() {
		$.post("appVerInfoNew.do", $("#ContentsForm").serialize(), function(data) {
			$('input[name="appVerName"]').val('');
			$('input[name="appVerSdate"]').val('');
			$("input[name=appVerState]:first").prop("checked", "checked");
			$('input[name="appVerContent"]').val('');

			$("#pop_wrap").show();
			$("#pop_container").show();
			$("#pop_container2").hide();
			$("#modify").hide();
			$("#delete").hide();
			$("#insert").show();
		});
	}

	function appVerInsert() {
		$.post("appVerInsert.do", $("#ContentsForm").serialize(),
				function(data) {

					if (data.json.result == true) {
						alert("등록 되었습니다.");
						$("#ContentsForm").attr('action', 'appInfoEdit.do');
						$("#ContentsForm").submit();
					} else {
						alert("등록 실패했습니다.");
					}
				});
	}

	function executeSave() {
		$.post("appInfoUpdate.do", $("#ContentsForm").serialize(), function(data) {
			if (data.json.result == true) {
				alert("수정 되었습니다.");
				$("#ContentsForm").attr('action', 'appInfoEdit.do');
				$("#ContentsForm").submit();
			} else {
				alert("수정 실패했습니다.");
			}
		});
	}

	function executePhModelSave() {
		$.post("appInfoUpdate.do", $("#ContentsForm").serialize(), function(data) {
			if (data.json.result == true) {
				alert("수정 되었습니다.");
				$("#ContentsForm").attr('action', 'appInfoEdit.do');
				$("#ContentsForm").submit();
			} else {
				alert("수정 실패했습니다.");
			}
		});
	}

	//리스트조회
	function phSearchPage() {
		//호출 및 메시지 출력
		$.post("searchModifyPhModel.do",$("#ContentsForm").serialize(),
			function(data) {
				var searchModifyPhModel = "";
					$.each(data.json.searchModifyPhModel,
						function(idx, list) {
							searchModifyPhModel += "<tr>";
							searchModifyPhModel += "<td>";
							searchModifyPhModel += "<input type=\"checkbox\" name=\"phModelchoice\" value=\""+list.rownum+"|"+list.phModelInfoSeq+"|"+list.phName+"|"+list.osVerName+"|"+list.phContent+"|"+list.osVerContent+"|"+list.phId+"|"+list.osVerId+"\"/>";
							searchModifyPhModel += "</td>";
							searchModifyPhModel += "<td><input type=\"text\" class=\"invisiblebox\" value=\""+list.phName+"\" readonly=\"readonly\" style=\"width: 150\"/></td>";
							searchModifyPhModel += "<td>";
							if (list.phContent != null) {
								searchModifyPhModel += "<input type=\"text\" class=\"invisiblebox\" value=\""+list.phContent+"\" readonly=\"readonly\" style=\"width: 210\"/>";
							} else {
								searchModifyPhModel += "<input type=\"text\" class=\"invisiblebox\" value=\"\" readonly=\"readonly\" style=\"width: 210\"/>";
							}
							searchModifyPhModel += "</td>";
							searchModifyPhModel += "<td><input type=\"text\" class=\"invisiblebox\" value=\""+list.osVerName+"\" readonly=\"readonly\" style=\"width: 150\"/></td>";
							searchModifyPhModel += "<td>";
							if (list.osVerContent != null) {
								searchModifyPhModel += "<input type=\"text\" class=\"invisiblebox\" value=\""+list.osVerContent+"\" readonly=\"readonly\" style=\"width: 210\"/>";
							} else {
								searchModifyPhModel += "<input type=\"text\" class=\"invisiblebox\" value=\"\" readonly=\"readonly\" style=\"width: 210\"/>";
							}
							searchModifyPhModel += "</td>";
							searchModifyPhModel += "</tr>";
	
						});
				$("#trsearchPhModel").html(searchModifyPhModel);
			});
	};
</script>
</head>
<body>
	<form:form commandName="ContentsForm" id="ContentsForm" name="ContentsForm">
		<input type="hidden" id="appInfoSeq" name="appInfoSeq" value="${appInfo.appInfoSeq}">
		<input type="hidden" id="appStoreDate" name="appStoreDate" value="${appInfo.appStoreDate}">
		<input type="hidden" id="appVerId" name="appVerId">
		<!-- <input type="hidden" name="isMapping" value=""> -->
		<form:hidden path="templetModelId" />

		<!-- 레이어 팝업 -->
		<div id="pop_wrap" style="display: none; position: absolute; margin-left : 170px; margin-top:-115px;">
			<div id="pop_container">
				<div style="overflow: auto;">
					<table class="srvRegi" style="width: 350px;">
						<colgroup>
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th class="first">이름</th>
								<td class="first">
									<input type="text" style="width: 100%" id="appVerName" name="appVerName">
								</td>
							</tr>
							<!-- <tr>
								<th>등록일</th>
								<td><input type="text" id="appVerSdate" name="appVerSdate"
									style="width: 200px" readonly="readonly"></td>
							</tr> -->
							<tr>
								<th>사용여부</th>
								<td>
									<input type="radio" id="appVerState" name="appVerState" value="Y"> 사용 &nbsp;&nbsp; 
									<input type="radio" id="appVerState" name="appVerState" value="N" /> 미사용
								</td>
							</tr>
							<tr>
								<th>내용</th>
								<td>
									<input type="text" id="appVerContent" name="appVerContent" style="width: 100%; height: 30" title="내용"/>
								</td>
							</tr>
						<tbody id="popupTbody"></tbody>
						<tr>
							<td>
								<a onclick="document.getElementById('pop_wrap').style.display='none'; document.body.className='';">
									<input type="button" value="닫기" style="width: 70px; height: 23px;"/>
								</a>
							</td>
							<td>
								<a href="javascript:appVerInsert();" onFocus="blur()">
									<img src="images/btn/btn_apply2.gif" border="0" id="insert">
								</a> 
								<a href="javascript:executeDelete();" onFocus="blur()">
									<img src="images/btn/delete7.gif" border="0" id="delete">
								</a>&nbsp;
								<a href="javascript:executeModify();" onFocus="blur()">
									<img src="images/btn/modify7.gif" border="0" id="modify">
								</a>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div id="pop_container2" style="margin-left:175px; margin-top:-185px;">
				<table>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;
							<span style="cursor: hand;" id="phModelOpen">[단말모델 정보]</span> 
							<span style="cursor: hand;" id="templetModelOpen">[단말조합 정보]</span>&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
				</table>
				<table class="sub_0601_table" id="phModelDiv">
					<colgroup>
						<col width="" />
						<col width="" />
						<col width="" />
						<col width="" />
						<col width="" />
					</colgroup>
					<thead>
						<tr>
							<th>
								<input type="checkbox" name="phModelchoiceAll" onclick="checkAll('ContentsForm','phModelchoiceAll', 'phModelchoice');" />
							</th>
							<th>단말명</th>
							<th>단말정보</th>
							<th>OS버전명</th>
							<th>OS버전정보</th>
						</tr>
					</thead>
					<c:choose>
						<c:when test="${empty allOsPhInfo}">
							<tr>
								<td colspan="5" height="100" align="center">등록된 게시물이 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<tbody id="trsearchPhModel">
								<c:forEach var="list" items="${allOsPhInfo}" varStatus="stat">
									<tr>
										<td class="td03">
											<input type="checkbox" name="phModelchoice" value="${stat.index+1}|${list.phModelInfoSeq}|${list.phName}|${list.osVerName}|${list.phContent}|${list.osVerContent}|${list.phId}|${list.osVerId}" />
											<input type="hidden" name="posibleDelete" value="Y" />
										</td>
										<td class="td03">${list.phName}</td>
										<td class="td03">${list.phContent}</td>
										<td class="td03">${list.osVerName}</td>
										<td class="td03">${list.osVerContent}</td>
									</tr>
								</c:forEach>
							</tbody>
							<!-- </table> -->
							<!-- </div> -->
						</c:otherwise>
					</c:choose>
					</tbody>
				</table>

				<div id="templetNameDiv" style="display: none;">
					<table class="sub_0601_table">
						<colgroup>
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>단말조합명</th>
								<th>내용</th>
								<th>등록일</th>
								<th>사용여부</th>
							</tr>
						</thead>
						<tbody id="trsearchTempletName" style="overflow: auto; height: 250px;">
							<c:choose>
								<c:when test="${empty templetModel}">
									<tr>
										<td height="100" align="center" colspan="5">등록된 게시물이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<tbody>
										<c:forEach var="list" items="${templetModel}">
											<tr
												onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
												onMouseOut="rowOnMouseOut(this);"
												onclick="javascript:executeDetail('${list.templetModelId}');">
												<td class="td03">${list.rownum}</td>
												<td class="td03">${list.templetModelName}</td>
												<td class="td03">${list.templetModelContent}</td>
												<td class="td03">${list.templetModelSdate}</td>
												<td class="td03"><img src="images/state/ic_map1.gif"></td>
											</tr>
										</c:forEach>
									</tbody>
								</c:otherwise>
							</c:choose>
							<!-- </table> -->
							<!-- 					</div> -->
						</tbody>
					</table>
				</div>
				<div id="templetModelDiv" style="display: none;">
					<table class="sub_0601_table">
						<colgroup>
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
						</colgroup>
						<thead>
							<tr>
								<th>
									<input type="checkbox" name="templetchoiceAll" onclick="checkAll('ContentsForm','templetchoiceAll', 'templetchoice');" />
								</th>
								<th>단말명</th>
								<th>단말정보</th>
								<th>OS버전</th>
								<th>OS버전정보</th>
							</tr>
						</thead>
						<tbody id="trsearchTempletModel"></tbody>
					</table>
				</div>
				<!-- </table> -->
				<!-- <table> -->
				<div id="search" style="width: 670px">
					<fieldset>
						<table style="margin-left:95px; margin-top:3px;">
							<tr>
								<!-- <td>&nbsp;&nbsp;&nbsp;
									<span style="cursor: hand;" id="phModelOpen">[단말모델 정보]</span> 
									<span style="cursor: hand;" id="templetModelOpen">[단말조합 정보]</span>&nbsp;&nbsp;&nbsp;
								</td> -->
							<!-- </tr>
							<tr> -->
								<td id="phModelTd">
									<form:select path="keywordTp" style="width:90px;">
										<form:option value="1" label="단말명" />
									</form:select> 
									<form:input type="text" size="25" path="phName" /> 
										<img src="images/btn/search5.gif" id="phModelBtn" style="vertical-align: bottom; width: 40px;">
								</td>

								<td id="templetModelTd" style="display: none;">
									<form:select path="keywordTp" style="width:90px;">
										<form:option value="1" label="단말명" />
									</form:select> 
									<form:input type="text" size="25" path="phName2" /> 
										<img src="images/btn/search5.gif" id="templetModelBtn" style="vertical-align: bottom; width: 40px;">
								</td>

								<td id="templetNameTd" style="display: none;">
									<form:select path="keywordTp" style="width:90px;">
										<form:option value="1" label="단말조합명" />
									</form:select> 
									<form:input type="text" size="25" path="templetModelName" />
										<img src="images/btn/search5.gif" id="templetNameBtn" style="vertical-align: bottom; width: 40px;"> 
									<!-- <a onclick="document.getElementById('pop_wrap').style.display='none'; document.body.className='';">
										<input type="button" value="닫기" />
									</a> -->
								</td>

								<td class="btn" id="phAdd">
									<a href="javascript:executeAdd('P', 'phModelchoice');" onFocus="blur()">&nbsp;&nbsp;
										<img src="images/btn/add.gif" style="vertical-align: bottom; width: 70px;">
									</a>&nbsp;&nbsp;
								</td>
								<td class="btn" id="templetAdd" style="display: none;">
									<a href="javascript:executeAdd('T','templetchoice');" onFocus="blur()">&nbsp;&nbsp;
										<img src="images/btn/add.gif" style="vertical-align: bottom; width: 70px;">
									</a>&nbsp;&nbsp;
								</td>
								<td class="btn">
									<a onclick="document.getElementById('pop_wrap').style.display='none'; document.body.className='';">
										<input type="button" value="닫기" style="width:50px; height:24px;"/>
									</a>
								</td>
							</tr>
							
						</table>
					</fieldset>
				</div>
			</div>
		</div>


		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td width="680">
								<img src="images/h3_ico.gif"><span>APP 수정</span>
							</td>
							<td>
								<a href="appInfoList.do" onFocus="blur()">
									<img src="images/btn/btn_list.gif" border="0">
								</a>
							</td>
						</tr>
					</table>
					<br>
					<div id="accordion">
						<h2>App 정보</h2>
						<div>
							<table style="margin-left: 554px;">
								<tr>
									<td>
										<a href="javascript:executeDel('${appInfo.appState}');" onFocus="blur()">
											<img src="images/btn/delete7.gif" border="0">
										</a>&nbsp; 
										<a href="javascript:executeSave();" onFocus="blur()">
											<img src="images/btn/modify7.gif" border="0">
										</a>&nbsp;
									</td>
								</tr>
							</table>
							<table class="srvRegiEdit" style="margin-top:-20px;">
								<colgroup>
									<col width="*" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr class="td06">
										<th>등록일</th>
										<td>${appInfo.appStoreDate}</td>
									</tr>
									<tr>
										<th>이름</th>
										<td>
											<input type="text" name="appName" value="${appInfo.appName}" class="invisible" style="width: 600px;" title="어플리케이션 이름" readonly="readonly" />
										</td>
									</tr>
									<tr>
										<th>사용여부</th>
										<td>
											<input type="radio" name="appState" value="Y" <c:if test="${appInfo.appState == 'Y'}">checked="checked"</c:if> /> 사용 &nbsp;&nbsp; 
											<input type="radio" name="appState" value="N" <c:if test="${appInfo.appState == 'N'}">checked="checked"</c:if> /> 미사용
										</td>
									</tr>
									<tr>
										<th>DOWN URL</th>
										<td>
											<input type="text" name="appDownURL" value="${appInfo.appDownURL}" class="textbox  validate-req" style="width: 600px" title="Down URL" maxlength="200" />
										</td>
									</tr>
									<tr>
										<th>제조사</th>
										<td>
											<input type="text" name="appMade" class="textbox" style="width: 600px" maxlength="100" value="${appInfo.appMade}" />
										</td>
									</tr>
									<tr>
										<th>내용</th>
										<td>
											<input type="text" name="appContent" style="width: 600px; title="내용" value="${appInfo.appContent}">
										</td>
									</tr>
								</tbody>
							</table>
						</div>

						<h2>App Version 정보</h2>
						<div>
							<table style="margin-left: 595;">
								<tr>
									<td>
										<a href="javascript:appVerInfoNew();" onFocus="blur()">
											<img src="images/btn/btn_apply2.gif" border="0">
										</a>
									</td>
								</tr>
							</table>
							<table class="sub_0601_table">
								<colgroup>
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
								</colgroup>
								<tbody id=appVerTbody>
									<tr>
										<th></th>
										<th>앱 버전</th>
										<th>제목</th>
										<th>상태</th>
										<th>수정</th>
									</tr>
									<c:choose>
										<c:when test="${empty appVerInfoList }">
											<tr>
												<td colspan="5" height="100" align="center">등록된 APP 버전이 없습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach var="list" items="${appVerInfoList}">
												<tr onmouseover="rowOnMouseOver(this);this.style.cursor='hand';" onMouseOut="rowOnMouseOut(this);">
													<td class="td03">
														<input type="radio" style="cursor: hand;" name="sort" onclick="getAppVerId('${list.appVerId}', '${list.appVerName }');" />
													</td>
													<td class="td03">${list.appVerName}</td>
													<td class="td03">${list.appVerContent}</td>
													<td class="td03">
														<c:if test="${list.appVerState == 'Y'}"> 사용</c:if> 
														<c:if test="${list.appVerState == 'N'}"> 미사용</c:if>
													</td>
													<td class="td03">
														<a href="javascript:appVerDetail('${list.appVerId}');" onFocus="blur()">
															<img src="images/btn/modify7.gif" border="0">
														</a>
													</td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>

						<h2>등록된 단말 정보</h2>
						<div>
							<table style="margin-left: 415;">
								<tr>
									<td>
										<a href="javascript:phInfoAdd();" onFocus="blur()">&nbsp;&nbsp;
											<img src="images/btn/add.gif" style="vertical-align: bottom; width: 70px;">
										</a>&nbsp;&nbsp;
									</td>
									<td>
										<a href="javascript:executePhModelDel('P');" onFocus="blur()">
											<img src="images/btn/device2.gif" style="vertical-align: bottom; width: 95px;">
										</a>&nbsp;&nbsp;
									</td>
									<td>
										<a href="javascript:executeSave();" onFocus="blur()">
											<img src="images/btn/modify7.gif" style="vertical-align: bottom; width: 50px;">
										</a>&nbsp;
									</td>
								</tr>
							</table>
							<div id="templetModelDiv" style="margin-top:-20px;">
								<table class="sub_0601_table">
									<colgroup>
										<col width="" />
										<col width="" />
										<col width="" />
									</colgroup>
									<thead>
										<tr>
											<th>
												<input type="checkbox" name="modelChoiceAll" onclick="checkAll('ContentsForm','modelChoiceAll', 'choice');" />
											</th>
											<th>단말정보</th>
											<th>OS버전정보</th>
										</tr>
									</thead>
									<tbody id="addPhModel">
										<c:forEach var="list" items="${appUseOsPh}" varStatus="stat">
											<tr>
												<td class="td03">
													<input type="checkbox" name="choice" value="${stat.index+1}|${list.phModelInfoSeq}|${list.phName}|${list.osVerName}|${list.phContent}|${list.osVerContent}|${list.phId}|${list.osVerId}" />
													<input type="hidden" name="checkboxPhModelInfos" value="${list.phModelInfoSeq}" /> 
													<input type="hidden" name="phIds" value="${list.phId}" /> 
													<input type="hidden" name="osVerIds" value="${list.osVerId}" /> 
													<input type="hidden" name="posibleDelete" value="${posibleDelete}" />
												</td>
												<td class="td03">${list.phName} ${list.phContent}</td>
												<td class="td03">${list.osVerName} ${list.osVerContent}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
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

<%-- <table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td><img src="images/h3_ico.gif"><span>APP 수정</span></td>
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
							<td style="font-size: 13;"><b>※ 어플리케이션 정보 입력 → 단말모델정보 선택
									추가 → 어플리케이션 정보 등록</b></td>
							<td class="btn"><a
								href="javascript:executeDel('${appInfo.appState}');"
								onFocus="blur()"><img src="images/btn/delete7.gif"
									border="0"></a>&nbsp; <a href="javascript:executeSave();"
								onFocus="blur()"><img src="images/btn/modify7.gif"
									border="0"></a>&nbsp; <a href="appInfoList.do"
								onFocus="blur()"><img src="images/btn/btn_list.gif"
									border="0"></a></td>
						</tr>
					</table>
					<table width="100%" border="0" cellpadding="10" cellspacing="1"
						bgcolor="#FF8200">
						<tr>
							<td width="404" valign="top" bgcolor="#FFFFFF" height="320px">
								<!-------앱정보 시작------->
								<table width="404" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="5"></td>
									</tr>
									<tr>
										<td class="ttl7"><span style="cursor: hand;" id="appOpen">[어플리케이션
												정보]</span><span style="cursor: hand;" id="verOpen">[버전 정보]</span></td>
									</tr>
									<tr>
										<td height="5"></td>
									</tr>
								</table>
								<div id="appInfo">
									<table width="404" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td><img src="images/box404_1.png"></td>
										</tr>
										<tr>
											<td align="center" background="images/box404_2.png">
												<table width="404" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td width="113" class="ttl4">등록일</td>
														<td width="1" bgcolor="#f3961d"></td>
														<td width="5"></td>
														<td class="ttl5">${appInfo.appStoreDate}</td>
														<td width="5"></td>
													</tr>
													<tr>
														<td height="1" colspan="5" bgcolor="#f3961d"></td>
													</tr>
													<tr>
														<td width="113" class="ttl4">이름</td>
														<td width="1" bgcolor="#f3961d"></td>
														<td width="5"></td>
														<td class="ttl4"><input type="text" name="appName"
															value="${appInfo.appName}" class="invisible"
															style="width: 95%" title="어플리케이션 이름" readonly="readonly" /></td>
														<td width="5"></td>
													</tr>
													<tr>
														<td height="1" colspan="5" bgcolor="#f3961d"></td>
													</tr>
												</table>
												<table width="404" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td width="113" class="ttl4">사용여부</td>
														<td width="1" bgcolor="#f3961d"></td>
														<td width="5"></td>
														<td class="ttl5"><input type="radio" name="appState"
															value="Y"
															<c:if test="${appInfo.appState == 'Y'}">checked="checked"</c:if> />
															사용 &nbsp;&nbsp; <input type="radio" name="appState"
															value="N"
															<c:if test="${appInfo.appState == 'N'}">checked="checked"</c:if> />
															미사용</td>
														<td width="5"></td>
													</tr>
													<tr>
														<td height="1" colspan="5" bgcolor="#f3961d"></td>
													</tr>
												</table>
												<table width="404" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td width="113" class="ttl4">DOWN URL</td>
														<td width="1" bgcolor="#f3961d"></td>
														<td width="5"></td>
														<td class="ttl4"><input type="text" name="appDownURL"
															value="${appInfo.appDownURL}"
															class="textbox  validate-req" style="width: 95%"
															title="Down URL" maxlength="200" /></td>
														<td width="5"></td>
													</tr>
													<tr>
														<td height="1" colspan="5" bgcolor="#f3961d"></td>
													</tr>
												</table>
												<table width="404" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td width="113" height="15" class="ttl4">제조사</td>
														<td width="1" bgcolor="#f3961d"></td>
														<td width="5"></td>
														<td class="ttl4"><input type="text" name="appMade"
															class="textbox" style="width: 95%" maxlength="100"
															value="${appInfo.appMade}" /></td>
														<td width="5"></td>
													</tr>
													<tr>
														<td height="1" colspan="5" bgcolor="#f3961d"></td>
													</tr>
												</table>
												<table width="404" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td width="113" class="ttl4">내용</td>
														<td width="1" bgcolor="#f3961d"></td>
														<td width="5"></td>
														<td class="ttl4"><textarea name="appContent"
																style="width: 95%; height: 50" title="내용">${appInfo.appContent}</textarea>
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
								</div>
								<div id="verInfo" style="display: none;">
									<table width="404" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="50%" valign="top" bgcolor="#FFFFFF"><iframe
													width="99%" height="270px;"
													src="appVerInfoList.do?appInfoSeq=${appInfo.appInfoSeq}&isMapping=false"
													scrolling="no" frameborder="0"></iframe></td>
										</tr>
									</table>
								</div> <!-------앱정보 끝------->
							</td>
							<!-------앱정보와연결된단말모델정보 시작------->
							<td width="50%" valign="top" bgcolor="#FFFFFF"
								style="padding-bottom: 30">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td>
											<table width="100%" border="0" cellspacing="0"
												cellpadding="0">
												<tr>
													<td class="ttl7">[어플리케이션이 실행가능한 단말모델 정보]</td>
													<td class="btn">
													<td class="btn" id="phDel"><a
														href="javascript:executePhModelDel('P');" onFocus="blur()"><img
															src="images/btn/device2.gif" border="0"></a></td>
													<td class="btn" id="templetDel" style="display: none;">
														<a href="javascript:executePhModelDel('T');"
														onFocus="blur()"><img src="images/btn/device2.gif"
															border="0"></a>
													</td>
												</tr>
											</table>
											<table width="100%" border="0" cellspacing="0"
												cellpadding="0">
												<tr>
													<td width="3"><img src="images/ttl_bar1.gif"></td>
													<td width="8%" background="images/ttl_bar2.gif" class="ttl"><input
														type="checkbox" name="choiceAll"
														onclick="checkAll('ContentsForm','choiceAll', 'choice');" />
													</td>
													<td width="1" background="images/ttl_bar2.gif"><img
														src="images/ttl_line.gif"></td>
													<td width="46%" background="images/ttl_bar2.gif"
														class="ttl">단말 정보</td>
													<td width="1" background="images/ttl_bar2.gif"><img
														src="images/ttl_line.gif"></td>
													<td width="46%" background="images/ttl_bar2.gif"
														class="ttl">OS버전 정보</td>
													<td width="3"><img src="images/ttl_bar3.gif"></td>
												</tr>
											</table>
											<div style="overflow: auto; height: 170px;">
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0" id="addPhModel">
													<col width="3"></col>
													<col width="8%" class="ttl4" style="padding: 0 0 0 5"></col>
													<col width="1"></col>
													<col width="46%" class="ttl4"></col>
													<col width="1"></col>
													<col width="46%" class="ttl4"></col>
													<col width="3"></col>
													<c:forEach var="list" items="${appUseOsPh}"
														varStatus="stat">
														<tr>
															<td width="3"></td>
															<td width="8%" class="ttl4" style="padding: 0 0 0 5">
																<input type="checkbox" name="choice"
																value="${stat.index+1}|${list.phModelInfoSeq}|${list.phName}|${list.osVerName}|${list.phContent}|${list.osVerContent}|${list.phId}|${list.osVerId}" />
																<input type="hidden" name="checkboxPhModelInfos"
																value="${list.phModelInfoSeq}" /> <input type="hidden"
																name="phIds" value="${list.phId}" /> <input
																type="hidden" name="osVerIds" value="${list.osVerId}" />
																<input type="hidden" name="posibleDelete"
																value="${posibleDelete}" />
															</td>
															<td width="1"></td>
															<td width="46%" class="ttl4"><input type="text"
																class="invisiblebox"
																value="${list.phName} ${list.phContent}"
																readonly="readonly" style="width: 170" /></td>
															<td width="1"></td>
															<td width="46%" class="ttl4"><input type="text"
																class="invisiblebox"
																value="${list.osVerName} ${list.osVerContent}"
																readonly="readonly" style="width: 170" /></td>
															<td width="3"></td>
														</tr>
													</c:forEach>
												</table>
											</div>
										</td>
									</tr>
								</table>
							</td>
							<!-------앱정보와연결된단말모델정보 끝------->
						</tr>
						<table>
							<tr>
								<!-------단말모델 시작------->
								<td colspan="2" valign="top" bgcolor="#FFFFFF">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="350px" id="phModelTd"><form:select
													path="keywordTp" style="width:90px;">
													<form:option value="1" label="단말명" />
												</form:select> <form:input type="text" size="25" path="phName" /> <img
												src="images/btn/search5.gif" id="phModelBtn"
												style="vertical-align: bottom; width: 40px;"></td>
											<td width="350px" id="templetModelTd" style="display: none;">
												<form:select path="keywordTp" style="width:90px;">
													<form:option value="1" label="단말명" />
												</form:select> <form:input type="text" size="25" path="phName2" /> <img
												src="images/btn/search5.gif" id="templetModelBtn"
												style="vertical-align: bottom; width: 40px;">
											</td>
											<td width="350px" id="templetNameTd" style="display: none;">
												<form:select path="keywordTp" style="width:90px;">
													<form:option value="1" label="단말조합명" />
												</form:select> <form:input type="text" size="25" path="templetModelName" />
												<img src="images/btn/search5.gif" id="templetNameBtn"
												style="vertical-align: bottom; width: 40px;">
											</td>
											<td class="ttl7"><span style="cursor: hand;"
												id="phModelOpen">[단말모델 정보]</span> <span
												style="cursor: hand;" id="templetModelOpen">[단말조합 정보]</span></td>
											<td class="btn" id="phAdd"><a
												href="javascript:executeAdd('P', 'phModelchoice');"
												onFocus="blur()"><img src="images/btn/add.gif"
													border="0"></a></td>
											<td class="btn" id="templetAdd" style="display: none;"><a
												href="javascript:executeAdd('T','templetModelchoice');"
												onFocus="blur()"><img src="images/btn/add.gif"
													border="0"></a></td>
										</tr>
									</table>
									<div id="phModelDiv">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="3"><img src="images/ttl_bar1.gif"></td>
												<td width="4%" background="images/ttl_bar2.gif" class="ttl">
													<input type="checkbox" name="phModelchoiceAll"
													onclick="checkAll('ContentsForm','phModelchoiceAll', 'phModelchoice');" />
												</td>
												<td width="1" background="images/ttl_bar2.gif"><img
													src="images/ttl_line.gif"></td>
												<td width="20%" background="images/ttl_bar2.gif" class="ttl">단말
													명</td>
												<td width="1" background="images/ttl_bar2.gif"><img
													src="images/ttl_line.gif"></td>
												<td width="28%" background="images/ttl_bar2.gif" class="ttl">단말
													정보</td>
												<td width="1" background="images/ttl_bar2.gif"><img
													src="images/ttl_line.gif"></td>
												<td width="20%" background="images/ttl_bar2.gif" class="ttl">OS버전
													명</td>
												<td width="1" background="images/ttl_bar2.gif"><img
													src="images/ttl_line.gif"></td>
												<td width="28%" background="images/ttl_bar2.gif" class="ttl">OS버전
													정보</td>
												<td width="3"><img src="images/ttl_bar3.gif"></td>
											</tr>
										</table>
										<c:choose>
											<c:when test="${empty allOsPhInfo}">
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
												<div style="overflow: auto; height: 250px">
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0" id="phModelList">
														<col width="3"></col>
														<col width="4%" class="ttl4" style="padding: 0 0 0 5"></col>
														<col width="1"></col>
														<col width="20%" class="ttl4"></col>
														<col width="1"></col>
														<col width="28%" class="ttl4"></col>
														<col width="1"></col>
														<col width="20%" class="ttl4"></col>
														<col width="1"></col>
														<col class="ttl4"></col>
														<col width="3"></col>
														<tbody id="trsearchPhModel">
															<c:forEach var="list" items="${allOsPhInfo}"
																varStatus="stat">
																<tr>
																	<td width="3"></td>
																	<td width="4%" align="center" style="padding: 0 0 0 3">
																		<input type="checkbox" name="phModelchoice"
																		value="${stat.index+1}|${list.phModelInfoSeq}|${list.phName}|${list.osVerName}|${list.phContent}|${list.osVerContent}|${list.phId}|${list.osVerId}" />
																		<input type="hidden" name="posibleDelete" value="Y" />
																	</td>
																	<td width="1"></td>
																	<td width="20%" class="ttl4"><input type="text"
																		class="invisiblebox" value="${list.phName}"
																		readonly="readonly" style="width: 150" /></td>
																	<td width="1"></td>
																	<td width="28%" class="ttl4"><input type="text"
																		class="invisiblebox" value="${list.phContent}"
																		readonly="readonly" style="width: 210" /></td>
																	<td width="1"></td>
																	<td width="20%" class="ttl4"><input type="text"
																		class="invisiblebox" value="${list.osVerName}"
																		readonly="readonly" style="width: 150" /></td>
																	<td width="1"></td>
																	<td class="ttl4"><input type="text"
																		class="invisiblebox" value="${list.osVerContent}"
																		readonly="readonly" style="width: 210" /></td>
																	<td width="3"></td>
																</tr>
															</c:forEach>
														</tbody>
													</table>
												</div>
											</c:otherwise>
										</c:choose>
									</div>
									<div id="templetNameDiv" style="display: none;">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="3"><img src="images/ttl_bar1.gif"></td>
												<td width="10%" background="images/ttl_bar2.gif" class="ttl">번호</td>
												<td width="2" background="images/ttl_bar2.gif"><img
													src="images/ttl_line.gif"></td>
												<td width="25%" background="images/ttl_bar2.gif" class="ttl">단말조합명</td>
												<td width="2" background="images/ttl_bar2.gif"><img
													src="images/ttl_line.gif"></td>
												<td width="25%" background="images/ttl_bar2.gif" class="ttl">내용</td>
												<td width="2" background="images/ttl_bar2.gif"><img
													src="images/ttl_line.gif"></td>
												<td width="25%" background="images/ttl_bar2.gif" class="ttl">등록일</td>
												<td width="2" background="images/ttl_bar2.gif"><img
													src="images/ttl_line.gif"></td>
												<td width="15%" background="images/ttl_bar2.gif" class="ttl">사용여부</td>
												<td width="3"><img src="images/ttl_bar3.gif"></td>
											</tr>
										</table>
										<div style="overflow: auto; height: 250px;">
											<c:choose>
												<c:when test="${empty templetModel}">
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
														<tbody id="trsearchTempletName">
															<c:forEach var="list" items="${templetModel}">
																<tr
																	onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
																	onMouseOut="rowOnMouseOut(this);"
																	onclick="javascript:executeDetail('${list.templetModelId}');">
																	<td width="3"></td>
																	<td width="10%" class="ttl4">${list.rownum}</td>
																	<td width="2"></td>
																	<td width="25%" class="ttl4">${list.templetModelName}</td>
																	<td width="2"></td>
																	<td width="25%" class="ttl4">${list.templetModelContent}</td>
																	<td width="2"></td>
																	<td width="25%" class="ttl4">${list.templetModelSdate}</td>
																	<td width="2"></td>
																	<td width="15%" class="ttl4"><img
																		src="images/state/ic_map1.gif"></td>
																	<td width="3"></td>
																</tr>
																<tr>
																	<td height="1" colspan="11" class="line"></td>
																</tr>
															</c:forEach>
														</tbody>
													</table>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									<div id="templetModelDiv" style="display: none;">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="3"><img src="images/ttl_bar1.gif"></td>
												<td width="4%" background="images/ttl_bar2.gif" class="ttl"><input
													type="checkbox" name="templetModelchoiceAll"
													onclick="checkAll('ContentsForm','templetModelchoiceAll', 'templetModelchoice');" /></td>
												<td width="1" background="images/ttl_bar2.gif"><img
													src="images/ttl_line.gif"></td>
												<td width="20%" background="images/ttl_bar2.gif" class="ttl">단말
													명</td>
												<td width="1" background="images/ttl_bar2.gif"><img
													src="images/ttl_line.gif"></td>
												<td width="28%" background="images/ttl_bar2.gif" class="ttl">단말
													정보</td>
												<td width="1" background="images/ttl_bar2.gif"><img
													src="images/ttl_line.gif"></td>
												<td width="20%" background="images/ttl_bar2.gif" class="ttl">OS버전
													명</td>
												<td width="1" background="images/ttl_bar2.gif"><img
													src="images/ttl_line.gif"></td>
												<td width="28%" background="images/ttl_bar2.gif" class="ttl">OS버전
													정보</td>
												<td width="3"><img src="images/ttl_bar3.gif"></td>
											</tr>
										</table>
										<div style="overflow: auto; height: 250px;">
											<table width="100%" border="0" cellspacing="0"
												cellpadding="0" id="templetModelList">
												<col width="3"></col>
												<col width="4%" class="ttl4" style="padding: 0 0 0 3"></col>
												<col width="1"></col>
												<col width="20%" class="ttl4"></col>
												<col width="1"></col>
												<col width="28%" class="ttl4"></col>
												<col width="1"></col>
												<col width="20%" class="ttl4"></col>
												<col width="1"></col>
												<col class="ttl4"></col>
												<col width="3"></col>
												<tbody id="trsearchTempletModel">
												</tbody>
											</table>
										</div>
									</div>
								</td>
								<!-------단말모델 끝------->
							</tr>
						</table> --%>



<%-- <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  	<tr>
    	<td height="100%">
    	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
      		<tr>
        		<td height="100%" valign="top" class="contents">
        		<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="20">
            		<tr><td valign="top" bgcolor="#FFFFFF">
              			<div id="contents" style="width: 850px">
              			<table border="0" cellspacing="0" cellpadding="0">
                  			<tr>
                    			<td><img src="images/h3_ico.gif"><span>APP 수정</span></td>
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
                  				<td style="font-size: 13;"><b>※ 어플리케이션 정보 입력 → 단말모델정보 선택 추가 → 어플리케이션 정보 등록</b></td>
                  				<td class="btn">
                  				<a href="javascript:executeDel('${appInfo.appState}');" onFocus="blur()"><img src="images/btn/delete7.gif" border="0"></a>&nbsp;
                  				<a href="javascript:executeSave();" onFocus="blur()"><img src="images/btn/modify7.gif" border="0"></a>&nbsp;
                  				<a href="appInfoList.do" onFocus="blur()"><img src="images/btn/btn_list.gif" border="0"></a>
                  				</td>
                			</tr>
              			</table>
              			<table width="100%" border="0" cellpadding="10" cellspacing="1" bgcolor="#FF8200">
                			<tr>
                  				<td width="404" valign="top" bgcolor="#FFFFFF" height="320px" >
                  				<!-------앱정보 시작------->
                  				<table width="404" border="0" cellspacing="0" cellpadding="0">
		                			<tr>
		                  				<td height="5"></td>
		                			</tr>
		                			<tr>
		                  				<td class="ttl7">
		                  				<span style="cursor: hand;" id="appOpen">[어플리케이션 정보]</span><span style="cursor: hand;" id="verOpen">[버전 정보]</span>
		                  				</td>
		                			</tr>
		                			<tr>
		                				<td height="5"></td>
		                			</tr>
		              			</table>
		              			<div id="appInfo">
		              			<table width="404" border="0" cellspacing="0" cellpadding="0"> 
		                			<tr>
		                  				<td><img src="images/box404_1.png"></td>
		                			</tr>
                        			<tr>
                          				<td align="center" background="images/box404_2.png">
                          				<table width="404" border="0" cellspacing="0" cellpadding="0">
                            				<tr>
                              					<td width="113" class="ttl4">등록일</td>
                              					<td width="1" bgcolor="#f3961d"></td>
                              					<td width="5"></td>
                              					<td class="ttl5">${appInfo.appStoreDate}</td>
                              					<td width="5"></td>
                            				</tr>
                            				<tr>
                              					<td height="1" colspan="5" bgcolor="#f3961d"></td>
                            				</tr>
                            				<tr>
                              					<td width="113" class="ttl4">이름</td>
                              					<td width="1" bgcolor="#f3961d"></td>
                              					<td width="5"></td>
                              					<td class="ttl4">
                              					<input type="text" name="appName" value="${appInfo.appName}" class="invisible" style="width:95%" title="어플리케이션 이름" readonly="readonly"/>
                              					</td>
                              					<td width="5"></td>
                            				</tr>
                            				<tr>
                              					<td height="1" colspan="5" bgcolor="#f3961d"></td>
                            				</tr>
                          				</table>
                            			<table width="404" border="0" cellspacing="0" cellpadding="0">
                              				<tr>
                                				<td width="113" class="ttl4">사용여부</td>
                                				<td width="1" bgcolor="#f3961d"></td>
                                				<td width="5"></td>
                                				<td class="ttl5">
		                          				<input type="radio" name="appState" value="Y" <c:if test="${appInfo.appState == 'Y'}">checked="checked"</c:if>/> 사용 &nbsp;&nbsp;
		                          				<input type="radio" name="appState" value="N" <c:if test="${appInfo.appState == 'N'}">checked="checked"</c:if>/> 미사용
                                				</td>
                                				<td width="5"></td>
                              				</tr>
                              				<tr>
	                                			<td height="1" colspan="5" bgcolor="#f3961d"></td>
    	                          			</tr>
        	                    		</table>
            	                		<table width="404" border="0" cellspacing="0" cellpadding="0">
                	              			<tr>
                    	            			<td width="113" class="ttl4">DOWN URL</td>
                        	        			<td width="1" bgcolor="#f3961d"></td>
                            	    			<td width="5"></td>
                                				<td class="ttl4">
                                				<input type="text" name="appDownURL" value="${appInfo.appDownURL}" class="textbox  validate-req" style="width:95%" title="Down URL" maxlength="200"/>
                                				</td>
                                				<td width="5"></td>
                              				</tr>
                              				<tr>
                                				<td height="1" colspan="5" bgcolor="#f3961d"></td>
                              				</tr>
                            			</table>
                            			<table width="404" border="0" cellspacing="0" cellpadding="0">
	                              			<tr>
    	                            			<td width="113" height="15" class="ttl4">제조사</td>
        	                        			<td width="1" bgcolor="#f3961d"></td>
            	                    			<td width="5"></td>
                	                			<td class="ttl4">
                    	            			<input type="text" name="appMade" class="textbox" style="width:95%" maxlength="100" value="${appInfo.appMade}"/>
                        	        			</td>
                            	    			<td width="5"></td>
                              				</tr>
                              				<tr>
                                				<td height="1" colspan="5" bgcolor="#f3961d"></td>
                              				</tr>
                            			</table>
                            			<table width="404" border="0" cellspacing="0" cellpadding="0">
	                              			<tr>
    	                            			<td width="113" class="ttl4">내용</td>
        	                        			<td width="1" bgcolor="#f3961d"></td>
            	                    			<td width="5"></td>
                	                			<td class="ttl4">
                    	            			<textarea name="appContent" style="width:95%; height:50" title="내용" >${appInfo.appContent}</textarea>
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
		              			</div>
		              			<div id="verInfo" style="display: none;">
		              			<table width="404" border="0" cellspacing="0" cellpadding="0">
			              			<tr>
				                		<td width="50%" valign="top" bgcolor="#FFFFFF">
	    	                  			<iframe width="99%" height="270px;" src="appVerInfoList.do?appInfoSeq=${appInfo.appInfoSeq}&isMapping=false" scrolling="no" frameborder="0"></iframe>
	        	              			</td>
		        	        		</tr>
		            	  		</table>
		              			</div>
                    			<!-------앱정보 끝------->
                    			</td>
                    			<!-------앱정보와연결된단말모델정보 시작------->
                  				<td width="50%" valign="top" bgcolor="#FFFFFF" style="padding-bottom:30">
                  				<table width="100%" border="0" cellspacing="0" cellpadding="0">
                        			<tr>
                          				<td>
                              			<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                			<tr>
	                                  			<td class="ttl7">[어플리케이션이 실행가능한 단말모델 정보]</td>
    	                              			<td class="btn">
        	                          			<td class="btn" id="phDel">
        	                          			<a href="javascript:executePhModelDel('P');" onFocus="blur()"><img src="images/btn/device2.gif" border="0"></a>
        	                          			</td>
                                  				<td class="btn" id="templetDel" style="display: none;">
                                  				<a href="javascript:executePhModelDel('T');" onFocus="blur()"><img src="images/btn/device2.gif" border="0"></a>
                                  				</td>
		    	                       		</tr>
                			            </table>
                        	    		<table width="100%" border="0" cellspacing="0" cellpadding="0">
                            	    		<tr>
		                        	          	<td width="3"><img src="images/ttl_bar1.gif"></td>
			                        	        <td width="8%" background="images/ttl_bar2.gif" class="ttl">
			                            	    <input type="checkbox" name="choiceAll" onclick="checkAll('ContentsForm','choiceAll', 'choice');"/>
			                                	</td>
			                                	<td width="1" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
			                                	<td width="46%" background="images/ttl_bar2.gif" class="ttl">단말 정보</td>
			                                	<td width="1" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
			                                	<td width="46%" background="images/ttl_bar2.gif" class="ttl">OS버전 정보</td>
			                                	<td width="3"><img src="images/ttl_bar3.gif"></td>
                                			</tr>
                              			</table>
										<div style="overflow:auto;height: 170px;">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" id="addPhModel">
											<col width="3"></col>
											<col width="8%" class="ttl4" style="padding:0 0 0 5"></col>
											<col width="1"></col>
											<col width="46%" class="ttl4"></col>
											<col width="1"></col>
											<col width="46%" class="ttl4"></col>
											<col width="3"></col>
											<c:forEach var="list" items="${appUseOsPh}" varStatus="stat">
											<tr>
												<td width="3"></td>
												<td width="8%" class="ttl4" style="padding:0 0 0 5">
												<input type="checkbox" name="choice" value="${stat.index+1}|${list.phModelInfoSeq}|${list.phName}|${list.osVerName}|${list.phContent}|${list.osVerContent}|${list.phId}|${list.osVerId}"/>
												<input type="hidden" name="checkboxPhModelInfos" value="${list.phModelInfoSeq}"/>
												<input type="hidden" name="phIds" value="${list.phId}"/>
												<input type="hidden" name="osVerIds" value="${list.osVerId}"/>
												<input type="hidden" name="posibleDelete" value="${posibleDelete}"/>
												</td>
												<td width="1"></td>
												<td width="46%" class="ttl4">
												<input type="text" class="invisiblebox" value="${list.phName} ${list.phContent}" readonly="readonly" style="width: 170"/>
												</td>
												<td width="1"></td>
												<td width="46%" class="ttl4">
												<input type="text" class="invisiblebox" value="${list.osVerName} ${list.osVerContent}" readonly="readonly" style="width: 170"/>
												</td>
												<td width="3"></td>
						  					</tr>
											</c:forEach>
										</table>
										</div>
										</td>
                        			</tr>
                      			</table>
                      			</td>
                   		 		<!-------앱정보와연결된단말모델정보 끝------->
							</tr>
	                		<tr>
	                			<!-------단말모델 시작------->
	                			<td colspan="2" valign="top" bgcolor="#FFFFFF">
	                    		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	                        		<tr>
	                          			<td width="350px" id="phModelTd">
										<form:select path="keywordTp" style="width:90px;">
							        		<form:option value="1" label="단말명"/>
										</form:select>
										<form:input type="text" size="25" path="phName" />
										<img src="images/btn/search5.gif" id="phModelBtn" style="vertical-align: bottom; width: 40px;">
										</td>
										<td width="350px" id="templetModelTd" style="display: none;">
										<form:select path="keywordTp" style="width:90px;">
							        		<form:option value="1" label="단말명"/>
										</form:select>
										<form:input type="text" size="25" path="phName2" />
										<img src="images/btn/search5.gif" id="templetModelBtn" style="vertical-align: bottom; width: 40px;">
										</td>
										<td width="350px" id="templetNameTd" style="display: none;">
										<form:select path="keywordTp" style="width:90px;">
							        		<form:option value="1" label="단말조합명"/>
										</form:select>
										<form:input type="text" size="25" path="templetModelName" />
										<img src="images/btn/search5.gif" id="templetNameBtn" style="vertical-align: bottom; width: 40px;">
										</td>
	                          			<td class="ttl7">
										<span style="cursor: hand;" id="phModelOpen">[단말모델 정보]</span>
                          				<span style="cursor: hand;" id="templetModelOpen">[단말조합 정보]</span>
										</td>
	                          			<td class="btn" id="phAdd">
	                          			<a href="javascript:executeAdd('P', 'phModelchoice');" onFocus="blur()"><img src="images/btn/add.gif" border="0"></a>
	                          			</td>
                          				<td class="btn" id="templetAdd" style="display: none;">
                          				<a href="javascript:executeAdd('T','templetModelchoice');" onFocus="blur()"><img src="images/btn/add.gif" border="0"></a>
                          				</td>
	                        		</tr>
	                      		</table>
	                      		<div id="phModelDiv">
	                      		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	                        		<tr>
		                          		<td width="3"><img src="images/ttl_bar1.gif"></td>
		                          		<td width="4%" background="images/ttl_bar2.gif" class="ttl">
		                          		<input type="checkbox" name="phModelchoiceAll" onclick="checkAll('ContentsForm','phModelchoiceAll', 'phModelchoice');"/>
		                          		</td>
		                          		<td width="1" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
		                          		<td width="20%" background="images/ttl_bar2.gif" class="ttl">단말 명</td>
		                          		<td width="1" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
		                          		<td width="28%" background="images/ttl_bar2.gif" class="ttl">단말 정보</td>
		                          		<td width="1" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
		                          		<td width="20%" background="images/ttl_bar2.gif" class="ttl">OS버전 명</td>
		                          		<td width="1" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
		                          		<td width="28%" background="images/ttl_bar2.gif" class="ttl">OS버전 정보</td>
		                          		<td width="3"><img src="images/ttl_bar3.gif"></td>
	                        		</tr>
	                      		</table>
								<c:choose>
								<c:when test="${empty allOsPhInfo}">
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
								<div style="overflow:auto;height: 250px" >
								<table width="100%" border="0" cellspacing="0" cellpadding="0" id="phModelList">
									<col width="3"></col>
									<col width="4%" class="ttl4" style="padding:0 0 0 5"></col>
									<col width="1"></col>
									<col width="20%" class="ttl4"></col>
									<col width="1"></col>
									<col width="28%" class="ttl4"></col>
									<col width="1"></col>
									<col width="20%" class="ttl4"></col>
									<col width="1"></col>
									<col class="ttl4"></col>
									<col width="3"></col>
									<tbody id="trsearchPhModel">
									<c:forEach var="list" items="${allOsPhInfo}" varStatus="stat">
									<tr>
										<td width="3"></td>
										<td width="4%" align="center" style="padding:0 0 0 3">
										<input type="checkbox" name="phModelchoice" value="${stat.index+1}|${list.phModelInfoSeq}|${list.phName}|${list.osVerName}|${list.phContent}|${list.osVerContent}|${list.phId}|${list.osVerId}"/>
										<input type="hidden" name="posibleDelete" value="Y"/>
										</td>
										<td width="1"></td>
										<td width="20%" class="ttl4"><input type="text" class="invisiblebox" value="${list.phName}" readonly="readonly" style="width: 150"/></td>
										<td width="1"></td>
										<td width="28%" class="ttl4"><input type="text" class="invisiblebox" value="${list.phContent}" readonly="readonly" style="width: 210"/></td>
										<td width="1"></td>
										<td width="20%" class="ttl4"><input type="text" class="invisiblebox" value="${list.osVerName}" readonly="readonly" style="width: 150"/></td>
										<td width="1"></td>
										<td class="ttl4"><input type="text" class="invisiblebox" value="${list.osVerContent}" readonly="readonly" style="width: 210"/></td>
										<td width="3"></td>
								  	</tr>
									</c:forEach>
									</tbody>
								</table>
								</div>
								</c:otherwise>
								</c:choose>
								</div>
								<div id="templetNameDiv" style="display: none;">
			                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
			                      <tr>
			                        <td width="3"><img src="images/ttl_bar1.gif"></td>
			                        <td width="10%" background="images/ttl_bar2.gif" class="ttl">번호</td>
			                        <td width="2" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
			                        <td width="25%" background="images/ttl_bar2.gif" class="ttl">단말조합명</td>
			                        <td width="2" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
			                        <td width="25%" background="images/ttl_bar2.gif" class="ttl">내용</td>
			                        <td width="2" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
			                        <td width="25%" background="images/ttl_bar2.gif" class="ttl">등록일</td>
			                        <td width="2" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
			                        <td width="15%" background="images/ttl_bar2.gif" class="ttl">사용여부</td>
			                        <td width="3"><img src="images/ttl_bar3.gif"></td>
			                      </tr>
			                    </table>
			                    <div style="overflow:auto; height: 250px;" >
			                    <c:choose>
			                    <c:when test="${empty templetModel}">
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
			                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
			 					  <tbody id="trsearchTempletName">
			 					  <c:forEach var="list" items="${templetModel}">
			                      <tr onmouseover="rowOnMouseOver(this);this.style.cursor='hand'" onMouseOut="rowOnMouseOut(this);" onclick="javascript:executeDetail('${list.templetModelId}');">
			                        <td width="3"></td>
			                        <td width="10%" class="ttl4">${list.rownum}</td>
			                        <td width="2"></td>
			                        <td width="25%" class="ttl4">${list.templetModelName}</td>
			                        <td width="2"></td>
			                        <td width="25%" class="ttl4">${list.templetModelContent}</td>
			                        <td width="2"></td>
			                        <td width="25%" class="ttl4">${list.templetModelSdate}</td>
			                        <td width="2"></td>
			                        <td width="15%" class="ttl4"><img src="images/state/ic_map1.gif"></td>
			                        <td width="3"></td>
			                      </tr>
			                      <tr>
			                        <td height="1" colspan="11" class="line"></td>
			                      </tr>
			                      </c:forEach>
			                      </tbody>
			                    </table>
			                    </c:otherwise>
			                    </c:choose>
			                    </div>
			                    </div>
			                      <div id="templetModelDiv" style="display: none;">
			                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
			                        <tr>
			                          <td width="3"><img src="images/ttl_bar1.gif"></td>
			                          <td width="4%" background="images/ttl_bar2.gif" class="ttl"><input type="checkbox" name="templetModelchoiceAll" onclick="checkAll('ContentsForm','templetModelchoiceAll', 'templetModelchoice');"/></td>
			                          <td width="1" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
			                          <td width="20%" background="images/ttl_bar2.gif" class="ttl">단말 명</td>
			                          <td width="1" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
			                          <td width="28%" background="images/ttl_bar2.gif" class="ttl">단말 정보</td>
			                          <td width="1" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
			                          <td width="20%" background="images/ttl_bar2.gif" class="ttl">OS버전 명</td>
			                          <td width="1" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
			                          <td width="28%" background="images/ttl_bar2.gif" class="ttl">OS버전 정보</td>
			                          <td width="3"><img src="images/ttl_bar3.gif"></td>
			                        </tr>
			                      </table> 
			                      <div style="overflow:auto; height: 250px;" >
			                      <table width="100%" border="0" cellspacing="0" cellpadding="0" id="templetModelList">
									<col width="3"></col>
									<col width="4%" class="ttl4" style="padding:0 0 0 3"></col>
									<col width="1"></col>
									<col width="20%" class="ttl4"></col>
									<col width="1"></col>
									<col width="28%" class="ttl4"></col>
									<col width="1"></col>
									<col width="20%" class="ttl4"></col>
									<col width="1"></col>
									<col class="ttl4"></col>
									<col width="3"></col>
									<tbody id="trsearchTempletModel">
									</tbody>
									</table>
								  </div>
			                      </div>
								</td>
								<!-------단말모델 끝------->
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
