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
<script type="text/javascript" src="js/paging.js"></script>

<script type="text/javascript">
	
	//중복체크 버튼 클릭 여부
	var checkValueName = "";
	
	//이벤트 등록
	$(document).ready(function() {
	
		//타입명 중복 체크 클릭시 이벤트 처리
		$("#anchNameDup").click(function() {
			checkValueName = "T";
			processNameDuplication();
		});
		
	});
	
	//통식방식명 중복 체크
	function processNameDuplication() {
	        
	    //아이디 유효성 검증
	    if ($("#comTypeName").val() == "") {
	        alert("통식방식명을 입력하세요.");
	        $("#comTypeName").val("");
	        $("#comTypeName").focus();
	        return;
	    }
	    
	    //검증조건 값 할당
	    $("#checkName").val($("#comTypeName").val());
	
	    //호출 및 메시지 출력
	    $.post("processTypeNameDuplication.do", $("#ContentsForm").serialize(), function(data) {
	        
	    	if (data.json.checkName == "success") {
	            alert("사용하실 수 있는 통식방식명 입니다.");
	        }else{
	        	alert("사용하실 수 없는 통식방식명 입니다.");
	        }
	        	
	    });
	}
	
	function save() {
	
		//중복체크사용 여부 검사
		if(checkValueName != "T"){
			alert("통식방식명 중복체크를 하세요.");
	        $("#anchNameDup").focus();
	        return;
		}
		
		if(confirm("등록하시겠습니까?")){
			
			$.post("comTypeInsert.do", $("#ContentsForm").serialize(), function(data) {
				
				if (data.json.comTypeInsert == "success") {
		            alert("등록완료 되었습니다.");
		        }else{
		        	alert("등록실패 하였습니다.");
		        }
				$("#comTypeId").val(data.json.comTypeId);
				$("#ContentsForm").attr('action','comTypeInfoEdit.do');
	    	    $("#ContentsForm").submit();
			});
		}
	}

</script>
</head>
<body>
	<form:form commandName="ContentsForm">
		<form:hidden path="checkName" />
		<form:hidden path="comTypeId" />
		<jsp:include page="../../common/menu.jsp" />

		<div id="bodyDiv">
			<div class="contentsDiv">
				<div class="contentDiv">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td><img src="images/h3_ico.gif"><span>
									<!-- <img src="images/title/title64.gif"> --> 통신방식정보 등록
							</span></td>
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
							<td class="btn"><a href="javascript:save();"
								onFocus="blur()"><img src="images/btn/btn_apply2.gif"
									border="0"></a> <a href="comTypeInfoList.do" onFocus="blur()"><img
									src="images/btn/btn_list.gif" border="0"></a>
						</tr>
					</table>
					<table width="750" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td><img src="images/box1.gif"></td>
						</tr>
						<tr>
							<td align="center" background="images/box2.gif">
								<table width="748" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="150" height="35" class="ttl4">통신방식명</td>
										<td width="1" bgcolor="#f3961d"></td>
										<td width="10"></td>
										<td><input type="text" name="comTypeName"
											id="comTypeName" class="textbox" style="width: 50%"
											title="서버타입명" maxlength="150" /> <a id="anchNameDup"><img
												src="images/btn/checkid.gif" align="absmiddle"
												style="cursor: hand"></a></td>
									</tr>
									<tr>
										<td height="1" colspan="4" bgcolor="#f3961d"></td>
									</tr>
								</table>
								<table width="748" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="150" height="35" class="ttl4">사용여부</td>
										<td width="1" bgcolor="#f3961d"></td>
										<td width="10"></td>
										<td><input type="radio" style="cursor: hand;"
											name="comTypeState" value="Y" /> 사용 &nbsp;&nbsp; <input
											type="radio" style="cursor: hand;" name="comTypeState"
											value="N" checked="checked" /> 미사용</td>
										<td width="5"></td>
									</tr>
									<tr>
										<td height="1" colspan="4" bgcolor="#f3961d"></td>
									</tr>
								</table>
								<table width="748" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="150" class="ttl4">내용</td>
										<td width="1" bgcolor="#f3961d"></td>
										<td width="10"></td>
										<td height="70"><textarea name="comTypeContent" rows="5"
												class="textbox" style="width: 62%; height: 50" title="내용"></textarea>
										</td>
										<td width="5"></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td><img src="images/box3.gif"></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />
		
		
		<!-- <table width="100%" height="100%" border="0" cellspacing="0"
			cellpadding="0">
			<tr>
				<td height="100%">
					<table width="100%" height="100%" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td height="100%" valign="top" class="contents">
								<table width="100%" height="100%" border="0" cellspacing="0"
									cellpadding="20">
									<tr>
										<td valign="top" bgcolor="#FFFFFF">
											<div id="contents" style="width: 850px">
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td><img src="images/h3_ico.gif"><span>
																<img src="images/title/title64.gif"> 통신방식정보 등록
														</span></td>
														<td width="30"></td>
													</tr>
													<tr>
														<td height="10"></td>
														<td></td>
														<td></td>
														<td></td>
													</tr>
												</table>
												<table width="750" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td class="btn"><a href="javascript:save();"
															onFocus="blur()"><img src="images/btn/btn_apply2.gif"
																border="0"></a> <a href="comTypeInfoList.do"
															onFocus="blur()"><img src="images/btn/btn_list.gif"
																border="0"></a>
													</tr>
												</table>
												<table width="750" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td><img src="images/box1.gif"></td>
													</tr>
													<tr>
														<td align="center" background="images/box2.gif">
															<table width="748" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="150" height="35" class="ttl4">통신방식명</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="10"></td>
																	<td><input type="text" name="comTypeName"
																		id="comTypeName" class="textbox" style="width: 50%"
																		title="서버타입명" maxlength="150" /> <a id="anchNameDup"><img
																			src="images/btn/checkid.gif" align="absmiddle"
																			style="cursor: hand"></a></td>
																</tr>
																<tr>
																	<td height="1" colspan="4" bgcolor="#f3961d"></td>
																</tr>
															</table>
															<table width="748" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="150" height="35" class="ttl4">사용여부</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="10"></td>
																	<td><input type="radio" style="cursor: hand;"
																		name="comTypeState" value="Y" /> 사용 &nbsp;&nbsp; <input
																		type="radio" style="cursor: hand;" name="comTypeState"
																		value="N" checked="checked" /> 미사용</td>
																	<td width="5"></td>
																</tr>
																<tr>
																	<td height="1" colspan="4" bgcolor="#f3961d"></td>
																</tr>
															</table>
															<table width="748" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="150" class="ttl4">내용</td>
																	<td width="1" bgcolor="#f3961d"></td>
																	<td width="10"></td>
																	<td height="70"><textarea name="comTypeContent"
																			rows="5" class="textbox"
																			style="width: 62%; height: 50" title="내용"></textarea>
																	</td>
																	<td width="5"></td>
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
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table> -->
	</form:form>
</body>
</html>