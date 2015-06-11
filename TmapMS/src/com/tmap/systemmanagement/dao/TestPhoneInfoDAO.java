/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.systemmanagement.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import com.tmap.systemmanagement.vo.TestPhoneInfoListVO;



/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */

@Repository
public class TestPhoneInfoDAO {

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	//공지사항관리 리스트 출력
	public List<TestPhoneInfoListVO> testPhoneInfoList(TestPhoneInfoListVO testPhoneInfoListVO, int skipResults, int maxResults){
		
		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.testPhoneSqlMap.testPhoneInfoList", testPhoneInfoListVO, rowBounds); 
		
	}
	
	//공지사항관리 리스트 수
	public int countTestPhoneInfoList(TestPhoneInfoListVO testPhoneInfoListVO){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.testPhoneSqlMap.countTestPhoneInfoList", testPhoneInfoListVO);
		
	}
	
	//공지사항관리 등록
	public void testPhoneInfoInsert(TestPhoneInfoListVO testPhoneInfoListVO){
		
		sqlSessionTemplate.insert("com.tmap.sqlMap.testPhoneSqlMap.testPhoneInfoInsert", testPhoneInfoListVO);
	}
	
	//공지사항관리 수정 정보 출력
	public TestPhoneInfoListVO testPhoneModifyList(TestPhoneInfoListVO testPhoneInfoListVO){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.testPhoneSqlMap.testPhoneModifyInfo", testPhoneInfoListVO);
		
	}
	
	//공지사항관리 수정
	public void testPhoneInfoUpdate(TestPhoneInfoListVO testPhoneInfoListVO){
		
		sqlSessionTemplate.update("com.tmap.sqlMap.testPhoneSqlMap.testPhoneInfoUpdate", testPhoneInfoListVO);
	}
	
	//공지사항관리 삭제
	public void testPhoneInfoDelete(TestPhoneInfoListVO testPhoneInfoListVO){
		
		sqlSessionTemplate.update("com.tmap.sqlMap.testPhoneSqlMap.testPhoneInfoDelete", testPhoneInfoListVO);
	}
	
}
