/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.servermanagement.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.servermanagement.dao.RsInterfaceInfoDAO;
import com.tmap.servermanagement.vo.RsInterfaceInfoVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 9. 6. 
 */
@Service
public class RsInterfaceInfoService {

	@Autowired
	RsInterfaceInfoDAO RsInterfaceInfoDAO;
	
	//RS Interface 정보
	public List<RsInterfaceInfoVO> rsInterfaceInfoList(RsInterfaceInfoVO rsInterfaceInfoVO) throws Exception{
		
		//리스트 수를 조회하여 설정
		int totalCount = RsInterfaceInfoDAO.countRsInterfaceInfoList(rsInterfaceInfoVO);
		rsInterfaceInfoVO.setTotalCount(totalCount);
		
		return RsInterfaceInfoDAO.rsInterfaceInfoList(rsInterfaceInfoVO, rsInterfaceInfoVO.getStartRowNum(), rsInterfaceInfoVO.getCountPerPage());
	}
	
	//RS Interface Edit폼
	public RsInterfaceInfoVO rsInterfaceInfo(String interfaceId) throws Exception{
		
		return RsInterfaceInfoDAO.rsInterfaceInfo(interfaceId);
	}
	
	//프로토콜명 중복체크
	public String checkName(String checkName) throws Exception{
		
		int result = RsInterfaceInfoDAO.checkName(checkName);
		
		if(result > 0){
			return "failed";
		}else{
			return "success";
		}
		
	}
	
	//RS Interface 등록
	public String interfaceInsert(RsInterfaceInfoVO rsInterfaceInfoVO) throws Exception{
		
		//interface_num
		int interfaceNum = RsInterfaceInfoDAO.interfaceNum(rsInterfaceInfoVO.getInterfaceAlign()) + 1;
		
		rsInterfaceInfoVO.setInterfaceNum(String.valueOf(interfaceNum));
		
		//com_type_info 등록
		int result = RsInterfaceInfoDAO.interfaceInsert(rsInterfaceInfoVO);
		
		if(result > 0){
			return "success";
		}else{
			return "failed";
		}
	}
	
	//interfaceId
	public String interfaceId(String interfaceProtocol) throws Exception{
		
		int result = RsInterfaceInfoDAO.interfaceId(interfaceProtocol);
		
		return String.valueOf(result);
	}
	
	//RS Interface 수정
	public String interfaceUpdate(RsInterfaceInfoVO rsInterfaceInfoVO) throws Exception{
		
		int result = RsInterfaceInfoDAO.interfaceUpdate(rsInterfaceInfoVO);
		
		if(result > 0){
			return "success";
		}else{
			return "failed";
		}
	}
	
	//RS Interface 삭제
	public String interfaceDelete(String interfaceId) throws Exception{
		
		int result = RsInterfaceInfoDAO.interfaceDelete(interfaceId);
		
		if(result > 0){
			return "success";
		}else{
			return "failed";
		}
	}
}
