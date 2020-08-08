package ldb.task.service;

import java.util.List;

import ldb.task.vo.BoardVO;

public interface BoardService {
	
	public List<BoardVO> selectBoard(BoardVO bvo);//��ü���
	public List<BoardVO> cheabunBoard(BoardVO bvo);//ä�����

	public boolean insertBoard(BoardVO bvo);//�����Է�
	
	public boolean updateHitnum(BoardVO bvo);//��ȸ������
	public List<BoardVO> searchBoard(BoardVO bvo);//�����
	
	public boolean deleteBoard(BoardVO bvo);//�Խñ� �����ϱ�

	public boolean updateBoard(BoardVO bvo);//�Խñ� �����ϱ�
	
	public List<BoardVO> checkPw(BoardVO bvo);//�Խñ� ��й�ȣ Ȯ���ϱ�

}
