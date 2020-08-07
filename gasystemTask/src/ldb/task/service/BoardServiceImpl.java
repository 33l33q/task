package ldb.task.service;
import java.util.List;

import ldb.task.dao.BoardDao;
import ldb.task.vo.BoardVO;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;

	Logger logger = Logger.getLogger(BoardServiceImpl.class);
	
	@Override
	public List<BoardVO> selectBoard(BoardVO bvo) {
		logger.info("(log)BoardServiceImpl.selectBoard 진입");
		List<BoardVO> sList = null;
		sList =	boardDao.selectBoard(bvo);
		logger.info("(log)BoardServiceImpl.selectBoard 종료");
		return sList;
	}

	@Override
	public List<BoardVO> cheabunBoard(BoardVO bvo) {
		logger.info("(log)BoardServiceImpl.cheabunBoard 진입");
		List<BoardVO> aList = null;
		aList = boardDao.cheabunBoard(bvo);
		logger.info("(log)BoardServiceImpl.cheabunBoard 종료");
		return aList;
	}

	@Override
	public boolean insertBoard(BoardVO bvo) {
		logger.info("(log)BoardServiceImpl.insertBoard 진입");
		
		int result = 0;
		result = boardDao.insertBoard(bvo);
		
		if(result != 0){
			logger.info("(log)BoardServiceImpl.insertBoard 종료");
			return true;
		}else{
			logger.info("(log)BoardServiceImpl.insertBoard 종료");
			return false;
		}
	}
	
	 
	
	
}
