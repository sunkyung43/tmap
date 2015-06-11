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
<script type="text/javascript">
  function selected(obj) {

    for ( var i = 1; i <= obj; i++) {

      if ($("#comTypeIds" + i).is(':checked')) {
        $("input[name=comState" + i + "]").removeAttr("disabled");
      } else {
        $("input[name=comState" + i + "]").attr("disabled", "disabled");
      }

    }

  }

  function executeSave(obj) {

    var menus = new Array();

    for ( var i = 1; i <= obj; i++) {
      menus.push($("input[name=comSetState" + i + "]:checked").val());
    }

    if (menus.length == 0) {
      alert("선택된 메뉴가 없습니다.");
      return;
    }
    
    $("#comSetStates").val(menus);

    if (confirm("적용하시겠습니까?")) {
      $.post("dsComStateUpdate.do", $("#ContentsForm").serialize(), function(data) {

        if (data.json.result == "success") {
          alert("적용완료 되었습니다.");
        } else {
          alert("적용실패 하였습니다.");
        }
        $("#ContentsForm").attr('action', 'dsComState.do');
        $("#ContentsForm").submit();
      });

    }
  }
</script>
</head>
<body>
	<form:form commandName="ContentsForm">
		<form:hidden path="comSetStates" />
		<div id="contents">
			<table>
				<tr>
					<td width="680"><img src="images/h3_ico.gif"><span>&nbsp;&nbsp;
							DS허용유무 설정</span></td>
					<td><a href="javascript:executeSave(${fn:length(dsComInfo)});"
						onFocus="blur()"><img src="images/btn/btn_apply6.gif"
							border="0"></a></td>
				</tr>
			</table>
			<br>
			<div>
				<table class="sub_0601_table" id="comTypeTbl">
					<colgroup>
						<col width="9%">
						<col width="*">
						<col width="40%">
						<col width="40%">
					</colgroup>
					<tbody>
						<tr>
							<th>번호</th>
							<th>통신방식명</th>
							<th>사용유무</th>
							<th>동시접속자수</th>
						</tr>
						<c:forEach var="list" items="${dsComInfo}" varStatus="state">
							<tr>
								<td class="td03">
									<input class="td04" type="text" name="comTypeCodes" class="reg_input" style="width: 15px" value="${list.comTypeCode}" />
								</td>
								<td class="td03">${list.comTypeName}</td>
								<td class="td03">
									<input type="radio" <c:if test="${list.comSetState == 'Y'}">checked="checked"</c:if> name="comSetState${list.comTypeCode}" value="Y" title="" required="required"> 
										<label for="systemState" class="MR20">사용</label>
									<input type="radio" <c:if test="${list.comSetState == 'N'}">checked="checked"</c:if> name="comSetState${list.comTypeCode}" value="N" title="" required="required"> 
										<label for="systemState" class="MR20">미사용</label>
								</td>
								<td class="td03">
									<input type="text" id="comSetCnts" name="comSetCnts" class="reg_input" style="width: 100px" value="${list.comSetCnt}"/>명
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!--         <table width="100%" border="0" cellspacing="0" cellpadding="0"> -->
				<!--           <tr> -->
				<!--             <td background="images/ttl_bar2.gif" class="ttl">통식방식명</td> -->
				<!--             <td width="20%" background="images/ttl_bar2.gif" class="ttl">허용유무</td> -->
				<!--           </tr> -->
				<!--         </table> -->
			</div>
		</div>
		<!--       <div style="overflow: auto; height: 145px;"> -->
		<!--         <table width="100%" border="0" cellspacing="0" cellpadding="0"> -->
		<%--           <c:forEach var="list" items="${dsComInfo}" varStatus="status"> --%>
		<!--             <tr> -->
		<%--               <td width="20%" class="ttl4"><input type="checkbox" style="cursor: hand;" id="comTypeIds${status.count}" name="comTypeIds" value="${list.comTypeId}" onclick="javascript:selected(${fn:length(dsComInfo)})" /></td> --%>
		<!--               <td width="1"></td> -->
		<%--               <td class="ttl4">${list.comTypeName}</td> --%>
		<!--               <td width="1"></td> -->
		<%--               <td width="30%" class="ttl4"><input type="radio" id="comState${status.count}" name="comState${status.count}" value="Y" <c:if test="${list.comState == 'Y'}">checked="checked"</c:if> />사용함 <input type="radio" id="comState${status.count}" name="comState${status.count}" value="N" <c:if test="${list.comState == 'N'}">checked="checked"</c:if> />사용안함 <input type="text" id="comSetCnt${status.count}" name="comSetCnt${status.count}" style="width: 15%" title="동시접속자수" value="${list.comCountSet}" /></td> --%>
		<!--               <td width="3"></td> -->
		<!--             </tr> -->
		<!--             <tr> -->
		<!--               <td height="1" colspan="9" bgcolor="#f3961d"></td> -->
		<!--             </tr> -->
		<%--           </c:forEach> --%>
		<!--         </table> -->
		<!--       </div> -->
		<!--     </div> -->
	</form:form>
</body>
</html>