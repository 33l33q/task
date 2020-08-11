/****** 페이징 클래스 *******/
package ldb.task.utils;

import ldb.task.vo.BoardVO;

public class Paging {
	
public static void setPage(BoardVO bvo, String curpage, String sizeCtrl){
	
	if(curpage==null||curpage.equals("0")){
		bvo.setCurPage(1);
	}
	if(curpage!=null){
		int curnum=Integer.parseInt(curpage);
		bvo.setCurPage(curnum);
	}
	bvo.setGroupSize(10);
	
	if(sizeCtrl==null){
	bvo.setPageSize(10);
	}
	if(sizeCtrl!=null){
		int ctrl=Integer.parseInt(sizeCtrl);
		bvo.setPageSize(ctrl);
	}
}


}
