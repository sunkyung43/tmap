<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%
  response.setHeader("Cache-Control", "no-store"); // HTTP 1.1
			response.setHeader("Pragma", "no-cache"); // HTTP 1.0
			response.setDateHeader("Expires", 0);
%>
<c:choose>
	<c:when test="${empty typeAndFile}">
		<tr>
			<td colspan="2" align="center">등록된 게시물이 없습니다.</td>
		</tr>
	</c:when>
	<c:otherwise>
		<c:set var="prevAppName" value="" />
		<c:set var="rowSpanNumber" value="0" />
		<c:set var="line" value="1" />
		<c:forEach var="list" items="${typeAndFile}">
			<c:set var="currentAppName" value="${list.dataTypeName}" />
			<c:set var="rowDraw" value="false" />

			<c:if test="${prevAppName == '' || currentAppName != prevAppName}">
				<c:set var="prevAppName" value="${list.dataTypeName}" />
				<c:set var="rowDraw" value="true" />
			</c:if>

			<tr>
				<c:choose>
					<c:when test="${rowInfo[list.dataTypeName] == 1}">
						<td>${list.dataTypeName}</td>
					</c:when>
					<c:otherwise>
						<c:if test="${rowDraw}">
							<c:set var="rowSpanNumber"
								value="${(rowInfo[list.dataTypeName])}" />
							<td rowspan="${rowSpanNumber}"
								style="border-bottom: 1px solid #CFCFCF; border-right: 1px solid #CFCFCF;">${list.dataTypeName}</td>
						</c:if>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${list.dataFileName == null}">
						<td colspan="2">등록된 데이터 파일이 없습니다.</td>
					</c:when>
					<c:otherwise>
						<td onmouseover="rowOnMouseOver(this);this.style.cursor='hand'"
							onMouseOut="rowOnMouseOut(this);"
							onclick="javascript:typeAndFile('${list.dataFileId}', '${list.dataTypeName}');">
							${list.dataFileName}</td>
					</c:otherwise>
				</c:choose>
			</tr>

		</c:forEach>
	</c:otherwise>
</c:choose>