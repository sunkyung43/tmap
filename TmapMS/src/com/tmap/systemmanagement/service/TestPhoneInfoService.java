/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.systemmanagement.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.systemmanagement.dao.TestPhoneInfoDAO;
import com.tmap.systemmanagement.vo.TestPhoneInfoListVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */
@Service
public class TestPhoneInfoService {

	@Autowired
	TestPhoneInfoDAO testPhoneInfoDAO;
	
	//테스트폰관리 리스트 출력
	public List<TestPhoneInfoListVO> testPhoneInfoList(TestPhoneInfoListVO testPhoneInfoListVO) throws Exception{
		
		//리스트 수를 조회하여 설정
		int totalCount = testPhoneInfoDAO.countTestPhoneInfoList(testPhoneInfoListVO);
		testPhoneInfoListVO.setTotalCount(totalCount);
		
		List<TestPhoneInfoListVO> testPhoneList = testPhoneInfoDAO.testPhoneInfoList(testPhoneInfoListVO, testPhoneInfoListVO.getStartRowNum(), testPhoneInfoListVO.getCountPerPage());
		return testPhoneList;
	}
	
	//테스트폰관리 등록
	public void testPhoneInfoInsert(TestPhoneInfoListVO testPhoneInfoListVO) throws Exception{
		
		testPhoneInfoListVO.setUserId("admin");
		testPhoneInfoListVO.setUserName("admin");
		testPhoneInfoDAO.testPhoneInfoInsert(testPhoneInfoListVO);
	}
	
	//테스트폰관리 수정폼
	public TestPhoneInfoListVO testPhoneModifyList(TestPhoneInfoListVO testPhoneInfoListVO) throws Exception{
		
		TestPhoneInfoListVO testPhoneModifyList = testPhoneInfoDAO.testPhoneModifyList(testPhoneInfoListVO);
		
		return testPhoneModifyList;
		
	}
	
	//테스트폰관리 수정
	public void testPhoneInfoUpdate(TestPhoneInfoListVO testPhoneInfoListVO) throws Exception{
		
		testPhoneInfoDAO.testPhoneInfoUpdate(testPhoneInfoListVO);
	}
	
	//테스트폰관리 삭제
	public void testPhoneInfoDelete(TestPhoneInfoListVO testPhoneInfoListVO) throws Exception{
		
		testPhoneInfoDAO.testPhoneInfoDelete(testPhoneInfoListVO);
	}
	
}
