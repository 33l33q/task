<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ldb.task.controller.BoardController"%>
<%@ page import="ldb.task.vo.BoardVO"%>
<%@ page import="ldb.task.vo.ReplyVO"%>

<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<title>댓글창~!~!</title>
		
		<link rel="stylesheet" type="text/css" href="/css/default.css"/>
		
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
		<script type="text/javascript">
		$(function(){
			var lnum = $("#lnum").val();
			
			allSelcet(lnum);
			
			var url = "";
			
			//DB에 설정한 최대크기에 맞춰 댓글 글자수 제한
			$(".lreContent").keyup(function(){
				cut_1000(this);
			});
			
			//값초기화
			function dataReset(){
				$("#lreContent").val("");
				$("#lrePw").val("");
				$("#lreId").val("");
			}
			

	         /*수정 버튼 클릭시 수정 폼 출력*/
	         $(document).on("click", ".up_form", function(){
	            $(".reset_btn").click();
	            var conText = $(this).parents("li").children().eq(1).html();
	            var checkId = $(this).parents("p").children().eq(1).html();
	            
	            alert("checkId >>> " + checkId);
	            
	            $(this).parents("li").find("input[type='button']").hide();
	            $(this).parents("li").children().eq(0).html();
	            
	            var reArea = $(this).parents("li").children().eq(1);
	            reArea.html("");
	            
	            var
	            data="<input type='password' id='checkPw' name='checkPw' placeholder='비밀번호를 입력하세요' style='float:left;'><br>";
	            data+="<input type='hidden' id='checkId' name='checkId' value='" + checkId + "' style='float:left;'><br>";
	            data+="<textarea name='conText' id='conText' cols=120' rows='3'>"+conText+"</textarea>";
	            data+="&nbsp<input type='button' class='resetBut' value='취소' style='float:right;'>"
	            data+="&nbsp<input type='button' class='upBut' value='수정' style='float:right;'>";
	            data+="&nbsp<input type='button' class='delBut' value='삭제' style='float:right;'>";

	            reArea.html(data);
	            
	         });

	         /*수정취소 버튼*/
	         $(document).on("click",".resetBut",function(){
	            var conText = $(this).parents("li").find("textarea").html();
	            $(this).parents("li").find("input[type='button']").show();
	            var conArea = $(this).parents("li").children().eq(1);
	            conArea.html(conText);
	         });
	         
			//댓글 수정하기
			$(document).on("click",".upBut",function(){
				alert("비밀번호 받아오기 >>> : " + $("#checkPw").val());
				var lreNum = $(this).parents("li").attr("data-num");
				url = "/board/update/" + lreNum + ".ldb";
				
				$.ajax({
					url : url,
					type : "post",
					headers :  {"Content-Type" : "application/json",
              			 		"X-HTTP-Method-Override" : "POST" },
              		dataType : "text",
              		data : JSON.stringify({
						lnum : lnum,
						lreNum : lreNum,
						lreContent : $("#conText").val(),
						lrePw : $("#checkPw").val(),
						lreId : $("#checkId").val()
              		}),
					success : function(result){
						if(result == "SUCCESS"){
							allSelcet(lnum);//리스트다시부르기
							
						}else if(result == "FAIL"){
							alert("댓글 수정 실패, 비밀번호를 확인하세요")
						}
					},
					error : function(){
						alert("시스템 오류 발생, 관리자에게 문의하세요")
					}
					
				})
			});//수정 종료
			
			//댓글 삭제하기
			$(document).on("click",".delBut",function(){
				alert("삭제하기");
				var lreNum = $(this).parents("li").attr("data-num");
				url = "/board/delete/" + lreNum + ".ldb";
				
				$.ajax({
					url : url,
					type : "post",
					headers :  {"Content-Type" : "application/json",
              			 		"X-HTTP-Method-Override" : "POST" },
              		dataType : "text",
              		data : JSON.stringify({
						lnum : lnum,
						lreNum : lreNum,
						lrePw : $("#checkPw").val(),
						lreId : $("#checkId").val()
              		}),
					success : function(result){
						if(result == "SUCCESS"){
							allSelcet(lnum);//리스트다시부르기
							
						}else if(result == "FAIL"){
							alert("삭제 실패")
						}
					},
					error : function(){
						alert("시스템 오류 발생, 관리자에게 문의하세요")
					}
				})
			});//삭제 종료
			
			//댓글 입력하기
			$("#insertBut").click(function(){
				
				if(!$("#lreContent").val()){
					alert("내용을 입력하세요");
					$("#lreContent").focus;
				}else if(!$("#lreId").val()){
					alert("작성자명을 입력하세요");
					$("#lrePw").focus;
				}else if(!$("#lreContent").val()){
					alert("비밀번호를 입력하세요");
					$("#lreContent").focus;
				}else{
					url = "/board/insertReply.ldb";
					
					$.ajax({
						url : url,
						type : "post",
						headers : {"Content-Type" : "application/json",
                           			 "X-HTTP-Method-Override" : "POST" },
						dataType : "text",
						data : JSON.stringify({
							lnum : lnum,
							lreContent : $("#lreContent").val(),
							lrePw : $("#lrePw").val(),
							lreId : $("#lreId").val()
							
						}),
						success : function(result){
							if(result == "SUCCESS"){
								dataReset();//리셋
								allSelcet(lnum);//리스트다시부르기
								
							}else if(result == "FAIL"){
								alert("댓글 등록에 실패했습니다.")
							}
						},
						error : function(){
							alert("시스템 오류 발생, 관리자에게 문의하세요")
						}
					});
				}
			});//댓글 입력 종료
			
			
			//댓글 목록 부르기
			function allSelcet(lnum){
				$("#replyAll").html("");
				url = "/board/all/" + lnum + ".ldb";
				
				$.getJSON(url, function(data){
					
					$(data).each(function(){
						var rownum	= this.rownum;
						var lreNum = this.lreNum;
						var lreId = this.lreId;
						var lrePw = this.lrePw;
						var lreContent = this.lreContent;
						var lreInsertdate = this.lreInsertdate;
						
						addItem(rownum,lreNum,lreId,lrePw,lreContent,lreInsertdate);
					})
					
				}).fail(function(){
					alert("댓글목록 불러오는데 실패");
				});
				
			}//댓글 목록 부르기 종료
			
			 /*새로운 글을 화면에 추가하기 위한 함수*/
		     function addItem(rownum,lreNum, lreId,lrePw,lreContent,lreInsertdate){
				
		         //새로운 글이 추가될 li 태그 객체
		         var new_li = $("<li>");
		         new_li.attr("data-num", lreNum);
		         new_li.addClass("comment_item");
		         
		         //작성자 정보가 지정될 <p>태그
		         var writer_p =$("<p>");
		         writer_p.addClass("writer");
		         
		         //순서
		         var rownum_span = $("<span>");
		         rownum_span.html("no." + rownum +"&nbsp");
		         rownum_span.addClass("acc");
		         
		         //이용자정보
		         var id_span = $("<span>");
		         id_span.html(lreId);
		         
		         //작성일시
		         var date_span = $("<span>");
		         date_span.html("&nbsp" + lreInsertdate.substr(0,10) + " ");
		         date_span.addClass("acc");
		   
		         //수정하기 버튼
		         var up_form = $("<input>");
		         up_form.attr({"type" : "button", "value" : "수정/삭제", "class" : "button", "style" : "float:right;"});
		         up_form.addClass("up_form");
		         
		         //비밀번호 저장
   		         var pw_span = $("<input>");
   		      	 pw_span.attr({"type" : "hidden", "name":"reLpw" ,"value": "hidden"});
   		  		 pw_span.addClass("pw_span");
		         
		         
		         //내용
		         var content_p = $("<p>");
		         content_p.addClass("con");
		         content_p.html(lreContent);
		         
		         //조립하기
	             writer_p.append(rownum_span).append(id_span).append(date_span).append(up_form).append(pw_span)
	             new_li.append(writer_p).append(content_p);
	             $("#replyAll").append(new_li);
	      }
			
			function getTextLength(str){
				var len = 0;
				for (var i=0; i<str.length; i++){
					if(escape(str.charAt(i)).length == 6){
						len++;
					}
					len++;
				}
				return len;
			}
				
			function cut_1000(obj){
				var text = $(obj).val();
				var leng = text.length;
				while(getTextLength(text) > 1000){
					leng--;
					text = text.substring(0, leng);
				}
				$(obj).val(text);
				$(".bytes").text(getTextLength(text));
			}			
			
		});//end of jquery
		
		</script>
	</head>
	<body>
		<div id="replyContaner">
			<div>
				<form id="replyForm" name="replyForm" class="reply_table">
					<table>
						<tr>
							<td>작성자  : <input type="text" id="lreId" name="lreId" maxlength="10"></td>
							<td>비밀번호 : <input type="password" id="lrePw" name="lrePw" maxlength="10"></td>
						</tr>
						<tr>
							<td colspan="2"><textarea name="lreContent" id="lreContent" cols="100" rows="3"></textarea>
							<input type="button" id="insertBut" name="insertBut" value="저장하기"></td>
						</tr>
					</table>
				</form>
			</div>
			<div  class="reply" align="left">
				<ul class="reply" id="replyAll"></ul>
			</div>
		</div>
	</body>
</html>