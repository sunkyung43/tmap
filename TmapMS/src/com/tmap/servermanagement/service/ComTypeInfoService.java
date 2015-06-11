/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.servermanagement.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.servermanagement.dao.ComTypeInfoDAO;
import com.tmap.servermanagement.vo.ComTypeInfoVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 9. 6. 
 */
@Service
public class ComTypeInfoService {

	@Autowired
	ComTypeInfoDAO comTypeInfoDAO;
	
	//통신방식 정보
	public List<ComTypeInfoVO> comTypeInfoList(ComTypeInfoVO comTypeInfoVO) throws Exception{
		
		//리스트 수를 조회하여 설정
		int totalCount = comTypeInfoDAO.countComTypeInfoList(comTypeInfoVO);
		comTypeInfoVO.setTotalCount(totalCount);
		
		return comTypeInfoDAO.comTypeInfoList(comTypeInfoVO, comTypeInfoVO.getStartRowNum(), comTypeInfoVO.getCountPerPage());
	}
	
	//통신방식명 중복체크
	public String checkName(String checkName) throws Exception{
		
		int result = comTypeInfoDAO.checkName(checkName);
		
		if(result > 0){
			return "failed";
		}else{
			return "success";
		}
		
	}
	
	//통신방식 등록
	public String comTypeInsert(ComTypeInfoVO comTypeInfoVO) throws Exception{
		
		//com_type_info 등록
		int result = comTypeInfoDAO.comTypeInsert(comTypeInfoVO);
		
		if(result > 0){
			
			//comTypeId
			int comTypeId = comTypeInfoDAO.comTypeId(comTypeInfoVO.getComTypeName());
			comTypeInfoVO.setComTypeId(String.valueOf(comTypeId));
			
			//ds_com_state 등록
			comTypeInfoDAO.dsComInfoInsert(comTypeInfoVO);
			
			return "success";
		}else{
			return "failed";
		}
	}
	
	//comTypeId
	public String comTypeId(String comTypeName) throws Exception{
		
		int result = comTypeInfoDAO.comTypeId(comTypeName);
		
		return String.valueOf(result);
	}
	
	
	//통신방식 Detail
	public ComTypeInfoVO comTypeInfo(String comTypeId) throws Exception{
		
		return comTypeInfoDAO.comTypeInfo(comTypeId);
	}
	
	//통신방식 수정
	public String comTypeUpdate(ComTypeInfoVO comTypeInfoVO) throws Exception{
		
		int result = comTypeInfoDAO.comTypeUpdate(comTypeInfoVO);
		
		if(result > 0){
			return "success";
		}else{
			return "failed";
		}
	}
	
	//통신방식 삭제
	public String comTypeDelete(String comTypeId) throws Exception{
		
		int result = comTypeInfoDAO.comTypeDelete(comTypeId);
		
		if(result > 0){
			return "success";
		}else{
			return "failed";
		}
	}
}
