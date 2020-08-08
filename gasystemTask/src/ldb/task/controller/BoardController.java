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
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@RequestMapping("/board")
@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	Logger logger = Logger.getLogger(BoardController.class); //로그설정
	
	final static String ABSTRACT_PATH =  "C://Users//BEE//Desktop//gasystem_task//gasystemTask//WebContent//image";
	final static String RELATIVE_PATH = "image//";
	final static String BOARD_GUBUN = "B";
	
	
	//전체 글 출력
	@RequestMapping("/selectBoard")
	public String selectBoard(@ModelAttribute BoardVO bvo, Model model){
		logger.info("(log)BoardController.selectBoard 시작 >>> ");
		List<BoardVO> selectBoard = null;
		selectBoard = boardService.selectBoard(bvo);
		
		model.addAttribute("boardAllList",selectBoard);
		model.addAttribute("bvo",bvo);
		
		String url = "selectBoard";
		
		logger.info("(log)BoardController.selectBoard 종료 >>> ");
		 	
		return url;
	}
	
	//글쓰기 페이지로 이동하기
	@RequestMapping("/moveToInsert")
	public String moveToInsert(){
		logger.info("(log)글쓰기 페이지로 이동");
		String url = "insertBoard";
		return url;
	}
	
	//글입력하기
	@RequestMapping(value="/insertBoard", method=RequestMethod.POST)
	public String insertBoard(@ModelAttribute BoardVO bvo, Model model, HttpServletRequest request ){
		logger.info("(log)BoardController.insertBoard 진입 >> ");
		String url = "";
		List<BoardVO> chaebunList = null;
		chaebunList = boardService.cheabunBoard(bvo);
		
		String cNum = chaebunList.get(0).getLnum();
		
		//게시판 글 채번 값 설정
		bvo.setLnum(ChaebunUtil.chaebunNum(cNum, BOARD_GUBUN));
		logger.info("채번 확인 >>> " +  bvo.getLnum());
		
		FileUploadUtil fuu = new FileUploadUtil();
		 	
		boolean bFlag = false;
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

			//vo값 제대로 들어갔는지 출력해서 확인하기
			PrintVOUtil.boardVOPrint(bvo);
			
		}else{
			logger.info("(log)multipartRequest 오류");
			url = "/board/selectBoard.ldb";
			return "redirect:" + url;
		}
		
		boolean result = false;
		result = boardService.insertBoard(bvo);
		
		if(result){
			url = "searchBoard.ldb?lnum="+bvo.getLnum();
		}else{
			url = "selectBoard";
		}

		return "redirect:" + url ;
	}
	
	//상세보기 출력
	@RequestMapping("/searchBoard")
	public String searchBoard(@ModelAttribute BoardVO bvo, Model model,HttpServletRequest request){
		logger.info("(log)BoardController.searchBoard 진입 >>> ");
		String url = "";
		String lnum = "";

			//조회수 증가
			boolean bFlag = false;
			bFlag = boardService.updateHitnum(bvo);
			
			logger.info("(log)조회수 증가 >>> " + bFlag);
			
			//상세조회
			lnum = bvo.getLnum();
			logger.info("(log)글번호 확인 >>> " + lnum);
			List<BoardVO> searchList = null;
			searchList = boardService.searchBoard(bvo);
			if(searchList.size() != 0){
				model.addAttribute("searchList", searchList);
				url = "searchBoard";
			}else{
				url = "redirect:selectBoard.ldb";
			}

		return url;
	
	}
	
	@RequestMapping("/deleteBoard")
	public String deleteBoard(@ModelAttribute BoardVO bvo, Model model, HttpServletRequest request){
		logger.info("(log)BoardController.deleteBoard 진입 >>> ");
		String url = "";
		String lnum = "";
		boolean result = false;
		
		lnum = bvo.getLnum();
		logger.info("(log)lnum 확인 >>>" + lnum); 
		if(lnum == null){
			lnum = request.getParameter(lnum);
		}
		
		result = boardService.deleteBoard(bvo);
		
		if(result){
			url = "redirect:selectBoard.ldb";
		}else{
			url = "redirect:searchBoard.ldb?lnum=" + lnum;
		}
		
		logger.info("(log)BoardController.deleteBoard 종료 >> ");
		
		return url;
	}
	
	@RequestMapping("/moveToUpdate")
	public String moveToUpdate(@ModelAttribute BoardVO bvo, Model model, HttpServletRequest request){
		logger.info("(log)수정페이지로 이동하기~~~ >>> ");
		String url = "";
		String message = "";
		String lnum = "";
		
		lnum = bvo.getLnum();
		List<BoardVO> searchList = null;
		
		searchList = boardService.searchBoard(bvo);

		if(!searchList.isEmpty()){
			model.addAttribute("searchList",searchList);
			model.addAttribute("lnum", lnum);
			url = "updateBoard";
		}else{
			message = "오류가 발생했습니다.";
			model.addAttribute("message", message);
			url = "redirect:searchBoard.ldb?lnum=" + lnum;
		}
		
		return url;
	}
	
	//글 수정하기
	@RequestMapping("/updateBoard")
	public String updateBoard(@ModelAttribute BoardVO bvo, Model model, HttpServletRequest request){
		logger.info("(log)BoardController.updateBoard 진입 >>> ");
		String url = "";
		String lnum = "";
		lnum = bvo.getLnum();
		logger.info("(log)lnum 확인 >>>" + lnum); 
		
		boolean result = false;
		boolean bFlag = false;
		
		FileUploadUtil fuu = new FileUploadUtil();

		bFlag = fuu.fileUpload(request, ABSTRACT_PATH);
		
		if(bFlag){
			Enumeration<String> en = fuu.getFileNames();
			String limage = null;
			if(en.hasMoreElements()){
				limage = en.nextElement();
			}
			
			if(limage == null)	bvo.setLimage("");
			else if(limage != null) bvo.setLimage(RELATIVE_PATH+limage);

			bvo.setLimage(bvo.getLimage());
			bvo.setLnum(fuu.getParameter("lnum"));
			bvo.setLid(fuu.getParameter("lid"));
			bvo.setLpw(fuu.getParameter("lpw"));
			bvo.setLcontent(fuu.getParameter("lcontent"));
			bvo.setLtitle(fuu.getParameter("ltitle"));

			//vo값 제대로 들어갔는지 출력해서 확인하기
			PrintVOUtil.boardVOPrint(bvo);
			
		}else{
			logger.info("(log)multipartRequest 오류");
			url = "/board/selectBoard.ldb";
			return "redirect:" + url;
		}
		
		result = boardService.updateBoard(bvo);
		
		if(result){
			url = "searchBoard.ldb?lnum="+lnum;
		}else{
			url = "selectBoard.ldb";
		}

		logger.info("(log)BoardController.updateBoard 종료 >>> ");
		return "redirect:" + url ;
	}
	
	//수정,삭제 권한 확인하기
	@RequestMapping(value="/GET/{lnum}.ldb",  method = {RequestMethod.PUT, RequestMethod.PATCH})
	@ResponseBody
	public ResponseEntity<String> checkPw(@PathVariable("lnum") String lnum, @RequestBody BoardVO bvo){
		logger.info("(log)BoardController.checkPw 비밀번호 확인 >>> ");
		
		String lpw = "";
		String checkLpw = "";
		ResponseEntity<String> entity = null;
		
		lpw = bvo.getLpw();
		bvo.setLpw(lpw);
		logger.info("비밀번호 비교하기" + bvo.getLpw());
		
		List<BoardVO> aList = null;
		aList = boardService.checkPw(bvo);
		
		checkLpw = aList.get(0).getLpw();
		
		if(lpw.equals(checkLpw)){
			logger.info("(log) 비밀번호가,,,같다면,,,?>>> ");
			try{
				entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
			}catch(Exception e){
				entity = new ResponseEntity<>("FAIL", HttpStatus.BAD_REQUEST);
				logger.info(e);
			}
		}else{
			entity = new ResponseEntity<>("FAIL", HttpStatus.BAD_REQUEST);
		}
		
		logger.info("(log)BoardController.checkPw 비밀번호 확인 종료 >>> ");
		return entity;
	}
	
}//end of controller
