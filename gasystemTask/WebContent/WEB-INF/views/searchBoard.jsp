<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ldb.task.controller.BoardController"%>
<%@ page import="ldb.task.vo.BoardVO"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	Object obj = request.getAttribute("searchList");
	Object obj2 = request.getAttribute("message");
	ArrayList<BoardVO> aList = (ArrayList<BoardVO>)obj;
	
	String message = (String)obj2;

	BoardVO bvo = aList.get(0);
%>
	<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>상세보기 페이지</title>
		
		<link rel="stylesheet" type="text/css" href="/css/default.css"/>
		
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
		<script type="text/javascript">
		$(function(){
			
			//수정 시 동작
			$("#updateBut").click(function(){
				alert("수정버튼");
				var lnum = $("#lnum").val();
				var lpw = $("#lpw").val();
				
				if(!lpw){
					alert("비밀번호를 입력하세요.");
					$("#lpw").focus();
					return false;
				}
				checkPwUp(lnum, lpw);

			});
			
			//삭제 시 동작
			$("#deleteBut").click(function(){
				alert("삭제버튼");
				var lnum = $("#lnum").val();
				var lpw = $("#lpw").val();
				
				if(!lpw){
					alert("비밀번호를 입력하세요.");
					$("#lpw").focus();
					return false;
				}
				
				checkPwDel(lnum, lpw);
		
				
			});
			
			//전체목록으로 이동
			$("#selectBut").click(function(){
				location.href = "/board/selectBoard.ldb";
			});	
			
			//비밀번호 체크
			function checkPwUp(lnum, lpw){
	            $.ajax({
	                url:'/board/GET/' + lnum + ".ldb",
	                type:'put',
	                headers:{
	                      "Content-Type" : "application/json",
	                      "X-HTTP-Method-Override" : "PUT"},
                    data:JSON.stringify({
						                  	 lpw:lpw,
						                  	 lnum:lnum}),
	                dataType:'text',
	                success:function(result){
	                       if(result == 'SUCCESS'){
	                    	   alert("비밀번호 확인 성공");
                    	   $("#searchForm").attr({
           	                "method":"post",
           	                "action":"/board/moveToUpdate.ldb"
           					});
	           				$("#searchForm").submit();


	                       }else if(result == 'FAIL'){
	                    	   alert("수정할 권한이 없습니다.");
	                       }
	                },
	                error : function(result){
	                       if(result == 'FAIL'){
	                    	   alert("수정할 권한이 없습니다.");
	                       }else{
	                    	   alert("오류발생")
	                       }
	                }
                 });
			}
			
			//삭제 비밀번호 체크
			function checkPwDel(lnum, lpw){
	            $.ajax({
	                url:'/board/GET/' +  lnum + ".ldb",
	                type:'put',
	                headers:{
	                      "Content-Type" : "application/json",
	                      "X-HTTP-Method-Override" : "PUT"},
                    data:JSON.stringify({
						                  	 lpw:lpw,
						                  	 lnum:lnum}),
	                dataType:'text',
	                success:function(result){
	                       console.log("result: " + result);
	                       if(result == 'SUCCESS'){
	                    	   alert("비밀번호 확인 성공");
	                    	   $("#searchForm").attr({
		        	                "method":"post",
		        	                "action":"/board/deleteBoard.ldb"
	        					});
	        				   $("#searchForm").submit();
							
	                       }else if(result == 'FAIL'){
                             alert("수정할 권한이 없습니다.");
                             return false;
	                       }
	                }
                 });
			}
			
		
		});
		</script>
	</head>
	<body>
		<div class = "container" align="center">
			<div>
				<form id="searchForm" name="searchForm" method="post" class="table">
					<input type="hidden" id="lnum" name="lnum" value=<%=bvo.getLnum() %>>
					<table border="1" align="center" >
						<tr>
							<td><b>제목</b></td>
							<td colspan="3"><%=bvo.getLtitle() %></td>
						</tr>
						<tr>
						<tr>
							<td><b>아이디</b></td>
							<td><%=bvo.getLid() %></td>
							<td><b>비밀번호</b></td>
							<td><input type="text" id="lpw" name="lpw"></td>
						</tr>
						<tr>
							<td><b>작성일</b></td>
							<td><%=bvo.getLinsertdate().substring(0,10) %></td>
							<td><b>조회수</b></td>
							<td><%=bvo.getLhitnum() %></td>
						</tr>
						<tr>
							<td><b>내용</b></td>
							<td colspan="3"><%=bvo.getLcontent() %></td>
						</tr>
	<%
					if(bvo.getLimage() != null){
	%>
						<tr>
							<td><b>이미지</b></td>
							<td><img src="../<%=bvo.getLimage() %>" style="max-width:90%";></td>
						</tr>
	<%
					}
	%>				
					</table>
				</form>
			</div>
			<div >
				<input type="button" class="but" name="updateBut" id="updateBut" value="수정">
				<input type="button" class="but" name="deleteBut" id="deleteBut" value="삭제">
				<input type="button" class="but" name="selectBut" id="selectBut" value="전체목록">
			</div>
			<div>
				<form id="indexWrite" name="indexBoard" method="get">
					<table>
						<tr>
							<td>▲이전글 <input type=text id="beforeView" name="beforeView" value="" size="50"></td></tr>
						<tr><td>▼다음글  <input type="text" id="afterView" name="afterView" value="" size="50"></td></tr>
					</table>
				</form>
			</div>	
		</div>	
	</body>
</html>