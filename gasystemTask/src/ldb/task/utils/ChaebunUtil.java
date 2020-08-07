package ldb.task.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.log4j.Logger;


public abstract class ChaebunUtil {
	
	static Logger logger = Logger.getLogger(ChaebunUtil.class);
	
	//������ȣ ���� Ŭ����
	public static String chaebunNum(String cNum, String gubun){

		logger.info("(log)chaebun util����");
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yymmdd");
		String date = sdf.format(d);
		String chaebun = "";
		
		chaebun = gubun + date + cNum;
		
		return chaebun;
	}
	
}