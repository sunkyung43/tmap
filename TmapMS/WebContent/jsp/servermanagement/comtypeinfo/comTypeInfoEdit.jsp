<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
	
	function executeModify(comTypeId){
		
		$("#comTypeId").val(comTypeId);
		
		if(confirm("서비스 구분 정보를 수정하시겠습니까?")){
			 
			$.post("comTypeUpdate.do", $("#ContentsForm").serialize(), function(data) {
				
				if (data.json.comTypeUpdate == "success") {
		            alert("수정완료 되었습니다.");
		        }else{
		        	alert("수정실패 하였습니다.");
		        }
				
				$("#ContentsForm").attr('action','comTypeInfoEdit.do');
	    	    $("#ContentsForm").submit();
			});
		}
	}
	
	function executeDel(comTypeId, state){
		
		$("#comTypeId").val(comTypeId);
		
		if(confirm("삭제하시겠습니까?")){
			if(state == 'Y'){
				alert("사용중인 서버구분정보는 삭제할 수 없습니다.\n미사용으로 전환 후 삭제하십시요.");
				return;
			}else{
				$.post("comTypeDelete.do", $("#ContentsForm").serialize(), function(data) {
					
					if (data.json.comTypeDelete == "success") {
			            alert("삭제완료 되었습니다.");
			        }else{
			        	alert("삭제실패 하였습니다.");
			        }
					
					$("#comTypeName").val("");
					$("#ContentsForm").attr('action','comTypeInfoList.do');
					$("#ContentsForm").submit();
				});
			}
		}
	}

</script>
</head>
<body>
<form:form commandName="ContentsForm">
<form:hidden path="comTypeId"/>
<jsp:include page="../../common/menu.jsp" />

<div id="bodyDiv">
			<div class="contentsDiv">
			<div class="contentDiv">
			<table>
            		<tr>
              			<td valign="top" bgcolor="#FFFFFF">
              			<table border="0" cellspacing="0" cellpadding="0">
                  			<tr>
                    			<td><img src="images/h3_ico.gif"><span>
                    			통신방식정보 수정</span></td>
                    			<td width="30"></td>
                  			</tr>
                  			<tr>
                    			<td height="10"></td>
                    			<td></td><td></td><td></td>
                  			</tr>
                		</table>
              			<table width="750" border="0" cellspacing="0" cellpadding="0">
	                    	<tr>
	                    		<td class="btn">
	                    		<a href="javascript:executeDel('${comTypeInfo.comTypeId}','${comTypeInfo.comTypeState}');" onFocus="blur()"><img src="images/btn/delete7.gif" border="0"></a>&nbsp;
		                  		<a href="javascript:executeModify('${comTypeInfo.comTypeId}');" onFocus="blur()"><img src="images/btn/modify7.gif" border="0"></a>&nbsp;
                        		<a href="comTypeInfoList.do" onFocus="blur()"><img src="images/btn/btn_list.gif" border="0"></a>
	                    	</tr>
						</table>
                  		<table width="750" border="0" cellspacing="0" cellpadding="0">
                      		<tr>
                        		<td><img src="images/box1.gif"></td>
                      		</tr>
                      		<tr>
                        		<td align="center" background="images/box2.gif" >
                        		<table width="748" border="0" cellspacing="0" cellpadding="0">
                            		<tr>
                              			<td width="150" height="35" class="ttl4">통신방식명</td>
		                              	<td width="1" bgcolor="#f3961d"></td>
		                              	<td width="10"></td>
		                              	<td>
		                              	<input type="text" class="invisible" value="${comTypeInfo.comTypeName}" />
                                  		</td>
                            		</tr>
                            		<tr>
                              			<td height="1" colspan="4" bgcolor="#f3961d"></td>
                            		</tr>
                          		</table>
                          		<table width="748" border="0" cellspacing="0" cellpadding="0">
                            		<tr>
                              			<td width="150" height="35" class="ttl4">등록일</td>
		                              	<td width="1" bgcolor="#f3961d"></td>
		                              	<td width="10"></td>
		                              	<td>
		                              	<input type="text" class="invisible" value="${comTypeInfo.comTypeSdate}" />
                                  		</td>
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
										<td> 
										<input type="radio" style="cursor: hand;" name="comTypeState" value="Y" <c:if test="${comTypeInfo.comTypeState == 'Y'}">checked="checked"</c:if>/> 사용 &nbsp;&nbsp; 
										<input type="radio" style="cursor: hand;" name="comTypeState" value="N" <c:if test="${comTypeInfo.comTypeState == 'N'}">checked="checked"</c:if>/> 미사용</td>
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
										<td height="70">
										<textarea name="comTypeContent" rows="5" class="textbox" style="width: 62%; height: 50" title="내용" >${comTypeInfo.comTypeContent}</textarea>
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
              			</td>
            		</tr>
        		</table>
			</div>
			</div>
</div>

<jsp:include page="../../common/footer.jsp" />

<%-- <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">

  	<tr>
    	<td height="100%">
    	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
      		<tr>
        		<td height="100%" valign="top" class="contents">
        		<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="20">
            		<tr>
              			<td valign="top" bgcolor="#FFFFFF">
		 	            <div id="contents" style="width: 850px">
              			<table border="0" cellspacing="0" cellpadding="0">
                  			<tr>
                    			<td><!-- <img src="images/title/title64.gif"> -->
                    			통신방식 정보 등록</td>
                    			<td width="30"></td>
                  			</tr>
                  			<tr>
                    			<td height="10"></td>
                    			<td></td><td></td><td></td>
                  			</tr>
                		</table>
              			<table width="750" border="0" cellspacing="0" cellpadding="0">
	                    	<tr>
	                    		<td class="btn">
	                    		<a href="javascript:executeDel('${comTypeInfo.comTypeId}','${comTypeInfo.comTypeState}');" onFocus="blur()"><img src="images/btn/delete7.gif" border="0"></a>&nbsp;
		                  		<a href="javascript:executeModify('${comTypeInfo.comTypeId}');" onFocus="blur()"><img src="images/btn/modify7.gif" border="0"></a>&nbsp;
                        		<a href="comTypeInfoList.do" onFocus="blur()"><img src="images/btn/btn_list.gif" border="0"></a>
	                    	</tr>
						</table>
                  		<table width="750" border="0" cellspacing="0" cellpadding="0">
                      		<tr>
                        		<td><img src="images/box1.gif"></td>
                      		</tr>
                      		<tr>
                        		<td align="center" background="images/box2.gif" >
                        		<table width="748" border="0" cellspacing="0" cellpadding="0">
                            		<tr>
                              			<td width="150" height="35" class="ttl4">통신방식명</td>
		                              	<td width="1" bgcolor="#f3961d"></td>
		                              	<td width="10"></td>
		                              	<td>
		                              	<input type="text" class="invisible" value="${comTypeInfo.comTypeName}" />
                                  		</td>
                            		</tr>
                            		<tr>
                              			<td height="1" colspan="4" bgcolor="#f3961d"></td>
                            		</tr>
                          		</table>
                          		<table width="748" border="0" cellspacing="0" cellpadding="0">
                            		<tr>
                              			<td width="150" height="35" class="ttl4">등록일</td>
		                              	<td width="1" bgcolor="#f3961d"></td>
		                              	<td width="10"></td>
		                              	<td>
		                              	<input type="text" class="invisible" value="${comTypeInfo.comTypeSdate}" />
                                  		</td>
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
										<td> 
										<input type="radio" style="cursor: hand;" name="comTypeState" value="Y" <c:if test="${comTypeInfo.comTypeState == 'Y'}">checked="checked"</c:if>/> 사용 &nbsp;&nbsp; 
										<input type="radio" style="cursor: hand;" name="comTypeState" value="N" <c:if test="${comTypeInfo.comTypeState == 'N'}">checked="checked"</c:if>/> 미사용</td>
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
										<td height="70">
										<textarea name="comTypeContent" rows="5" class="textbox" style="width: 62%; height: 50" title="내용" >${comTypeInfo.comTypeContent}</textarea>
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
      		<tr></tr>
    	</table>
    	</td>
  	</tr>
</table> --%>
</form:form>
</body>
</html>