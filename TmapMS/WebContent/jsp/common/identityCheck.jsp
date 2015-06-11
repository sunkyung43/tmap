<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
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
<script language="JavaScript" src="js/common.js"></script>
<script language="JavaScript" src="js/script.js"></script>
<script language="JavaScript" src="js/ValidateCheck.js"></script>
<script type="text/javascript">
	function initLoad() {
		document.ContentsForm.userid.focus();
	}
	
	function evtEnter() {
		var evtKey = window.event.keyCode;
		if (evtKey == 13){
			executeSave(document.ContentsForm);
			return false;
		}
	}
	  
	function executeSave(form) {
		if (validate(form)) {
			document.ContentsForm.nextScript.value = opener.document.ContentsForm.nextScript.value;
			document.ContentsForm.action = 'IdentityCheckAction.action';
			document.ContentsForm.submit();
		}
	}

	function executeView() {
		if (document.ContentsForm.identityState) {
			if(document.ContentsForm.identityState.value == 'Y') {
				alert('확인 완료');
			} else {
				alert('확인 실패');
			}
		} else {
			alert('아이디/비밀번호 확인을 하지 않았습니다.');
		}
	}
	
	function executeResult() {
		if (parent.document.ContentsForm.identityState) {
			parent.document.ContentsForm.identityState = "Y";
		} else {
			var newObj = parent.document.createElement('input');
			newObj.setAttribute('type', 'hidden');
			newObj.setAttribute('value', "Y");
			newObj.setAttribute('name', 'identityState');
			newObj.setAttribute('id', 'identityState');
	        parent.document.ContentsForm.appendChild(newObj);
		}
	}
	document.onkeydown=evtEnter;
</script>
</head>
<body onload="javascript:initLoad();" leftmargin="0" topmargin="0" rightmargin="0" bottommargin="70" bgcolor="#FFFFFF">
<form name="ContentsForm" method="post">
<input type="hidden" name="nextScript"/>

<table border="0" cellspacing="0" cellpadding="0">
  <tr><td height="10"></td></tr>
  <tr>
    <td align="center"><img src="images/login_text.gif"></td>
  </tr>
  <tr>
    <td><img src="images/login_line.gif" vspace="25"></td>
  </tr>
  <tr>
    <td align="center">
		<table border="0" cellspacing="0" cellpadding="0">
		  <tr>
		    <td><table border="0" cellspacing="0" cellpadding="4">
		      <tr>
		        <td><img src="images/login_id.gif"></td>
		        <td>
		         <input name="userid" type="text" class="login" id="textfield" style="width:180" hname="아이디" maxByte="20" required/>
		     </td>
		      </tr>
		      <tr>
		        <td><img src="images/login_pw.gif"></td>
		        <td>
		         <input name="userpw" type="password" class="login" id="textfield2" style="width:180" hname="패스워드" maxByte="20" required/>
		     </td>
		      </tr>
		    </table></td>
		    <td width="100" align="right">
		     <a href="javascript:executeSave(document.ContentsForm);" onFocus="blur()"><img src="images/btn/login.gif" border="0"></a>
		 </td>
		    </tr>
		</table>
    </td>
  </tr>
  <tr><td height="10"></td></tr>
</table>
</form>
</body>
</html>