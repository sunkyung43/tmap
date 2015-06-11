/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.systemmanagement.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import com.tmap.systemmanagement.vo.MessageInfoListVO;


/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */
@Repository
public class MessageInfoDAO {

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	//공통메세지관리 리스트 출력
	public List<MessageInfoListVO> messageInfoList(MessageInfoListVO messageInfoListVO, int skipResults, int maxResults){
		
		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.messageSqlMap.messageInfoList", messageInfoListVO, rowBounds); 
		
	}
	
	//공통메세지관리 리스트 수
	public int countMessageInfoList(MessageInfoListVO messageInfoListVO){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.messageSqlMap.countMessageInfoList", messageInfoListVO);
		
	}
	
	//공통메세지관리 등록
	public void messageInfoInsert(MessageInfoListVO messageInfoListVO){
		
		sqlSessionTemplate.insert("com.tmap.sqlMap.messageSqlMap.messageInfoInsert", messageInfoListVO);
	}
	
	//공통메세지관리 수정 정보 출력
	public MessageInfoListVO messageModifyList(MessageInfoListVO messageInfoListVO){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.messageSqlMap.messageModifyInfo", messageInfoListVO);
		
	}
	
	//공통메세지관리 수정
	public void messageInfoUpdate(MessageInfoListVO messageInfoListVO){
		
		sqlSessionTemplate.update("com.tmap.sqlMap.messageSqlMap.messageInfoUpdate", messageInfoListVO);
	}
	
	//공통메세지관리 삭제
	public void messageInfoDelete(MessageInfoListVO messageInfoListVO){
		
		sqlSessionTemplate.update("com.tmap.sqlMap.messageSqlMap.messageInfoDelete", messageInfoListVO);
	}
	
}
