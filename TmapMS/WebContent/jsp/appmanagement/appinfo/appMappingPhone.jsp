<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery-1.4.4.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.9.2.min.js"></script>
<script type="text/javascript" src="js/formValidate.js"></script>

<script type="text/javascript">

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

	function checkAll(name) {
		if ($("input[name=" + name + "All]").is(":checked")) {
			$("input[name=" + name + "]").attr("checked", true);
		} else {
			$("input[name=" + name + "]").attr("checked", false);
		}
		;
	}
	
	function btn_phTemplet_click(){
		$("#templetModelDetail").hide();
		$("#templetNameDiv").show();
		$("#phModelDiv").hide();
		$("#templetNameTd").show();
		$("#phModelTd").hide();
		$("#templetModelTd").hide();
	}
	function btn_phModel_click(){
		$("#templetNameDiv").hide();
		$("#templetModelDetail").hide();
		$("#phModelDiv").show();
		$("#templetNameTd").hide();
		$("#phModelTd").show();
		$("#templetModelTd").hide();
	}
	
	//리스트조회
	function phSearchPage() {
		//호출 및 메시지 출력
		$.post("searchModifyPhModel.do",$("#PhModelForm").serialize(),
			function(data) {
				var searchModifyPhModel = "";
					$.each(data.json.searchModifyPhModel,
						function(idx, list) {
							searchModifyPhModel += "<tr>";
							searchModifyPhModel += "<td>";
							searchModifyPhModel += "<input type=\"checkbox\" name=\"phModelchoice\" value=\""+list.rownum+"|"+list.phModelInfoSeq+"|"+list.phName+"|"+list.osVerName+"|"+list.phContent+"|"+list.osVerContent+"|"+list.phId+"|"+list.osVerId+"\"/>";
							searchModifyPhModel += "</td>";
							searchModifyPhModel += "<td>"+list.phName+"</td>";
							searchModifyPhModel += "<td>";
							if (list.phContent != null) {
								searchModifyPhModel += list.phContent;
							} else {
								searchModifyPhModel += "";
							}
							searchModifyPhModel += "</td>";
							searchModifyPhModel += "<td>"+list.osVerName+"</td>";
							searchModifyPhModel += "<td>";
							if (list.osVerContent != null) {
								searchModifyPhModel += list.osVerContent;
							} else {
								searchModifyPhModel += "";
							}
							searchModifyPhModel += "</td>";
							searchModifyPhModel += "</tr>";
	
						});
				$("#trsearchPhModel").html(searchModifyPhModel);
			});
	};

	//단말조합 리스트조회
	function templetSearchPage() {
		
		//호출 및 메시지 출력
	    $.post("searchTempletModel.do", $("#PhModelForm").serialize(), function(data) {
	        
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
	    $.post("searchTempletName.do", $("#PhModelForm").serialize(), function(data) {
	        
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
//-->
</script>
<div class="headline" style="margin-left:10px;margin-top:5px;margin-bottom:5px">
	<img src="images/h3_ico.gif"> <span>단말 매핑 정보</span>
</div>
<div style="text-align:right;margin-top:-25px">
	<a href="#" class="closeBtn">닫 기</a>
</div>

<form:form commandName="PhModelForm" id="PhModelForm" name="PhModelForm">
	<div id="templetModelDiv" style="margin-top: -8px;">
		<input type="hidden" name="appVerId" id="popAppVerId" />
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
					<th><input type="checkbox" name="phModelIdsAll"
						onclick="javascript:checkAll('phModelIds')" checked="checked" /></th>
					<th>단말명</th>
					<th>단말정보</th>
					<th>OS버전명</th>
					<th>OS버전정보</th>
				</tr>
			</thead>
			<tbody id="addPhModel">

				<c:choose>
					<c:when test="${empty verUseOsPh}">
						<tr>
							<td class="td03 empty" colspan="5" height="100" align="center">등록된
								단말 모델 정보가 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="list" items="${verUseOsPh}" varStatus="stat">
							<tr>
								<td class="td03"><input type="checkbox" name="phModelIds"
									value="${list.phModelInfoSeq}" checked="checked" /> <input
									type="hidden" name="checkboxPhModelInfos"
									value="${list.phModelInfoSeq}" /></td>
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
	<div id="phoneSetDiv">
		<div id="phModeDiv" style="margin-top: 15px;">
			<table>
				<tr>
					<td>
						<div style="margin-left: 15px;">
							<a href="javascript:btn_phModel_click();" class="regBtn"
								id="btn_phModel">단말 모델 정보</a> <a
								href="javascript:btn_phTemplet_click();" class="regBtn"
								id="btn_phTemplet">단말 조합 정보</a>
						</div>
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
						<th><input type="checkbox" name="phModelchoiceAll"
							onclick="checkAll('phModelchoice');" /></th>
						<th>단말명</th>
						<th>단말정보</th>
						<th>OS버전명</th>
						<th>OS버전정보</th>
					</tr>
				</thead>
				<tbody id="trsearchPhModel" class="contentList">
					<c:choose>
						<c:when test="${empty allOsPhInfo}">
							<tr class="empty">
								<td colspan="5" height="100" align="center">등록된 게시물이 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="list" items="${allOsPhInfo}" varStatus="stat">
								<tr>
									<td class="td03"><input type="checkbox"
										name="phModelchoice" value="${list.phModelInfoSeq}" /> <input
										type="hidden" name="checkboxPhModelInfos"
										value="${list.phModelInfoSeq}" /></td>
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
				<tbody id="trsearchTempletName"
					style="overflow: auto; height: 250px;">
					<c:choose>
						<c:when test="${empty templetModel}">
							<tr>
								<td height="100" align="center" colspan="5">등록된 게시물이 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="list" items="${templetModel}">
								<tr onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
									onMouseOut="rowOnMouseOut(this);"
									onclick="javascript:getTempletDetailModel('${list.templetModelId}');">
									<td class="td03">${list.rownum}</td>
									<td class="td03">${list.templetModelName}</td>
									<td class="td03">${list.templetModelContent}</td>
									<td class="td03">${list.templetModelSdate}</td>
									<td class="td03"><img src="images/state/ic_map1.gif"></td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		<div id="templetModelDetail" style="display: none;"></div>
		<div id="phmodel_add_btn"
			style="text-align: right; margin-right: 15px; margin-top: 5px">
			<a href="javascript:addPhModel();" class="regBtn">모델 추가</a>

		</div>
	</div>
	<div id="search">
		<table style="margin-left: 170px; margin-top: 3px;">
			<tr>
				<!-- <td>&nbsp;&nbsp;&nbsp;
									<span style="cursor: hand;" id="phModelOpen">[단말모델 정보]</span> 
									<span style="cursor: hand;" id="templetModelOpen">[단말조합 정보]</span>&nbsp;&nbsp;&nbsp;
								</td> -->
				<!-- </tr>
							<tr> -->
				<td id="phModelTd"><form:select path="keywordTp"
						style="width:90px;">
						<form:option value="1" label="단말명" />
					</form:select> <form:input type="text" size="25" id="phName" name="phName"
						path="phName" text="" /> <img src="images/btn/search5.gif"
					id="phModelBtn" style="vertical-align: bottom; width: 40px;">
				</td>

				<td id="templetModelTd" style="display: none;"><form:select
						path="keywordTp" style="width:90px;">
						<form:option value="1" label="단말명" />
					</form:select> <form:input type="text" size="25" path="phName2" id="phName2"
						name="phName2" /> <img src="images/btn/search5.gif"
					id="templetModelBtn" style="vertical-align: bottom; width: 40px;">
				</td>

				<td id="templetNameTd" style="display: none;"><form:select
						path="keywordTp" style="width:90px;">
						<form:option value="1" label="단말조합명" />
					</form:select> <form:input type="text" size="25" path="templetModelName"
						id="templetModelName" name="templetModelName" /> <img
					src="images/btn/search5.gif" id="templetNameBtn"
					style="vertical-align: bottom; width: 40px;"></td>

				<td class="btn"><a
					onclick="document.getElementById('pop_wrap').style.display='none'; document.body.className='';"></a>
				</td>
			</tr>

		</table>
	</div>
	<div style="text-align: center; margin-top: 5px; margin-bottom: 10px">
		<a style="margin-right: 5px;" href="javascript:executePhModelSave();"
			class="regBtn">저장</a><a href="#" class="closeBtn">닫 기</a>
	</div>
</form:form>