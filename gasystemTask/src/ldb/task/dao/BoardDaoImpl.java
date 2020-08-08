package ldb.task.dao;

import java.util.List;

import ldb.task.vo.BoardVO;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDaoImpl implements BoardDao {
	private SqlSession session;

	@Override
	public List<BoardVO> selectBoard(BoardVO bvo) {
		return session.selectList("selectBoard");
	}

	@Override
	public List<BoardVO> cheabunBoard(BoardVO bvo) {
		return session.selectOne("cheabunBoard");
	}

	@Override
	public int insertBoard(BoardVO bvo) {
		return session.insert("insertBoard");
	}

	@Override
	public int updateHitnum(BoardVO bvo){
		return session.update("updateHitnum");
	}

	@Override
	public List<BoardVO> searchBoard(BoardVO bvo) {
		return session.selectList("searchBoard");
	}

	@Override
	public int deleteBoard(BoardVO bvo) {
		return session.update("deleteBoard");
	}

	@Override
	public int updateBoard(BoardVO bvo) {
		return session.update("updateBoard");
	}

	@Override
	public List<BoardVO> checkPw(BoardVO bvo) {
		return session.selectOne("checkPw", bvo);
	}
	
	
	
}
