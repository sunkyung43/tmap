<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<script language="JavaScript" src="js/formValidate.js"></script>
<script type="text/javascript">
	function executeSave() {

		if (!validate()) {
			return;
		}

		if (confirm("적용하시겠습니까?")) {
			$.post("dsBandWidthUpdate.do", $("#ContentsForm").serialize(),
					function(data) {

						if (data.json.result == "success") {
							alert("적용완료 되었습니다.");
						} else {
							alert("적용실패 하였습니다.");
						}
						$("#ContentsForm").attr('action', 'dsBandWidth.do');
						$("#ContentsForm").submit();
					});

		}
	}
</script>
</head>
<body>
	<form:form commandName="ContentsForm">
		<table>
			<tr>
				<td width="680"><img src="images/h3_ico.gif"> <span>&nbsp; DS
						세션설정</span></td>
				<td><a href="javascript:executeSave();" onFocus="blur()"><img
						src="images/btn/btn_apply6.gif"></a></td>
			</tr>
		</table>
		<br>
		<table class="srvRegi">
			<colgroup>
				<col width="100px" />
				<col width="*" />
			</colgroup>
			<tr>
				<th class="first" style="text-align: center;">세션 유지시간</th>
				<td class="first"><input type="text"
					class="textbox validate-req" name="sessionMaxIdletime"
					title="세션 유지 시간" style="width: 80px" value=""> &nbsp; 초</td>
				<!-- </tr>
			<tr> -->
				<th class="first" style="text-align: center;">세션별 최대
					<p></p>대역폭
				</th>
				<td class="first"><input type="text"
					class="textbox validate-req" name="sessionMaxBandwidth"
					title="세션 유지 시간" style="width: 80px" value=""> &nbsp; Mbps</td>
				<!-- </tr>
			<tr> -->
				<th class="first" style="text-align: center;">전체 대역폭</th>
				<td class="first"><input type="text"
					class="textbox validate-req" name="totalMaxBandwidth"
					title="전체 대역폭" style="width: 80px" value=""> &nbsp; Mbps</td>
			</tr>
		</table>





















		<%-- <div id="contents">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="ttl7">[DS대역폭설정]</td>
					<td class="btn"><a href="javascript:executeSave();"
						onFocus="blur()"><img src="images/btn/btn_apply6.gif"
							border="0"></a></td>
				</tr>

			</table>
			<table width="100%" border="0" cellspacing="1" cellpadding="1"
				bgcolor="#FF8200">
				<tr>
					<td width="18%" height="40" bgcolor="#FFFFFF" class="ttl"
						style="font-size: 15;">세션 유지 시간</td>
					<td width="15%" bgcolor="#FFFFFF">&nbsp; <input type="text"
						class="textbox validate-req" name="sessionMaxIdletime"
						title="세션 유지 시간" style="width: 60%"
						value="${dsBandWidth.sessionMaxIdletime}"> 초
					</td>
					<td width="18%" bgcolor="#FFFFFF" class="ttl"
						style="font-size: 15;">세션별 최대 대역폭</td>
					<td width="15%" bgcolor="#FFFFFF">&nbsp; <input type="text"
						class="textbox validate-req" name="sessionMaxBandwidth"
						title="세션별 최대 대역폭" style="width: 60%"
						value="${dsBandWidth.sessionMaxBandwidth}"> Mbps
					</td>
					<td width="18%" bgcolor="#FFFFFF" class="ttl"
						style="font-size: 15;">전체 대역폭</td>
					<td width="15%" bgcolor="#FFFFFF">&nbsp; <input type="text"
						class="textbox validate-req" name="totalMaxBandwidth"
						title="전체 대역폭" style="width: 60%"
						value="${dsBandWidth.totalMaxBandwidth}"> Mbps
					</td>
				</tr>
			</table>
		</div> --%>
	</form:form>
</body>
</html>