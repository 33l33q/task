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
		return session.selectOne("cheabunBoard", bvo);
	}

	@Override
	public int insertBoard(BoardVO bvo) {
		return session.insert("insertBoard", bvo);
	}
	
	
}
