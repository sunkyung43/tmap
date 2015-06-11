package com.tmap.common;

public class CommonUtil {
	
	/**
	 * 전화번호 하이픈(-) 추가
	 * @param telNumber 핸드폰 번호 혹은 일반 전화번호
	 * @return 010-1234-5678, 031-123-4567, 02-1234-5678...
	 */
	public static String telNumberFormat(String telNumber) {
		if (telNumber == null || "".equals(telNumber)) {
			return "";
		}
	
		try {
			telNumber = telNumber.trim();
			
			int len = telNumber.length();
			int num = Integer.parseInt(telNumber.substring(1, 2));
			if (len == 11) {
				//010 3221 2663
				return telNumber.substring(0, 3) + '-' + telNumber.substring(3, 7) + '-' + telNumber.substring(7);
			} else if (len == 10) {
				if (num == 2) {
					//02 2028 3434
					return telNumber.substring(0, 2) + '-' + telNumber.substring(2, 6) + '-' + telNumber.substring(6);
				} else if (num > 2) {
					//031 987 3434
					return telNumber.substring(0, 3) + '-' + telNumber.substring(3, 6) + '-' + telNumber.substring(6);
				} else {
					//016 221 2663
					return telNumber.substring(0, 3) + '-' + telNumber.substring(3, 6) + '-' + telNumber.substring(6);
				}
			} else if (len == 9) {
				if (num == 2) {
					//02 852 3662
					return telNumber.substring(0, 2) + '-' + telNumber.substring(2, 5) + '-' + telNumber.substring(5);
				}
			}
			
			return telNumber;
		} catch (Exception e) {
			return "";
		}
	}
	
	public static boolean isEmpty(Object obj) {
		if (obj == null) {
			return true;
		}
		
		if (obj instanceof String) {
			String str = (String) obj;
			if (str == null || str.length() < 1 || "".equals(str)) {
				return true;
			}
		} else {
		}
		
		return false;
	}
	
	public static boolean isNotEmpty(Object obj) {
		return !isEmpty(obj);
	}
}
