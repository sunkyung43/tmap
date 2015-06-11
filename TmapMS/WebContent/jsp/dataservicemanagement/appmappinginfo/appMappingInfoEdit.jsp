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
<link rel="stylesheet" href="css/base.css" type="text/css" />
<link rel="stylesheet" href="css/tmap.css" type="text/css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/formValidate.js"></script>
<script type="text/javascript" src="js/appMappingInfo/edit.js"></script>
<script type="text/javascript" src="js/jquery.fixheadertable.min.js"></script>
<script type="text/javascript">

  //이벤트 등록
  $(document).ready(function() {
    //조회 버튼 클릭 이벤트 처리
    $("#btnSearch").bind("click", function() {
      fileInType();
    });

    $("#btnSearch2").bind("click", function() {
      verInFile();
    });

    $("#").click(function() {
      $("#fileTd").hide();
      $("#typeTd").show();
      $("#verBasicTbody").show();
      $("#verTbody").hide();
      $("#dataverTbody").hide();
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

    $("#appVersionInfoList").click(function() {
      //$("#appVerId").val($(this).val());
      showTable();
      $.post("verTypeAndFile.do", $("#ContentsForm").serialize(), function(data) {
        $("#verTypeFile").html(data);
      });
    });

  });

  function getAppVerId(appVerId) {
    $("#appVerId").val(appVerId);
    showTable();
    $.post("verTypeAndFile.do", $("#ContentsForm").serialize(), function(data) {
      $("#verTypeFile").html(data);
    });
  }

  function showTable() {
    $("#verInTypeInfoTable").show();
    $("#typeInFileDiv").hide();

  }
  function hideTable() {
    $("#verInTypeTable").hide();
    $("#typeInFileDiv").hide();
  }

  function typeAndFile(dataFileId, dataTypeName) {

    $("#dataFileId").val(dataFileId);
    $("#oType").val(dataTypeName);
    $("#fileTd").hide();
    $("#typeInFileDiv").show();

    //호출 및 메시지 출력
    $.post("appMappingVerInFile.do", $("#ContentsForm").serialize(), function(data) {
      $.each(data.json.fileDetail, function(idx, list) {
        $("#oName").val(list.dataFileName);
        $("#oContent").val(list.dataFileContent);
        $("#oStore").val(list.dataFileStore);
        $("#oSdate").val(list.dataFileSdate);
      });
    });
    verInFile();
  }

  function executeModify(appMappingId) {

    $("#appMappingId").val(appMappingId);

    if (confirm("데이터 정보를 수정하시겠습니까?")) {

      $.post("appMappingUpdate.do", $("#ContentsForm").serialize(), function(data) {
        alert("수정되었습니다.");
        $("#ContentsForm").attr('action', 'appMappingInfoEdit.do');
        $("#ContentsForm").submit();
      });
    }
  }

  function mappingModify(appMappingId) {

    $("#appMappingId").val(appMappingId);

    if (confirm("매핑 정보를 수정하시겠습니까?")) {

      $.post("mappingModify.do", $("#ContentsForm").serialize(), function(data) {
        alert("수정되었습니다.");
       location.replace('appMappingInfoList.do');
      });
    }
  }

  function executeDel(appMappingId, state) {

    $("#appMappingId").val(appMappingId);

    if (confirm("삭제하시겠습니까?")) {
      if (state == 'Y') {
        alert("사용중인 매핑정보는 삭제할 수 없습니다.\n미사용으로 전환 후 삭제하십시요.");
        return;
      } else {
        $.post("appMappingDelete.do", $("#ContentsForm").serialize(), function(data) {
          alert("삭제되었습니다.");
          $("#appMappingName").val("");
          $("#ContentsForm").attr('action', 'appMappingInfoList.do');
          $("#ContentsForm").submit();
        });
      }
    }
  }

  function serviceGo(appMappingId) {
    $("#appMappingId").val(appMappingId);
    $("#ContentsForm").attr('action', 'appServiceInfoEdit.do');
    $("#ContentsForm").submit();
  }

  function appVerAdd() {
    $("#pop_wrap").show();
    $("#pop_container2").show();
    $("#pop_container").hide();
  }

  function save() {

    if (!validate()) {
      return;
    }

    if (confirm("등록하시겠습니까?")) {
      ContentsForm.action = "appVerInfoInsert.do";
      ContentsForm.submit();
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
    $.post("mappingFileInType.do", $("#ContentsForm").serialize(), function(data) {
      $("#fileInTypeDiv").html(data);
    });
  }

  function fileDetail(dataFileId) {
    $("#dataFileId").val(dataFileId);
    verInFile2();
  }

  function verInFile() {
    //호출 및 메시지 출력
    $.post("mappingVerInFile.do", $("#ContentsForm").serialize(), function(data) {
      $.post("mappingFileDetail.do", $("#ContentsForm").serialize(), function(r) {
        $.each(r.json.fileDetail, function(idx, list) {
          $("#fName").val(list.dataFileName);
          $("#fContent").val(list.dataFileContent);
          $("#fStore").val(list.dataFileStore);
          $("#fSdate").val(list.dataFileSdate);
        });
      });
      $("#verTbody").html(data);
    });
  }
  
  function verInFile2() {
    //호출 및 메시지 출력
    $.post("mappingVerInFile.do", $("#ContentsForm").serialize(), function(data) {
      $.post("mappingFileDetail.do", $("#ContentsForm").serialize(), function(r) {
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
  
  function executeDetail(fileVerId, fileVerName){
		
		$("#fileVerId").val(fileVerId);
		document.getElementById('pop_wrap').style.display='none';
		
		
		//호출 및 메시지 출력
	    $.post("verDetail.do", $("#ContentsForm").serialize(), function(data) {
	    	
	    	var verDetail ="";
	    	
	    	if(data.json.verDetail != ""){
		    	$.each(data.json.verDetail, function(idx, list) {
		    		verDetail += "<tr>";
		    		/* verDetail += "<td width=\"3\"></td>"; */
		    		verDetail += "<td>"+list.file_name+"</td>";
	           		/* verDetail += "<td width=\"1\"></td>"; */
	           		verDetail += "<td>"+list.file_size+"</td>";
	           		/* verDetail += "<td width=\"1\"></td>"; */
	           		verDetail += "<td>"+list.file_sdate+"</td>";
	           		/* verDetail += "<td width=\"1\"></td>"; */
	           		verDetail += "<td>"+list.file_state+"</td>";
	           		/* verDetail += "<td width=\"1\"></td>"; */
	           		verDetail += "<td>"+list.file_update+"</td>";
	           		/* verDetail += "<td width=\"3\"></td>"; */
	           		verDetail += "</tr>";
	           		/* verDetail += "<tr>";
	           		verDetail += "<td height=\"1\" colspan=\"12\" bgcolor=\"#f3961d\"></td>";
	           		verDetail += "</tr>"; */
		    	});
		    	}else{
		    		verDetail += "<tr>";
		    		verDetail += "<td height=\"100\" align=\"center\" colspan=\"5\">등록된 데이터 파일이 없습니다.</td>";
		    		verDetail += "</tr>";
		    		/* verDetail += "<tr>";
		    		verDetail += "<td height=\"1\" class=\"line\" colspan=\"12\"></td>";
		    		verDetail += "</tr>"; */
		    	}
	    		$("#popupTbody").html(verDetail);
	    		$("#verName").html("Ver Name : "+fileVerName);
	    		document.getElementById('pop_wrap').style.display='';
	    });
	}
  
  function appMappingDetailSave() {
    if (confirm("버전 정보를 추가하시겠습니까?")) {
      $.post("appMappingDetailInfoInsert.do", $("#ContentsForm").serialize(), function(data) {
        $("#datainfo_pop_wrap").hide();
        hideDataAdd();
      });
    }
  }
  
  /* function executeDetail() {
    $("#ContentsForm").attr('action', 'appMappingInfoEdit.do');
    $("#ContentsForm").submit();
  } */

  function regTypeAdd() {
    if ($("#appVerId").val() == '') {

    }
    $("#dataFileAddTable").show();

  }
  
  function hideDataAdd(){
    $("#dataFileAddTable").hide();
  }
  
</script>
</head>
<body>
  <!-- 레이어 팝업 -->
  <div id="pop_wrap" style="display: none; position: absolute;">
    <div id="pop_container" style="height: 350px; top:200px; left:680px;">
     <iframe src="about:blank" scrolling="no" frameborder="0" title="팝업 아이프레임 영역"></iframe>
       <div style="overflow: auto; height: 350px;"> 
      <table>
        <tr>
          <td>
          	<a onclick="document.getElementById('pop_wrap').style.display='none'; document.body.className='';"> 
          		<input type="button" value="닫기" style="margin-left: 470;" />
          	</a>
          </td>
        </tr>
      </table>
      <table class="sub_0601_table" style="width: 500px;">
        <colgroup>
          <col width="25%" />
          <col width="15%" />
          <col width="20%" />
          <col width="18%" />
          <col width="18%" />
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
  </div>
  <form:form commandName="ContentsForm" id="ContentsForm" name="ContentsForm">
    <form:hidden path="appInfoSeq" value="${mappingDetail.appInfoSeq}" />
    <form:hidden path="dataTypeId" />
    <form:hidden path="appMappingId" value="${mappingDetail.appMappingId}" />
    <form:hidden path="dataFileId" />
    <form:hidden path="fileVerId" />
    <form:hidden path="appVerId" value="${mappingDetail.appVerId}" />
    <form:hidden path="appServiceId" value="${mappingDetail.appMapServiceId}" />
    <jsp:include page="../../common/menu.jsp" />
    <div id="bodyDiv">
      <div class="contentsDiv">
        <div class="contentDiv">
          <table>
            <tr>
              <td width="560px">
              	<img src="images/h3_ico.gif">
              		<span>데이터 매핑정보 수정</span> <!-- <img src="images/title/title17.gif"> -->
              </td>
              <td>
              	<a href="javascript:executeDel('${mappingDetail.appMappingId}','${mappingDetail.appMappingState}');" onFocus="blur()">
              		<img src="images/btn/delete7.gif" border="0">
              	</a> &nbsp;
				<a href="appMappingInfoList.do" onFocus="blur()">
					<img src="images/btn/btn_list.gif" border="0">
				</a> 
				<a href="javascript:mappingModify('${mappingDetail.appMappingId}');" onFocus="blur()">
					<img src="images/btn/modify7.gif" border="0">
				</a>
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
                <th class="first">App 명</th>
                <td class="first">
                	<input type="text" id="appName" name="appName" class="noBorder" title="App 명" value="${mappingDetail.appName}" readonly="readonly" />
                </td>
              </tr>
              <tr>
                <th>매핑 데이터 명</th>
                <td>
                	<input type="text" name="appMappingName" id="appMappingName" title="매핑 데이터 명" value="${mappingDetail.appMappingName}" readonly="readonly" class="noBorder" />
                </td>
              </tr>
              <tr>
                <th>사용여부</th>
                <td>
                	<input type="radio" style="cursor: hand;" name="appMappingState" value="Y" <c:if test="${mappingDetail.appMappingState == 'Y'}">checked="checked"</c:if> /><label class="MR20">사용</label>
                	<input type="radio" style="cursor: hand;" name="appMappingState" value="N" <c:if test="${mappingDetail.appMappingState == 'N'}">checked="checked"</c:if> /><label class="MR20">미사용</label>
                </td>
              </tr>
              <tr>
                <th>내용</th>
                <td>
                	<input type="text" name="appMappingContent" style="width: 610px;" value="${mappingDetail.appMappingContent}" title="내용">
                </td>
              </tr>
            </tbody>
          </table>
          <br />
          <table>
            <tr>
              <td width="560px">*데이터 추가시 등록할 버전 선택 후 사용하세요.</td>
              <td>
              	<a href="javascript:regTypeAdd()" onFocus="blur()"> 데이터 타입 추가하기</a>
              </td>
            </tr>
          </table>
          <table class="sub_0601_table" id="appVersionInfoList">
            <colgroup>
              <col width="*" />
              <col width="*" />
              <col width="*" />
            </colgroup>
            <thead>
              <tr>
                <th>버전명</th>
                <th>내용</th>
                <th>버전상태</th>
              </tr>
            </thead>
            <tbody>
              <c:choose>
                <c:when test="${empty MappingDetailList}">
                  <tr>
                    <td colspan="4">등록된 APP 버전이 없습니다.</td>
                  </tr>
                </c:when>
                <c:otherwise>
                  <c:forEach var="list" items="${MappingDetailList}">
                    <tr onmouseover="rowOnMouseOver(this);this.style.cursor='hand';" onMouseOut="rowOnMouseOut(this);" onclick="getAppVerId('${list.appVerId}');">
                      <td>${list.appVerName}</td>
                      <td>${list.appVerContent}</td>
                      <td>
                      	<c:if test="${list.appVerState == 'Y'}"> 사용</c:if> 
						<c:if test="${list.appVerState == 'N'}"> 미사용</c:if>
					</td>
                    </tr>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
              <tr>
            </tbody>
          </table>
          <br>
           <div id="dataFileAddTable" style="display: none;">
            <div>
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
                    <tr onmouseover="rowOnMouseOver(this);this.style.cursor='hand'" onMouseOut="rowOnMouseOut(this);">
                      <td>
                      	<input type="radio" name="sort" onclick="typeDetail('${list.dataTypeId}', '${list.dataTypeName}');" />
                      </td>
                      <td>${list.dataTypeName}</td>
                      <td>${list.dataTypeContent}</td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
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
                    <td class="first">
                    	<input type="text" id="tName" readonly="readonly" style="width: 120px;" />
                    </td>
                    <th class="first">파일명</th>
                    <td class="first">
                    	<input type="text" id="fName" readonly="readonly" style="width: 120">
                    </td>
                  </tr>
                  <tr>
                    <th>내용</th>
                    <td>
                    	<input type="text" class="invisiblebox\" id="fContent" readonly="readonly" style="width: 120">
                    </td>
                  </tr>
                  <tr>
                    <th>파일등록</th>
                    <td>
                    	<input type="text" class="invisiblebox" id="fStore" readonly="readonly" style="width: 120">
                    </td>
                    <th>등록일</th>
                    <td>
                    	<input type="text" class="invisiblebox" id="fSdate" readonly="readonly" style="width: 120">
                    </td>
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
                  <th><input type="checkbox" name="chkCtrl" id="chkCtrl" onclick="javascript:checkAll();" /></th>
                  <th>버전명</th>
                  <th>버전순위</th>
                  <th>등록일</th>
                </tr>
              </thead>
              <tbody id="verInFileTbody">
              </tbody>
              <tfoot>
                <tr style="margin-top: 40">
                  <td colspan="4">
                  	<a href="javascript:hideDataAdd()"> 닫기 </a>
                  	<a href="javascript:appMappingDetailSave()"> 
                  		<img src="images/btn/btn_apply2.gif" style="vertical-align: bottom; width: 75px; float: right">
                  	</a>
                  </td>
                </tr>
              </tfoot>
            </table>
          </div>
           </div> 
          <div id="verInTypeInfoTable" style="display: none;">
            <table class="sub_0601_table">
              <colgroup>
                <col width="35%">
                <col width="*">
              </colgroup>
              <thead>
                <tr>
                  <th>데이터 타입명</th>
                  <th>데이터 파일명</th>
                </tr>
              </thead>
              <tbody id="verTypeFile">
              </tbody>
            </table>
            <br>
           <table class="srvRegi">
              <colgroup>
                <col width="100px">
                <col width="*">
              </colgroup>
              <tbody>
                <tr>
                  <th class="first">타입명</th>
                  <td class="first">
                  	<input type="text" class="noBorder" id="oType" readonly="readonly">
                  </td>
                  <th class="first">파일명</th>
                  <td class="first">
                  	<input type="text" class="noBorder" id="oName" readonly="readonly">
                  </td>
                </tr>
                <tr>
                  <th>내용</th>
                  <td colspan="3">
                  	<input type="text" class="noBorder" id="oContent" readonly="readonly">
                  </td>
                </tr>
                <tr>
                  <th>file등록</th>
                  <td>
                  	<input type="text" class="noBorder" id="oStore" readonly="readonly">
                  </td>
                  <th>등록일</th>
                  <td>
                  	<input type="text" class="noBorder" id="oSdate" readonly="readonly">
                  </td>
                </tr>
              </tbody>
            </table> 
          </div>
          <br>
          <div id="typeInFileDiv" style="display: none">
            <div style="text-align: right; margin-right: 10px;">
              <form:select path="keywordTp">
                <form:option value="1" label="버전명" />
              </form:select>
              <form:input type="text" size="15" path="searchFileVerName" />
              <img src="images/btn/search5.gif" id="btnSearch2" style="vertical-align: bottom; width: 40px;">
            </div>
            <table class="sub_0601_table">
              <colgroup>
                <col width="10%">
                <col width="30%">
                <col width="25%">
                <col width="35%">
              </colgroup>
              <thead>
                <tr>
                  <th height="45px">
                  	<input type="checkbox" name="chkCtrl" onclick="javascript:checkAll('ContentsForm', 'chkCtrl', 'dataFileIds');" />
                  </th>
                  <th>버전명</th>
                  <th>버전순위</th>
                  <th>등록일</th>
                </tr>
              </thead>
              <tbody id="verTbody">
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
    <jsp:include page="../../common/footer.jsp" />
  </form:form>
</body>
</html>