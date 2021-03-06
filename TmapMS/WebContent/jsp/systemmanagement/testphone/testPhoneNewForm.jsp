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
<script language="JavaScript" src="../../../js/common.js"></script>
<script language="JavaScript" src="../../../js/script.js"></script>
<script type="text/javascript" src="../../../js/jquery.js"></script>
<script language="JavaScript" src="../../../js/formValidate.js"></script>
<script type="text/javascript">
	function save() {

		var re = /^[0-9]+$/;
		if (!re.test(testPhoneNumber.value)) {
			alert("전화번호는 숫자만 넣으셔야 합니다.");
			testPhoneNumber.value = "";
			testPhoneNumber.focus();
			return;
		}
		if (confirm("등록하시겠습니까?")) {
			ContentsForm.action = "testPhoneInsert.do";
			ContentsForm.submit();
		}
	}
</script>
</head>
<body>
	<form name="ContentsForm" method="post" id="ContentsForm">
			
		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table>
						<tr>
							<td width="590"><img src="images/h3_ico.gif"><span>테스트폰관리
									등록</span></td>
							<td class="btn"><a href="javascript:save();"
								onFocus="blur()"><img src="images/btn/btn_apply2.gif"
									border="0"></a> <a
								href="testPhoneList.do" onFocus="blur()"><img
									src="images/btn/btn_list.gif" border="0"></a></td>
						</tr>
					</table>
					<br>
					<table class="srvRegi">
						<colgroup>
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<tr>
							<th class="first">사용여부</th>
							<td class="first"><input type="radio" name="testPhoneState" checked="checked"
								value="Y" /> 사용&nbsp;&nbsp; <input type="radio"
								name="testPhoneState" value="N" /> 미사용
						</tr>
						<tr>
							<th>전화번호</th>
							<td><input type="text" name="testPhoneNumber" id="testPhoneNumber"
								class="textbox validate-req validate-digits"
								style="width: 620px" title="전화번호" maxByte="13" />
							</td>
						</tr>
						<tr>
							<th>비고</th>
							<td><input type="text" name="etc"
								style="width: 620px;" title="비고" /></td>
						</tr>
						<tr>
							<th>등록자명</th>
							<%-- <Label>${modifyInfo.userName}</Label> --%>
							<td><label name="writer">${sessionScope.userId}</label>
							<%-- <input type="text" name="userName" class="invisible"
								style="width: 200px" readonly="readonly"
								value="${modifyInfo.userName}" /> --%></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />


		<!-- <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="100%"><table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="10" background="../../../images/bg_bar.gif"></td>
        <td height="100%" valign="top" class="contents"><table width="100%" height="100%" border="0" cellspacing="0" cellpadding="20">
            <tr>
              <td valign="top" bgcolor="#FFFFFF">
              
              <div id="contents" style="width: 850px">
              <table border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td><img src="images/h3_ico.gif"><span>테스트폰관리 등록</span></td>
                    <td width="30"></td>
                  </tr>
                  <tr>
                    <td height="10"></td>
                    <td></td>
                    <td></td>
                    <td></td>
                  </tr>
                </table>
                  <table width="750" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td class="btn">
                      <a href="javascript:save();" onFocus="blur()"><img src="../../../images/btn/btn_apply2.gif"border="0"></a>
                      <a href="testPhoneList.do" onFocus="blur()"><img src="../../../images/btn/btn_list.gif" border="0"></a>
                      </td>
                    </tr>
                  </table>
                  <table width="750" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="../../../images/box1.gif"></td>
                    </tr>
                    <tr>
                      <td align="center" background="../../../images/box2.gif">
                      <table width="748" border="0" cellspacing="0" cellpadding="0">
                      	<tr>
                      		<td width="130" class="ttl4">사용여부</td>
                          	<td width="1" bgcolor="#f3961d"></td>
                          	<td width="10"></td>
                          	<td>
                            	<input type="radio" name="testPhoneState" value="Y"/> 사용함&nbsp;&nbsp;
                            	<input type="radio" name="testPhoneState" value="N" checked="checked"/> 사용안함 
                        </tr>
                        <tr>
                          	<td height="1" colspan="4" bgcolor="#f3961d"></td>
                        </tr>
                      </table>
                      <table width="748" border="0" cellspacing="0" cellpadding="0">
                      	<tr>
                            <td width="130" class="ttl4">전화번호</td>
                            <td width="1" bgcolor="#f3961d"></td>
                            <td align="center">
                            	<input type="text" name="testPhoneNumber"  class="textbox validate-req validate-digits" style="width:600px" title="전화번호" minByte="10" maxByte="13"/>
                            </td>
                        </tr>
                        <tr>
                          	<td height="1" colspan="4" bgcolor="#f3961d"></td>
                        </tr>
                      </table>
                      <table width="748" border="0" cellspacing="0" cellpadding="0">
                      	<tr>
                            <td width="130" class="ttl4">비고</td>
                            <td width="1" bgcolor="#f3961d"></td>
                            <td align="center">
                            	<textarea name="etc" rows="5" class="textbox" style="width:600; height:100" title="비고" maxByte="150"></textarea>
                            </td>
                        </tr>
                        <tr>
                          	<td height="1" colspan="4" bgcolor="#f3961d"></td>
                        </tr>
                      </table>
                      <table width="748" border="0" cellspacing="0" cellpadding="0">
                      	<tr>
                            <td width="130" class="ttl4">등록자명</td>
                            <td width="1" bgcolor="#f3961d"></td>
                            <td align="center">
                            	<input type="text" name="userName" class="invisible" style="width:555" readonly="readonly"/>
                            </td>
                        </tr>
                      </table>
                      </td>
                    </tr>
                    <tr>
                      <td><img src="../../../images/box3.gif"></td>
                    </tr>
                  </table>
                  </div>
                  </td>
            </tr>
        </table></td>
        <td width="10" background="../../../images/bg_bar.gif"></td>
      </tr>
      <tr></tr>
    </table></td>
  </tr>
</table> -->
	</form>
</body>
</html>