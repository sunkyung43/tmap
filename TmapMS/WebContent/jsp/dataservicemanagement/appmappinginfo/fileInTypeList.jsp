<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	response.setHeader("Cache-Control", "no-store"); // HTTP 1.1
	response.setHeader("Pragma", "no-cache"); // HTTP 1.0
	response.setDateHeader("Expires", 0);
%>
<table class="sub_0601_table">
	<colgroup>
		<col width="10%">
		<col width="*">
		<col width="20%">
		<col width="20%">
	</colgroup>
	<thead>
		<tr>
			<th>번호</th>
			<th>데이터 파일명</th>
			<th>저장공간</th>
			<th>등록일</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${empty fileInType}">
				<tr>
					<td colspan="4">등록된 데이터 파일이 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="list" items="${fileInType}">
					<tr onmouseover="rowOnMouseOver(this);this.style.cursor='hand'" onMouseOut="rowOnMouseOut(this);" onclick="fileDetail('${list.dataFileId}');">
						<td>${list.rownum}</td>
						<td>${list.dataFileName}</td>
						<td>${list.storageName}</td>
						<td>${list.dataFileSdate}</td>
					<tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</tbody>
</table>



