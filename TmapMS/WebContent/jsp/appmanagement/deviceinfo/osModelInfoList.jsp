<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	response.setHeader("Cache-Control", "no-store"); // HTTP 1.1
	response.setHeader("Pragma", "no-cache"); // HTTP 1.0
	response.setDateHeader("Expires", 0);
%>	
	
	<table class="sub_0601_table">
		<colgroup>
			<col width="" />
			<col width="" />
			<col width="" />
			<col width="" />
			<col width="" />
	
		</colgroup>
		<tbody>
			<tr>
				<th></th>
				<th>OS버전명</th>
				<th>OS버전정보</th>
				<th>OS버전상태</th>
			</tr>
			<c:choose>
				<c:when test="${empty osVerInfoFrame}">
					<tr>
						<td colspan="4" height="100" class="td03">등록된 게시물이
							없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="list" items="${osVerInfoFrame}">
						<tr
							onmouseover="rowOnMouseOver(this);this.style.cursor='hand';"
							onMouseOut="rowOnMouseOut(this);">
							<td class="td03"><c:if test="${list.osVerState == 'Y' }">
							<input type="checkbox" id="checkOsVerIds" name="checkOsVerIds"
								onclick="selectOsModel('${list.osVerInfoSeq}')" value="${list.osVerInfoSeq}"/>
						</c:if></td>
							<td class="td03">
								${list.osVerName}</td>
							<td class="td03">
								${list.osVerContent}</td>
							<td class="td03">
								<c:if test="${list.osVerState == 'Y' }">
								사용
							</c:if> <c:if test="${list.osVerState == 'N' }">
								미사용
							</c:if>
							</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>