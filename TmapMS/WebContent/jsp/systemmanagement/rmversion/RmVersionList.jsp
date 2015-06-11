<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
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
<script type="text/javascript">
	
	function initLoad() {
		eval(layerview+'["pageLoading"]'+styleview+'display="none"');
	}
	
	function executeSaveCertTime() {
		//보안코드의 속성을 제거하여 validate(form)에서 체크하지 않도록 처리
		var code = document.getElementsByName("securityCode")[0];
		if (code.getAttribute("required") == '') {
			code.removeAttribute("required");
			code.removeAttribute("minbyte");
		}
		
		if (validate(document.ContentsForm)) {
			hideConfirm();
			pageLoading();
			document.ContentsForm.action = 'CertTimeNewCommitAction.action';
			document.ContentsForm.submit();
		}
	}
	
	function executeSaveSecurityCode() {
		if (validate(document.ContentsForm)) {
			hideConfirm();
			pageLoading();
			document.ContentsForm.action = 'SecurityCodeNewCommit.do';
			document.ContentsForm.submit();
		}
	}
	
	function executeSaveMapVerCheck() {
		hideConfirm();
		pageLoading();
		document.ContentsForm.action = 'RmVersionNewCommit.do';
		document.ContentsForm.submit();
	}
	
	function createCode() {
		document.ContentsForm.securityCode.value = MakeWord();
	}
	
	function execute() {
		if(event.keyCode==13) {
			if (document.getElementById('certtimeImg').style.display == '') {
				executeSaveCertTime();
			} else if (document.getElementById('mapVercheckImg').style.display == '') {
				executeSaveMapVerCheck();
			} else {
				executeSaveSecurityCode();
			}
		}
	}
	
	function showConfirm(type) {
		if (type == 'certtimeImg') {
			document.getElementById('certtimeImg').style.display = '';
			document.getElementById('securityImg').style.display = 'none';
			document.getElementById('mapVercheckImg').style.display = 'none';
		} else if (type == 'mapVercheckImg') {
			document.getElementById('certtimeImg').style.display = 'none';
			document.getElementById('securityImg').style.display = 'none';
			document.getElementById('mapVercheckImg').style.display = '';
			
		} else {
			document.getElementById('certtimeImg').style.display = 'none';
			document.getElementById('securityImg').style.display = '';
			document.getElementById('mapVercheckImg').style.display = 'none';
		}

		document.ContentsForm.password.value = '';
		eval(layerview+'["Confirm"]'+styleview+'display=""');
		
		document.ContentsForm.password.focus();
	}

	function hideConfirm() {
		eval(layerview+'["Confirm"]'+styleview+'display="none"');
	}
</script>
</head>
<body onload="javascript:initLoad();" background="images/bg.gif" leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0">
<form name="ContentsForm" method="post">
<input type="hidden" name="mapVerCheckSeq" value="${rmVersionList.mapVerCheckSeq}">
<a name="top"></a>

<jsp:include page="../../common/menu.jsp" />

<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="70" align="center" background="images/top_bg.gif">
	<jsp:include page="../../common/header2.jsp" />
    </td>
  </tr>
  <tr>
    <td height="5" background="images/top_bg2.gif"></td>
  </tr>
  <tr>
    <td height="35"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="10"><img src="images/top_bg31.gif"></td>
        <td align="left" background="images/top_bg3.gif" style="padding:0 0 7 0"><jsp:include page="../../common/date.jsp" /></td>
        <td width="10"><img src="images/top_bg31.gif"></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="100%"><table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="10" background="images/bg_bar.gif"></td>
        <td height="100%" valign="top" class="contents"><table width="100%" height="100%" border="0" cellspacing="0" cellpadding="20">
            <tr>
              <td valign="top" bgcolor="#FFFFFF">
              
              <div id="contents" style="width: 850px">
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="20"></td>
                </tr>
              </table>
              <!-- Map버전운영관리 START -->
              <table width="100%" border="0" cellpadding="15" cellspacing="1" bgcolor="#FF8200">
                <tr>
                  <td valign="top" bgcolor="#FFFFFF" >
	                  <table border="0" cellspacing="0" cellpadding="0">
	                    <tr>
	                      <td><img src="images/title/title.gif"></td>	                      
	                      <td><font size="2" color="red">&nbsp;&nbsp;&nbsp;[ 설날 등 이벤트 소통기간 동안의 트래픽 과부하에 대응하여 맵 다운로드를 skip 하는 RM 기능 ]</font></td>
	                      </tr>
	                    <tr>
	                      <td height="10"></td>
	                      </tr>
	                  </table>
	                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                    <tr>
	                      <td height="1" bgcolor="#FF8200"></td>
	                    </tr>
	                    <tr>
	                      <td class="ttl5"><table border="0" cellspacing="0" cellpadding="0">                          	                           
	                          <tr>
	                            <td width="25"></td>
	                            <td width="145">맵 버전 긴급 운영설정</td>
	                            <td width="150">
	                              <input type="radio" name="mapVerCheck" id="mapVerCheck" value="Y" <c:if test="${rmVersionList.mapVerCheck == 'Y'}">checked="checked"</c:if>> 사용 &nbsp;&nbsp;
	                              <input type="radio" name="mapVerCheck" id="mapVerCheck" value="N" <c:if test="${rmVersionList.mapVerCheck == 'N'}">checked="checked"</c:if>> 미사용
	                            </td>
	                            <td width="200">적용일시 : ${rmVersionList.mapVerCheckDate}</td>
	                            <td><a href="javascript:showConfirm('mapVercheckImg');" onFocus="blur()"><img src="images/btn/btn_apply2.gif" border="0"></a></td>
	                          </tr>
	                      </table></td>
	                    </tr>
	                    <tr>
	                      <td height="1" bgcolor="#FF8200"></td>
	                    </tr>
	                    <tr>
	                      <td height="10"></td>
	                    </tr>
	                  </table>
					  </td>
	                </tr>
	              </table>
              <!-- Map버전운영관리 START -->
              </div></td>
            </tr>
        </table></td>
        <td width="10" background="images/bg_bar.gif"></td>
      </tr>
      <tr></tr>
    </table></td>
  </tr>
  <tr>
  	<td><jsp:include page="../../common/footer.jsp" /></td>
  </tr>
</table>
<input type="hidden" name="certTimeInfoSeq" value="${data.certTimeInfoSeq}">

<!-- 비밀번호 확인 화면 -->
<div id="Confirm" style="height: 100%; width: 100%; position: absolute; top: 0px; left: 0px; display:none; z-index:3; background-repeat: repeat; background-image: url(images/blink.png)" align="center">
<table width="100%" align="center" height="100%" valign="middle">
	<tr>
		<td align="center" valign="middle">
			<table width="275" border="0" cellspacing="0" cellpadding="0" bgcolor="white">
				<tr>
					<td align="center"  height="150">
						<table width="99%" height="50" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td style="font-size: 13; line-height: 140%" align="center">
								<b>
									진행하시겠습니까?
								</b>
								</td>
							</tr>
						</table>
						<center>
						<table height="50" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><img src="images/login_pw.gif"></td>
								<td>&nbsp;
									<input type="password" name="password" class="login" id="textfield2" style="width:180" title="패스워드" maxlength="20" onkeypress="javascript:if(event.keyCode==13) {execute();}" />
									<input type="hidden" name="userid" value="" />
								</td>
							</tr>
						</table>
						</center>
						<img id="certtimeImg" src="images/btn/btn_apply2.gif" onclick="javascript:executeSaveCertTime();" style="cursor:hand;">&nbsp;
						<img id="securityImg" src="images/btn/btn_apply1.gif" onclick="javascript:executeSaveSecurityCode();" style="cursor:hand;display: none;">&nbsp;
						<img id="mapVercheckImg" src="images/btn/btn_apply2.gif" onclick="javascript:executeSaveMapVerCheck();" style="cursor:hand;display: none;">&nbsp;
						<img src="images/btn/close.gif" onclick="javascript:hideConfirm();" style="cursor:hand;">&nbsp;
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
</form>
</body>
</html>