package ldb.task.service;

import java.util.List;

import ldb.task.vo.BoardVO;

public interface BoardService {
	
	public List<BoardVO> selectBoard(BoardVO bvo);//전체출력
	
	public List<BoardVO> cheabunBoard(BoardVO bvo);//채번출력
	public boolean insertBoard(BoardVO bvo);//정보입력

}
