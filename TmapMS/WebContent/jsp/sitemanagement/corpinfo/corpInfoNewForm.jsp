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
<script language="JavaScript" src="js/common.js"></script>
<script language="JavaScript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script language="JavaScript" src="js/formValidate.js"></script>
<script>
	
	function save() {

		if(!validate()){
            return;
        }
		
		if(confirm("등록하시겠습니까?")){
			ContentsForm.action="corpInfoInsert.do";
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
							<td width="590"><img src="images/h3_ico.gif"><span>업체 등록</td>
							<td class="btn"><a href="javascript:save();"
								onFocus="blur()"><img src="images/btn/btn_apply2.gif"
									border="0"></a> <a href="corpInfoList.do" onFocus="blur()"><img
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
							<th class="first">회사명</th>
							<td class="first"><input type="text" name="corpName"
								class="textbox validate-req" style="width: 620px" title="회사명"
								maxlength="150" /></td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td><input type="text" name="corpTel"
								class="textbox validate-req validate-digits"
								style="width: 620px" title="전화번호" maxlength="13" /></td>
						</tr>
						<tr>
							<th>관리자</th>
							<td><input type="text" name="corpCeoName"
								class="textbox validate-req" style="width: 620px" title="관리자"
								maxlength="50" /></td>
						</tr>
						<tr>
							<th>업체</th>
							<td><input type="text" name="corpBusinessType"
								class="textbox" style="width: 620px" maxlength="100" /></td>
						</tr>
						<tr>
							<th>주소</th>
							<td><input type="text" name="corpAdd" class="textbox"
								style="width: 620px" maxlength="250" /></td>
						</tr>
						<tr>
							<th>사용여부</th>
							<td>
							<input type="radio" name="corpUseState"
								value="Y" checked="checked"/>	
								사용&nbsp;&nbsp; <input type="radio" name="corpUseState"
								value="N"/>
								미사용
							</td>
						</tr>
					</table>
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
              <table border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td><img src="images/h3_ico.gif"><span>업체 등록</td>
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
                      <a href="javascript:save();" onFocus="blur()"><img src="images/btn/btn_apply2.gif" border="0"></a>
                      <a href="corpInfoList.do" onFocus="blur()"><img src="images/btn/btn_list.gif" border="0"></a>
                      </td>
                    </tr>
                  </table>
                  <table width="750" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="images/box1.gif"></td>
                    </tr>
                    <tr>
                      <td align="center" background="images/box2.gif"><table width="748" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="150" class="ttl4">회사명</td>
                            <td width="1" bgcolor="#f3961d"></td>
                            <td width="10"></td>
                            <td><input type="text" name="corpName" class="textbox validate-req" style="width:580px" title="회사명" maxlength="150" /></td>
                          </tr>
                          <tr>
                            <td height="1" colspan="4" bgcolor="#f3961d"></td>
                          </tr>
                        </table>
                          <table width="748" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td width="150" class="ttl4">전화번호</td>
                              <td width="1" bgcolor="#f3961d"></td>
                              <td width="10"></td>
                              <td><input type="text" name="corpTel" class="textbox validate-req validate-digits" style="width:580px" title="전화번호" maxlength="13" /></td>
                            </tr>
                            <tr>
                              <td height="1" colspan="4" bgcolor="#f3961d"></td>
                            </tr>
                          </table>
                          <table width="748" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td width="150" class="ttl4">관리자</td>
                              <td width="1" bgcolor="#f3961d"></td>
                              <td width="10"></td>
                              <td><input type="text" name="corpCeoName" class="textbox validate-req" style="width:580px" title="관리자" maxlength="50" /></td>
                            </tr>
                            <tr>
                              <td height="1" colspan="4" bgcolor="#f3961d"></td>
                            </tr>
                          </table>
                          <table width="748" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td width="150" class="ttl4">업태</td>
                              <td width="1" bgcolor="#f3961d"></td>
                              <td width="10"></td>
                              <td><input type="text" name="corpBusinessType" class="textbox" style="width:580px" maxlength="100" /></td>
                            </tr>
                            <tr>
                              <td height="1" colspan="4" bgcolor="#f3961d"></td>
                            </tr>
                          </table>
                          <table width="748" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td width="150" class="ttl4">주소</td>
                              <td width="1" bgcolor="#f3961d"></td>
                              <td width="10"></td>
                              <td><input type="text" name="corpAdd" class="textbox" style="width:580px" maxlength="250" /></td>
                            </tr>
                            <tr>
                              <td height="1" colspan="4" bgcolor="#f3961d"></td>
                            </tr>
                          </table>
                          <table width="748" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td width="150" class="ttl4">사용여부</td>
                              <td width="1" bgcolor="#f3961d"></td>
                              <td width="10"></td>
                              <td>
                              <select name="corpUseState" style="width:100px;" class="textbox" >
									<option value="Y">사용</option>
									<option value="N">미사용</option>
							  </select>
							  </td>
                            </tr>
                          </table>
                         </td>
                    </tr>
                    <tr>
                      <td><img src="images/box3.gif"></td>
                    </tr>
                  </table>
              </div>      
              </td>
            </tr>
        </table></td>
        <td width="10" background="images/bg_bar.gif"></td>
      </tr>
      <tr></tr>
    </table></td>
  </tr>
  <tr>
    <td height="10"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="10"><img src="images/bottom_bg1.gif"></td>
        <td width="100%" background="images/bottom_bg2.gif"></td>
        <td width="10"><img src="images/bottom_bg3.gif"></td>
      </tr>
    </table></td>
  </tr>
  <tr>
  	<td><jsp:include page="../../common/footer.jsp" /></td>
  </tr>
</table> --%>
	</form>
</body>
</html>