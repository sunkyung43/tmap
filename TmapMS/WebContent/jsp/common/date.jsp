<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String tmapRsUrl = "";
%>
<%
  response.setHeader("Cache-Control", "no-store"); // HTTP 1.1
			response.setHeader("Pragma", "no-cache"); // HTTP 1.0
			response.setDateHeader("Expires", 0);
%>
<table width="96%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="130" align="left"><table border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="left" class="date"><div id="display"></div></td>
      </tr>
    </table></td>
    <td></td>
  </tr>
</table>
<script type="text/javascript">
var date = new Date();
document.getElementById("display").innerHTML = "<b>TODAY</b> " + date.getFullYear() + "." + (date.getMonth()+1)+"." + date.getDate()+" ("+getDay(date)+")";

function getDay(date) {
	var day = date.getDay();
	switch(day) {
	case 0:
		day = "SUN";
		break;
	case 1:
		day = "MON";
		break;
	case 2:
		day = "TUE";
		break;
	case 3:
		day = "WED";
		break;
	case 4:
		day = "THU";
		break;
	case 5:
		day = "FRI";
		break;
	case 6:
		day = "SAT";
		break;
	}
	return day;
}
</script>

<input type="hidden" name="isConnectingFromTmapMS" value="<%=tmapRsUrl%>"/>
<input type="hidden" name="activeUserIdForTmapRS" value="<%=session.getAttribute("ID")%>"/>

<div id="TmapRS" style="height: 100%; width: 100%; position: absolute; top: 0px; left: 0px; display:none; z-index:2; 
background-repeat: repeat; background-image: url(../../../images/blink.png)" align="center">
<table bgcolor="white">
	<tr>
		<td align="right">
			<img src="../../../images/btn/close.gif" onclick="javascript:hideTmapRS();" style="cursor:hand">
		</td>
	</tr>
	<tr>
		<td>
			<iframe name="rsViewer" width="950px" height="800px" src="" scrolling="auto" frameborder="0"></iframe>
		</td>
	</tr>
</table>
</div>

<div id="pageLoading" style="height: 100%; width: 100%; position: absolute; top: 0px; left: 0px; display:none; z-index:3; 
background-repeat: repeat; background-image: url(../../../images/blink.png)" align="center">
<table width="100%" align="center" height="100%" valign="middle">
	<tr>
		<td align="center" valign="middle">
			<table bgcolor="#666666" cellspacing="9" border="1" width="250" height="60">
				<tr>
					<td align="center"><font size="2" color="#eeeeee">잠시만 기다리세요.</font></td>
				</tr>
				<tr>
					<td>
						<marquee direction="right" width="250" scrollamount="8">
							<table width="200" height="5" bgcolor="white"><tr><td><p></td></tr></table>
						</marquee>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>