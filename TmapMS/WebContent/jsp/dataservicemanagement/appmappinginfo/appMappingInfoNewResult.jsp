<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%
  response.setHeader("Cache-Control", "no-store"); // HTTP 1.1
			response.setHeader("Pragma", "no-cache"); // HTTP 1.0
			response.setDateHeader("Expires", 0);
%>
 <%-- <table id="resultTable">
 <colgroup>
 <col width="">
 <col width="">
 <col width="">
 <col width="">
 <col width="">
 <col width="">
 </colgroup>
 <tbody>
 <tr>
 <th></th>
 <th></th>
 <th></th>
 <th></th>
 <th></th>
  <th></th>
 </tr>
 <c:choose>
          <c:when test="${empty typeAndFile}">
            	<tr>
            		<td colspan="6">매핑된 데이터가 없습니다.</td>
            	</tr>
          </c:when>
          <c:otherwise>
            	<c:forEach var="list" items="${typeAndFile}">
            		<tr>
                     <td>숫자부분</td>
                     <td><label>${appMappingInfo.appName}</label></td>
                     <td><label for="">${appMappingInfo.appMappingName}</label></td>
                     <td><label for="">${appMappingInfo.appVerName }</label></td>
                     <td>${list.dataTypeName}</td>
                     <td>${list.dataFileName}</td>
            		</tr>
            	</c:forEach>
          </c:otherwise>
        </c:choose>
 </tbody>
 </table> --%>
 
 
 
  <table id="resultTable" border=1>
  <tr>
    <th style="text-align: right;"><label  for="appName">App 명</label></th>
    <td><label>${appMappingInfo.appName}</label></td>
  </tr>
  <tr> 
    <th><label for="appMappingName">App 매핑 명</label></th>
    <td><label for="">${appMappingInfo.appMappingName}</label></td>
  </tr>
  <tr>
    <th><label for="">App 버전 명</label>  </th>
    <td><label for="">${appMappingInfo.appVerName }</label></td>
  </tr>
  <tr>
    <td colspan=2>
      <fieldset>
        <legend><label for="">매핑정보</label></legend>
        <table border="1">
          <tr>
            <th><label for="">데이터 타입명</label></th>
            <th><label for="">데이터 파일명</label></th>
          </tr>
        </table>
        <c:choose>
          <c:when test="${empty typeAndFile}">
            <table>
            	<tr>
            		<td><label for="noData">매핑된 데이터가 없습니다. </label></td>
            	</tr>
            </table>
          </c:when>
          <c:otherwise>
            <table>
            	<c:forEach var="list" items="${typeAndFile}">
            		<tr>
                     <td>${list.dataTypeName}</td>
                     <td>${list.dataFileName}</td>
            		</tr>
            	</c:forEach>
            </table>
          </c:otherwise>
        </c:choose>
      </fieldset>
    </td>
  </tr>
</table>
