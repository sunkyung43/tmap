<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<link type="text/css" rel="stylesheet" href="css/jquery.stepy.css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/formValidate.js"></script>
<script type="text/javascript" src="js/jquery.stepy.min.js"></script>
<script type="text/javascript">

	//중복체크 버튼 클릭 여부
	var checkValueName = "";

	//이벤트 등록
	$(document).ready(function() {

		$("#stepContainer").stepy({
			back : function(index) {
			},
			next : function(index) {
				excute(index);
				return false;
			},
			select : function(index) {
			},
			finish : function(index) {
				executeSave();
			},
			titleClick : false,
			backLabel : '< 이전',
			nextLabel:'다음 >'
		});

		//서버명 중복 체크
		$("#anchNameDup").click(function() {
			checkValueName = "T";
			processNameDuplication();
		});

		$("#serverTypeCode").change(function() {
			selectServer($("#serverTypeCode > option:selected").text());
		});

	});

	//통식방식명 중복 체크
	function processNameDuplication() {

		//아이디 유효성 검증
		if ($("#systemName").val() == "") {
			alert("서버명을 입력하세요.");
			$("#systemName").val("");
			$("#systemName").focus();
			return;
		}

		//검증조건 값 할당
		$("#checkSystemName").val($("#systemName").val());
		//호출 및 메시지 출력
		$.post("processNameDuplication.do", $("#ContentsForm").serialize(),
				function(data) {

					if (data.json.checkName == "success") {
						alert("사용하실 수 있는 서버명 입니다.");
					} else {
						alert("사용하실 수 없는 서버명 입니다.");
					}
				});
	}

	function excute(index) {
		if (index == 2) {
			if (checkValueName != "T") {
				alert("서버명 중복체크를 하세요.");
				$("#anchNameDup").focus();
				return;
			}
			if (ContentsForm.serverTypeCode.value == "서버구분") {
				alert("서버를 선택하세요.");
				return;
			}

			var re = /^[0-9]+$/;
			if (!re.test(systemMemory.value)) {
				alert("메모리 정보는 숫자만 넣으셔야 합니다.");
				systemMemory.value = "";
				systemMemory.focus();
				return;
			}
			if (!re.test(systemCpuCount.value)) {
				alert("CPU 갯수는 숫자만 넣으셔야 합니다.");
				systemCpuCount.value = "";
				systemCpuCount.focus();
				return;
			}
			$('#stepContainer').stepy('step', 2);
		}
		if (index == 3) {
			var re = /^(1|2)?[0-9]?[0-9]([.](1|2)?[0-9]?[0-9]){3}$/;
			var portcheck = /^[0-9]+$/;
			if (!re.test(systemIpOut.value)) {
				alert("올바른 IP를 입력해주세요.");
				systemIpOut.value = "";
				systemIpOut.focus();
				return;
			}
			if (!portcheck.test(systemPortOut.value)) {
				alert("숫자만 입력가능합니다.");
				systemPortOut.value = "";
				systemPortOut.focus();
				return;
			}
			if (!re.test(systemIpIn.value)) {
				alert("올바른 IP를 입력해주세요.");
				systemIpIn.value = "";
				systemIpIn.focus();
				return;
			}
			if (!portcheck.test(systemPortIn.value)) {
			  alert("숫자만 입력가능합니다.");
				systemPortIn.value = "";
				systemPortIn.focus();
				return;
			}
			$('#stepContainer').stepy('step', 3);
		}
		if (index == 4) {

			$('#stepContainer').stepy('step', 4);
		}
	}

	function selectServer(serverTypeName) {
		if (serverTypeName == 'DS') {
			$("#com_tr").hide();
			$("#mds_tr").hide();
			$("#mdmiTbl tr:gt(1)").show();
			$("#comTypeTbl tr:gt(1)").show();
		} else {
			$("#comTypeTbl tr:gt(1)").hide();
			$("#com_tr").show();
			$("#mdmiTbl tr:gt(1)").hide();
			$("#mds_tr").show();
		}
	}

	function selected(comTypeId) {
		if ($("#comTypeCodes" + comTypeId).is(':checked')) {
			$("#comSetCnt" + comTypeId).removeClass("invisible");
			$("#comSetCnt" + comTypeId).addClass("textbox validate-req");
			$("#comSetCnt" + comTypeId).removeAttr("readonly");
		} else {
			$("#comSetCnt" + comTypeId).removeClass("textbox validate-req");
			$("#comSetCnt" + comTypeId).addClass("invisible");
			$("#comSetCnt" + comTypeId).attr("readonly", "readonly");
			$("#comSetCnt" + comTypeId).val("");
		}
	}

	function executeSave() {

		var typeName = $("#serverTypeCode > option:selected").text();
		$("#serverTypeName").val(typeName);
		//     if (!validate()) {
		//       return;
		//     }

		if (confirm("등록하시겠습니까?")) {

			$.post("systemInfoInsert.do", $("#ContentsForm").serialize(),
					function(data) {

						if (data.json.systemInfoInsert == "success") {
							alert("등록 되었습니다.");
						} else {
							alert("등록실패 하였습니다.");
						}
						//$("#systemId").val(data.json.systemId);
// 						$("#ContentsForm").attr('action', 'systemInfoList.do');
// 						$("#ContentsForm").submit();
						location.replace('systemInfoList.do');
					});
		}
	}
	
</script>
</head>
<body>
	<form:form commandName="ContentsForm" id="ContentsForm"
		name="ContentsForm">
		<form:hidden path="checkSystemName" />
		<form:hidden path="serverTypeName" />
		<form:hidden path="systemId" />
		<jsp:include page="../../common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<img src="images/h3_ico.gif">
						<span>서버 기기 관리 등록</span>
					<div id="stepContainer">
						<fieldset title="Step 1">
							<legend style="display: none;">서버 정보 입력</legend>
							<table class="srvRegi">
								<colgroup>
									<col width="100px" />
									<col width="*" />
								</colgroup>
								<tr>
									<th>서버명</th>
									<td>
										<input type="text" id="systemName" name="systemName" value="" title style="width: 530px" class="regiInput validate-req" required="required" maxlength="50" /> 
											<a id="anchNameDup"> 
												<img src="images/btn/checkid.gif" align="absmiddle" style="cursor: hand">
											</a>
											<label style="color: red;">*</Label>
									</td>
								</tr>
								<tr>
									<th>서버구분</th>
									<td>
										<select name="serverTypeCode" id="serverTypeCode" title="서버구분">
											<option>서버구분</option>
											<c:forEach var="list" items="${serverType}">
												<option value="${list.code}">${list.codeName}</option>
											</c:forEach>
										</select>
										<label style="color: red;"> * 통신방식 설정의 경우 'DS' 에서만 제공됩니다.</Label>
									</td>
								</tr>
								<tr>
									<th>Memory정보</th>
									<td>
										<input type="text" id="systemMemory" name="systemMemory" value="" title="Memory정보" style="width: 560px" class="regiInput">&nbsp; MB 
											<label style="color: red;">*</Label>
									</td>
								</tr>
								<tr>
									<th>CPU갯수</th>
									<td>
										<input type="text" id="systemCpuCount" name="systemCpuCount" value="" title="CPU갯수" style="width: 560px" class="regiInput">&nbsp; 개 
											<label style="color: red;">*</Label>
									</td>
								</tr>
								<tr>
									<th>사용여부</th>
									<td>
										<input type="radio" name="systemState" value="Y" title="" required="required" checked="checked"> 사용&nbsp;&nbsp;&nbsp; 
										<input type="radio" name="systemState" value="N" title="" required="required"> 미사용 
											<label style="color: red;">*</Label>
									</td>
								</tr>
							</table>
						</fieldset>
						<fieldset title="Step 2">
							<legend style="display: none">IP/Port 정보 입력</legend>
							<table class="srvRegi">
								<colgroup>
									<col width="100px" />
									<col width="*" />
								</colgroup>
								<tr>
									<th>IP정보 (외부)</th>
									<td>
										<input type="text" id="systemIpOut" name="systemIpOut" value="" title="" IP정보(외부)" style="width: 590px" class="regiInput">
											<label style="color: red;">*</Label>
									</td>
								</tr>
								<tr>
									<th>Port정보 (외부)</th>
									<td>
										<input type="text" id="systemPortOut" name="systemPortOut" value="" title="Memory정보" style="width: 590px" class="regiInput">
											<label style="color: red;">*</Label></td>
								</tr>
								<tr>
									<th>IP정보 (내부)</th>
									<td>
										<input type="text" id="systemIpIn" name="systemIpIn" value="" title="Memory정보" style="width: 590px" class="regiInput">
											<label style="color: red;">*</Label>
									</td>
								</tr>
								<tr>
									<th>Port정보 (내부)</th>
									<td>
										<input type="text" id="systemPortIn" name="systemPortIn" value="" title="Memory정보" style="width: 590px" class="regiInput">
											<label style="color: red;">*</Label>
									</td>
								</tr>
								<tr>
									<th>내용</th>
									<td>
										<input type="text" id="etc" name="etc" value="" maxlength="200" title="Memory정보" style="width: 590px" class="regiInput">
									</td>
								</tr>
							</table>
						</fieldset>
						<fieldset title="Step 3">
							<legend style="display: none">DS/RS 설정</legend>
							<br>
							<span>
								<h3>
									<img src="images/h3_ico.gif">&nbsp; 통신방식
								</h3>
							</span>
							<table class="sub_0601_table" id="comTypeTbl">
								<colgroup>
									<col width="9%">
									<col width="*">
									<col width="40%">
								</colgroup>
								<tbody>
									<tr>
										<th>번호</th>
										<th>통신방식명</th>
										<th>동시접속자수</th>
									</tr>
									<tr id="com_tr">
										<td colspan="3" class="td03" style="color: red;">
											<h2>* 통신방식의 경우 서버타입이 'DS' 일 경우만 설정 가능합니다.</h2>
										</td>
									</tr>
									<c:choose>
										<c:when test="${empty comSetInfo}">
											<c:forEach var="list" items="${comType}" varStatus="state">
												<tr>
													<td class="td03">
														<input class="td04" type="text" name="comTypeCodes" class="reg_input" style="width: 15px" value="${list.code}" readonly="readonly" />
													</td>
													<td class="td03">${list.codeName}</td>
													<td class="td03">
														<input type="text" name="comSetCnts" class="reg_input" style="width: 110px" value="0" />명
													</td>
												</tr>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<c:forEach var="list" items="${comSetInfo}" varStatus="state">
												<tr>
													<td class="td03">
														<input class="td04" type="text" name="comTypeCodes" class="reg_input" style="width: 15px" value="${list.comTypeCode}" readonly="readonly" />
													</td>
													<td class="td03">${list.comTypeName}</td>
													<td class="td03">
														<input type="text" name="comSetCnts" class="reg_input" style="width: 110px" value="${list.comSetCnt}" readonly="readonly" />명
													</td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
							<br> 
							<span>
								<h3>
									<img src="images/h3_ico.gif">&nbsp; 서비스 운영 정보
								</h3>
							</span>
							<table class="sub_0601_table" id="mdmiTbl">
								<colgroup>
									<col width="33%">
									<col width="33%">
									<col width="*">
								</colgroup>
								<tbody>
									<tr>
										<th>세선 유지 시간(초)</th>
										<th>세션별 최대 대역폭</th>
										<th>전체 대역폭</th>
									</tr>
									<tr id="mds_tr">
										<td colspan="3" class="td03" style="color: red;">
											<h2>* 통신방식의 경우 서버타입이 'DS' 일 경우만 설정 가능합니다.</h2>
										</td>
									</tr>
									<tr id="service_typeDS_tr">
										<td>
											<input type="text" name="sessionMaxIdletime" id="sessionMaxIdletime" title="세션 유지 시간" /> 초
										</td>
										<td>
											<input type="text" name="sessionMaxBandwidth" id="sessionMaxBandwidth" title="세션별 최대 대역폭" /> Mbps
										</td>
										<td>
											<input type="text" name="totalMaxBandwidth" id="totalMaxBandwidth" title="전체 대역폭" /> Mbps
										</td>
									</tr>
								</tbody>
							</table>
						</fieldset>
						<input type="button" class="finish" value="완료" />
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />
	</form:form>
</body>
</html>