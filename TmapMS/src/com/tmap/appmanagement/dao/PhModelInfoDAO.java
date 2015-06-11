/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.appmanagement.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.appmanagement.vo.PhModelInfoListVO;




/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */
@Repository
public class PhModelInfoDAO {

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	//단말모델정보 리스트 출력
	public List<PhModelInfoListVO> phModelInfoList(PhModelInfoListVO phModelInfoListVO, int skipResults, int maxResults){
		
		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.phModelInfoSqlMap.phModelInfoList", phModelInfoListVO, rowBounds);
	}
	
	public List<PhModelInfoListVO> phModelNameList(PhModelInfoListVO phModelInfoListVO){
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.phModelInfoSqlMap.phModelNameList", phModelInfoListVO);
	}
	//단말모델정보 리스트 수
	public int countPhModelInfoList(PhModelInfoListVO phModelInfoListVO){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.phModelInfoSqlMap.countPhModelInfoList", phModelInfoListVO);
	}
	
	//단말모델정보 수정
	public void phModelChangeState(PhModelInfoListVO phModelInfoListVO){
		
		String[] cnt = phModelInfoListVO.getPhModelInfoSeqs();
		
		for(int i=0; i<cnt.length; i++){
			
			phModelInfoListVO.setPhModelInfoSeq(cnt[i]);
			
			sqlSessionTemplate.update("com.tmap.sqlMap.phModelInfoSqlMap.phModelChangeState", phModelInfoListVO);
		}
	}
	
	//단말모델정보 삭제
	public void phModelDelete(PhModelInfoListVO phModelInfoListVO){
		
		String[] cnt = phModelInfoListVO.getPhModelInfoSeqs();
		
		for(int i=0; i<cnt.length; i++){
			
			phModelInfoListVO.setPhModelInfoSeq(cnt[i]);
			
			sqlSessionTemplate.delete("com.tmap.sqlMap.phModelInfoSqlMap.phModelDelete", phModelInfoListVO);
		}
	}
	
	//단말모델 상세정보
	public PhModelInfoListVO phModelInfoDetail(PhModelInfoListVO phModelInfoListVO){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.phModelInfoSqlMap.phModelInfoDetail", phModelInfoListVO);
	}
	
	
}
