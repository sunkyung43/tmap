/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.systemmanagement.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.systemmanagement.dao.ComCodeInfoDAO;
import com.tmap.systemmanagement.vo.ComCodeInfoListVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 19. 
 */
@Service
public class ComCodeInfoService {

	@Autowired
	ComCodeInfoDAO comCodeInfoDAO;
	
	//공통코드관리 리스트 출력
	public List<ComCodeInfoListVO> comCodeInfoList(ComCodeInfoListVO comCodeInfoListVO) throws Exception{
		
		//리스트 수를 조회하여 설정
		int totalCount = comCodeInfoDAO.countComCodeInfoList(comCodeInfoListVO);
		comCodeInfoListVO.setTotalCount(totalCount);
		
		List<ComCodeInfoListVO> comCodeInfoList = comCodeInfoDAO.comCodeInfoList(comCodeInfoListVO, comCodeInfoListVO.getStartRowNum(), comCodeInfoListVO.getCountPerPage());
		
		return comCodeInfoList; 
	}
	
	//공통코드관리 등록
	public void comCodeInfoInsert(ComCodeInfoListVO comCodeInfoListVO) throws Exception{
		
		comCodeInfoDAO.comCodeInfoInsert(comCodeInfoListVO);
	}
	
	public void comCodeInsert(ComCodeInfoListVO comCodeInfoListVO) throws Exception{
			
			comCodeInfoDAO.comCodeInsert(comCodeInfoListVO);
	}
	
	public List<ComCodeInfoListVO> comCodeCount(ComCodeInfoListVO comCodeInfoListVO) throws Exception{
		
		List<ComCodeInfoListVO> comCodeCountList = comCodeInfoDAO.comCodeCountList(comCodeInfoListVO);
	
		return comCodeCountList;
	}
	
	//공통코드관리 상세정보
	public ComCodeInfoListVO comCodeInfoDetail(ComCodeInfoListVO comCodeInfoListVO) throws Exception{
		
		ComCodeInfoListVO comCodeInfoDetail = comCodeInfoDAO.comCodeInfoDetail(comCodeInfoListVO);
		return comCodeInfoDetail;
	}
	
	//공통코드관리 상세정보2(codeLevel이 2)
	public List<ComCodeInfoListVO> comCodeDetail(ComCodeInfoListVO comCodeInfoListVO) throws Exception{
		
		List<ComCodeInfoListVO> comCodeDetail = comCodeInfoDAO.comCodeDetail(comCodeInfoListVO);
		return comCodeDetail;
	}
	
	//공통코드관리 수정
	public void comCodeInfoUpdate(ComCodeInfoListVO comCodeInfoListVO) throws Exception{
		
		comCodeInfoDAO.comCodeInfoUpdate(comCodeInfoListVO);
	}
	
	//소분류코드 사용유무 변경
	public String comCodeInfoUseState(ComCodeInfoListVO comCodeInfoListVO) throws Exception{
		
		int result = comCodeInfoDAO.comCodeInfoUseState(comCodeInfoListVO);
		
		if(result > 0){
			return "success";
		}else{
			return "failed";
		}
	}
	
	//공통코드관리 삭제
	public void comCodeInfoDelete(ComCodeInfoListVO comCodeInfoListVO) throws Exception{
		
		comCodeInfoDAO.comCodeInfoDelete(comCodeInfoListVO);
	}
	
	public String processIdDuplication(String id) throws Exception {
		
		//동일 아이디 카운트
		int result = comCodeInfoDAO.countSameId(id);
		
		if(result > 0){
			return "failed";
		}else{
			return "success";
		}
	}
}
