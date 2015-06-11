<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
  response.setHeader("Cache-Control", "no-store"); // HTTP 1.1
			response.setHeader("Pragma", "no-cache"); // HTTP 1.0
			response.setDateHeader("Expires", 0);
%>
<div id="header2">
<table width="28%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="120" align="right"><a href="main.do" onFocus="blur()"><img
				src="images/logo.gif" border="0" /></a></td>
	</tr>
</table>
</div>
<div id="header3">
<table width="85%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="right">
			<table border="0" cellspacing="0" cellpadding="2">
				<tr>
					<td><img src="images/top_ic.gif" /></td>
					<td><font color="#7f7f7f">[<span class="name">${sessionScope.userId}</span>]
					</font></td>
					<td><a href="logout.do"><img src="images/btn/logout.gif"
							border="0" style="cursor: hand" /></a></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>