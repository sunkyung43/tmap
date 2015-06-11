<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
</head>
<body>
  <form name="ContentsForm" method="post">
    <jsp:include page="../../common/menu.jsp" />
    <div id="bodyDiv">
      <div class="contentsDiv">
        <div class="contentDiv">
          <div>
            <iframe marginwidth="-10" width="100%" height="300" id="dsComState" src="dsComState.do" scrolling="no" frameborder="0"></iframe>
          </div>
          <div>
            <iframe marginwidth="-10" width="100%"  id="dsBandWidth" src="dsBandWidth.do" scrolling="no" frameborder="0"></iframe>
          </div>
          <div>
            <iframe marginwidth="-10" width="100%" height="300" id="ipFilter" name="ipFilter" src="ipFilter.do" scrolling="no" frameborder="0"></iframe>
          </div>
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
							<td height="100%" valign="top" style="padding: 5 10 10 10">
								<table width="100%" height="100%" border="0" cellspacing="0"
									cellpadding="20">
									<tr>
										<td valign="top" bgcolor="#FFFFFF">
											<div id="contents" style="width: 850px">
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td><img src="images/h3_ico.gif"><span>서비스운영정보
																수정</span></td>
														<td height="10"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td height="10"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellpadding="10"
													cellspacing="1" class="line">
													<tr>
														<td width="50%" valign="top" bgcolor="#FFFFFF"><iframe
																marginwidth="-10" width="99%" height="220px"
																id="dsComState" src="dsComState.do" scrolling="no"
																frameborder="0"></iframe> </td>
                      			<td width="50%" valign="top" bgcolor="#FFFFFF">
                  				<iframe marginwidth="-10" width="99%" height="200px" id="dsComCnt" src="dsComCnt.do" scrolling="no" frameborder="0"></iframe>
														</td>
													</tr>
													<tr>
														<td valign="top" bgcolor="#FFFFFF" colspan="2"><iframe
																marginwidth="-10" width="100%" height="80px"
																id="dsBandWidth" src="dsBandWidth.do" scrolling="no"
																frameborder="0"></iframe></td>
													</tr>
													<tr>
														<td valign="top" bgcolor="#FFFFFF" colspan="2"><iframe
																marginwidth="-10" width="100%" height="260px"
																id="ipFilter" name="ipFilter" src="ipFilter.do"
																scrolling="no" frameborder="0"></iframe></td>
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
		</table> -->
  </form>
</body>
</html>