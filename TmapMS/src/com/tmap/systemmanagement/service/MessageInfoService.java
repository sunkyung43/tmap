/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.systemmanagement.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.systemmanagement.dao.MessageInfoDAO;
import com.tmap.systemmanagement.vo.MessageInfoListVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */
@Service
public class MessageInfoService {

	@Autowired
	MessageInfoDAO messageInfoDAO;
	
	//공통메세지관리 리스트 출력
	public List<MessageInfoListVO> messageInfoList(MessageInfoListVO messageInfoListVO) throws Exception{
		
		//리스트 수를 조회하여 설정
		int totalCount = messageInfoDAO.countMessageInfoList(messageInfoListVO);
		messageInfoListVO.setTotalCount(totalCount);
		
		List<MessageInfoListVO> messageList = messageInfoDAO.messageInfoList(messageInfoListVO, messageInfoListVO.getStartRowNum(), messageInfoListVO.getCountPerPage());
		return messageList;
	}
	
	//공통메세지관리 등록
	public void messageInfoInsert(MessageInfoListVO messageInfoListVO) throws Exception{
		
		messageInfoDAO.messageInfoInsert(messageInfoListVO);
	}
	
	//공통메세지관리 수정폼
	public MessageInfoListVO messageModifyList(MessageInfoListVO messageInfoListVO) throws Exception{
		
		MessageInfoListVO messageModifyList = messageInfoDAO.messageModifyList(messageInfoListVO);
		
		return messageModifyList;
		
	}
		
	//공통메세지관리 수정
	public void messageInfoUpdate(MessageInfoListVO messageInfoListVO) throws Exception{
		
		messageInfoDAO.messageInfoUpdate(messageInfoListVO);
	}
		
	//공통메세지관리 삭제
	public void messageInfoDelete(MessageInfoListVO messageInfoListVO) throws Exception{
		
		messageInfoDAO.messageInfoDelete(messageInfoListVO);
	}
	
}
