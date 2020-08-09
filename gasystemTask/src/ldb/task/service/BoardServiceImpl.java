package ldb.task.service;
import java.util.List;

import ldb.task.dao.BoardDao;
import ldb.task.vo.BoardVO;
import ldb.task.vo.ReplyVO;

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
		logger.info("(log)BoardServiceImpl.selectBoard ����");
		List<BoardVO> sList = null;
		sList =	boardDao.selectBoard(bvo);
		logger.info("(log)BoardServiceImpl.selectBoard ����");
		return sList;
	}

	@Override
	public List<BoardVO> cheabunBoard(BoardVO bvo) {
		logger.info("(log)BoardServiceImpl.cheabunBoard ����");
		List<BoardVO> aList = null;
		aList = boardDao.cheabunBoard(bvo);
		logger.info("(log)BoardServiceImpl.cheabunBoard ����");
		return aList;
	}

	@Override
	public boolean insertBoard(BoardVO bvo) {
		logger.info("(log)BoardServiceImpl.insertBoard ����");
		
		int iFlag = 0;
		iFlag = boardDao.insertBoard(bvo);
		
		if(iFlag != 0){
			logger.info("(log)BoardServiceImpl.insertBoard ����, �ۼ� ����");     
			return true;
		}else{
			logger.info("(log)BoardServiceImpl.insertBoard ����, �ۼ� ����");
			return false;
		}
	}

	@Override
	public boolean updateHitnum(BoardVO bvo) {
		logger.info("(log)BoardServiceImpl.updateHitnum ����");
		int iFlag = 0;
		iFlag = boardDao.updateHitnum(bvo);
		
		if(iFlag != 0 ){
			logger.info("(log)BoardServiceImpl.updateHitnum ����, ��ȸ�� ����");
			return true;
			
		}else{
			logger.info("(log)BoardServiceImpl.updateHitnum ����, ���� ����");
			return false;
		}
	}

	@Override
	public List<BoardVO> searchBoard(BoardVO bvo) {
		logger.info("(log)BoardServiceImpl.searchBoard ����");
		List<BoardVO> sList = null;
		sList = boardDao.searchBoard(bvo);
		logger.info("(log)BoardServiceImpl.searchBoard ����");
		return sList;
	}

	@Override
	public boolean deleteBoard(BoardVO bvo) {
		logger.info("(log)BoardServiceImpl.deleteBoard ����");
		int iFlag = 0;
		iFlag = boardDao.deleteBoard(bvo);
		if(iFlag != 0){
			logger.info("(log)BoardServiceImpl.deleteBoard ����");
			return true;
		}else{
			logger.info("(log)BoardServiceImpl.deleteBoard ����");
			return false;	
		}
	}

	@Override
	public boolean updateBoard(BoardVO bvo) {
		logger.info("(log)BoardServiceImpl.updateBoard ����");
		int iFlag = 0;
		iFlag = boardDao.updateBoard(bvo);
		if(iFlag != 0){
			logger.info("(log)BoardServiceImpl.updateBoard ����");
			return true;
		}else{
			logger.info("(log)BoardServiceImpl.updateBoard ����");
			return false;	
		}
	}

	@Override
	public List<BoardVO> checkPw(BoardVO bvo) {
		logger.info("(log)BoardServiceImpl.checkPw ����");
		List<BoardVO> aList = null;
		aList = boardDao.checkPw(bvo);
		logger.info("(log)BoardServiceImpl.checkPw ����");
		return aList;
	}
	
	/********************************************************************/
	
	
	@Override
	public List<ReplyVO> selectReply(ReplyVO rvo) {
		logger.info("(log)BoardServiceImpl.selectReply ����");
		List<ReplyVO> sList = null;
		sList = boardDao.selectReply(rvo);
		logger.info("(log)BoardServiceImpl.selectReply ����");
		return sList;
	}

	@Override
	public boolean insertReply(ReplyVO rvo) {
		logger.info("(log)BoardServiceImpl.insertReply ����");
		int iFlag = 0;
		iFlag = boardDao.insertReply(rvo);
		if(iFlag == 0){
			logger.info("(log)BoardServiceImpl.insertReply ����");
			return false;
		}else{
			logger.info("(log)BoardServiceImpl.insertReply ����");
			return true;
		}
	}

	@Override
	public List<ReplyVO> cheabunReply(ReplyVO rvo) {
		logger.info("(log)BoardServiceImpl.cheabunReply ����");
		
		List<ReplyVO> aList = null;
		aList = boardDao.cheabunReply(rvo);
		logger.info("(log)BoardServiceImpl.cheabunReply ����");
		return aList;
	}

	@Override
	public List<ReplyVO> searchReply(ReplyVO rvo) {
		logger.info("(log)BoardServiceImpl.searchReply ����");
		
		List<ReplyVO> sList = null;
		sList = boardDao.searchReply(rvo);
		
		logger.info("(log)BoardServiceImpl.searchReply ����");
		return sList;
	}

	@Override
	public boolean updateReply(ReplyVO rvo) {
		logger.info("(log)BoardServiceImpl.updateReply ����");
		int iFlag = 0;
		iFlag = boardDao.updateReply(rvo);
		if(iFlag == 0){
			logger.info("(log)BoardServiceImpl.updateReply ����");
			return false;
		}else{
			logger.info("(log)BoardServiceImpl.updateReply ����");
			return true;
		}
		
	}

	@Override
	public boolean deleteReply(ReplyVO rvo) {
		logger.info("(log)BoardServiceImpl.deleteReply ����");
		int iFlag = 0;
		iFlag = boardDao.deleteReply(rvo);
		if(iFlag == 0){
			logger.info("(log)BoardServiceImpl.deleteReply ����");
			return false;
		}else{
			logger.info("(log)BoardServiceImpl.deleteReply ����");
			return true;
		}
		
	}

	
	
	
}
