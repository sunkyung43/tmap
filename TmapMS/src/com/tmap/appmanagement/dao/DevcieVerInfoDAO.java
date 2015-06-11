package com.tmap.appmanagement.dao;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.appmanagement.vo.PhModelInfoListVO;

@Repository
public class DevcieVerInfoDAO {

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int checkVermodelInfo(PhModelInfoListVO phModelInfoListVO) throws Exception {
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.deviceVerInfosqlMap.checkVermodelInfo", phModelInfoListVO);
	}
	
	public int newVerModelInfo(PhModelInfoListVO phModelInfoListVO) throws Exception {
		
		return sqlSessionTemplate.insert("com.tmap.sqlMap.deviceVerInfosqlMap.newVerModelInfo", phModelInfoListVO);
	}
}
