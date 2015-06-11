/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.appmanagement.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.appmanagement.dao.TempletModelInfoDAO;
import com.tmap.appmanagement.vo.TempletModelInfoListVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */
@Service
public class TempletModelInfoService {

	@Autowired
	TempletModelInfoDAO templetModelInfoDAO;

	//App관리 리스트 출력
	public List<TempletModelInfoListVO> templetModelInfoList(TempletModelInfoListVO templetModelInfoListVO) throws Exception{
		
		//리스트 수를 조회하여 설정
		int totalCount = templetModelInfoDAO.countTempletModelInfoList(templetModelInfoListVO);
		templetModelInfoListVO.setTotalCount(totalCount);
		
		List<TempletModelInfoListVO> templetModelList = templetModelInfoDAO.templetModelInfoList(templetModelInfoListVO, templetModelInfoListVO.getStartRowNum(), templetModelInfoListVO.getCountPerPage());
		return templetModelList;
	}
	
	//App관리 rowSpan
	public List<Map<String, Object>> rowSpan(TempletModelInfoListVO templetModelInfoListVO) throws Exception{
		
		List<Map<String, Object>> rowSpan = templetModelInfoDAO.rowSpan(templetModelInfoListVO);
		return rowSpan;
	}
	
	//App관리 등록 - 단말모델 정보 리스트
	public List<TempletModelInfoListVO> templetModelInfoNew(TempletModelInfoListVO templetModelInfoListVO) throws Exception{
		
		List<TempletModelInfoListVO> templetModelInfoNew = templetModelInfoDAO.templetModelInfoNew(templetModelInfoListVO);
		return templetModelInfoNew;
		
	}
	
	
	//단말조합 등록 - 단말조합 정보 등록
	public void templetModelInfoInsert(TempletModelInfoListVO templetModelInfoListVO) throws Exception{
		
		templetModelInfoDAO.templetModelInfoInsert(templetModelInfoListVO);
		
	}
	
	//단말조합 등록 - 단말모델 등록
	public void osPhInfoInsert(TempletModelInfoListVO templetModelInfoListVO) throws Exception{
		
		String seq = templetModelInfoDAO.templetModelInfoSeq(templetModelInfoListVO);
		
		templetModelInfoListVO.setTempletModelId(seq);
		
		templetModelInfoDAO.osPhInfoInsert(templetModelInfoListVO);
	}
	
	//단말조합 정보
	public TempletModelInfoListVO templetModelInfo(String templetModelId) throws Exception{
		
		TempletModelInfoListVO templetModelInfo = templetModelInfoDAO.templetModelInfo(templetModelId);
		
		return templetModelInfo;
	}
	
	//단말조합에 등록된 단말모델
	public List<TempletModelInfoListVO> appUseOsPh(String templetModelId) throws Exception{
		
		List<TempletModelInfoListVO> appUseOsPh = templetModelInfoDAO.appUseOsPh(templetModelId);
		
		return appUseOsPh;
	}
	
	//단말조합에 등록되지 않은 단말모델
	public List<TempletModelInfoListVO> allOsPhInfo(TempletModelInfoListVO templetModelInfoListVO) throws Exception{
		
		List<TempletModelInfoListVO> allOsPhInfo = templetModelInfoDAO.allOsPhInfo(templetModelInfoListVO);
		
		return allOsPhInfo;
	}
	
	//단말조합 수정 - 단말조합 정보 수정
	public void templetModelInfoUpdate(TempletModelInfoListVO templetModelInfoListVO) throws Exception{
		
		
		templetModelInfoDAO.templetModelInfoUpdate(templetModelInfoListVO);
	}
	
	//App관리 수정 - 단말모델수정
	public void osPhInfoUpdate(TempletModelInfoListVO templetModelInfoListVO) throws Exception{
		
		if(templetModelInfoListVO.getCheckboxPhModelInfos() != null){
			
			//기존 등록된 단말모델 사용여부 변경
			templetModelInfoDAO.osPhInfoDelete(templetModelInfoListVO.getTempletModelId());
			
			//단말모델 수정
			templetModelInfoDAO.osPhInfoUpdate(templetModelInfoListVO);
		
		}else{
			
			//기존 등록된 단말모델 사용여부 변경
			templetModelInfoDAO.osPhInfoDelete(templetModelInfoListVO.getTempletModelId());
		}
	}
	
	//단말조합 삭제
	public void templetModelInfoDelete(String templetModelId) throws Exception{
		
		//단말조합 삭제
		templetModelInfoDAO.templetModelInfoDelete(templetModelId);
		
		//단말모델 삭제
		templetModelInfoDAO.osPhInfoDelete(templetModelId);
	}
	
}
