package ldb.task.controller;

import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import ldb.task.service.BoardService;
import ldb.task.utils.ChaebunUtil;
import ldb.task.utils.FileUploadUtil;
import ldb.task.utils.PrintVOUtil;
import ldb.task.vo.BoardVO;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping("/board")
@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	Logger logger = Logger.getLogger(BoardController.class); //�α׼���
	
	final static String ABSTRACT_PATH =  "C://Users//BEE//Desktop//gasystem_task//gasystemTask//WebContent//image";
	final static String RELATIVE_PATH = "image//";
	final static String BOARD_GUBUN = "B";
	
	//��ü �� ���
	@RequestMapping("/selectBoard")
	public String selectBoard(@ModelAttribute BoardVO bvo, Model model, HttpServletRequest request){
		logger.info("(log)BoardController.selectBoard ���� >>> ");
		List<BoardVO> selectBoard = null;
		selectBoard = boardService.selectBoard(bvo);
		
		model.addAttribute("boardAllList",selectBoard);
		model.addAttribute("bvo",bvo);
		
		String url = "selectBoard";
		
		logger.info("(log)BoardController.selectBoard ���� >>> ");
		
		return url;
	}
	
	//�۾��� �������� �̵��ϱ�
	@RequestMapping("/moveToInsert")
	public String moveToInsert(){
		logger.info("(log)�۾��� �������� �̵�");
		String url = "insertBoard";
		return url;
	}

	//���Է��ϱ�
	@RequestMapping(value="/insertBoard", method=RequestMethod.POST)
	public String insertBoard(@ModelAttribute BoardVO bvo, Model model, HttpServletRequest request ){
		logger.info("(log)BoardController.insertBoard ���� >> ");
		String url = "";
		List<BoardVO> chaebunList = null;
		chaebunList = boardService.cheabunBoard(bvo);
		
		String cNum = chaebunList.get(0).getLnum();
		
		//�Խ��� �� ä�� �� ����
		bvo.setLnum(ChaebunUtil.chaebunNum(cNum, BOARD_GUBUN));
		logger.info("ä�� Ȯ�� >>> " +  bvo.getLnum());
		
		FileUploadUtil fuu = new FileUploadUtil();
		 	
		boolean bFlag = false;
		String filePath = "n";
		bFlag = fuu.fileUpload(request, ABSTRACT_PATH);
		
		if(bFlag){
			Enumeration<String> en = fuu.getFileNames();
			String limage = null;
			limage  = en.nextElement();
			
			if(limage == null)	bvo.setLimage("");
			else if(limage != null) bvo.setLimage(RELATIVE_PATH+limage);

			logger.info("(log)multipartRequest 5");
			bvo.setLid(fuu.getParameter("lid"));
			bvo.setLpw(fuu.getParameter("lpw"));
			bvo.setLcontent(fuu.getParameter("lcontent"));
			bvo.setLtitle(fuu.getParameter("ltitle"));

			//vo�� ����� ������ ����ؼ� Ȯ���ϱ�
			PrintVOUtil.boardVOPrint(bvo);
			
		}else{
			logger.info("(log)multipartRequest ����");
			url = "/board/selectBoard.ldb";
			return "redirect:" + url;
		}
		
		boolean result = false;
		result = boardService.insertBoard(bvo);
		
		if(result){
			url = "/board/searchBoard?lnum="+bvo.getLnum();
		}else{
			url = "/board/selectBoard";
		}

		return "rediect:" + url;
	}
	
	@RequestMapping("/moveToSearch")
	public String moveToSearch(@ModelAttribute BoardVO bvo, Model model){
		logger.info("(log)�󼼺��� �������� �̵�");
		
		String url = "searchBoard";
		return url;
	}
	
	

}//end of controller
