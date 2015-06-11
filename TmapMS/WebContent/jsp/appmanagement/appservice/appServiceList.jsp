<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/paging.js"></script>
<script type="text/javascript">
	
	//이벤트 등록
	$(document).ready(function() {
	
	    fnPaging();
	    
	 	//검색 조건 설정
	    searchCondChange();
	  
	    $("#keywordTp").change(function(){
	    	searchCondChange();
	    });
	    
	    //조회 버튼 클릭 이벤트 처리
	    $("#btnSearch").bind("click", function() {
	    	searchPage(0);
	    });
	    
	   //조회 버튼 엔터 이벤트 처리
	    $("#appName").bind("keydown", function(event) {
	        if (event.keyCode == 13) {	
	        	searchPage(0);
	        }
	    });
	   
	    $("#appUpName").bind("keydown", function(event) {
	        if (event.keyCode == 13) {	
	        	searchPage(0);
	        }
	    });
	});
	 
	function executeNew() {
		$("#ContentsForm").attr('action','appServiceNew.do');
	    $("#ContentsForm").submit();
	}
	
	function executeDetail(appInfoServiceSeq) {
		$("#appInfoServiceSeq").val(appInfoServiceSeq);
		$("#ContentsForm").attr('action','appServiceEdit.do');
	    $("#ContentsForm").submit();
	}
	
	//검색 조건 변경
	function searchCondChange(keywordTp) {
		if ($("#keywordTp").val() == "1") {
			$("#appUpName").val("");
			$("#appUpName").hide();
			$("#appName").show();
			
		} else {
	        $("#appName").val("");
	        $("#appName").hide();
	        $("#appUpName").show();
	        
		}
	}; 
	
	//리스트조회
	function searchPage(page) {
		if (page == "" || page == 0){
	        $("#currentPage").val(1);
	    }else {
	        $("#currentPage").val(page);
	    }
		
	    $("#startRowNum").val((page-1) * ($('#countPerPage').val()));
		$("#ContentsForm").attr('action','appServiceList.do');
	    $("#ContentsForm").submit();
	};
</script>
</head>
<body>
<form:form commandName="ContentsForm">
<form:hidden path="currentPage"/>
<form:hidden path="startRowNum"/>
<form:hidden path="countPerPage"/>
<form:hidden path="pageCount"/>
<form:hidden path="totalCount"/>
<form:hidden path="appInfoServiceSeq"/>

		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
				<img src="images/h3_ico.gif"><span>App 강제 업그레이드 관리</span><br></br>
					<table class="sub_0601_table">
		            	<colgroup>
		                    <col width=""/>
		                    <col width=""/>
		                    <col width=""/>
		                    <col width=""/>
		                </colgroup>
	                    	<tbody>
	                    		<tr>
			                      <th>번호</th>
			                      <th>서비스정보</th>
			                      <th>등록일</th>
			                      <th>상태</th>
	                      		</tr>
			                    <c:choose>
			                    	<c:when test="${empty appServiceList}">
				                      	<tr>
				                        	<td colspan="4" height="100" class="td03">등록된 게시물이 없습니다.</td>
				                      	</tr>
			                    	</c:when>
			                    	<c:otherwise>
			                    		<c:forEach var="list" items="${appServiceList}">
			                      			<tr onmouseover="rowOnMouseOver(this);this.style.cursor='hand'" onMouseOut="rowOnMouseOut(this);" onclick="javascript:executeDetail(${list.appInfoServiceSeq});">
			                        			<td class="td03">${list.rownum}</td>
						                        <td class="td03">어플리케이션[${list.appName}] 버전[${list.appVerName}] → 업그레이드 어플리케이션 [${list.appUpName}] 버전[${list.appUpVerName}]</td>                      
						                        <td class="td03">${list.appInfoServiceStoreDate}</td>
						                        <td class="td03">
							                        <c:if test="${list.appInfoServiceState == 'Y'}">사용</c:if>
							                        <c:if test="${list.appInfoServiceState == 'N'}">미사용</c:if>
						                        </td>
			                      			</tr>
			                    		</c:forEach>
			                    	</c:otherwise>
			                    </c:choose>
	                      </tbody>
		            </table>
	                <div id="paging"></div>
	                <div id="search">
	                   <fieldset>
	                     <form:select path="keywordTp" style="width:100px;">
				                <form:option value="1" label="기존App"/>
		  		    	        <form:option value="2" label="업그레이드App"/>
		                  	</form:select>
					      	<form:input type="text" size="30" path="appName" />
						  	<form:input type="text" size="30" path="appUpName" style="display:none;"/>
						  	<img src="images/btn/search3.gif" id="btnSearch" name="btnSearch" style="vertical-align: bottom; width: 70px;">
	                        <a href="javascript:executeNew();" onFocus="blur()"><img src="images/btn/btn_apply2.gif" style="vertical-align: bottom; width: 70px;"></a>
	                  </fieldset>
	                </div>
				</div>
			</div>
			<div id="divPageing" class="paging"></div>
		</div>
		<jsp:include page="../../common/footer.jsp" />
</form:form>
</body>
</html>