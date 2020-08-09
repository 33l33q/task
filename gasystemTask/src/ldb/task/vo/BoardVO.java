package ldb.task.vo;

public class BoardVO extends UtilVO {
	private	String	lnum;
	private	String	lid;
	private	String	lpw;
	private	String	ltitle;
	private	String	lcontent;
	private	String	limage;
	private	String	linsertdate;
	private	String	lupdatedate;
	private	String	ldeleteYN;
	private	String	lhitnum;
	
	//페이징을 위한 변수
	private String rownum;

	//제목 미리보기
	private String preLnum;
	private String preLtitle;
	private	String nextLnum;
	private String nextLtitle;
	

	//댓글 갯수
	private String cntReply;

	public String getCntReply() {
		return cntReply;
	}
	public void setCntReply(String cntReply) {
		this.cntReply = cntReply;
	}
	public String getRownum() {
		return rownum;
	}
	public String getPreLnum() {
		return preLnum;
	}
	
	public void setPreLnum(String preLnum) {
		this.preLnum = preLnum;
	}
	public String getPreLtitle() {
		return preLtitle;
	}
	public void setPreLtitle(String preLtitle) {
		this.preLtitle = preLtitle;
	}
	public String getNextLnum() {
		return nextLnum;
	}
	public void setNextLnum(String nextLnum) {
		this.nextLnum = nextLnum;
	}
	public String getNextLtitle() {
		return nextLtitle;
	}
	public void setNextLtitle(String nextLtitle) {
		this.nextLtitle = nextLtitle;
	}
	public void setRownum(String rownum) {
		this.rownum = rownum;
	}
	public String getLnum() {
		return lnum;
	}
	public void setLnum(String lnum) {
		this.lnum = lnum;
	}
	public String getLid() {
		return lid;
	}
	public void setLid(String lid) {
		this.lid = lid;
	}
	public String getLpw() {
		return lpw;
	}
	public void setLpw(String lpw) {
		this.lpw = lpw;
	}
	public String getLtitle() {
		return ltitle;
	}
	public void setLtitle(String ltitle) {
		this.ltitle = ltitle;
	}
	public String getLcontent() {
		return lcontent;
	}
	public void setLcontent(String lcontent) {
		this.lcontent = lcontent;
	}
	public String getLimage() {
		return limage;
	}
	public void setLimage(String limage) {
		this.limage = limage;
	}
	public String getLinsertdate() {
		return linsertdate;
	}
	public void setLinsertdate(String linsertdate) {
		this.linsertdate = linsertdate;
	}
	public String getLupdatedate() {
		return lupdatedate;
	}
	public void setLupdatedate(String lupdatedate) {
		this.lupdatedate = lupdatedate;
	}
	public String getLdeleteYN() {
		return ldeleteYN;
	}
	public void setLdeleteYN(String ldeleteYN) {
		this.ldeleteYN = ldeleteYN;
	}
	public String getLhitnum() {
		return lhitnum;
	}
	public void setLhitnum(String lhitnum) {
		this.lhitnum = lhitnum;
	}

}
