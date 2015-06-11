<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
<script type="text/javascript">
	// 아이피 정보가 수정됐는지 여부 구분하기
	var isEdit = false;

	//아이피 적용하기
	function save() {

		makeNotAllowIps();

		if (confirm("적용하시겠습니까?")) {
			$.post("ipFilterUpdate.do", $("#ContentsForm").serialize(),
					function(data) {

						if (data.json.result == "success") {
							alert("적용완료 되었습니다.");
						} else {
							alert("적용실패 하였습니다.");
						}
						$("#ContentsForm").attr('action', 'ipFilter.do');
						$("#ContentsForm").submit();
					});

		}

	}

	function checkLength(obj, nextObj) {
		if (obj == undefined || nextObj == undefined) {
			return;
		}

		if (obj.value.length > 2) {
			nextObj.focus();
		}
	}

	function checkIp(ipType) {
		if (ipType == undefined) {
			return true;
		}

		var form = document.ContentsForm;
		var ip = form.ip;
		var obj;
		var objName = 'form.ip2_';

		//초기화
		ip.value = '';

		//ip에 담기
		if (ipType == 'saveIp') {
			objName = 'form.ip1_';
		}

		for ( var i = 1; i < 5; i++) {
			obj = eval(objName + i);
			//숫자
			var pattern = /^[0-9]+$/;
			if (!pattern.test(obj.value)) {
				alert('IP가 적절하지 않습니다.');
				obj.focus();
				return true;
			}

			//자리수
			if (obj.value.length < 1) {
				alert('IP가 적절하지 않습니다.');
				obj.focus();
				return true;
			}
			//입력값
			if (obj.value > 255) {
				alert('IP가 유효하지 않습니다.');
				obj.focus();
				return true;
			}

			ip.value += obj.value;
			if (i < 4) {
				ip.value += '.';
			}

			if (i > 4 && (objName == 'form.ip3_' || objName == 'form.ip1_')) {
				break;
			}

			if (i > 3 && objName == 'form.ip2_') {
				objName = 'form.ip3_';
				i = 0;
				ip.value += '-';
			}
		}
	}

	function initIpForms() {
		var form = document.ContentsForm;
		for ( var i = 1; i < 5; i++) {
			for ( var j = 1; j < 4; j++) {
				obj = eval("form.ip" + j + "_" + i);
				obj.value = "";
			}
		}
	}

	function executeSaveIps(ipType) {
		if (checkIp(ipType))
			return;
		isEdit = true;
		var form = document.ContentsForm;
		var ipList = form.notAllowIPs;

		var addOption = document.createElement("OPTION");
		ipList.options.add(addOption);
		addOption.innerHTML = form.ip.value;
		addOption.value = form.ip.value;
		initIpForms();
	}

	function deleteNotAllowIp() {
		isEdit = true;
		var form = document.ContentsForm;
		var ipList = form.notAllowIPs;
		var index = ipList.selectedIndex;
		if (ipList.value == '') {
			alert('선택된 IP가 없습니다.');
			return;
		}
		if (confirm('선택된 제한된 IP를 삭제하시겠습니까?')) {
			ipList.remove(index);
		}
	}

	function makeNotAllowIps() {
		var form = document.ContentsForm;
		var ipList = form.notAllowIPs;

		for ( var i = 0; i < ipList.options.length; i++) {
			var addOption = document.createElement('input');
			addOption.setAttribute('type', 'hidden');
			addOption.setAttribute('value', ipList.options[i].value);
			addOption.setAttribute('name', 'notAllowIpList');
			addOption.setAttribute('id', 'notAllowIpList');

			form.appendChild(addOption);
		}
	}
</script>
</head>
<body>
	<form:form commandName="ContentsForm" id="ContentsForm"
		name="ContentsForm">
		<input type="hidden" name="ip" />
		<table>
			<tr>
				<td width="680"><img src="images/h3_ico.gif"> <span>&nbsp; IP 설정</span></td>
			</tr>
		</table>
		<br>
		<table class="srvRegi">
			<colgroup>
				<col width="100px" />
				<col width="*" />
			</colgroup>
			<tr>
				<th class="first">제한 할 IP</th>
				<td class="first"><select name="notAllowIPs" style="width: 260;"
					multiple="multiple" size="5">
						<c:forEach var="list" items="${ipFilter}">
							<option value="${list.ipFilter}">${list.ipFilter}</option>
						</c:forEach>
				</select>&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:save();"
					onFocus="blur()"><img src="images/btn/btn_apply6.gif"
						border="0"></a></td>
			</tr>
			<tr>
				<th>IP주소</th>
				<td><input type="text" class="textbox" style="width: 45"
					name="ip1_1" maxlength="3"
					onkeyup="javascript:checkLength(this, ip1_2);"
					onkeydown="javascript:onlyNumber();" /> . <input type="text"
					class="textbox" style="width: 45" name="ip1_2" maxlength="3"
					onkeyup="javascript:checkLength(this, ip1_3);"
					onkeydown="javascript:onlyNumber();" /> . <input type="text"
					class="textbox" style="width: 45" name="ip1_3" maxlength="3"
					onkeyup="javascript:checkLength(this, ip1_4);"
					onkeydown="javascript:onlyNumber();" /> . <input type="text"
					class="textbox" style="width: 45" name="ip1_4" maxlength="3"
					onkeyup="javascript:checkLength(this, this);"
					onkeydown="javascript:onlyNumber();" /> &nbsp;&nbsp;&nbsp; <a
					href="javascript:executeSaveIps('saveIp');" onFocus="blur()"><img
						src="images/btn/apply7.gif" border="0" align="absmiddle"
						name="saveIp"></a>&nbsp;&nbsp;*사용가능 &nbsp;&nbsp;<font
					color="red">[접속제한 IP 등록]</font></td>
			</tr>
			<tr>
				<th>IP주소대역</th>
				<td><input type="text" class="textbox" style="width: 45"
					name="ip2_1" maxlength="3"
					onkeyup="javascript:checkLength(this, ip2_2);"
					onkeydown="javascript:onlyNumber();" /> . <input type="text"
					class="textbox" style="width: 45" name="ip2_2" maxlength="3"
					onkeyup="javascript:checkLength(this, ip2_3);"
					onkeydown="javascript:onlyNumber();" /> . <input type="text"
					class="textbox" style="width: 45" name="ip2_3" maxlength="3"
					onkeyup="javascript:checkLength(this, ip2_4);"
					onkeydown="javascript:onlyNumber();" /> . <input type="text"
					class="textbox" style="width: 45" name="ip2_4" maxlength="3"
					onkeyup="javascript:checkLength(this, ip3_1);"
					onkeydown="javascript:onlyNumber();" /> - <input type="text"
					class="textbox" style="width: 45" name="ip3_1" maxlength="3"
					onkeyup="javascript:checkLength(this, ip3_2);"
					onkeydown="javascript:onlyNumber();" /> . <input type="text"
					class="textbox" style="width: 45" name="ip3_2" maxlength="3"
					onkeyup="javascript:checkLength(this, ip3_3);"
					onkeydown="javascript:onlyNumber();" /> . <input type="text"
					class="textbox" style="width: 45" name="ip3_3" maxlength="3"
					onkeyup="javascript:checkLength(this, ip3_4);"
					onkeydown="javascript:onlyNumber();" /> . <input type="text"
					class="textbox" style="width: 45" name="ip3_4" maxlength="3"
					onkeyup="javascript:checkLength(this, this);"
					onkeydown="javascript:onlyNumber();" /> &nbsp;&nbsp;&nbsp; <a
					href="javascript:executeSaveIps('saveIpBandwidth');"
					onFocus="blur()"><img src="images/btn/apply7.gif" border="0"
						align="absmiddle" name="saveIpBandwidth"></a></td>
			</tr>
		</table>








		<%-- <div id="contents">
			<table width="700" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="ttl7">[제한IP설정]</td>
					<td class="btn"><a href="javascript:save();" onFocus="blur()"><img
							src="images/btn/btn_apply6.gif" border="0"></a></td>
				</tr>
			</table>
			<table width="700" border="0" cellspacing="0" cellpadding="0">
				<!-- <tr>
	   		<td><img src="images/box1.gif"></td>
	   	</tr>
	   	<tr>
	   		<td align="center" background="images/box2.gif">
      		<table width="746" border="0" cellspacing="0" cellpadding="0"> -->
				<tr>
					<td width="184" class="ttl3"><B>제한 할 IP</B></td>
					<td width="1" bgcolor="#f3961d"></td>
					<td class="ttl4">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><span style="padding: 5 5 5 5"> <select
										name="notAllowIPs" style="width: 260;" multiple="multiple"
										size="5">
											<c:forEach var="list" items="${ipFilter}">
												<option value="${list.ipFilter}">${list.ipFilter}</option>
											</c:forEach>
									</select>
								</span></td>
								<td align="center" valign="bottom"><a
									href="javascript:deleteNotAllowIp();" onFocus="blur()"><img
										src="images/btn/mapdown1.gif" border="0"></a>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table width="746" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="1" bgcolor="#f3961d"></td>
				</tr>
				<tr>
					<td class="ttl4"><B>접속제한 IP 등록하기</B></td>
				</tr>
				<tr>
					<td height="1" bgcolor="#f3961d"></td>
				</tr>
			</table>
			<table width="746" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="198" class="ttl3"><B>IP주소</B></td>
					<td width="1" bgcolor="#f3961d"></td>
					<td width="10"></td>
					<td align="left" class="ttl5"><input type="text"
						class="textbox" style="width: 45" name="ip1_1" maxlength="3"
						onkeyup="javascript:checkLength(this, ip1_2);"
						onkeydown="javascript:onlyNumber();" /> . <input type="text"
						class="textbox" style="width: 45" name="ip1_2" maxlength="3"
						onkeyup="javascript:checkLength(this, ip1_3);"
						onkeydown="javascript:onlyNumber();" /> . <input type="text"
						class="textbox" style="width: 45" name="ip1_3" maxlength="3"
						onkeyup="javascript:checkLength(this, ip1_4);"
						onkeydown="javascript:onlyNumber();" /> . <input type="text"
						class="textbox" style="width: 45" name="ip1_4" maxlength="3"
						onkeyup="javascript:checkLength(this, this);"
						onkeydown="javascript:onlyNumber();" /> &nbsp;&nbsp;&nbsp; <a
						href="javascript:executeSaveIps('saveIp');" onFocus="blur()"><img
							src="images/btn/apply7.gif" border="0" align="absmiddle"
							name="saveIp"></a>&nbsp;&nbsp;*사용가능</td>
				</tr>
				<tr>
					<td height="1" colspan="4" bgcolor="#f3961d"></td>
				</tr>
			</table>
			<table width="746" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="198" class="ttl3"><B>IP주소대역</B></td>
					<td width="1" bgcolor="#f3961d"></td>
					<td width="10"></td>
					<td class="ttl5"><input type="text" class="textbox"
						style="width: 45" name="ip2_1" maxlength="3"
						onkeyup="javascript:checkLength(this, ip2_2);"
						onkeydown="javascript:onlyNumber();" /> . <input type="text"
						class="textbox" style="width: 45" name="ip2_2" maxlength="3"
						onkeyup="javascript:checkLength(this, ip2_3);"
						onkeydown="javascript:onlyNumber();" /> . <input type="text"
						class="textbox" style="width: 45" name="ip2_3" maxlength="3"
						onkeyup="javascript:checkLength(this, ip2_4);"
						onkeydown="javascript:onlyNumber();" /> . <input type="text"
						class="textbox" style="width: 45" name="ip2_4" maxlength="3"
						onkeyup="javascript:checkLength(this, ip3_1);"
						onkeydown="javascript:onlyNumber();" /> - <input type="text"
						class="textbox" style="width: 45" name="ip3_1" maxlength="3"
						onkeyup="javascript:checkLength(this, ip3_2);"
						onkeydown="javascript:onlyNumber();" /> . <input type="text"
						class="textbox" style="width: 45" name="ip3_2" maxlength="3"
						onkeyup="javascript:checkLength(this, ip3_3);"
						onkeydown="javascript:onlyNumber();" /> . <input type="text"
						class="textbox" style="width: 45" name="ip3_3" maxlength="3"
						onkeyup="javascript:checkLength(this, ip3_4);"
						onkeydown="javascript:onlyNumber();" /> . <input type="text"
						class="textbox" style="width: 45" name="ip3_4" maxlength="3"
						onkeyup="javascript:checkLength(this, this);"
						onkeydown="javascript:onlyNumber();" /> &nbsp;&nbsp;&nbsp; <a
						href="javascript:executeSaveIps('saveIpBandwidth');"
						onFocus="blur()"><img src="images/btn/apply7.gif" border="0"
							align="absmiddle" name="saveIpBandwidth"></a></td>
				</tr>
			</table>
			<!-- 	</td>
		</tr>
		<tr>
			<td><img src="images/box3.gif"></td>
		</tr>
	</table> -->
		</div> --%>
	</form:form>
</body>
</html>