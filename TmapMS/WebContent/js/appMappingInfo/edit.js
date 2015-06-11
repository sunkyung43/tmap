function typeDetail(dataTypeId, dataTypeName){
	$("#dataTypeId").val(dataTypeId);
	$("#tName").val(dataTypeName);
	$("#fName").val("");
	$("#fContent").val("");
	$("#fStore").val("");
	$("#fSdate").val("");
	$("#oName").val("");
	$("#oContent").val("");
	$("#oStore").val("");
	$("#oSdate").val("");
	$("#oType").val("");
	$("#fileTbody").html("");
	$("#typeTd").hide();
	$("#fileTd").show();
	$("#verBasicTbody").show();
	$("#verTbody").hide();
	fileInType();
}

//데이터 파일
function fileInType(){
	
	//호출 및 메시지 출력
    $.post("fileModify.do", $("#ContentsForm").serialize(), function(data) {
    	
    	var fileInType ="";
    	/*
*/    	if(data.json.fileInType != ""){
    	$.each(data.json.fileInType, function(idx, list) {
    		fileInType += "<tr onclick=\"javascript:fileDetail("+list.dataFileId+");\" onMouseOver=\"rowOnMouseOver(this);this.style.cursor='hand'\" onMouseOut=\"rowOnMouseOut(this);\" >";
    		fileInType +="<td width=\"10%\">"+list.rownum+"</td>";
    		fileInType +="<td width=\"30%\">"+list.dataFileName+"</td>";
    		fileInType +="<td width=\"25%\">"+list.storageName+"</td>";
    		fileInType +="<td width=\"35%\">"+list.dataFileSdate+"</td>";
    		fileInType +="</tr>";
    	});
    	}else{
    		fileInType += "<tr>";
    		fileInType += "<td height=\"50\" align=\"center\">등록된 데이터 파일이 없습니다.</td>";
    		fileInType += "</tr>";
    	}
    	$("#fileTbody").html(fileInType);
    	$("#fileTbody").show();
    });
	
}

//데이터 버전
function verInFile(){
	
	//호출 및 메시지 출력
    $.post("appMappingVerInFile.do", $("#ContentsForm").serialize(), function(data) {
    	
    	var verInFile ="";
    	
    	if(data.json.verInFile != ""){
    	$.each(data.json.verInFile, function(idx, list) {
    		verInFile += "<tr onmouseover=\"rowOnMouseOver(this);\" onMouseOut=\"rowOnMouseOutColor(this, '"+list.color+"');\">";
    		verInFile += "<td>";
    		if(list.state == "Y"){
    		verInFile += "<input type=\"checkbox\" id=\"dataFileIds\" name=\"dataFileIds\" value=\""+list.fileVerId+"\" checked=\"checked\"/>";
			}else{
			verInFile += "<input type=\"checkbox\" id=\"dataFileIds\" name=\"dataFileIds\" value=\""+list.fileVerId+"\"/>";	    			
    		}
    		verInFile += "</td>";
    		verInFile += "<td onclick=\"javascript:executeDetail("+list.fileVerId+",'"+list.fileVerName+"')\">"+list.fileVerName+"</td>";
    		verInFile += "<td onclick=\"javascript:executeDetail("+list.fileVerId+",'"+list.fileVerName+"')\">"+list.fileVerRank+"</td>";
    		verInFile += "<td onclick=\"javascript:executeDetail("+list.fileVerId+",'"+list.fileVerName+"')\">"+list.fileVerSdate+"</td>";
    		verInFile += "</tr>";
    	});
    	}else{
    		verInFile += "<tr>";
    		verInFile += "<td colspan='4' style='height:50px;text-align:center;'>등록된 데이터 버전이 없습니다.</td>";
    		verInFile += "</tr>";
    	}
    	$.each(data.json.fileDetail, function(idx, list) {
    		$("#fName").val(list.dataFileName);
    		$("#fContent").val(list.dataFileContent);
    		$("#fStore").val(list.dataFileStore);
    		$("#fSdate").val(list.dataFileSdate);
    	});
    	$("#verBasicTbody").hide();
    	$("#verTbody").html(verInFile);
    	$("#verTbody").show();
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
	    		verDetail += "<td width=\"25%\">"+list.file_name+"</td>";
           		verDetail += "<td width=\"15%\">"+list.file_size+"</td>";
           		verDetail += "<td width=\"25%\">"+list.file_sdate+"</td>";
           		verDetail += "<td width=\"17%\">"+list.file_state+"</td>";
           		verDetail += "<td width=\"18%\">"+list.file_update+"</td>";
           		verDetail += "</tr>";
	    	});
	    	}else{
	    		verDetail += "<tr>";
	    		verDetail += "<td height=\"100\" align=\"center\" colspan=\"12\">등록된 데이터 파일이 없습니다.</td>";
	    		verDetail += "</tr>";
	    	}
    		$("#popupTbody").html(verDetail);
    		$("#verName").html("Ver Name : "+fileVerName);
    		document.getElementById('pop_wrap').style.display='';
    });
}