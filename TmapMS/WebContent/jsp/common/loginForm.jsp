<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tmap Managerment Site</title>
<!--  Stylesheet		-------------------------------------------------------------------------->
<link rel="stylesheet" href="css/tmap.css" type="text/css" />
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/formValidate.js"></script>
<script type="text/javascript" src="js/sha256.js"></script>
<script type="text/javascript">
	
	function initLoad() {
		$("#userId").focus();
	}

	$(document).ready(function() {
		
		//엔터 이벤트 처리
	    $("input:text").bind("keydown", function(event) {
	        if (event.keyCode == 13) {
	        		executeSave();
	        }
	    });

		//엔터 이벤트 처리
	    $("input:password").bind("keydown", function(event) {
	        if (event.keyCode == 13) {
	        		executeSave();
	        }
	    });
		
		$("#btnLogin").click(function(){
			executeSave();
		});
	});
	  
	function executeSave() {
		if (!validate($("#ContentsForm"))) {return;}
		$("#userPass").val(SHA256($("#usertmppw").val()).toLowerCase());
		$("#usertmppw").val("");
		$.post("login.do", $("#ContentsForm").serialize(), function(data) {
			if (data.json.CODE == "SUCCESS") {
				$("#ContentsForm").attr("action", data.json.ACTION);
			    $("#ContentsForm").submit();
			} else {
				alert(data.json.MESSAGE);
			}
		});
	}
	
</script>
</head>
<body onload="javascript:initLoad();" leftmargin="0" topmargin="0" rightmargin="0" bottommargin="70" bgcolor="#FFFFFF">
<form id="ContentsForm" name="ContentsForm" method="post">
<input type="hidden" id="userPass" name="userPass"/>
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center"><table width="720" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="center" style="padding:0 0 20 0"><img src="images/login.gif"></td>
      </tr>
      <tr>
        <td height="250" align="center" style="background-image:url(images/login_box.gif); background-repeat:no-repeat"><table border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center"><img src="images/login_text.gif"></td>
          </tr>
          <tr>
            <td><img src="images/login_line.gif" vspace="25"></td>
          </tr>
        </table>
          <table border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td><table border="0" cellspacing="0" cellpadding="4">
                <tr>
                  <td><img src="images/login_id.gif"></td>
                  <td>
	                  <input type="text" id="userId" name="userId" class="login validate-req" id="textfield" style="width:180" title="아이디" maxlength="20" />
	              </td>
                </tr>
                <tr>
                  <td><img src="images/login_pw.gif"></td>
                  <td>
	                  <input type="password" id="usertmppw" name="usertmppw" class="login validate-req" id="textfield2" style="width:180" title="패스워드" maxlength="20"/>
	              </td>
                </tr>
              </table></td>
              <td width="100" align="right">
	              <a href="#" onFocus="blur()"><img src="images/btn/login.gif" id="btnLogin" border="0"></a>
	          </td>
              </tr>
          </table></td>
      </tr>
      <tr>
        <td align="center" style="padding:20 0 0 0"><img src="images/footer/footer.gif" style="width:700px"></td>
      </tr>
    </table></td>
  </tr>
 </table>
</form>
</body>
</html>