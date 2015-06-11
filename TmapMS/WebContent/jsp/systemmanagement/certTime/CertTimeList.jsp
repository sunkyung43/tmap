<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script language="JavaScript" src="js/formValidate.js"></script>
<script language="JavaScript" src="js/GeneratorSecurityCode.js"></script>
<script type="text/javascript">
	function executeSaveCertTime() {
		//보안코드의 속성을 제거하여 validate(form)에서 체크하지 않도록 처리
		var code = document.getElementsByName("securityCode")[0];
		if (code.getAttribute("required") == '') {
			code.removeAttribute("required");
			code.removeAttribute("minbyte");
		}

		if (validate(document.ContentsForm)) {
			//hideConfirm();
			//pageLoading();
			document.ContentsForm.action = 'certTimeNewCommit.do';
			document.ContentsForm.submit();
		}
	}

	function executeSaveSecurityCode() {
		if (validate(document.ContentsForm)) {
			//hideConfirm();
			//pageLoading();
			document.ContentsForm.action = 'securityCodeNewCommit.do';
			document.ContentsForm.submit();
		}
	}

	function executeSaveMapVerCheck() {
		hideConfirm();
		pageLoading();
		document.ContentsForm.action = 'RmVersionCommitAction.action';
		document.ContentsForm.submit();
	}

	function createCode() {
		document.ContentsForm.securityCode.value = MakeWord();
	}

	function execute() {
		if (event.keyCode == 13) {
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

		document.ContentsForm.password.focus();
	}

	/* function hideConfirm() {
		eval(layerview + '["Confirm"]' + styleview + 'display="none"');
	} */
</script>
</head>
<body>
	<form name="ContentsForm" method="post">
		<input type="hidden" name="certTimeInfoSeq"
			value="${certTime.certTimeInfoSeq}"> <input type="hidden"
			name="securityCodeSeq" value="${securityCode.securityCodeSeq}">

		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table class="srvRegi">
						<img src="images/h3_ico.gif">
						<span>인증시간 관리</span>
						<br></br>
						<colgroup>
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<tr class="top">
							<th class="first">인증시간</th>
							<td class="first" width="200px"><input type="text" class="textbox"
								style="width: 50; text-align: center" name="certTime"
								value="${certTime.certTime}" title="인증시간" maxbyte="4"
								onkeydown="javascript:onlyNumber();" maxlength="4" /> &nbsp; (초)</td>
							<th class="first">적용일시</th>
							<td class="first" width="220px">${certTime.certTimeStoreDate}</td>
							<td class="first"><a href="javascript:executeSaveCertTime();"
								onFocus="blur()"><img src="images/btn/btn_apply2.gif"
									border="0"></a></td>
						</tr>
					</table>
					<br></br>
					<table class="srvRegi">
						<img src="images/h3_ico.gif">
						<span>보안코드 관리</span>
						<br></br>
						<colgroup>
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<tr class="top">
							<th class="first">적용중인 보안코드</th>
							<td class="first" width="200px"><input type="text" name="securityCode"
								value="${securityCode.securityCode}" class="textbox"
								readonly="readonly" style="width: 200; text-align: center"
								maxlength="16" title="보안코드" minbyte="16" maxbyte="16"></td>
							<td class="first"><a href="javascript:createCode();" onFocus="blur()"><img
									src="images/btn/createcode.gif" border="0" style="cursor: hand"
									align="absmiddle"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
							<th class="first">적용일시</th>
							<td class="first" width="200px">${securityCode.securityCodeStoreDate}</td>
							<td class="first"><a href="javascript:executeSaveSecurityCode();"
								onFocus="blur()"><img src="images/btn/btn_apply1.gif"
									border="0"></a></td>
						</tr>
					</table>

					<br></br>
<!-- 					<table class="srvRegi"> -->
<!-- 						<img src="images/h3_ico.gif"> -->
<!-- 						<span>맵 버전 긴급 운영설정</span> -->
<!-- 						<font size="2" color="red">&nbsp;&nbsp;&nbsp;[ 설날 등 이벤트 -->
<!-- 							소통기간 동안의 트래픽 과부하에 대응하여 맵 다운로드를 skip 하는 RM 기능 ]</font> -->
<!-- 						<br></br> -->
<%-- 						<colgroup> --%>
<%-- 							<col width="100px" /> --%>
<%-- 							<col width="*" /> --%>
<%-- 						</colgroup> --%>
<!-- 						<tr class="top"> -->
<!-- 							<th class="first">맵 버전 긴급 운영설정</th> -->
<!-- 							<td class="first" width="200px"><input type="radio" name="mapVerCheck" id="mapVerCheck" -->
<!-- 								value="Y" -->
<%-- 								<c:if test="${rmVersionList.mapVerCheck == 'Y'}">checked="checked"</c:if>> --%>
<!-- 								사용 &nbsp;&nbsp; <input type="radio" name="mapVerCheck" -->
<!-- 								id="mapVerCheck" value="N" -->
<%-- 								<c:if test="${rmVersionList.mapVerCheck == 'N'}">checked="checked"</c:if>> --%>
<!-- 								미사용</td> -->
<!-- 							<th class="first" width="200px">적용일시</th> -->
<%-- 							<td class="first" width="220px">${rmVersionList.mapVerCheckDate}</td> --%>
<!-- 							<td class="first"><a href="javascript:showConfirm('mapVercheckImg');" -->
<!-- 								onFocus="blur()"><img src="images/btn/btn_apply2.gif" -->
<!-- 									border="0"></a></td> -->
<!-- 						</tr> -->
<!-- 					</table> -->

					<!-- 비밀번호 확인 화면 -->
		<%-- <div id="Confirm" style="height: 100%; width: 100%; position: absolute; top: 0px; left: 0px; display: none; z-index: 3; background-repeat: repeat; background-image: url(images/blink.png)" align="center">
						<table width="100%" align="center" height="100%" valign="middle">
							<tr>
								<td align="center" valign="middle">
									<table width="275" border="0" cellspacing="0" cellpadding="0"
										bgcolor="white">
										<tr>
											<td align="center" height="150">
												<table width="99%" height="50" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td style="font-size: 13; line-height: 140%"
															align="center"><b> 진행하시겠습니까? </b></td>
													</tr>
												</table>
												<table height="50" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td><img src="images/login_pw.gif"></td>
														<td>&nbsp; <input type="password" name="password"
															class="login" id="textfield2" style="width: 180"
															title="패스워드" maxByte="20" required
															onkeypress="javascript:if(event.keyCode==13) {execute();}" />
															<input type="hidden" name="userid" value="<s:property value="#session['ID']"/>" />
														</td>
													</tr>
												</table> 
												<img id="certtimeImg" src="images/btn/btn_apply2.gif"
												onclick="javascript:executeSaveCertTime();"
												style="cursor: hand;">&nbsp; <img id="securityImg"
												src="images/btn/btn_apply1.gif"
												onclick="javascript:executeSaveSecurityCode();"
												style="cursor: hand; display: none;">&nbsp; <img
												id="mapVercheckImg" src="images/btn/btn_apply2.gif"
												onclick="javascript:executeSaveMapVerCheck();"
												style="cursor: hand; display: none;">&nbsp; <img
												src="images/btn/close.gif"
												onclick="javascript:hideConfirm();" style="cursor: hand;">&nbsp;
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</div> --%>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />


		<%-- <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
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
              <!-- 인증시간관리 START -->
              <table width="100%" border="0" cellpadding="15" cellspacing="1" bgcolor="#FF8200">
                <tr>
                  <td valign="top" bgcolor="#FFFFFF" >
	                <table border="0" cellspacing="0" cellpadding="0">
	                    <tr>
	                      <td><img src="images/title/title52.gif"></td>
	                      <td width="30"></td>
	                    </tr>
	                    <tr>
	                      <td height="10"></td>
	                      <td></td>
	                      <td></td>
	                      <td></td>
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
	                          <td width="62">인증시간</td>
	                          <td width="90"><input type="text" class="textbox" style="width:30;text-align: center" name="certTime" value="${certTime.certTime}" title="인증시간" maxbyte="4" onkeydown="javascript:onlyNumber();" maxlength="4"/> (초)</td>
	                          <td width="170">적용일시 : ${certTime.certTimeStoreDate}</td>
	                          <td><a href="javascript:showConfirm('certtimeImg');" onFocus="blur()"><img src="images/btn/btn_apply2.gif" border="0"></a></td>
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
	              <!-- 인증시간관리 END -->
		              
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="50"></td>
                    </tr>
                  </table>
                  
              <!-- 보안코드관리 START -->
              <table width="100%" border="0" cellpadding="15" cellspacing="1" bgcolor="#FF8200">
                <tr>
                  <td valign="top" bgcolor="#FFFFFF" >
	                  <table border="0" cellspacing="0" cellpadding="0">
	                    <tr>
	                      <td><img src="images/title/title51.gif"></td>
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
	                            <td width="110">적용중인 보안코드</td>
	                            <td width="140"><input type="text" name="securityCode" value="${securityCode.securityCode}" class="textbox" readonly="readonly" style="width:130;text-align: center" maxlength="16" title="보안코드" minbyte="16" maxbyte="16" ></td>
	                            <td width="100"><a href="javascript:createCode();" onFocus="blur()"><img src="images/btn/createcode.gif" border="0" style="cursor:hand" align="absmiddle"></a></td>
	                            <td width="170">적용일시 : ${securityCode.securityCodeStoreDate}</td>
	                            <td><a href="javascript:showConfirm('securityImg');" onFocus="blur()"><img src="images/btn/btn_apply1.gif" border="0"></a></td>
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
	              <!-- 인증시간관리 END -->
	              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="50"></td>
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
</table> --%>

		<%--   <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="50"></td>
                    </tr>
                  </table>
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
</table> --%>


		<%-- <!-- 비밀번호 확인 화면 -->
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
									<input type="password" name="password" class="login" id="textfield2" style="width:180" title="패스워드" maxByte="20" required onkeypress="javascript:if(event.keyCode==13) {execute();}" />
									<input type="hidden" name="userid" value="<s:property value="#session['ID']"/>" />
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
</div> --%>
	</form>
</body>
</html>