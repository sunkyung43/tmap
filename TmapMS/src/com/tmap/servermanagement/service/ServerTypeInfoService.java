/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.servermanagement.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.servermanagement.dao.ServerTypeInfoDAO;
import com.tmap.servermanagement.vo.ServerTypeInfoVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 9. 6. 
 */
@Service
public class ServerTypeInfoService {

	@Autowired
	ServerTypeInfoDAO serverTypeInfoDAO;
	
	//서버 구분 정보
	public List<ServerTypeInfoVO> serverTypeInfoList(ServerTypeInfoVO serverTypeInfoVO) throws Exception{
		
		//리스트 수를 조회하여 설정
		int totalCount = serverTypeInfoDAO.countServerTypeInfoList(serverTypeInfoVO);
		serverTypeInfoVO.setTotalCount(totalCount);
		
		return serverTypeInfoDAO.serverTypeInfoList(serverTypeInfoVO, serverTypeInfoVO.getStartRowNum(), serverTypeInfoVO.getCountPerPage());
	}
	
	//타입명 중복체크
	public String checkType(String checkType) throws Exception{
		
		int result = serverTypeInfoDAO.checkType(checkType);
		
		if(result > 0){
			return "failed";
		}else{
			return "success";
		}
		
	}
	
	//코드명 중복체크
	public String checkCode(String checkCode) throws Exception{
		
		int result = serverTypeInfoDAO.checkCode(checkCode);
		
		if(result > 0){
			return "failed";
		}else{
			return "success";
		}
		
	}
	
	//서버 구분 등록
	public String serverTypeInsert(ServerTypeInfoVO serverTypeInfoVO) throws Exception{
		
		int result = serverTypeInfoDAO.serverTypeInsert(serverTypeInfoVO);
		
		if(result > 0){
			return "success";
		}else{
			return "failed";
		}
	}
	
	//serverTypeId
	public String serverTypeId(String serverTypeName) throws Exception{
		
		int result = serverTypeInfoDAO.serverTypeId(serverTypeName);
		
		return String.valueOf(result);
	}
	
	
	//서버 구분 Detail
	public ServerTypeInfoVO serverTypeInfo(String serverTypeId) throws Exception{
		
		return serverTypeInfoDAO.serverTypeInfo(serverTypeId);
	}
	
	//서버 구분 수정
	public String serverTypeUpdate(ServerTypeInfoVO serverTypeInfoVO) throws Exception{
		
		int result = serverTypeInfoDAO.serverTypeUpdate(serverTypeInfoVO);
		
		if(result > 0){
			return "success";
		}else{
			return "failed";
		}
	}
	
	//서버 구분 삭제
	public String serverTypeDelete(String serverTypeId) throws Exception{
		
		int result = serverTypeInfoDAO.serverTypeDelete(serverTypeId);
		
		if(result > 0){
			return "success";
		}else{
			return "failed";
		}
	}
}
