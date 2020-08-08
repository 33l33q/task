<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="ldb.task.controller.BoardController"%>
<%@ page import="ldb.task.vo.BoardVO"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>전체글목록보기</title>
		
		<link rel="stylesheet" type="text/css" href="/css/default.css"/>
		
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
		<script type="text/javascript">
		$(function(){
		
			$(".moveSearch").click(function(){
				var lnum = $(this).parents("tr").attr("data");
				$("#lnum").val(lnum);
				$("#selectForm").attr({
	                "method":"post",
	                "action":"../board/searchBoard.ldb"
				});
				$("#selectForm").submit();
			});//end of moveSearch
			
			$("#moveToInsert").click(function(){
				alert("글쓰기페이지로이동");
				location.href="/board/moveToInsert.ldb";
			});

			
		});//end of jqeury
		
		</script>
	</head>
	<body>
		<div align="center">
			<div >
				<form id="selectForm" name="selectForm" method="get">
				<input type="hidden" id="lnum" name="lnum">
					<table border ="1" align="center"  width="1000" class="table">
						<div id="bTit" align="center"><h2>게시판 전체 목록</h2></div>
						<colgroup>
							<col width="15%"/>
							<col width="50%"/>
							<col width="15%"/>
							<col width="10%"/>
							<col width="10%"/>
						</colgroup>
						<thead>
							<tr>
								<th>글번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>조회수</th>
								<th>작성일</th>
								
							</tr>
						</thead>
						<tbody>
	<%
				Object obj = request.getAttribute("boardAllList");
				ArrayList<BoardVO> aList = (ArrayList<BoardVO>)obj;
				
				if(aList.size() == 0){
	%>
						<tr>
							<td colspan ="3" align="center">게시글이 존재하지 않습니다.</td>
						</tr>
	<%
				}else{
					for(int i = 0 ; i < aList.size();i++){
						BoardVO bvo = aList.get(i);
	%>
						<tr data = <%=bvo.getLnum() %> >
							<td align = "center"><%=bvo.getRownum() %></td>
							<td><span class="moveSearch"><%=bvo.getLtitle() %></td>
							<td align = "center"><%=bvo.getLid() %></td>
							<td align = "center"><%=bvo.getLhitnum() %></td>
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
			<div id="boardButton">
				<input type="button" value="글작성" class="but" id="moveToInsert" name="moveToInsert">
			</div>
		</div>
	</body>
</html>