/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.servermanagement.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import com.tmap.servermanagement.vo.RsInterfaceInfoVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 9. 6. 
 */
@Repository
public class RsInterfaceInfoDAO {

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	//RS Interface 정보 리스트 수
	public int countRsInterfaceInfoList(RsInterfaceInfoVO rsInterfaceInfoVO){
		
		return sqlSessionTemplate.selectOne("rsInterfaceInfoSqlMap.countRsInterfaceInfoList", rsInterfaceInfoVO);
	}
	
	//RS Interface 정보 리스트
	public List<RsInterfaceInfoVO> rsInterfaceInfoList(RsInterfaceInfoVO rsInterfaceInfoVO, int skipResults, int maxResults){
		
		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("rsInterfaceInfoSqlMap.rsInterfaceInfoList", rsInterfaceInfoVO, rowBounds);
	}
	
	//RS Interface Edit폼
	public RsInterfaceInfoVO rsInterfaceInfo(String interfaceId){
		
		return sqlSessionTemplate.selectOne("rsInterfaceInfoSqlMap.rsInterfaceInfo", interfaceId);
	}
	
	//프로토콜명 중복체크
	public int checkName(String checkName){
		
		return sqlSessionTemplate.selectOne("rsInterfaceInfoSqlMap.checkName", checkName);
	}
	
	public int interfaceNum(String interfaceAlign){
		
		return sqlSessionTemplate.selectOne("rsInterfaceInfoSqlMap.interfaceNum", interfaceAlign);
	}
	
	//RS Interface 등록
	public int interfaceInsert(RsInterfaceInfoVO rsInterfaceInfoVO){
		
		return sqlSessionTemplate.insert("rsInterfaceInfoSqlMap.interfaceInsert", rsInterfaceInfoVO);
	}
	
	//interfaceId
	public int interfaceId(String interfaceProtocol){
		
		return sqlSessionTemplate.selectOne("rsInterfaceInfoSqlMap.interfaceId", interfaceProtocol);
	}
	
	//RS Interface 수정
	public int interfaceUpdate(RsInterfaceInfoVO rsInterfaceInfoVO){
		
		return sqlSessionTemplate.update("rsInterfaceInfoSqlMap.interfaceUpdate", rsInterfaceInfoVO);
	}
	
	//RS Interface 삭제
	public int interfaceDelete(String interfaceId){
		
		return sqlSessionTemplate.update("rsInterfaceInfoSqlMap.interfaceDelete", interfaceId);
	}
}
