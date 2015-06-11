/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.servermanagement.dao;

import java.util.List;
import javax.annotation.Resource;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import com.tmap.servermanagement.vo.SettingAllInfoVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 9. 6. 
 */
@Repository
public class SettingAllInfoDAO {

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	//ipFilter 리스트
	public List<SettingAllInfoVO> ipFilter(){
		
		return sqlSessionTemplate.selectList("settingAllInfoSqlMap.ipFilter");
	}
	
	//제한IP 설정
	public int ipFilterUpdate(String[] notAllowIpList){
		
		sqlSessionTemplate.delete("settingAllInfoSqlMap.ipFilterDelete");
		
		int result = 0;
		
		SettingAllInfoVO settingAllInfoVO = new SettingAllInfoVO();
		
		for(int i = 0; i < notAllowIpList.length; i++){
			
			settingAllInfoVO.setIpFilter(notAllowIpList[i]);
			
			result = sqlSessionTemplate.insert("settingAllInfoSqlMap.ipFilterUpdate", settingAllInfoVO.getIpFilter());
		}
		
		return result;
	}
	
	//dsComInfo
	public List<SettingAllInfoVO> defaultComSetList(){
		
		return sqlSessionTemplate.selectList("settingAllInfoSqlMap.defaultComSetList");	
	}
	
	//dsBandWidth
	public SettingAllInfoVO dsBandWidth(){
		
		return sqlSessionTemplate.selectOne("settingAllInfoSqlMap.dsBandWidth");
	}
	
	//DS허용유무 설정
	public int dsComStateUpdate(SettingAllInfoVO settingAllInfoVO, String[] comSetStates){
		
		String[] cnt = settingAllInfoVO.getComTypeCodes();
		
		int result = 0;
		for(int i=0; i<cnt.length; i++){
			
		  settingAllInfoVO.setComSetCnt(settingAllInfoVO.getComSetCnts()[i]);
		  settingAllInfoVO.setComTypeCode(cnt[i]);
		  settingAllInfoVO.setComSetState(comSetStates[i]);
			
			result = sqlSessionTemplate.update("settingAllInfoSqlMap.dsComStateUpdate", settingAllInfoVO);
			
		}
		
		return result;
	}
	
	//DS동시접속자 설정
	public int dsComCntUpdate(SettingAllInfoVO settingIdInfoVO, String[] comCnt){
		
		String[] cnt = settingIdInfoVO.getComTypeCodes();
		
		int result = 0;
		
		for(int i=0; i<cnt.length; i++){
			
			settingIdInfoVO.setComTypeCode(cnt[i]);
			settingIdInfoVO.setComCountSet(comCnt[i]);
			
			result = sqlSessionTemplate.update("settingAllInfoSqlMap.dsComCntUpdate", settingIdInfoVO);
			
			if(result > 0){
				
				//com_set_info테이블 수정
				sqlSessionTemplate.update("settingAllInfoSqlMap.comSecInfoUpdate", settingIdInfoVO);
			}
		
		}
		
		return result;
	}
	
	//최초등록 여부확인
	public int selectCount(){
		
		return sqlSessionTemplate.selectOne("settingAllInfoSqlMap.selectCount");
	}
	
	//DS대역폭 설정
	public int dsBandWidthUpdate(SettingAllInfoVO settingIdInfoVO){
		
		int	result = sqlSessionTemplate.update("settingAllInfoSqlMap.dsBandWidthUpdate", settingIdInfoVO);
			
		if(result > 0){
			
			//mapdown_manage_info테이블 수정
			sqlSessionTemplate.update("settingAllInfoSqlMap.mapdownManageInfoUpdate", settingIdInfoVO);
		}
		
		return result;
	}
	
	//DS대역폭 최초등록
	public int dsBandWidthInsert(SettingAllInfoVO settingIdInfoVO){
		
		int	result = sqlSessionTemplate.insert("settingAllInfoSqlMap.dsBandWidthInsert", settingIdInfoVO);
			
		if(result > 0){
			
			//mapdown_manage_info테이블 수정
			sqlSessionTemplate.update("settingAllInfoSqlMap.mapdownManageInfoUpdate", settingIdInfoVO);
		}
		
		return result;
	}
	
}
