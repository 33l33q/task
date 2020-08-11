/****** 글 작성 및 수정 시 MultipartRequest를 거쳐가는 공통 클래스 *******/
package ldb.task.utils;

import java.util.Enumeration;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.oreilly.servlet.MultipartRequest;

public class FileUploadUtil {
	

	static Logger logger = Logger.getLogger(FileUploadUtil.class);
	
	private static final int  SIZE_LIMIT = 5240880;
	private MultipartRequest m;
	
	public boolean fileUpload(HttpServletRequest request, String filePath){
		boolean result = false;
		
		try{
			
			 m = new MultipartRequest(	request, 
					 					filePath, 
					 					SIZE_LIMIT, 
					 					"UTF-8", 
					 					new FileName());
			 
			 result = true;
			 
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return result;
	}
	
	public String getParameter(String s){
		return m.getParameter(s);
	}
	
	public Enumeration<String> getFileNames(){
		Enumeration<String> en = m.getFileNames();
		Vector<String> v = new Vector<String>();
	
		while(en.hasMoreElements()){
			String fileName = en.nextElement().toString();
			 v.add(m.getFilesystemName(fileName));
		}
		return v.elements();
	}
}
