package ldb.task.utils;


import ldb.task.vo.BoardVO;

import org.apache.log4j.Logger;

public abstract class PrintVOUtil {

	static Logger logger = Logger.getLogger(PrintVOUtil.class);
	
	public static void boardVOPrint(BoardVO bvo){
		
		logger.info("(log) bvo.getLtitle() >>>" + bvo.getLtitle());
		logger.info("(log) bvo.getLcontent()>>>" + bvo.getLcontent());
		logger.info("(log) bvo.getLhitnum()>>>" + bvo.getLhitnum());
		logger.info("(log) bvo.getLimage()>>>" + bvo.getLimage());
		logger.info("(log) bvo.getLnum()>>>" + bvo.getLnum());
		logger.info("(log) bvo.getLpw()>>>" + bvo.getLpw());
		logger.info("(log) bvo.getLid() >>>" + bvo.getLid());
		logger.info("(log) bvo.getLupdatedate() >>>" + bvo.getLupdatedate());
		logger.info("(log) bvo.getLinsertdate()>>>" + bvo.getLinsertdate());
		
	}//end of main
}//end of class
