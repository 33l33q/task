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
		<title>���â~!~!</title>
		
		<link rel="stylesheet" type="text/css" href="/css/default.css"/>
		
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
		<script type="text/javascript">
		$(function(){
			var lnum = $("#lnum").val();
			
			allSelcet(lnum);
			
			var url = "";
			
			//DB�� ������ �ִ�ũ�⿡ ���� ��� ���ڼ� ����
			$(".lreContent").keyup(function(){
				cut_1000(this);
			});
			
			//���ʱ�ȭ
			function dataReset(){
				$("#lreContent").val("");
				$("#lrePw").val("");
				$("#lreId").val("");
			}
			

	         /*���� ��ư Ŭ���� ���� �� ���*/
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
	            data="<input type='password' id='checkPw' name='checkPw' placeholder='��й�ȣ�� �Է��ϼ���' style='float:left;'><br>";
	            data+="<input type='hidden' id='checkId' name='checkId' value='" + checkId + "' style='float:left;'><br>";
	            data+="<textarea name='conText' id='conText' cols=120' rows='3'>"+conText+"</textarea>";
	            data+="&nbsp<input type='button' class='resetBut' value='���' style='float:right;'>"
	            data+="&nbsp<input type='button' class='upBut' value='����' style='float:right;'>";
	            data+="&nbsp<input type='button' class='delBut' value='����' style='float:right;'>";

	            reArea.html(data);
	            
	         });

	         /*������� ��ư*/
	         $(document).on("click",".resetBut",function(){
	            var conText = $(this).parents("li").find("textarea").html();
	            $(this).parents("li").find("input[type='button']").show();
	            var conArea = $(this).parents("li").children().eq(1);
	            conArea.html(conText);
	         });
	         
			//��� �����ϱ�
			$(document).on("click",".upBut",function(){
				alert("��й�ȣ �޾ƿ��� >>> : " + $("#checkPw").val());
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
							allSelcet(lnum);//����Ʈ�ٽúθ���
							
						}else if(result == "FAIL"){
							alert("��� ���� ����, ��й�ȣ�� Ȯ���ϼ���")
						}
					},
					error : function(){
						alert("�ý��� ���� �߻�, �����ڿ��� �����ϼ���")
					}
					
				})
			});//���� ����
			
			//��� �����ϱ�
			$(document).on("click",".delBut",function(){
				alert("�����ϱ�");
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
							allSelcet(lnum);//����Ʈ�ٽúθ���
							
						}else if(result == "FAIL"){
							alert("���� ����")
						}
					},
					error : function(){
						alert("�ý��� ���� �߻�, �����ڿ��� �����ϼ���")
					}
				})
			});//���� ����
			
			//��� �Է��ϱ�
			$("#insertBut").click(function(){
				
				if(!$("#lreContent").val()){
					alert("������ �Է��ϼ���");
					$("#lreContent").focus;
				}else if(!$("#lreId").val()){
					alert("�ۼ��ڸ��� �Է��ϼ���");
					$("#lrePw").focus;
				}else if(!$("#lreContent").val()){
					alert("��й�ȣ�� �Է��ϼ���");
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
								dataReset();//����
								allSelcet(lnum);//����Ʈ�ٽúθ���
								
							}else if(result == "FAIL"){
								alert("��� ��Ͽ� �����߽��ϴ�.")
							}
						},
						error : function(){
							alert("�ý��� ���� �߻�, �����ڿ��� �����ϼ���")
						}
					});
				}
			});//��� �Է� ����
			
			
			//��� ��� �θ���
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
					alert("��۸�� �ҷ����µ� ����");
				});
				
			}//��� ��� �θ��� ����
			
			 /*���ο� ���� ȭ�鿡 �߰��ϱ� ���� �Լ�*/
		     function addItem(rownum,lreNum, lreId,lrePw,lreContent,lreInsertdate){
				
		         //���ο� ���� �߰��� li �±� ��ü
		         var new_li = $("<li>");
		         new_li.attr("data-num", lreNum);
		         new_li.addClass("comment_item");
		         
		         //�ۼ��� ������ ������ <p>�±�
		         var writer_p =$("<p>");
		         writer_p.addClass("writer");
		         
		         //����
		         var rownum_span = $("<span>");
		         rownum_span.html("no." + rownum +"&nbsp");
		         rownum_span.addClass("acc");
		         
		         //�̿�������
		         var id_span = $("<span>");
		         id_span.html(lreId);
		         
		         //�ۼ��Ͻ�
		         var date_span = $("<span>");
		         date_span.html("&nbsp" + lreInsertdate.substr(0,10) + " ");
		         date_span.addClass("acc");
		   
		         //�����ϱ� ��ư
		         var up_form = $("<input>");
		         up_form.attr({"type" : "button", "value" : "����/����", "class" : "button", "style" : "float:right;"});
		         up_form.addClass("up_form");
		         
		         //��й�ȣ ����
   		         var pw_span = $("<input>");
   		      	 pw_span.attr({"type" : "hidden", "name":"reLpw" ,"value": "hidden"});
   		  		 pw_span.addClass("pw_span");
		         
		         
		         //����
		         var content_p = $("<p>");
		         content_p.addClass("con");
		         content_p.html(lreContent);
		         
		         //�����ϱ�
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
							<td>�ۼ���  : <input type="text" id="lreId" name="lreId" maxlength="10"></td>
							<td>��й�ȣ : <input type="password" id="lrePw" name="lrePw" maxlength="10"></td>
						</tr>
						<tr>
							<td colspan="2"><textarea name="lreContent" id="lreContent" cols="100" rows="3"></textarea>
							<input type="button" id="insertBut" name="insertBut" value="�����ϱ�"></td>
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