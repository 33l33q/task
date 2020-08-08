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
		
		int iFlag = 0;
		iFlag = boardDao.insertBoard(bvo);
		
		if(iFlag != 0){
			logger.info("(log)BoardServiceImpl.insertBoard 종료, 작성 성공");     
			return true;
		}else{
			logger.info("(log)BoardServiceImpl.insertBoard 종료, 작성 실패");
			return false;
		}
	}

	@Override
	public boolean updateHitnum(BoardVO bvo) {
		logger.info("(log)BoardServiceImpl.updateHitnum 진입");
		int iFlag = 0;
		iFlag = boardDao.updateHitnum(bvo);
		
		if(iFlag != 0 ){
			logger.info("(log)BoardServiceImpl.updateHitnum 종료, 조회수 증가");
			return true;
			
		}else{
			logger.info("(log)BoardServiceImpl.updateHitnum 종료, 증가 실패");
			return false;
		}
	}

	@Override
	public List<BoardVO> searchBoard(BoardVO bvo) {
		logger.info("(log)BoardServiceImpl.searchBoard 진입");
		List<BoardVO> sList = null;
		sList = boardDao.searchBoard(bvo);
		logger.info("(log)BoardServiceImpl.searchBoard 종료");
		return sList;
	}

	@Override
	public boolean deleteBoard(BoardVO bvo) {
		logger.info("(log)BoardServiceImpl.deleteBoard 진입");
		int iFlag = 0;
		iFlag = boardDao.deleteBoard(bvo);
		if(iFlag != 0){
			logger.info("(log)BoardServiceImpl.deleteBoard 종료");
			return true;
		}else{
			logger.info("(log)BoardServiceImpl.deleteBoard 종료");
			return false;	
		}
	}

	@Override
	public boolean updateBoard(BoardVO bvo) {
		logger.info("(log)BoardServiceImpl.updateBoard 진입");
		int iFlag = 0;
		iFlag = boardDao.updateBoard(bvo);
		if(iFlag != 0){
			logger.info("(log)BoardServiceImpl.updateBoard 종료");
			return true;
		}else{
			logger.info("(log)BoardServiceImpl.updateBoard 종료");
			return false;	
		}
	}

	@Override
	public List<BoardVO> checkPw(BoardVO bvo) {
		logger.info("(log)BoardServiceImpl.checkPw 진입");
		List<BoardVO> aList = null;
		aList = boardDao.checkPw(bvo);
		logger.info("(log)BoardServiceImpl.checkPw 종료");
		return aList;
	}
	
	
	
	
	
}
