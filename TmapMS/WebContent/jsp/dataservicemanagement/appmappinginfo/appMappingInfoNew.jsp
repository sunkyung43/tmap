<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="java.util.Date"%>
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
<link type="text/css" rel="stylesheet" href="css/jquery.stepy.css" />
<style type="text/css">
</style>
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/formValidate.js"></script>
<script type="text/javascript" src="js/jquery.stepy.min.js"></script>
<script type="text/javascript">
	//이벤트 등록
	var checkValueName = '';
	$(document).ready(function() {
		$("#stepContainer").stepy({
			back : function(index) {
			 if(index == 2){
			   return false;
			 }
			},
			next : function(index) {
				excute(index);
				return false;
			},
			select : function(index) {
			},
			finish : function(index) {
			  appMappingDetailSave();
			},
			titleClick : false,
			backLabel : '< 이전',
		nextLabel:'다음 >'
		});
		
		$("#appMappingName").blur(function(){
  		  checkValueName = 'F';
		  if($("#appMappingName").val() == ''){
  		  alert("매핑 데이터명을 입력해주세요!");
  		  return;
		  }
		  //동적 체크
		  $.get("appMappingInNameCheck.do", $("#ContentsForm").serialize(),
		      function(data){
		        if(data.json.SUCCESS == 'FAILED')
		        {
		          checkValueName = 'F';
		          alert("이미 사용중인 이름입니다.");
		        }else{
		          checkValueName = 'T';
		        }
		  });
	  });
	});
	function excute(index) {
		if (index == 2) {
			mappingInfoSave();
		}
		if (index == 3) {
			appMappingServiceInsert();
		}
		if (index == 4) {
			$('#stepContainer').stepy('step', 4);
		}
		if (index == 5) {
			appMappingDetailSave();
		}
	}

	//매핑정보 입력
	function mappingInfoSave() {

		if($("#appInfoSeq").val() == "" || $("#appInfoSeq").val() == "")
		  {
			alert("등록할 App을 선택해 주세요.");
		  	return;		  
		  }
		if(checkValueName == 'F'){
		  alert("매핑데이터명 확인요망");
		  return;
		}
	  
		$.post("appMappingInfoInsert.do", $("#ContentsForm").serialize(),
				function(data) {
					if (data.json.SUCCESS == "SUCCESS") {
						$("#appMappingId").val(data.json.appMappingId);
						//AppVerList 획득
						getAppVerList();
					} else {
						alert("등록실패");
					}
				});
	}

	function getAppVerList() {
		$.post("appVerInfoList.do?isMapping=true", $("#ContentsForm")
				.serialize(), function(data) {
			$("#appVerListDiv").html(data);
			$('#stepContainer').stepy('step', 2);
		});
	}
	//AppVerId 획득
	function getAppVerId(appVerId, appVerName) {
		//클릭한 버전의 ID 획득
		$("#appVerId").val(appVerId);
		$("#appVerName").val(appVerName);
	}

	//AppMappingServiceInfo 등록
	function appMappingServiceInsert() {
		$.post("appMappingServiceInfoInsert.do",
				$("#ContentsForm").serialize(), function(data) {
					if (data.json.SUCCESS == "SUCCESS") {
						$("#appServiceId").val(data.json.appServiceId);
						$('#stepContainer').stepy('step', 3);
					} else {
						alert("등록실패");
					}
				});
	}

	function dataFileInfoSave() {

		if (!validate()) {
			return;
		}

		$("#returnList").click(function() {
			$("#mappingListDiv").slidDown("slow");
			$("#mappingDiv").hide();
			$("#mappingInfo").hide();
			$("#detail").hide();
			$("#fileBasicTbody").show();
			$("#verBasicTbody").show();
			$("#verTbody").hide();

		});
		if (confirm("등록하시겠습니까?")) {
			//호출 및 메시지 출력
			$.post("appMappingInsert.do", $("#ContentsForm").serialize(),
					function(data) {
						$("#appMappingId").val(data.json.appMappingId);
						alert("등록완료.");
						/* 								 $("#ContentsForm").attr('action',
						 'appMappingInfoNew.do'); 
						 $("#ContentsForm").submit(); */
						// 								getAppVerList();
						executeSaveDatail();

					});
		}
	}

	function appMappingDetailSave() {
		if (confirm("데이터 정보를 등록하시겠습니까?")) {
			$.post("appMappingDetailInfoInsert.do", $("#ContentsForm")
					.serialize(), function(data) {
				$("#datainfo_pop_wrap").hide();
				alert("등록완료");
// 				$("#resultDiv").html(data);
				location.replace("appMappingInfoList.do");
				
			});
		}
	}

	function executeSaveDatail(appMappingId) {

		$("#appMappingId").val(appMappingId);

		if (confirm("데이터 정보를 등록하시겠습니까?")) {

			$.post("appMappingUpdate.do", $("#ContentsForm").serialize(),
					function(data) {
						alert("등록되었습니다.");
						$("#ContentsForm").attr('action','appMappingInfoEdit.do');
						$("#ContentsForm").submit();
					});
		}
	}

	function typeDetail(dataTypeId, dataTypeName) {
		$("#dataTypeId").val(dataTypeId);
		$("#tName").val(dataTypeName);
		$("#fName").val("");
		$("#fContent").val("");
		$("#fStore").val("");
		$("#fSdate").val("");
		fileInType();
	}

	function fileInType() {
		//호출 및 메시지 출력
		$.post("mappingFileInType.do", $("#ContentsForm").serialize(),
				function(data) {
					$("#fileInTypeDiv").html(data);

				});
	}

	function checkAll() {
		if ($("#chkCtrl").is(":checked")) {
			$('input[name=dataFileIds]').attr('checked', true);
		} else {
			$('input[name=dataFileIds]').attr('checked', false);
		}
		$('input[name=dataFileIds]').click(function() {
			$('input[name=chkCtrl]').attr('checked', false);
		});
	}

	function fileDetail(dataFileId) {
		$("#dataFileId").val(dataFileId);
		verInFile();
	}

	function verInFile() {
		//호출 및 메시지 출력
		$.post("mappingVerInFile.do", $("#ContentsForm").serialize(), function(
				data) {
			$.post("mappingFileDetail.do", $("#ContentsForm").serialize(),
					function(r) {
						$.each(r.json.fileDetail, function(idx, list) {
							$("#fName").val(list.dataFileName);
							$("#fContent").val(list.dataFileContent);
							$("#fStore").val(list.dataFileStore);
							$("#fSdate").val(list.dataFileSdate);
						});
					});
			$("#verInFileTbody").html(data);
		});

	}

	function executeDetail(fileVerId, fileVerName) {
		$("#fileVerId").val(fileVerId);
		document.getElementById('pop_wrap').style.display = 'none';
		/* document.getElementById('verpop_wrap').style.display = 'none'; */
		document.getElementById('datainfo_pop_wrap').style.display = 'none';

		//호출 및 메시지 출력
		$.post("verDetail.do",
						$("#ContentsForm").serialize(),
						function(data) {
							var verDetail = "";
							if (data.json.verDetail != "") {
								$
										.each(
												data.json.verDetail,
												function(idx, list) {
													verDetail += "<tr>";
													verDetail += "<td width=\"25%\">"
															+ list.file_name
															+ "</td>";
													verDetail += "<td width=\"15%\">"
															+ list.file_size
															+ "</td>";
													verDetail += "<td width=\"25%\">"
															+ list.file_sdate
															+ "</td>";
													verDetail += "<td width=\"17%\">"
															+ list.file_state
															+ "</td>";
													verDetail += "<td width=\"18%\">"
															+ list.file_update
															+ "</td>";
													verDetail += "</tr>";
													verDetail += "<tr>";
													verDetail += "</tr>";
												});
							} else {
								verDetail += "<tr>";
								verDetail += "<td height=\"50\" align=\"center\" colspan=\"12\">등록된 데이터 파일이 없습니다.</td>";
								verDetail += "</tr>";
								verDetail += "<tr>";
								verDetail += "</tr>";
							}
							$("#popupTbody").html(verDetail);
							$("#verName").html("Ver Name : " + fileVerName);
							document.getElementById('pop_wrap').style.display = '';
							/* document.getElementById('verpop_wrap').style.display = ''; */
						});
	}
</script>
</head>
<body>

	<form:form commandName="ContentsForm" id="ContentsForm" name="ContentsForm" onsubmit="return false;">
		<form:hidden path="appInfoSeq" />
		<form:hidden path="dataTypeId" />
		<form:hidden path="appMappingId" />
		<form:hidden path="dataFileId" />
		<form:hidden path="fileVerId" />
		<form:hidden path="appVerId" />
		<form:hidden path="appServiceId" />
		<form:hidden path="appVerName" />

		<!-- 레이어 팝업 -->
		<div id="pop_wrap" style="display: none;">
			<div id="pop_container" style="width: 400px; top: 190; left: 490; position: absolute; overflow: auto; height: 250px;">
				<!-- <iframe src="about:blank" scrolling="no" frameborder="0"
					title="팝업 아이프레임 영역"></iframe> -->
				<!-- <div class="pop_contents" style="overflow: auto; height: 250px;"> -->
					<table>
						<tr>
							<td id="verName" style="font-weight: bold; font-size: 12; width:120px"
								colspan="9"></td>
							<td><a
								onclick="document.getElementById('pop_wrap').style.display='none'; document.body.className='';">
									<input type="button" value="닫기" style="margin-left: 230px;"/>
							</a></td>
						</tr>
					</table>
					<table class="sub_0601_table" style="width: 380px;">
						<colgroup>
							<col width="18%" />
							<col width="15%" />
							<col width="20%" />
							<col width="18%" />
							<col width="25%" />
						</colgroup>
						<thead>
							<tr>
								<th>파일명</th>
								<th>크기</th>
								<th>등록일</th>
								<th>사용여부</th>
								<th>업데이트</th>
							</tr>
						</thead>
						<tbody id="popupTbody">
						</tbody>
					</table>
				</div>
			</div>

		<!--//  데이터 정보 레이어 팝업 -->

		<jsp:include page="../../common/menu.jsp" />
		<div id="mask"></div>
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<!-- Step 컨테이너 시작 -->
					<div id="stepContainer" style="width: 800px;">
						<fieldset title="Step 1">
							<legend style="display: none;">App 선택 및 매핑정보 입력</legend>
							<div id="mappingDiv" style="display: none;">
								<table class="srvRegi">
									<colgroup>
										<col width="100px" />
										<col width="*" />
									</colgroup>
									<tbody>
										<tr>
											<th>APP 명</th>
											<td><input type="text" id="appName" name="appName"
												title="App 명" readonly="readonly" class="regiInput" /></td>
										</tr>
										<tr>
											<th>매핑 데이터 명</th>
											<td><input type="text" id="appMappingName" name="appMappingName"
												title="매핑 데이터 명" class="regiInput" style="width: 200px;" /></td>
										</tr>
										<tr>
											<th>사용여부</th>
											<td><input type="radio" style="cursor: hand;"
												name="appMappingState" value="Y" checked="checked" /> 사용
												&nbsp;&nbsp; <input type="radio" style="cursor: hand;"
												name="appMappingState" value="N" /> 미사용</td>
										</tr>
										<tr>
											<th>내용</th>
											<td><input type="text" style="width: 200px;"
												name="appMappingContent" title="내용" class="regiInput" /></td>
										</tr>

									</tbody>
								</table>
							</div>

							<div id="mappingListDiv">
								<iframe style="width:100%; height:250px; border: 0; "
									id="appMappingList" src="appMappingList.do"
									></iframe>
							</div>
						</fieldset>

						<fieldset title="Step 2">
							<legend style="display: none;">App Version 선택</legend>
							<div id="appVerListDiv"></div>
						</fieldset>
						<fieldset title="Step 3">
							<legend style="display: none;">데이터 타입선택</legend>
							<table class="sub_0601_table">
								<colgroup>
									<col width="10%">
									<col width="40%">
									<col width="*">
								</colgroup>
								<thead>
									<tr>
										<th></th>
										<th>데이터 타입명</th>
										<th>내용</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="list" items="${dataTypeInfo}">
										<tr
											onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
											onMouseOut="rowOnMouseOut(this);">
											<td><input type="radio" name="sort"
												onclick="typeDetail('${list.dataTypeId}', '${list.dataTypeName}');" /></td>
											<td>${list.dataTypeName}</td>
											<td>${list.dataTypeContent}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>

						</fieldset>

						<fieldset title="Step 4">
							<legend style="display: none">데이터파일 선택</legend>
							<img src="images/h3_ico.gif"><span>데이터 파일</span>
							<br>
							<div>
								<table class="srvRegi" style="width: 800px;">
									<colgroup>
										<col width="">
										<col width="">
										<col width="">
										<col width="">
									</colgroup>
									<tbody>
										<tr>
											<th class="first">타입명</th>
											<td class="first"><input type="text" id="tName" readonly="readonly"
												style="width: 120px;"/></td>
											<th class="first">파일명</th>
											<td class="first"><input type="text" id="fName" readonly="readonly"
												style="width: 120"></td>
										</tr>
										<tr>
											<th>내용</th>
											<td><input type="text" class="invisiblebox\"
												id="fContent" readonly="readonly" style="width: 120"></td>
										</tr>
										<tr>
											<th>파일등록</th>
											<td><input type="text" class="invisiblebox" id="fStore"
												readonly="readonly" style="width: 120"></td>
											<th>등록일</th>
											<td><input type="text" class="invisiblebox" id="fSdate"
												readonly="readonly" style="width: 120"></td>
										</tr>
									</tbody>

								</table>
							</div>
							<div id="fileInTypeDiv"></div>
							
							<img src="images/h3_ico.gif"><span>데이터 버전</span>
							<div>
								<table class="sub_0601_table">
									<colgroup>
										<col width="8%">
										<col width="*">
										<col width="15%">
										<col width="15%">
									</colgroup>
									<thead>
										<tr>
											<th><input type="checkbox" name="chkCtrl" id="chkCtrl"
												onclick="javascript:checkAll();" /></th>
											<th>버전명</th>
											<th>버전순위</th>
											<th>등록일</th>
										</tr>
									</thead>
									<tbody id="verInFileTbody">

									</tbody>
								</table>
							</div>
						</fieldset>
<!-- 						<fieldset title="Step 5"> -->
<!-- 							<legend style="display: none">등록확인</legend> -->
<!-- 							<div id="resultDiv"></div> -->
<!-- 							<a href="appMappingInfoList.do" onFocus="blur()"> <img -->
<!-- 								src="images/btn/btn_list.gif" border="0" /></a> -->
<!-- 						</fieldset> -->


						<input type="submit" class="finish" value="완료" />
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />

	</form:form>
</body>
</html>