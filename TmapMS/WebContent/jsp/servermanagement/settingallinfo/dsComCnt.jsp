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
<link rel="stylesheet" href="css/tmap.css" type="text/css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/paging.js"></script>
<script language="JavaScript" src="js/formValidate.js"></script>
<script type="text/javascript">
	
	function initLoad(obj) {
		
		for (var i = 1; i <= obj; i++) {
		
			$("input[name=comSetCnt"+i+"]").addClass("textbox");
			$("input[name=comSetCnt"+i+"]").attr("readonly", "readonly");
		
		}
	}
	
	function selected(obj){
		
		for (var i = 1; i <= obj; i++) {
			
			if($("#comTypeIds"+i).is(':checked')){
				$("input[name=comSetCnt"+i+"]").removeClass("textbox");
				$("input[name=comSetCnt"+i+"]").addClass("textbox validate-req");
				$("input[name=comSetCnt"+i+"]").removeAttr("readonly");
			}else{
				$("input[name=comSetCnt"+i+"]").removeClass("textbox validate-req");
				$("input[name=comSetCnt"+i+"]").addClass("textbox");
				$("input[name=comSetCnt"+i+"]").attr("readonly", "readonly");
			}	
			
		}
		
	}
	
	function executeSave(obj) {
		
		var menus = new Array();
		
		for (var i = 1; i <= obj; i++) {
			
			if(eval($("#comTypeIds"+i).is(':checked'))){
				
				menus.push($("input[name=comSetCnt"+i+"]").val());
				
			}
		}

		if (menus.length == 0) {
			alert("선택된 메뉴가 없습니다.");
			return;
		}
		
		if(!validate()){
	        return;
	    }
		
		$("#comSetCnts").val(menus);
		
		if( confirm("적용하시겠습니까?")){
			$.post("dsComCntUpdate.do", $("#ContentsForm").serialize(), function(data) {
				
				if (data.json.result == "success") {
		            alert("적용완료 되었습니다.");
		        }else{
		        	alert("적용실패 하였습니다.");
		        }
				$("#ContentsForm").attr('action','dsComCnt.do');
	    	    $("#ContentsForm").submit();
			});
			
		}
	}
	
</script>
</head>
<body onload="javascript:initLoad(${fn:length(dsComInfo)});">
<form:form commandName="ContentsForm">
<form:hidden path="comSetCnts"/>
<div id="contents">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	    	<td class="ttl7">[DS동시접속자설정]</td>
	    	<td class="btn">
	   		<a href="javascript:executeSave(${fn:length(dsComInfo)});" onFocus="blur()"><img src="images/btn/btn_apply6.gif" border="0"></a>
	   		</td>
	    </tr>
	    
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="3"><img src="images/ttl_bar1.gif"></td>
			<td width="20%" background="images/ttl_bar2.gif" class="ttl"></td>
			<td width="1" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
			<td background="images/ttl_bar2.gif" class="ttl">통식방식명</td>
            <td width="1" background="images/ttl_bar2.gif"><img src="images/ttl_line.gif"></td>
            <td width="40%" background="images/ttl_bar2.gif" class="ttl">허용유무</td>
			<td width="3"><img src="images/ttl_bar3.gif"></td>
		</tr>
	</table>
	<div style="overflow:auto;height: 145px;">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">																					
		<c:forEach var="list" items="${dsComInfo}" varStatus="status">
		<tr>
			<td width="20%" class="ttl4">
			<input type="checkbox" style="cursor: hand;" id="comTypeIds${status.count}" name="comTypeIds" value="${list.comTypeId}" onclick="javascript:selected(${fn:length(dsComInfo)})"/>
			</td>
            <td width="1"></td>
       		<td class="ttl4">${list.comTypeName}</td>
       		<td width="1"></td>
       		<td width="40%" class="ttl4">
			<input type="text" id="comSetCnt${status.count}" name="comSetCnt${status.count}" style="width:70%" title="동시접속자수" value="${list.comCountSet}"/>
			</td>
			<td width="3"></td>
		</tr>
		<tr>
			<td height="1" colspan="9" bgcolor="#f3961d"></td>
		</tr>
		</c:forEach>
	</table>
	</div>
</div>
</form:form>
</body>
</html>