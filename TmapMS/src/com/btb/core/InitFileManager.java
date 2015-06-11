package com.btb.core;

import java.io.File;
import java.io.FileInputStream;
import java.util.Properties;

public class InitFileManager {
	private Properties properties;
	private static InitFileManager instance;
	private static String CLASSES_ROOT;
	private static String CONF_ROOT;
	private InitFileManager() {
		properties = new Properties();

		try {

			CLASSES_ROOT = getClass().getResource("/Init.property").getPath();
			CLASSES_ROOT = CLASSES_ROOT.replaceAll("%20", " ");

			if("\\".equals(System.getProperty("file.separator")) && CLASSES_ROOT.startsWith("/"))
				CLASSES_ROOT = CLASSES_ROOT.substring(1);

			CLASSES_ROOT = CLASSES_ROOT.replaceAll("/Init\\.property", "");

			if(CLASSES_ROOT.endsWith("/"))
				CLASSES_ROOT = CLASSES_ROOT.substring(0, CLASSES_ROOT.length()-1);

			CONF_ROOT = CLASSES_ROOT+"/";
			properties.load(new FileInputStream(new File(CONF_ROOT+"Init.property")));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static InitFileManager getInstance() {
		if (instance == null) {
			instance = new InitFileManager();
		}
		return instance;
	}

	public static String getProperty(String key) {
		return InitFileManager.getInstance().properties.getProperty(key);
	}

	public static String getProperty(String key, String defaultValue) {
		String keyValue = getProperty(key);
		return keyValue==null||"".equals(keyValue)||keyValue.length() < 1 ? defaultValue : keyValue;
	}
}