<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	response.setHeader("Cache-Control", "no-store"); // HTTP 1.1
	response.setHeader("Pragma", "no-cache"); // HTTP 1.0
	response.setDateHeader("Expires", 0);
%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript">
	var $J = jQuery.noConflict();
</script>
<script src="js/jquery.tabs.pack.js" type="text/javascript"></script>
<!--<script src="/tmap2/js/jquery.history.pack.js" type="text/javascript"></script>-->
<script src="js/chili-1.7.pack.js" type="text/javascript"></script>
<script src="js/hoverIntent.js" type="text/javascript"></script>
<script src="js/jquery.bgiframe.min.js" type="text/javascript"></script>
<script src="js/superfish.js" type="text/javascript"></script>
<script src="js/supersubs.js" type="text/javascript"></script>
<script type="text/javascript">

	$J(document).ready(function() {
		setTopNavi(0, 0);
		$J('#topmenu').superfish({
			animation : {
				opacity : 'show',
				height : 'show'
			},
			speed : 'fast',
			pathClass : 'current',
			onInit : function() {
				$J("#gnb").css("opacity", 1);
			}
		});
	});

	function setTopNavi(depth1, depth2) {
		if (depth1 && $J("#topmenu > li:eq(" + (depth1 - 1) + ")").length)
			$J("#topmenu > li:eq(" + (depth1 - 1) + ")").addClass("current");
		if (depth2
				&& $J("#topmenu > li:eq(" + (depth1 - 1) + ") ul li:eq("
						+ (depth2 - 1) + ")").length)
			$J(
					"#topmenu > li:eq(" + (depth1 - 1) + ") ul li:eq("
							+ (depth2 - 1) + ")").addClass("current");
	}
	
</script>
<c:set var="menuid" value="${sessionScope.menuId}" />
<c:set var="hmenuid" value="${sessionScope.hMenuId}" />
<c:set var="sessionMenuList" value="${sessionScope.menuList}" />
<c:set var="currentMenu" value="" />
<c:set var="currentSubMenu" value="" />
<style type="text/css">
@import url("css/layout.css");
/* Web Font */
@import url("https://fonts.googleapis.com/earlyaccess/nanumgothic.css");

a:link {
	text-decoration: none;
}

a:visited {
	text-decoration: none;
}

a:active {
	text-decoration: none;
}

a:hover {
	text-decoration: none;
}
</style>
<div style="text-align:right;">
		<img src="images/top_ic.gif" />
		<font color="#7f7f7f">[<span class="name">${sessionScope.userId}</span>]
		</font>
		<a href="logout.do"><img src="images/btn/logout.gif"
			style="vertical-align: bottom; width: 55px; height: 20px;" /></a>
			 </div>
<div id="gnb" style="opacity: 0; filter: alpha(opacity =   0);">
	<p class="logo" style="margin-left: -520px; top:1px;">
		<a href="main.do"> <img src="images/logo.gif" /></a>
	</p>
	<ul id="topmenu" class="gnb">
		<c:forEach var="list" items="${sessionMenuList}" varStatus="status">
			<c:if test="${list.menuLevel == 1}">
				<c:choose>
					<c:when test="${list.menuId == hmenuid}">
						<li><a href="${list.menuUrl}" class="sf-with-ul">${list.menuName}</a>
							<c:set var="currentMenu" value="${list.menuName}" />
					</c:when>
					<c:otherwise>
						<li><a href="${list.menuUrl}">${list.menuName}</a>
					</c:otherwise>
				</c:choose>
				<ul class="gnb2depth1">
					<c:forEach var="subList" items="${sessionMenuList}"
						varStatus="subStatus">
						<c:if
							test="${subList.menuLevel != 1 && list.menuId == subList.menuHiId}">
							<c:choose>
								<c:when test="${subList.menuId == menuid}">
									<li><a href="${subList.menuUrl}"><b><font
												color="black">${subList.menuName}</font></b></a></li>
									<c:set var="currentSubMenu" value="${subList.menuName}" />
								</c:when>
								<c:otherwise>
									<li><a href="${subList.menuUrl}">${subList.menuName}</a></li>
								</c:otherwise>
							</c:choose>
						</c:if>
					</c:forEach>
				</ul>
				</li>
			</c:if>
		</c:forEach>
		
	</ul>
</div>
<div class="topMenuInfo">
	<c:if test="${empty currentMenu}">
		<c:set var="currentMenu" value="Main" />
	</c:if>
	<h5>${currentMenu}</h5>
	<c:if test="${!empty currentSubMenu}">
			<h2><img src="images/sub_path_ico.gif">&nbsp;${currentMenu} > ${currentSubMenu}</h2>
		</c:if>
</div>