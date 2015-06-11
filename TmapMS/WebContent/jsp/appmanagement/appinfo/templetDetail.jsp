<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<table class="sub_0601_table" id="phModelDiv">
	<colgroup>
		<col width="" />
		<col width="" />
		<col width="" />
		<col width="" />
		<col width="" />
	</colgroup>
	<thead>
		<tr>
			<th><input type="checkbox" name="templetDetailAll"
							onclick="checkAll('templetDetail');" />
			</th>
			<th>단말명</th>
			<th>단말정보</th>
			<th>OS버전명</th>
			<th>OS버전정보</th>
		</tr>
	</thead>
	<c:choose>
		<c:when test="${empty detailList}">
			<tr>
				<td colspan="5" height="100" align="center">등록된 단말 모델이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<tbody id="trsearchPhModel" class="contentList">
				<c:forEach var="list" items="${detailList}" varStatus="stat">
					<tr>
						<td class="td03"><input type="checkbox" name="templetDetail"
							value="${list.phModelInfoSeq}" /></td>
						<td class="td03">${list.phName}</td>
						<td class="td03">${list.phContent}</td>
						<td class="td03">${list.osVerName}</td>
						<td class="td03">${list.osVerContent}</td>
					</tr>
				</c:forEach>
			</tbody>
		</c:otherwise>
	</c:choose>
	</tbody>
</table>