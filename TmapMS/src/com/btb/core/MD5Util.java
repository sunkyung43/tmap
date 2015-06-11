package com.btb.core;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;


public class MD5Util {
		
	public String getStringCheckSum(String str) {
		return createStringCheckSum(str);
	}
	
	private String createStringCheckSum(String strInput) {
		String strOut = "";
		try { 
			MessageDigest digest = MessageDigest.getInstance("MD5");
			digest.update(strInput.getBytes());
			byte[] hash = digest.digest(); 
			StringBuffer sb = new StringBuffer();
			
			for (int i = 0; i < hash.length; i++) { 
				String strHash = Integer.toHexString(0xff&(char) hash[i]);				
				sb.append(strHash.length() == 1 ? "0" : "").append(strHash);				
			}
			
			strOut = sb.toString();
		} catch (NoSuchAlgorithmException nsae) {
			strOut = strInput;
		}
		return strOut;
	}
	
	private String encryptString(String str) {
		StringBuffer sb = new StringBuffer();
				
		try {
			MessageDigest md5 = MessageDigest.getInstance("MD5");
			md5.update(str.getBytes());
			byte[] md5Bytes = md5.digest();
			
			for (int i=0; i<md5Bytes.length; i++) {				
				sb.append(md5Bytes[i]);	
			}
		} catch(Exception e) {}
		
		return sb.toString();
	}
	
	private int fileReadSize;
	private String filePath;
	private MessageDigest digest;
	private File file; 
	private long file_size;
	private FileInputStream in;
	private byte arr[];
	private int cnt;
		
	public void setFileReadSize(int arraySize) {
		this.fileReadSize = arraySize;		
	}
	
	public String getFileCheckSum(String filePath) {
		this.filePath = filePath;
		return createFileCheckSum();
	}
	
	private String createFileCheckSum() {		
		digest = null;

		try {
			digest = MessageDigest.getInstance("MD5");
			file = new File(filePath);
			file_size = file.length();
			in = new FileInputStream(filePath);

			cnt = 0;
			
			while (true) {
				long temp = (file_size - cnt);

				if (temp < fileReadSize) {   // 맨 마지막 버퍼  
					arr = new byte[(int)temp];
					in.read(arr);
					digest.update(arr);
					cnt += temp;
					break;
				} else {
					arr = new byte[fileReadSize];
				}

				in.read(arr);
				digest.update(arr);
				cnt += fileReadSize;
			}					
			in.close();

		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return null;
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		return hashByte2MD5(digest.digest());	
	}

	private String hashByte2MD5(byte[] hash) {
		StringBuffer hexString = new StringBuffer();
		for (int i=0; i<hash.length; i++) {
			if ( (0xff & hash[i]) <0x10 ) {
				hexString.append("0" + Integer.toHexString(0xff & hash[i]));
			} else {
				hexString.append(Integer.toHexString(0xff & hash[i]));
			}
		}
		return hexString.toString();
	}
}