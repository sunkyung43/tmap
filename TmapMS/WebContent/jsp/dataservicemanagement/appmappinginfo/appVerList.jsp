<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
  response.setHeader("Cache-Control", "no-store"); // HTTP 1.1
			response.setHeader("Pragma", "no-cache"); // HTTP 1.0
			response.setDateHeader("Expires", 0);
%>
	<table class="sub_0601_table">
		<colgroup>
			<col width="8%"/>
			<col width="25%"/>
			<col width="*"/>
			<col width="20%"/>
		</colgroup>
		<thead>
		<tr>
			<th></th>
			<th>버전명</th>
			<th>내용</th>
			<th>버전상태</th>
		</tr>
		</thead>
		<tbody>
			<c:choose>
			<c:when test="${empty appVerInfoList }">
			<tr>
				<td colspan="4">등록된 APP 버전이 없습니다.</td>
			</tr>
			</c:when>
			<c:otherwise>
			<c:forEach var="list" items="${appVerInfoList}">
				<tr onmouseover="rowOnMouseOver(this);this.style.cursor='hand';" onMouseOut="rowOnMouseOut(this);" >
					<td><input type="radio" style="cursor:hand;" name="sort" onclick="getAppVerId('${list.appVerId}', '${list.appVerName }');"/>
					</td>
					<td>${list.appVerName}
					</td>
					<td>${list.appVerContent}
					</td>
					<td>
						<c:if test="${list.appVerState == 'Y'}">
						사용
						</c:if>
						<c:if test="${list.appVerState == 'N'}">
						미사용
						</c:if>
					</td>
				</tr>			
			</c:forEach>
			</c:otherwise>				
			</c:choose>
			<tr>
		</tbody>
	</table>
