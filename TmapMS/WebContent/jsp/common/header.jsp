<%
  response.setHeader("Cache-Control", "no-store"); // HTTP 1.1
			response.setHeader("Pragma", "no-cache"); // HTTP 1.0
			response.setDateHeader("Expires", 0);
%>
<table width="95%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="120" align="center"><a href="main.do" onFocus="blur()"><img src="../../images/logo.gif" border="0" /></a></td>
    <td align="right" valign="bottom"><table border="0" cellspacing="0" cellpadding="2">
      <tr>
        <td></td>
        <td><img src="../../images/top_ic.gif" /></td>
        <td><font color="#7f7f7f">[<span class="name">${sessionScope.userId}</span>]</font></td>
        <td><a href="logout.do"><img src="../../images/btn/logout.gif" border="0" style="cursor:hand" /></a></td>
      </tr>
    </table></td>
  </tr>
</table>
