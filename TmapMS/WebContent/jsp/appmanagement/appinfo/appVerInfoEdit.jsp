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
<script type="text/javascript" src="js/formValidate.js"></script>
<script type="text/javascript">
	//수정
	function save() {
	
		if(!validate()){
	        return;
	    }
		
		if( confirm("수정하시겠습니까?")){
			ContentsForm.action="appVerUpdate.do";
			ContentsForm.submit();
		}
	}
	
	//삭제
	function del() {
		 
		if( confirm("삭제하시겠습니까?")){
			ContentsForm.action="appVerDelete.do";
			ContentsForm.submit();
		}
	}
</script>
</head>
<body>
<form name="ContentsForm" method="post" id="ContentsForm">
<input type="hidden" name="appVerId" value="${appVerInfo.appVerId}">
<input type="hidden" name="appInfoSeq" value="${appVerInfo.appInfoSeq}">
<div id="contents" style="position: absolute;">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="ttl7">[버전 정보 수정]</td>
			<td align="right" style="padding:0 0 5 0">
			<a href="javascript:save();" onFocus="blur()"><img src="images/btn/modify7.gif" border="0"></a>
            <a href="javascript:del();" onFocus="blur()"><img src="images/btn/delete7.gif" border="0"></a>
			<a href="appVerInfoList.do?appInfoSeq=${appVerInfo.appInfoSeq}" onFocus="blur()"><img src="images/btn/btn_list.gif" border="0"></a>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" background="images/box385_2.gif">
		<tr>
			<td><img src="images/box385_1.gif" /></td>
		</tr>
		<tr>
			<td align="center">
				<table width="99%" border="0" cellspacing="0" cellpadding="0">
					<tr>
	                    <td width="113" height="5" class="ttl4">버전</td>
	                    <td width="1" bgcolor="#f3961d"></td>
	                    <td width="5"></td>
	                    <td class="ttl4">
	                    <input type="text" name="appVerName" class="invisible" style="width:95%; ime-mode:disabled;" value="${appVerInfo.app_ver_name}" readonly="readonly"/>
	                    </td>
	                    <td width="5"></td>
	                </tr>
					<tr>
						<td height="1" colspan="4" bgcolor="#f3961d"></td>
					</tr>
				</table>
				<table width="99%" border="0" cellspacing="0" cellpadding="0">
					<tr>
                        <td width="113" height="15" class="ttl4">사용여부</td>
                        <td width="1" bgcolor="#f3961d"></td>
                        <td width="5"></td>
                        <td class="ttl5">
                          <input type="radio" name="app_ver_state" value="Y" <c:if test="${appVerInfo.app_ver_state == 'Y'}">checked="checked"</c:if>/> 사용 &nbsp;&nbsp;
                          <input type="radio" name="app_ver_state" value="N" <c:if test="${appVerInfo.app_ver_state == 'N'}">checked="checked"</c:if>/> 미사용
                        </td>
                        <td width="5"></td>
                    </tr>
					<tr>
						<td height="1" colspan="4" bgcolor="#f3961d"></td>
					</tr>
				</table>
				<table width="99%" border="0" cellspacing="0" cellpadding="0">
					<tr>
		                <td width="113" class="ttl4">내용</td>
		                <td width="1" bgcolor="#f3961d"></td>
		                <td width="5"></td>
		                <td class="ttl4">
		                <textarea name="app_ver_content" rows="5" class="textbox" style="width:95%; height:40" title="내용">${appVerInfo.app_ver_content}</textarea>
		                </td>
		                <td width="5"></td>
		            </tr>
		            <tr>
						<td height="1" colspan="4" bgcolor="#f3961d"></td>
					</tr>
				</table>
				<table width="99%" border="0" cellspacing="0" cellpadding="0">
					<tr>
	                    <td width="113" height="5" class="ttl4">등록일</td>
	                    <td width="1" bgcolor="#f3961d"></td>
	                    <td width="5" ></td>
	                    <td class="ttl5">${appVerInfo.app_ver_sdate}</td>
	                    <td width="5"></td>
	                </tr>
				</table>
			</td>
		</tr>
		<tr>
		<td><img src="images/box385_3.gif" /></td>
		</tr>
	</table>
</div>
</form>
</body>
</html>