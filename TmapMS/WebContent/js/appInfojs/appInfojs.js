	function executeDetail(templetModelId) {
		$("#templetModelId").val(templetModelId);
		$("#templetNameTd").hide();
  		$("#phModelTd").hide();
  		$("#templetModelTd").show();
  		$("#phModelDiv").hide();
  		$("#templetNameDiv").hide();
  		$("#templetModelDiv").show();
		templetSearchPage();
	}
	
	//단말조합 리스트조회
	function templetSearchPage() {
		
		//호출 및 메시지 출력
	    $.post("searchTempletModel.do", $("#ContentsForm").serialize(), function(data) {
	        
	        var searchTempletModel = "";
	        
	        $.each(data.json.searchTempletModel, function(idx, list) {
	        	searchTempletModel += "<tr>";
	        	searchTempletModel += "<td class='td03'>";
	        	searchTempletModel += "<input type=\"checkbox\" name=\"templetchoice\" value=\""+list.rownum+"|"+list.phModelInfoSeq+"|"+list.phName+"|"+list.osVerName+"|"+list.phContent+"|"+list.osVerContent+"|"+list.phId+"|"+list.osVerId+"\"/>";
	        	searchTempletModel += "</td>";
	        	searchTempletModel += "<td class='td03'>"+list.phName+"</td>";
	        	searchTempletModel += "<td class='td03'>";
	        	if(list.phContent != null){
	        	searchTempletModel += list.phContent;
	        	}else{
	        	searchTempletModel += "<input type=\"text\"  value=\"\" readonly=\"readonly\" class=\"invisiblebox\" />";	
	        	}
	        	searchTempletModel += "</td>";
	        	searchTempletModel += "<td class='td03'>"+list.osVerName+"</td>";
	        	searchTempletModel += "<td class='td03'>";
	        	if(list.osVerContent != null){
	        	searchTempletModel += list.osVerContent;
	        	}else{
	        	searchTempletModel += "<input type=\"text\" class=\"invisiblebox\" value=\"\" readonly=\"readonly\" style=\"width: 210\"/>";	
	        	}
	        	searchTempletModel += "</td>";
	        	searchTempletModel += "</tr>";
	        });
	        
	        $("#trsearchTempletModel").html(searchTempletModel);
		});
	}
	
	//단말조합 정보 조회
	function templetSearch() {
		
		//호출 및 메시지 출력
	    $.post("searchTempletName.do", $("#ContentsForm").serialize(), function(data) {
	        
	        var searchTempletName = "";
	        
	        $.each(data.json.searchTempletName, function(idx, list) {
	        	
	        	searchTempletName += "<tr onmouseover=\"rowOnMouseOver(this);this.style.cursor='hand'\" onMouseOut=\"rowOnMouseOut(this);\" onclick=\"javascript:executeDetail("+list.templetModelId+");\">";
	        	searchTempletName += "<td class='td03'>"+list.rownum+"</td>";
	        	searchTempletName += "<td class='td03'>"+list.templetModelName+"</td>";
	        	searchTempletName += "<td class='td03'>"+list.templetModelContent+"</td>";
	        	searchTempletName += "<td class='td03'>"+list.templetModelSdate+"</td>";
	        	searchTempletName += "<td class='td03'>";
	        	searchTempletName += "<img src=\"images/state/ic_map1.gif\">";
	        	searchTempletName += "</td>";
	        	searchTempletName += "</tr>";
                
	        });
	        
	        $("#trsearchTempletName").html(searchTempletName);
		});
	}