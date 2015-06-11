package com.tmap.login.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.login.vo.MenuInfoVO;

@Repository
public class MenuDAO {
	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	public List<MenuInfoVO> userMenuList(String userId) {
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.menuSqlMap.userMenuList", userId);
	}

}
