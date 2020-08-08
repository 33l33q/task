package ldb.task.dao;

import java.util.List;

import ldb.task.vo.BoardVO;

public interface BoardDao {

	public List<BoardVO> selectBoard(BoardVO bvo);
	
	public List<BoardVO> cheabunBoard(BoardVO bvo);
	public int insertBoard(BoardVO bvo);
	
	public int updateHitnum(BoardVO bvo);
	public List<BoardVO> searchBoard(BoardVO bvo);

	public int deleteBoard(BoardVO bvo);
	public int updateBoard(BoardVO bvo);
	
	public List<BoardVO> checkPw(BoardVO bvo);
}
