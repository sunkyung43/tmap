package com.tmap.login.dao;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.login.vo.UserInfoVO;

@Repository
public class LoginDAO {
	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	public UserInfoVO userInfo(String userId) {
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.loginSqlMap.userInfo", userId);
	}
}
