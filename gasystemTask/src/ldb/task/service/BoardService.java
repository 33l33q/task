package ldb.task.service;

import java.util.List;

import ldb.task.vo.BoardVO;

public interface BoardService {
	
	public List<BoardVO> selectBoard(BoardVO bvo);//��ü���
	
	public List<BoardVO> cheabunBoard(BoardVO bvo);//ä�����
	public boolean insertBoard(BoardVO bvo);//�����Է�

}
