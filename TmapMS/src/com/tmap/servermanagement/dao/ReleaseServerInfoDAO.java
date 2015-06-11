/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.servermanagement.dao;


import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.servermanagement.vo.RsInterfaceInfoVO;
import com.tmap.servermanagement.vo.SystemInfoVO;
import com.tmap.systemmanagement.vo.MessageInfoListVO;


/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 9. 6. 
 */
@Repository
public class ReleaseServerInfoDAO {

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<SystemInfoVO> rsServerList(){
		
		return sqlSessionTemplate.selectList("releaseServerInfoSqlMap.rsServerList");
	}
	
	public List<RsInterfaceInfoVO> rsInterfaceList(){
		
		return sqlSessionTemplate.selectList("releaseServerInfoSqlMap.rsInterfaceList");
	}
	
	public List<MessageInfoListVO> messageList(){
		
		return sqlSessionTemplate.selectList("releaseServerInfoSqlMap.messageList");
	}
}
