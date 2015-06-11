<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	response.setHeader("Cache-Control", "no-store"); // HTTP 1.1
	response.setHeader("Pragma", "no-cache"); // HTTP 1.0
	response.setDateHeader("Expires", 0);
%>
<c:choose>
	<c:when test="${empty verInFile}">
		<tr>
			<td colspan="4">등록된 데이터 파일이 없습니다.</td>
		</tr>
	</c:when>
	<c:otherwise>
		<c:forEach var="list" items="${verInFile}">
			<tr bgcolor="${list.color}" onmouseover="rowOnMouseOver(this);"	onMouseOut="rowOnMouseOutColor(this, '${list.color}');">
				<td>
					<c:choose>
						<c:when test="${list.state == 'Y'}">
							<input type="checkbox" class="checkbox" id="dataFileIds" name="dataFileIds" value="${list.fileVerId}" checked="checked" />
						</c:when>
						<c:otherwise>
							<input type="checkbox" class="checkbox" id="dataFileIds" name="dataFileIds" value="${list.fileVerId}" />
						</c:otherwise>
					</c:choose>
				</td>
				<td onclick="javascript:executeDetail('${list.fileVerId}','${list.fileVerName}')">${list.fileVerName}</td>
				<td onclick="javascript:executeDetail('${list.fileVerId}','${list.fileVerName}')">${list.fileVerRank }</td>
				<td onclick="javascript:executeDetail('${list.fileVerId}','${list.fileVerName}')">${list.fileVerSdate}</td>
			</tr>
		</c:forEach>
	</c:otherwise>
</c:choose>
