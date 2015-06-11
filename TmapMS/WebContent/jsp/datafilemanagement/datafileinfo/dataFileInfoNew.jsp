<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<% 
 response.setHeader("Cache-Control","no-cache"); 
 response.setHeader("Pragma","no-cache"); 
 response.setDateHeader("Expires",0); 
%>
<title>Tmap Managerment Site</title>
<!--  Stylesheet		-------------------------------------------------------------------------->
<link rel="stylesheet" href="css/common.css" type="text/css" />
<link rel="stylesheet" href="css/layout_contents.css" type="text/css" />
<link type="text/css" rel="stylesheet" href="css/jquery.stepy.css" />
<link rel="stylesheet" href="css/base.css" type="text/css" />
<link rel="stylesheet" href="css/tmap.css" type="text/css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/formValidate.js"></script>
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="js/jquery.stepy.min.js"></script>
<script type="text/javascript">
  $(document).ready(function() {
    
    $("#stepContainer").stepy({
      back : function(index) {
        if(index == 2){
          reSetPage($("#DataFileListForm"));
					reSetPage($("#FileVersionForm"));
          if($("#fileVersionInfoList > option").size() < 1){
            $("#fileVerList_TR").hide();
          }else{
            $("#fileVerList_TR").show();
          }
        }
      },
      next : function(index) {
        changeStep(index);
        return false;
      },
      select : function(index) {
      },
      finish : function(index) {
        location.replace("dataFileInfoList.do");
      },
      titleClick : false,
      backLabel : '< 이전',
  	nextLabel:'다음 >'
      });
  
  	$("#btnFileStateUpdate")
		.click(function() {
					if ($("input:checkbox[name=fileListIds]:checked").size() < 1) {
						return;
					}
					var message, action;
					var selectFileAction = $("#selectFileAction").val();
					if (selectFileAction == "D") { // 삭제
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
					$.post(action,$("#DataFileListForm").serialize(),function(data) {
						alert(data.json.MESSAGE);
						 $.post("fileVersionInfo.do",{"fileVersionInfoList":$("#fileVerId").val()},
		              function(data) {
		                // 버전 정보 셋팅
		                reSetForm($("#FileVersionForm"));
		                setFileVersionInfo(data.json.fileVersionInfo);

		                // 파일 정보 셋팅
		                $("#dataFileListInfo tr").remove();
		                gridDataFileListInfoList(data.json.dataFileListInfoList);
		              });
					});
				});
      
    $("#btnDataFileRegister").click(function() {
      executeSave();
    });
 
    $("#fileVersionInfoList")
    .click(function() {
          // 파일 업로드 화면 출력
          $.post("fileVersionInfo.do", $("#fileVersionInfoList").serialize(),function(data) {
              // 버전 정보 셋팅
              reSetForm($("#FileVersionForm"));
              setFileVersionInfo(data.json.fileVersionInfo);

              // 파일 정보 셋팅
              $("#dataFileListInfo tr").remove();
              gridDataFileListInfoList(data.json.dataFileListInfoList);
            });
        });
  });
  
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

  function changeStep(index) {
    if (index == 2) {
      executeSave();
    }
    if (index == 3) {
      fileVersionSave();
    }
    if (index == 4) {
      $('#stepContainer').stepy('step', 4);
    }
  }
  
  
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
              var addTr = "<tr><td>";
              addTr += "<input type=\"checkbox\" id=\"fileListIds\" name=\"fileListIds\" value=\""+list.fileListId+"\"/>";
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

  function specialCharCheck(input) //특수문자체크
  {
      var chars = '~!@#$%^&*()+=|{}[]<>,./?';
      return containsChars(input,chars);
  }
  
  
  function containsChars(input,chars)
  {
      for (var inx = 0; inx < input.length; inx++) 
      {
          if (chars.indexOf(input.charAt(inx)) != -1)
          {
         	 return true;
          }
      }
      return false;
  }
  
  function fileVersionSave() {
	  
    if (!formValidate(document.FileVersionForm)) {
      return;
    }
    
       
    if (!$("input[name=fileVerState]:checked").val()) {
      alert("File Version 사용여부를 선택해 주세요.");
      return;
    }

    var action;
    var insert;
    
    if ($("#fileVerId").val() == "") {
      action = "fileVersionInfoInsert.do";
      insert = true;
    } else {
      action = "fileVersionInfoUpdate.do";
      insert = false;
    }
    
    if(specialCharCheck($("#fileVerName").val()))
    {
    		alert("버전명에 특수문자는 사용할 수 없습니다.")
    }
    
    
    $.post(action,$("#FileVersionForm").serialize(),function(data) {
          alert(data.json.MESSAGE);
          
          if(insert){ 
              if (data.json.fileVerId && data.json.fileVerId != '') {
                $("#fileVersionInfoList").append(
                        "<option value=\""+data.json.fileVerId+"\">"
                            + $("#fileVerName").val() + "</option>");
              } 
                $.post("fileVersionInfo.do",{"fileVersionInfoList":data.json.fileVerId},
                    function(data) {
                      // 버전 정보 셋팅
                      reSetForm($("#FileVersionForm"));
                      setFileVersionInfo(data.json.fileVersionInfo);
      
                      // 파일 정보 셋팅
                      $("#dataFileListInfo tr").remove();
                      gridDataFileListInfoList(data.json.dataFileListInfoList);
                    });
         
    //파일업로드화면 표시
        			 $("#dataFileListIFrame").attr("src", "dataFileListInfoList.do?dataFileId="+ $("#dataFileId").val()+"&fileVerId=" + data.json.fileVerId + "&fileVerName=" + data.json.fileVerName + "&dataFileName=" + $("#ContentsForm > table > tbody > tr:first > td > input").val());
    		}			
    else{
      $("#dataFileListIFrame").attr("src", "dataFileListInfoList.do?dataFileId="+ $("#dataFileId").val()+"&fileVerId=" + $("#fileVerId").val() + "&fileVerName=" + $("#fileVerName") + "&dataFileName=" + $("#ContentsForm > table > tbody > tr:first > td > input").val());
      }
          $('#stepContainer').stepy('step', 3);      
    });
  }
  
//버전 정보 셋팅
	function setFileVersionInfo(fileVersionInfo) {
		$("input[name=fileVerId]").val(fileVersionInfo.fileVerId);
		$("input[name=dataFileId]").val(fileVersionInfo.dataFileId);
		$("input[name=fileVerName]").val(fileVersionInfo.fileVerName);
		$("#fileVerSdate").val(fileVersionInfo.fileVerSdate);
		$("input[name=fileVerState]").filter(
				"input[value=" + fileVersionInfo.fileVerState + "]").attr(
				"checked", "checked");
		$("#etc").val(fileVersionInfo.etc);
	}
 
  function executeSave() {
    if (!formValidate(document.ContentsForm)) {
      return;
    }
    if (!$("input[name=dataFileState]:checked").val()) {
      alert("Data File 사용여부를 선택해 주세요.");
      return;
    } 
    if(specialCharCheck($("#dataFileName").val()))
    {
    	alert("파일명에는 특수문자를 사용할 수 없습니다.");
    	return;	
    }
    
    //insert , update 구분
    var action;
    if ($("#dataFileId").val() == "") {
      action = "dataFileInfoInsert.do";
    } else {
      action = "dataFileInfoUpdate.do";
    }
    $.post(action, $("#ContentsForm").serialize(), function(data) {
      alert(data.json.MESSAGE);

      if (action == "dataFileInfoInsert.do") {
        $("#dataFileId").val(data.json.dataFileId);
      }
      if($("#fileVersionInfoList > option").size() < 1){
        $("#fileVerList_TR").hide();
      }
      $('#stepContainer').stepy('step', 2);
    });
  }
</script>
</head>
<body>
	<jsp:include page="../../common/menu.jsp" />
	<div id="bodyDiv">
		<div class="contentsDiv">
			<div class="contentDiv">
				<table>
					<tr>
						<td width="680px"><img src="images/h3_ico.gif"><span>데이터
								파일정보 등록</span></td>
						<td><a href="dataFileInfoList.do"
							onFocus="blur()"> <img src="images/btn/btn_list.gif"
								border="0">
						</a></td>
					</tr>
				</table>
				<br>
				<div id="stepContainer">
					<fieldset title="Step 1">
						<legend style="display: none;">Data File 정보입력</legend>
						<form:form commandName="ContentsForm" name="ContentsForm">

							<table class="srvRegi">
								<colgroup>
									<col width="100px" />
									<col width="*" />
								</colgroup>
								<tr>
									<th>파일명</th>
									<td><input type="text" id="dataFileName"
										name="dataFileName" style="width: 610px" class="regiInput"
										maxlength="150" /></td>
								</tr>
								<tr>
									<th>사용여부</th>
									<td><input type="radio" name="dataFileState" value="Y"
										checked="checked"> <label for="dataFileState"
										class="MR20">사용</label> <input type="radio"
										name="dataFileState" value="N"> <label
										for="dataFileState" class="MR20">미사용</label></td>
								</tr>
								<tr>
									<th>데이터 타입</th>
									<td><form:select path="dataTypeId" id="dataTypeValue"
											items="${ContentsForm.dataTypeInfoList}"
											itemValue="dataTypeId" itemLabel="dataTypeName"
											multiple="false" cssClass="select validate-req"
											cssStyle="width: 70px;" /></td>
								</tr>
								<tr>
									<th>저장경로</th>
									<td><form:select path="storageId" id="savaPath"
											items="${ContentsForm.dataStorageInfoList}"
											itemValue="storageId" itemLabel="storageName"
											multiple="false" cssClass="select validate-req"
											cssStyle="width: 100px;" /></td>
								</tr>
								<tr>
									<th>내용</th>
									<td><textarea name="dataFileContent"
											style="width: 610px; height: 50; resize: none;" title="내용"
											class="textBox"></textarea></td>
								</tr>
							</table>
						</form:form>
					</fieldset>
					<fieldset title="Step 2">
						<legend style="display: none">Version 정보 입력</legend>
						<form:form commandName="FileVersionForm" name="FileVersionForm">
							<form:hidden path="dataFileId" />
							<form:hidden path="fileVerId" />
							<table class="srvRegi">
								<colgroup>
									<col width="100px" />
									<col width="*" />
								</colgroup>
								<tr>
									<th>버전명</th>
									<td><input type="text" id="fileVerName" name="fileVerName"
										class="textBox validate-req" style="width: 610px" title="버전명" /></td>
								</tr>
								<tr>
									<th>사용여부</th>
									<td><input type="radio" id="fileVerState"
										name="fileVerState" value="Y" title="사용여부" checked="checked"/> 사용 &nbsp;&nbsp; 
										<input type="radio" id="fileVerState" name="fileVerState" value="N" title="사용여부" /> 미사용</td>
								</tr>
								<tr>
									<th>비고</th>
									<td><textarea id="etc" name="etc" title="비고"
											class="textBox"
											style="width: 610px; height: 50; resize: none;"></textarea></td>
								</tr>
								<tr id="fileVerList_TR">
									<th>등록된 버전</th>
									<td><form:select id="fileVersionInfoList"
											name="fileVersionInfoList" path=""
											items="${fileVersionInfoList}" itemValue="fileVerId"
											itemLabel="fileVerName" multiple="false" cssClass="select"
											style="width:500px" size="3" /></td>
								</tr>
							</table>

						</form:form>
					</fieldset>
					<fieldset title="Step 3">
						<legend>데이터 업로드</legend>
						<form:form commandName="DataFileListForm" name="DataFileListForm">

							<form:hidden path="dataFileId" />
							<form:hidden path="fileVerId" />
							<input type="hidden" id="fileVerName" name="fileVerName" />
							<input type="hidden" id="fileUpdate" name="fileUpdate" />
							<div></div>
							<div>
								<iframe id="dataFileListIFrame" name="dataFileListIFrame"
									width="640px" height="310px" style="margin-left: 115px;"
									src="dataFileListInfoList.do?dataFileId=&fileVerId=&fileVerName=&dataFileName="
									frameborder="0" scrolling="yes"></iframe>
							</div>
							<div>
								<fieldset style="text-align: right">
									<select id="selectFileAction" style="margin-bottom: 5px">
										<option value="" selected="selected">선택</option>
										<option value="D">삭제</option>
										<option value="Y">필수 파일 등록</option>
										<option value="N">필수 파일 해제</option>
									</select> <a href="#" onFocus="blur()" id="btnFileStateUpdate"><img
										src="images/btn/apply5.gif" border="0"
										style="margin-right: 15px; margin-bottom: -5px; width: 35px;" /></a>
								</fieldset>
								<table class="sub_0601_table">
									<colgroup>
										<col width="10%">
										<col width="">
										<col width="">
										<col width="">
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
							</div>
						</form:form>
					</fieldset>
					<!-- <fieldset title="Step 3">
						<legend>등록확인</legend>
					</fieldset> -->
					<input type="button" class="finish" value="완료" />
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../../common/footer.jsp" />

</body>
</html>