/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.sitemanagement.service;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.sitemanagement.HistoryType;
import com.tmap.sitemanagement.TABLE_NAME;
import com.tmap.sitemanagement.dao.HistoryInfoDAO;
import com.tmap.sitemanagement.vo.HistoryInfoListVO;
import com.tmap.sitemanagement.vo.MenuInfoListVO;
import com.tmap.systemmanagement.vo.ComCodeInfoListVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */
@Service
public class HistoryInfoService {
	@Autowired HttpServletRequest request;
	@Autowired
	HistoryInfoDAO historyInfoDAO;

	//히스토리 리스트
	public List<HistoryInfoListVO> historyInfoList(HistoryInfoListVO historyInfoListVO) throws Exception{

		//리스트 수를 조회하여 설정
		int totalCount = historyInfoDAO.countHistoryInfoList(historyInfoListVO);
		historyInfoListVO.setTotalCount(totalCount);

		return historyInfoDAO.historyInfoList(historyInfoListVO, historyInfoListVO.getStartRowNum(), historyInfoListVO.getCountPerPage());
	}

	//메뉴 리스트
	public List<MenuInfoListVO> menuList() throws Exception{

		return historyInfoDAO.menuList();
	}

	//코드 리스트
	public List<ComCodeInfoListVO> codeList() throws Exception{

		return historyInfoDAO.codeList();
	}

	/**
	 * 공통적으로 사용할 경우 이 메소드를 사용합니다.
	 * 기본적으로 
	 * insert( ... )
	 * update( ... )
	 * delete( ... )
	 * 위 세가지 메소드만을 사용하면됩니다.
	 * @param TYPE
	 * @param table_name		필요한 테이블이 없으면 enum에 추가하기
	 * @param menu_id		세션에 menuId 사용
	 * @param modyfi_id
	 * @param ip
	 * @param DATA_VO
	 * @return
	 * @throws Exception
	 */
	public HistoryInfoListVO getHistoryVO(HistoryType TYPE, TABLE_NAME table_name, String menu_id, String modyfi_id, String ip, Object DATA_VO) throws Exception {
		
		String history_data = vo2data(table_name.toString(), DATA_VO);
		
		HistoryInfoListVO historyVO = new HistoryInfoListVO();
		historyVO.setEvent_type(TYPE.toString());
		historyVO.setHistory_data(history_data);
		historyVO.setIp(ip);
		historyVO.setMenu_id(menu_id);
		historyVO.setModyfi_id(modyfi_id);
		
		historyInfoDAO.insertHistory(historyVO);
		
		return historyVO;
	}

	/**
	 * INSERT 히스토리를 입력합니다.
	 * @param table_name		INSERT 되는 테이블 명
	 * @param DATA_VO		사용한 VO
	 */
	public void insert(TABLE_NAME table_name,Object DATA_VO) throws Exception {
		getHistoryVO(HistoryType.INSERT, table_name, (String) request.getSession().getAttribute("menuId"), (String) request.getSession().getAttribute("userId"), request.getRemoteAddr(), DATA_VO);
	}

	/**
	 * INSERT 히스토리를 입력합니다.
	 * @param table_name		INSERT 되는 테이블 명
	 * @param menu_id		메뉴 ID
	 * @param modyfi_id		요청자 ID
	 * @param ip				요청자 IP
	 * @param DATA_VO		사용한 VO
	 */
	public void insert(TABLE_NAME table_name, String menu_id, String modyfi_id, String ip, Object DATA_VO) throws Exception {
		getHistoryVO(HistoryType.INSERT, table_name, menu_id, modyfi_id, ip, DATA_VO);
	}

	/**
	 * UPDATE 히스토리를 입력합니다.
	 * @param table_name		UPDATE 되는 테이블 명
	 * @param DATA_VO		사용한 VO
	 */
	public void update(TABLE_NAME table_name, Object DATA_VO) throws Exception {
		getHistoryVO(HistoryType.UPDATE, table_name, (String) request.getSession().getAttribute("menuId"), (String) request.getSession().getAttribute("userId"), request.getRemoteAddr(), DATA_VO);
	}

	/**
	 * UPDATE 히스토리를 입력합니다.
	 * @param table_name		UPDATE 되는 테이블 명
	 * @param menu_id		메뉴 ID
	 * @param modyfi_id		요청자 ID
	 * @param ip				요청자 IP
	 * @param DATA_VO		사용한 VO
	 */
	public void update(TABLE_NAME table_name, String menu_id, String modyfi_id, String ip, Object DATA_VO) throws Exception {
		getHistoryVO(HistoryType.UPDATE, table_name, menu_id, modyfi_id, ip, DATA_VO);
	}

	/**
	 * DELETE 히스토리를 입력합니다.
	 * @param table_name		DELETE 되는 테이블 명
	 * @param menu_id		메뉴 ID
	 * @param DATA_VO		사용한 VO
	 */
	public void delete(TABLE_NAME table_name, Object DATA_VO) throws Exception {
		getHistoryVO(HistoryType.DELETE, table_name, (String) request.getSession().getAttribute("menuId"), (String) request.getSession().getAttribute("userId"), request.getRemoteAddr(), DATA_VO);
	}

	/**
	 * DELETE 히스토리를 입력합니다.
	 * @param table_name		DELETE 되는 테이블 명
	 * @param menu_id		메뉴 ID
	 * @param modyfi_id		요청자 ID
	 * @param ip				요청자 IP
	 * @param DATA_VO		사용한 VO
	 */
	public void delete(TABLE_NAME table_name, String menu_id, String modyfi_id, String ip, Object DATA_VO) throws Exception {
		getHistoryVO(HistoryType.DELETE, table_name, menu_id, modyfi_id, ip, DATA_VO);
	}

	/**
	 * 입력된 VO의 테이블명, 필드명, 필드값을 하나의 String으로 만든다.
	 * @param tableName
	 * @param dataVO
	 * @return
	 */
	private String vo2data(String tableName, Object dataVO) {
		String data = null;
		
		try{
			
			Map<String,Map<String,String>> classMap = new HashMap<String,Map<String,String>>();
			Map<String,String> fieldMap = new HashMap<String,String>();
			
			String fieldName = null;
			Object fieldValue = null;
			
			Field[] fields = dataVO.getClass().getDeclaredFields();
			
			for( Field field : fields ) {
				try{
					field.setAccessible(true);
					fieldName = field.getName();
					fieldValue = field.get(dataVO);
					if( fieldValue != null ) {
						fieldMap.put(fieldName, String.valueOf(fieldValue));
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
			
			classMap.put(tableName, fieldMap);
			
			data =  classMap.toString();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return data;
	}
}
