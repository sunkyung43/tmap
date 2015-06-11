/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.appmanagement.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.appmanagement.vo.TempletModelInfoListVO;


/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */
@Repository
public class TempletModelInfoDAO {

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	//단말조합 리스트 출력
	public List<TempletModelInfoListVO> templetModelInfoList(TempletModelInfoListVO templetModelInfoListVO, int skipResults, int maxResults){
		
		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.templetModelSqlMap.templetModelInfoList", templetModelInfoListVO, rowBounds); 
		 
	}
	
	//단말조합 리스트 수
	public int countTempletModelInfoList(TempletModelInfoListVO templetModelInfoListVO){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.templetModelSqlMap.countTempletModelInfoList", templetModelInfoListVO);
	}
	
	public List<Map<String, Object>> rowSpan(TempletModelInfoListVO templetModelInfoListVO){
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.templetModelSqlMap.rowSpan", templetModelInfoListVO);
	}
	
	//단말조합 등록 - 단말모델 정보 리스트
	public List<TempletModelInfoListVO> templetModelInfoNew(TempletModelInfoListVO templetModelInfoListVO){
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.templetModelSqlMap.templetModelInfoNew", templetModelInfoListVO);
	}
	
	//단말조합 등록 - 단말조합 정보 등록
	public int templetModelInfoInsert(TempletModelInfoListVO templetModelInfoListVO){
		
		return sqlSessionTemplate.insert("com.tmap.sqlMap.templetModelSqlMap.templetModelInfoInsert", templetModelInfoListVO); 
	}
	
	//단말조합 - 마지막 등록된 templetModelId 정보출력
	public String templetModelInfoSeq(TempletModelInfoListVO templetModelInfoListVO){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.templetModelSqlMap.templetModelInfoSeq", templetModelInfoListVO);
	}
	
	//단말조합 등록 - 단말모델 등록
	public void osPhInfoInsert(TempletModelInfoListVO templetModelInfoListVO){
		
		String[] cnt1 = templetModelInfoListVO.getCheckboxPhModelInfos();
		
		for(int i = 0; i < cnt1.length; i++){
			
			templetModelInfoListVO.setPhModelInfoSeq(cnt1[i]);
			
			sqlSessionTemplate.insert("com.tmap.sqlMap.templetModelSqlMap.osPhInfoInsert", templetModelInfoListVO);
		}
	}
	
	//단말조합 수정 - 단말모델 수정
	public void osPhInfoUpdate(TempletModelInfoListVO templetModelInfoListVO){
		
		String[] cnt1 = templetModelInfoListVO.getCheckboxPhModelInfos();
		
		for(int i = 0; i < cnt1.length; i++){
			
			templetModelInfoListVO.setPhModelInfoSeq(cnt1[i]);
			
			sqlSessionTemplate.insert("com.tmap.sqlMap.templetModelSqlMap.osPhInfoInsert", templetModelInfoListVO);
		}
	}
	
	//단말조합 정보
	public TempletModelInfoListVO templetModelInfo(String templetModelId){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.templetModelSqlMap.templetModelInfo", templetModelId);
	}
	
	//단말조합에 등록된 단말모델
	public List<TempletModelInfoListVO> appUseOsPh(String templetModelId){
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.templetModelSqlMap.appUseOsPh", templetModelId);
	}
	
	//단말조합에 등록되지 않은 단말모델
	public List<TempletModelInfoListVO> allOsPhInfo(TempletModelInfoListVO templetModelInfoListVO){
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.templetModelSqlMap.allOsPhInfo", templetModelInfoListVO);
	}
	
	//단말조합 수정 - 단말조합 정보 수정
	public void templetModelInfoUpdate(TempletModelInfoListVO templetModelInfoListVO){
		
		sqlSessionTemplate.update("com.tmap.sqlMap.templetModelSqlMap.templetModelInfoUpdate", templetModelInfoListVO);
	}
	
	//기존 등록된 단말모델 사용여부 변경
	public void osPhInfoDelete(String templetModelId){
		
		sqlSessionTemplate.update("com.tmap.sqlMap.templetModelSqlMap.osPhInfoDelete", templetModelId);
		
	}
	
	//단말조합 삭제
	public void templetModelInfoDelete(String templetModelId){
		
		sqlSessionTemplate.update("com.tmap.sqlMap.templetModelSqlMap.templetModelInfoDelete", templetModelId);
	}
	
	
}
