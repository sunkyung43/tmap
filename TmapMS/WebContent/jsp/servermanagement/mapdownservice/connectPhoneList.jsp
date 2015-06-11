<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
<link rel="stylesheet" href="/resources/demos/style.css" />
<link rel="stylesheet" href="css/tmap.css" type="text/css" />
<link rel="stylesheet" href="css/common.css" type="text/css" />
<link rel="stylesheet" href="css/layout_contents.css" type="text/css" />
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript">
	
	$(function() {
	    $( "#tabs" ).tabs();
	 });
  
	var ctn = "";
	
	function executeRe(systemId) {
		$("#systemId").val(systemId);
		$("#ContentsForm").attr('action','connectPhoneList.do');
		 $("#ContentsForm").attr('target', 'connectPhoneList');
		$("#ContentsForm").submit();
	}
	
	function hpInfo(comTypeName, code){
		allConnInfoHide();
		$("#type_"+code).show();
		var ctn2 = $("#typeName"+comTypeName).val();
		
		if(ctn != ctn2){
			$("#font"+ctn).css("font-size", "");
			$("#font"+ctn).css("color", "blue");
			$("#font"+comTypeName).css("font-size", "15");
			$("#font"+comTypeName).css("color", "red");
			ctn =  $("#typeName"+comTypeName).val();
		} 
	}
	
	function allConnInfoHide()
	{
		$(".layer").hide();
	}
	
	function disConnect(mdn, type){
		if(mdn == "" || type == ""){
			return;
		}
		if (confirm("사용자의 접속을 종료시키시겠습니까?")) {
			 $.post("disConnectUser.do", {systemId : $("#systemId").val(), mdn:mdn, netType:type}, function(data) {
						if(data.json.result){
							executeRe($("#systemId").val());
						}else{
							
						}
			});
		}
	}
	
</script>
</head>
<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0">
	<form:form commandName="ContentsForm">
		<form:hidden path="systemId"/>
	</form:form>
</body>
</html>