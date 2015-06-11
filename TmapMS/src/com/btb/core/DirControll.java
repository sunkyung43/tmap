package com.btb.core;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;

public class DirControll {

	public static boolean deleteFolder(File targetFolder) {

		File[] childFile = targetFolder.listFiles();
		boolean confirm = false;
		int size = (childFile == null) ? 0 : childFile.length;

		if (size > 0) {

			for (int i = 0; i < size; i++) {

				if (childFile[i].isFile()) {
					confirm = childFile[i].delete();
				} else {
					deleteFolder(childFile[i]);
				}
			}
		}
		targetFolder.delete();
		return (!targetFolder.exists());
	}

	public static void copyDirectory(File sourceLocation, File targetLocation) throws IOException {

		if (sourceLocation.isDirectory()) {
			if (!targetLocation.isDirectory()) {
				targetLocation.mkdir();
			}
			String[] children = sourceLocation.list();
			for (int i = 0; i < children.length; i++) {
				File sourceFile = new File(sourceLocation + "/" + children[i]);
				File targetFile = new File(targetLocation + "/" + children[i]);
				FileUtils.copyFile(sourceFile, targetFile);
			}
		} else {
		}
	}
	
	public static File makeDir(String path){

		if(path == null || path.trim().length() == 0)
			return null;
		try {

			File mkdir = new File(path);

			if(mkdir.isDirectory())
				return mkdir;

			if(!mkdir.mkdirs()) {
				return null;
			}

			return mkdir;
		}
		catch(Exception e){
			return null;
		}		
	}
}