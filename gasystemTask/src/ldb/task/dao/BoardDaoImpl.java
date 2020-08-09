package ldb.task.dao;

import java.util.List;

import ldb.task.vo.BoardVO;
import ldb.task.vo.ReplyVO;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDaoImpl implements BoardDao {
	private SqlSession session;

	@Override
	public List<BoardVO> selectBoard(BoardVO bvo) {
		return session.selectList("selectBoard", bvo);
	}

	@Override
	public List<BoardVO> cheabunBoard(BoardVO bvo) {
		return session.selectOne("cheabunBoard", bvo);
	}

	@Override
	public int insertBoard(BoardVO bvo) {
		return session.insert("insertBoard", bvo);
	}

	@Override
	public int updateHitnum(BoardVO bvo){
		return session.update("updateHitnum", bvo);
	}

	@Override
	public List<BoardVO> searchBoard(BoardVO bvo) {
		return session.selectList("searchBoard", bvo);
	}

	@Override
	public int deleteBoard(BoardVO bvo) {
		return session.update("deleteBoard", bvo);
	}

	@Override
	public int updateBoard(BoardVO bvo) {
		return session.update("updateBoard", bvo);
	}

	@Override
	public List<BoardVO> checkPw(BoardVO bvo) {
		return session.selectOne("checkPw", bvo);
	}

	/**************************************************/
	
	@Override
	public List<ReplyVO> selectReply(ReplyVO rvo) {
		return session.selectList("selectReply", rvo);
	}

	@Override
	public int insertReply(ReplyVO rvo) {
		return session.insert("insertReply", rvo);
	}

	@Override
	public List<ReplyVO> cheabunReply(ReplyVO rvo) {
		return session.selectOne("cheabunReply", rvo);
	}

	@Override
	public List<ReplyVO> searchReply(ReplyVO rvo) {
		return session.selectList("searchReply", rvo);
	}

	@Override
	public int updateReply(ReplyVO rvo) {
		return session.update("updateReply", rvo);
	}

	@Override
	public int deleteReply(ReplyVO rvo) {
		return session.delete("deleteReply", rvo);
	}
	
	
	
}
