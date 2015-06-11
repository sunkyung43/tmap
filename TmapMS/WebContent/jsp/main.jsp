<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tmap Managerment Site</title>
<!--  Stylesheet		-------------------------------------------------------------------------->
<link rel="stylesheet" href="css/common.css" type="text/css" />
<link rel="stylesheet" href="css/layout_contents.css" type="text/css" />
<link rel="stylesheet" href="css/jquery-ui.css" type="text/css" />
<!--  Stylesheet		-------------------------------------------------------------------------->

<style type="text/css">
#TmapRS {
	position: absolute;
}
</style>
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
	});
	
	function executeDetail(selectSeq) {
		document.ContentsForm.seq.value = selectSeq;
		document.ContentsForm.action = 'noticesDetailAction.action';
		document.ContentsForm.submit();
	}
	
	function executeDsDetail(selectedMapDownSeq) {
		document.ContentsForm.mapdownManageSeq.value = selectedMapDownSeq;	
		document.ContentsForm.action = 'MapDownManagerListAction.action';
		document.ContentsForm.submit();
	}
</script>
</head>
<body>
	<form name="ContentsForm" method="post">
		<c:import url="common/menu.jsp" />
		<div id="bodyDiv">
			<div class="contentsDiv">
			</div>
		</div>
	</form>
	<c:import url="common/footer.jsp" />
</body>
</html>