<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form"%>
<%
   response.setHeader    ("Pragma",        "No-cache" );       // HTTP1.0
   response.setDateHeader("Expires",                 0);
   response.setHeader    ("Cache-Control", "no-cache" );       // HTTP1.1
  %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tmap Managerment Site</title>
<!--  Stylesheet		-------------------------------------------------------------------------->
<link rel="stylesheet" href="css/common.css" 			type="text/css" />
<link rel="stylesheet" href="css/layout_contents.css" 	type="text/css" />
<link rel="stylesheet" href="css/jquery.stepy.css" 		type="text/css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/formValidate.js"></script>
<script type="text/javascript" src="js/appInfojs/appInfojs.js"></script>
<script type="text/javascript" src="js/jquery.stepy.min.js"></script>
<script type="text/javascript">
 
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
    
    function validateSteps(stepnumber){
      var isStepValid = true;
      var isUpdate = false;        
      if(stepnumber == 1){
          if(validateStep1() == false){
          isStepValid = false;
        }else{
          isStepValid = true;
        }
      }
      return isStepValid;      
    }
    
    function validateStep1(){
      var isValid = true;
      
      var an = $('#appName').val();
      if(!an && an.length <= 0){
        isValid = false;
        alert(" 입력사항입니다.");
      }
      var an = $('#appDownURL').val();
      if(!an && an.length <= 0){
        isValid = false;
        alert("제조사이름은 필수 입력사항입니다.");
      }
      var am = $('#appMade').val();
      if(!am && am.length <= 0){
        isValid = false;
        alert("제조사이름은 필수 입력사항입니다.");
      }
      
      return isValid;
      
    }
    
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
      $("#phModelSearch").show();
      $("#templetSearch").hide();
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
      $("#phModelSearch").hide();
      $("#templetSearch").show();
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

    if (!validate()) {
      return;
    }

    if (confirm("등록하시겠습니까?")) {
      ContentsForm.action = "appInfoInsert.do";
      ContentsForm.submit();
    }
  }
  
  function executePhModelDel(state) {
    if (isChecked('ContentsForm', 'choice')) {
      var resultTable = document.getElementById("addPhModel");
      var phModelTable = '';
      var modelchoice = '';
      var obj = document.getElementsByName("choice");
      
      if(state == 'P'){
        modelchoice = 'phModelchoice';
        phModelTable = document.getElementById("phModelList");
      }
      if(state == 'T'){
        modelchoice = 'templetchoice';
        phModelTable = document.getElementById("templetModelList");
      }
      
      for (var i = 0; i < obj.length; i++) {
        if (obj[i].checked) {
          var tr = phModelTable.insertRow(-1);
          var td0 = tr.insertCell();
          var td1 = tr.insertCell();
          var td2 = tr.insertCell();

          var selectedValue = (obj[i].value).split('|');
          td0.innerHTML = "<input type=\"checkbox\" name=\""+modelchoice+"\" value=\""+obj[i].value+"\"/>";
          td0.innerHTML = "<input type=\"text\" class=\"invisiblebox\" value="+selectedValue[2]+" readonly=\"readonly\" style=\"width: 150\"/>";
          if(selectedValue[4] != ""){
          td1.innerHTML = "<input type=\"text\" class=\"invisiblebox\" value="+selectedValue[4]+" readonly=\"readonly\" style=\"width: 210\"/>";
          }else{
          td1.innerHTML = "<input type=\"text\" class=\"invisiblebox\" value=\"\" readonly=\"readonly\" style=\"width: 210\"/>";  
          }
          td2.innerHTML = "<input type=\"text\" class=\"invisiblebox\" value="+selectedValue[3]+" readonly=\"readonly\" style=\"width: 150\"/>";
          if(selectedValue[5] != ""){
          td2.innerHTML = "<input type=\"text\" class=\"invisiblebox\" value="+selectedValue[5]+" readonly=\"readonly\" style=\"width: 210\"/>";
          }else{
          td2.innerHTML = "<input type=\"text\" class=\"invisiblebox\" value=\"\" readonly=\"readonly\" style=\"width: 210\"/>";  
          }
          
        }
      } //end add for
      for (var i = obj.length-1; i > -1; i--) {
        if (obj[i].checked) {
          resultTable.deleteRow(i);
        }
      }
      
    }
    
    if (document.ContentsForm.choiceAll.checked) {
      document.ContentsForm.choiceAll.checked = !document.ContentsForm.choiceAll.checked;
    }
  }
  
  function executeAdd(state, choice) {
    if (isChecked('ContentsForm', choice)) {
      //var resultTable = document.getElementById("addPhModel"); id="addPhModel"
      var phModelTable = '';
      var trHtml = '';
      var obj = '';
      
      if(state == 'P'){
        obj = document.getElementsByName("phModelchoice");
        phModelTable = document.getElementById("phModelList");
      }
      if(state == 'T'){
        obj = document.getElementsByName("templetchoice");
        phModelTable = document.getElementById("templetModelList");
      }
      
      var cnt = $("input[name=phIds]").size();
      
      for (var i = 0; i < obj.length; i++) {
        if (obj[i].checked) {
          var selectedValue = (obj[i].value).split('|');
          trHtml = "<tr><td class='td03'><input type='hidden' name='checkboxPhModelInfos' value='"+selectedValue[1]+"'/>"
          + "<input type='hidden' name='phIds' value='"+selectedValue[6]+"'/>"
          + "<input type='hidden' name='osVerIds' value='"+selectedValue[7]+"'/>"
          + "<input type='checkbox' name='choice' value='"+obj[i].value+"'/></td>";
          trHtml += "<td class='td03'>"+selectedValue[2]+" "+selectedValue[4]+"</td>";
          trHtml += "<td class='td03'>"+selectedValue[3]+" "+selectedValue[5]+"</td></tr>";
          
          if(cnt < 1){
            $("#addPhModel:last").append(trHtml);
          }else{
            for(var j=0; j < cnt; j++){
              if(selectedValue[6] != $("input[name=phIds]")[j].value){
                $("#addPhModel:last").append(trHtml);
              }
            }
          }
          }
        }//end add for
       
      //end delete for
      for (var i = obj.length-1; i > -1; i--) {
        if (obj[i].checked) {
          phModelTable.deleteRow(i+1);
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
  
  //단말모델 리스트조회
  function phSearchPage() {
    
    //호출 및 메시지 출력
      $.post("searchPhModel.do", $("#ContentsForm").serialize(), function(data) {
          
          var searchPhModel = "";
          
          $.each(data.json.searchPhModel, function(idx, list) {
            searchPhModel += "<tr>";
            searchPhModel += "<td>";
            searchPhModel += "<input type=\"checkbox\" name=\"phModelchoice\" value=\""+list.rownum+"|"+list.phModelInfoSeq+"|"+list.phName+"|"+list.osVerName+"|"+list.phContent+"|"+list.osVerContent+"|"+list.phId+"|"+list.osVerId+"\"/>";
            searchPhModel += "</td>";
            searchPhModel += "<td><input type=\"text\" class=\"invisiblebox\" value=\""+list.phName+"\" readonly=\"readonly\" /></td>";
            searchPhModel += "<td >";
            if(list.phContent != null){
            searchPhModel += "<input type=\"text\" class=\"invisiblebox\" value=\""+list.phContent+"\" readonly=\"readonly\" />";
            }else{
            searchPhModel += "<input type=\"text\" class=\"invisiblebox\" value=\"\" readonly=\"readonly\" />"; 
            }
            searchPhModel += "</td>";
            searchPhModel += "<td><input type=\"text\" class=\"invisiblebox\" value=\""+list.osVerName+"\" readonly=\"readonly\"/></td>";
            searchPhModel += "<td>";
            if(list.osVerContent != null){
            searchPhModel += "<input type=\"text\" class=\"invisiblebox\" value=\""+list.osVerContent+"\" readonly=\"readonly\"/>";
            }else{
            searchPhModel += "<input type=\"text\" class=\"invisiblebox\" value=\"\" readonly=\"readonly\" />"; 
            }
            searchPhModel += "</td>";
            searchPhModel += "</tr>";
          });
          
          $("#trsearchPhModel").html(searchPhModel);
    });
  }
  
  
  
  
</script>
</head>
<body>
	<form:form commandName="ContentsForm" id="ContentsForm"
		name="ContentsForm">
		<form:hidden path="templetModelId" />
		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div id="stepContainer">
					<fieldset title="Step 1">
						<legend style="display: none;">APP 정보 입력</legend>
						<table class="srvRegi">
							<colgroup>
								<col width="100px" />
								<col width="*" />
							</colgroup>
							<tbody>
								<tr>
									<th>이름</th>
									<td><input type="text" style="width: 580px" id="appName"
										name="appName" title="어플리케이션 이름" class="regiInput" /><label
										style="color: red;">*</Label></td>
								</tr>
								<tr>
									<th>사용여부</th>
									<td><input type="radio" name="appState" value="Y"
										checked="checked" /> <label for="appState" class="MR20">사용</label>
										<input type="radio" name="appState" value="N" /><label
										for="appState" class="MR20">미사용</label></td>
								</tr>
								<tr>
									<th>Download URL</th>
									<td><input type="text" id="appDownURL" name="appDownURL"
										style="width: 580px" title="Down URL" maxlength="200"
										class="regiInput" /><label style="color: red;">*</Label></td>
								</tr>
								<tr>
									<th>개발사</th>
									<td><input type="text" id="appMade" name="appMade"
										class="textbox" style="width: 580px" maxlength="100"
										class="regiInput" />&nbsp;<label style="color: red;">*</Label></td>
								</tr>
								<tr>
									<th>내용</th>
									<td><input type="text" name="appContent" class="textbox"
										style="width: 580px;" title="내용" />&nbsp;<label
										style="color: red;">*</Label></td>
								</tr>
							</tbody>
						</table>
					</fieldset>
					<fieldset title="Step 2">
						<legend style="display: none;">APP 버전 등록</legend>
						<table class="srvRegi">
							<colgroup>
								<col width="100px" />
								<col width="*" />
							</colgroup>
							<tbody>
								<tr>
									<th>버전명</th>
									<td><input type="text" id="appVerName" name="appVerName"
										title="어플리케이션 이름"  style="width: 580px;" class="regiInput" />&nbsp;<label
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
											class="textbox" style="width: 580px;" title="내용" />&nbsp;<label
										style="color: red;">*</Label></td>
								</tr>
							</tbody>
						</table>
					</fieldset>
					<fieldset title="Step 3">
						<legend style="display: none">단말모델 추가</legend>
						<div>
							<span style="cursor: hand; font-size: 11pt" id="phModelOpen">[단말모델
								정보]</span> <span style="cursor: hand; font-size: 11pt"
								id="templetModelOpen">[단말조합 정보]</span> <span id="phAdd"><a
								href="javascript:executeAdd('P', 'phModelchoice');"
								onFocus="blur()"><img src="images/btn/add.gif"
									style="vertical-align: bottom; margin-top: 10; width: 70x;"></a></span>
							<span id="templetAdd" style="display: none"><a
								href="javascript:executeAdd('T','templetchoice');"
								onFocus="blur()"><img src="images/btn/add.gif"
									style="vertical-align: bottom; margin-top: 10; width: 70x;"></a></span>
						</div>
						<div id="phModelDiv">
							<table class="sub_0601_table" id="phModelList">
								<colgroup>
									<col width="12%" />
									<col width="22%" />
									<col width="22%" />
									<col width="22%" />
									<col width="22%" />
								</colgroup>
								<thead>
									<tr>
										<th><input type="checkbox" id="phModelchoiceAll"
											name="phModelchoiceAll"
											onclick="checkAll('ContentsForm','phModelchoiceAll', 'phModelchoice');" /></th>
										<th>단말명</th>
										<th>단말 정보</th>
										<th>OS버전 명</th>
										<th>OS버전 정보</th>
									</tr>
								</thead>
								<tbody id="trsearchPhModel">
									<c:choose>
										<c:when test="${empty appInfoNew}">
											<tr>
												<td height="100px" colspan="5">등록된 게시물이 없습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach var="list" items="${appInfoNew}" varStatus="stat">
												<tr>
													<td class="td03"><input type="checkbox"
														name="phModelchoice"
														value="${stat.index+1}|${list.phModelInfoSeq}|${list.phName}|${list.osVerName}|${list.phContent}|${list.osVerContent}|${list.phId}|${list.osVerId}" /></td>
													<td class="td03">${list.phName}</td>
													<td class="td03">${list.phContent}</td>
													<td class="td03">${list.osVerName}</td>
													<td class="td03">${list.osVerContent}</td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
						<div id="templetNameDiv" style="display: none">
							<table class="sub_0601_table">
								<colgroup>
									<col width="10%" />
									<col width="20%" />
									<col width="*" />
									<col width="20%" />
									<col width="15%" />
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
								<tbody id="trsearchTempletName">
									<c:choose>
										<c:when test="${empty templetModel}">
											<tr>
												<td colspan="5" align="center">등록된 게시물이 없습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach var="list" items="${templetModel}">
												<tr
													onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
													onMouseOut="rowOnMouseOut(this);"
													onclick="javascript:executeDetail('${list.templetModelId}');">
													<td>${list.rownum}</td>
													<td>${list.templetModelName}</td>
													<td>${list.templetModelContent}</td>
													<td>${list.templetModelSdate}</td>
													<td><img src="images/state/ic_map1.gif"></td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
						<div id="templetModelDiv" style="display: none;">
							<table class="sub_0601_table" id="templetModelList">
								<colgroup>
									<col width="">
									<col width="">
									<col width="">
									<col width="">
									<col width="">
								</colgroup>
								<thead>
									<tr>
										<th><input type="checkbox" name="templetchoiceAll"
											onclick="checkAll('ContentsForm','templetchoiceAll', 'templetchoice');" /></th>
										<th>단말 명</th>
										<th>단말 정보</th>
										<th>OS버전 명</th>
										<th>OS버전 정보</th>
									</tr>
								</thead>
								<tbody id="trsearchTempletModel">
								</tbody>
							</table>
						</div>
						<div id="search" style="margin-top: 20">
							<fieldset id="phModelTd" style="margin-top: 5px;">
								<form:select path="keywordTp">
									<form:option value="1" label="단말명" />
								</form:select>
								<form:input type="text" size="25" path="phName" />
								<img src="images/btn/search5.gif" id="phModelBtn"
									style="vertical-align: bottom; width: 40px;">
							</fieldset>
							<fieldset id="templetSearch"
								style="display: none; margin-top: 5px;">
								<form:select path="keywordTp" style="width:90px;">
									<form:option value="1" label="단말조합명" />
								</form:select>
								<form:input type="text" size="25" path="templetModelName" />
								<img src="images/btn/search5.gif" id="templetNameBtn"
									style="vertical-align: bottom; width: 40px;">
							</fieldset>
							<%-- <fieldset id="templetNameTd" style="display: none;">
                <form:select path="keywordTp" style="width:90px;">
                  <form:option value="1" label="단말조합명" />
                </form:select>
                <form:input type="text" size="25" path="templetModelName" />
                <img src="images/btn/search5.gif" id="templetNameBtn" style="vertical-align: bottom; width: 70x;">
              </fieldset> --%>
						</div>
					</fieldset>
					<fieldset title="Step 4">
						<legend style="display: none">실행가능 단말모델 확인</legend>
						<table>
							<tr>
								<td>
									<table style="margin-top: 10px;">
										<tr>
											<td style="font-size: 11pt">[어플리케이션이 실행가능한 단말모델 정보]
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
											<td id="phDel"><a
												href="javascript:executePhModelDel('P');" onFocus="blur()"><img
													src="images/btn/device2.gif" border="0"></a></td>
											<td id="templetDel" style="display: none;"><a
												href="javascript:executePhModelDel('T');" onFocus="blur()"><img
													src="images/btn/device2.gif" border="0"></a></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="10"></td>
							</tr>
						</table>
						<table class="sub_0601_table">
							<colgroup>
								<col width="*" />
								<col width="46%" />
								<col width="46%" />
							</colgroup>
							<thead>
								<tr>
									<th><input type="checkbox" name="choiceAll"
										onclick="checkAll('ContentsForm','choiceAll', 'choice');" /></th>
									<th>단말 정보</th>
									<th>OS버전 정보</th>
								</tr>
							</thead>
							<tbody id="addPhModel">
							</tbody>
						</table>
					</fieldset>
					<input type="button" class="finish" value="완료" />
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />


	</form:form>
</body>
</html>