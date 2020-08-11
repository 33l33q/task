<!-- selectBoard.jsp :  게시글 전체 목록 출력 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="ldb.task.controller.BoardController"%>
<%@ page import="ldb.task.vo.BoardVO"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
		Object obj = request.getAttribute("boardAllList");
		ArrayList<BoardVO> aList = (ArrayList<BoardVO>)obj;
		
		Object obj2 = request.getAttribute("bvo");
		BoardVO pBvo = (BoardVO)obj2; //페이징을 위한  VO가 담겨 있음
		
		String keyword = pBvo.getKeyword();
		String search = pBvo.getSearch();
		
		int pageSize = pBvo.getPageSize();
		int nSize = pBvo.getPageSize();
		int groupSize = pBvo.getGroupSize();
		int curPage = pBvo.getCurPage();
		int totalCount = pBvo.getTotalCount();
		
		if(request.getParameter("curPage") != null){
			curPage = Integer.parseInt(request.getParameter("curPage"));
		}
%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>전체글목록보기</title>
		
		<link rel="stylesheet" type="text/css" href="/css/default.css"/>
		
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
		<script type="text/javascript">
		$(function(){
			
			//상세페이지로 이동
			$(".moveSearch").click(function(){
				var lnum = $(this).parents("tr").attr("data");
				$("#lnum").val(lnum);
				$("#selectForm").attr({
	                "method":"post",
	                "action":"/board/searchBoard.ldb"
				});
				$("#selectForm").submit();
			});//end of moveSearch
			
			//글작성 페이지로 이동
			$("#moveToInsert").click(function(){
				alert("글쓰기페이지로이동");
				location.href="/board/moveToInsert.ldb";
			});

			//검색키워드 변경 시 이벤트
	         $("#keyword").change(function(){
	             if($("#keyword").val()=="all"){
	                $("#keyword").val("전체목록을 조회");
	             }else if($("#keyword").val()!="all"){
	                $("#search").val("");
	                $("#search").focus();
	             }
	          });
			
			//검색 시 이벤트
			$("#keySearch").click(function(){
				var keyword = $("#keyword").val();
				var search = $("#search").val();
				
				if(!search){
				    alert("검색어를 입력하세요");
				    return false;
				 }
				goPage(1);
			});
			
			$("#pageCtrl").change(function(){
				
				if(!$("#search").val()){
			    	goPage(1);
				}else if($("#search").val()){
					var keyword = $("#keyword").val();
					var search = $("#search").val();
					
					$("#page").val(page);
					$("#goSearch").attr({
						"method":"get",
						"action":"/board/selectBoard.ldb"
					});
					$("#goSearch").submit();
					
				}
			 });
	         
			function goPage(page){
				if($("#keyword").val()=="all"){
					$("#search").val("");
				}
				
				$("#page").val(page);
				$("#goSearch").attr({
					"method":"get",
					"action":"/board/selectBoard.ldb"
				});
				$("#goSearch").submit();
			}
			
		});//end of jqeury
		
		</script>
	</head>
	<body>
		<div align="center">
			<div>
				<div id="bTit" align="center"><h2>게시판 전체 목록</h2></div>			
				<%--==========================검색시작==========================--%>
				<div id="selectSearch" class="selectSearch" align ="left">
	                 <form id="goSearch" name="goSearch" >
	                       <table summary ="검색">
	                          <colgroup>
	                             <col width="70%"></col>
	                             <col width="30%"></col>
	                          </colgroup>
	                          <tr>
	                             <td id="btd">
	                                <label><b>검색조건</b></label>
	                                <select class="keyword" name="keyword"> 
	                                   <option value="all">전체보기</option>
	                                   <option value="ltitle">제목</option>
	                                   <option value="lcontent">내용</option>
	                                   <option value="lid">작성자</option>
	                                </select>
	                                <input type="text" name="search" id="search" placeholder="검색어를 입력하세요" />
	                                <input type="button" class="but" style="width:40px" value="검색" name="keySearch" id="keySearch"/>
	                             </td>
	                            <td id="std">
	                                <select id="pageCtrl" name="pageCtrl" selectes="10">
	                                	<option value="5">5줄</option>
	                                   <option value="10">10줄</option>
	                                   <option value="20">20줄</option>
	                                   <option value="30">30줄</option>
	                                   <option value="50">50줄</option>
	                                </select>
	                             </td>   
	                          </tr>
	                       </table>
	                 </form>
				</div>
				<%--========================== 검색끝! ==========================--%>
				<br>
				<form id="selectForm" name="selectForm" method="get">
				<input type="hidden" id="lnum" name="lnum">
					<table align="center"  width="1000" class="table">
						<colgroup>
							<col width="10%"/>
							<col width="50%"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="10%"/>
						</colgroup>
						<thead>
							<tr>
								<th>글번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>조회수</th>
								<th>댓글수</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody>
<%
				if(aList.size() == 0){
%>
						<tr>
							<td colspan ="6" align="center">게시글이 존재하지 않습니다.</td>
						</tr>
<%
				}else{
					for(int i = 0 ; i < aList.size();i++){
						BoardVO bvo = aList.get(i);
%>
						<tr data = <%=bvo.getLnum() %> >
							<td align = "center"><%=bvo.getRownum() %></td>
							<td><span class="moveSearch"><%=bvo.getLtitle() %></span></td>
							<td align = "center"><%=bvo.getLid() %></td>
							<td align = "center"><%=bvo.getLhitnum() %></td>
							<td align = "center"><%=bvo.getCntReply() %></td>
							<td align = "center"><%=bvo.getLinsertdate().substring(0, 10) %></td>
						</tr>
	<%
				
					}
				}
			
	%>
						</tbody>
					</table>
				</form>
			</div>
			<br>
			<div class="butContaner" align="right">
				<input type="button" value="글작성" class="but" id="moveToInsert" name="moveToInsert">
			</div>
			<br><br><br>
			 <jsp:include page="paging.jsp" flush="true">
                 <jsp:param name="url" value="../board/selectBoard.ldb"/>
                 <jsp:param name="str" value=""/>
                 <jsp:param name="pageSize" value="<%=pageSize%>"/>
                 <jsp:param name="groupSize" value="<%=groupSize%>"/>
                 <jsp:param name="curPage" value="<%=curPage%>"/>
                 <jsp:param name="totalCount" value="<%=totalCount%>"/>
                 <jsp:param name="keyword" value="<%=keyword%>"/>
                 <jsp:param name="search" value="<%=search%>"/>   
			 </jsp:include>
	</body>
</html>