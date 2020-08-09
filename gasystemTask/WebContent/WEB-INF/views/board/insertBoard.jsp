<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>글작성</title>
		
		<link rel="stylesheet" type="text/css" href="/css/default.css"/>
		
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
		<script type="text/javascript" src="../webedit/dist/js/service/HuskyEZCreator.js" charset="utf-8"></script>
		<script type="text/javascript">
		var oEditors = [];
		$(function(){
			//네이버 에디터 적용
			nhn.husky.EZCreator.createInIFrame({
				oAppRef : oEditors,
				elPlaceHolder : "lcontent",
				sSkinURI : "../webedit/dist/SmartEditor2Skin.html",
				htParams : {
					bUseToolbar : true,
					bUseVerticalResizer : true,
					bUseModeChanger : true,
					fOnBeforeUnload : function() {
					}
				},
				
				fOnAppLoad : function() {
					oEditors.getById["lcontent"].exec("PASTE_HTML", [""]);
				},
				
				fCreator : "createSEditor2"
			});
			
			//DB에 설정한 최대크기에 맞춰 글내용 글자수 제한
			$(".lcontent").keyup(function(){
				cut_2000(this);
			});
			
			//DB에 설정한 최대크기에 맞춰 제목 글자수 제한
			$(".ltitle").keyup(function(){
				cut_100(this);
			});
			
			$("#insertBoard").click(function() {

				//필수값 validation
		        var lcontent = oEditors.getById["lcontent"].getIR();
		        var checkarr = ["<p>&nbsp;</p>","&nbsp;","<p><br></p>","<p></p>","<br>"];
		        if(jQuery.inArray(lcontent.toLowerCase(), checkarr) != -1){
		            alert("내용을 입력해 주십시오.");
		            oEditors.getById["lcontent"].exec("FOCUS");
		            return false;
		        }

				if(!$("#ltitle").val()) {
					alert("제목을 입력하세요");
					$("#ltitle").focus();
					return false;
				}
				
				if(!$("#lid").val()) {
					alert("이름을 입력하세요");
					$("#lid").focus();
					return false;
				}
				
				//비밀번호 일치 여부 확인하기
				var lpwVal = $("#lpw").val();
				var reLpwVal = $("#reLpw").val();
				
				alert(reLpwVal + " : " + lpwVal);
				
				if(!lpwVal){
					alert("비밀번호를 입력하세요.");
					$("#lpw").focus();
					return false;
				}
				
				if(lpwVal != reLpwVal){
					alert("비밀번호를 확인하세요.");
					$("#lpw").focus();
					return false;
				}

				
				else{
					var ext1 = $("#limage").val().split(".").pop().toLowerCase();
					if(ext1){
						if(jQuery.inArray(ext1,["gif","png","jpg","jpeg"]) == -1 ) {
	                        alert("gif,png,jpg,jpeg 사진만 업로드 할 수 있습니다");
							return false;
						}
					}
					
					oEditors.getById["lcontent"].exec("UPDATE_CONTENTS_FIELD", []);
					$("#insertForm").submit();
				}
				
				$("#insertForm").attr({
					"method":"POST",
					"action":"../board/insertBoard.ldb"
				});
				
				$("#insertForm").submit();
			});
			
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
			
			function cut_2000(obj){
				var text = $(obj).val();
				var leng = text.length;
				while(getTextLength(text) > 2000){
					leng--;
					text = text.substring(0, leng);
				}
				$(obj).val(text);
				$(".bytes").text(getTextLength(text));
			}
			
			function cut_100(obj){
				var text = $(obj).val();
				var leng = text.length;
				while(getTextLength(text) > 100){
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
		<div class ="contaner">
			<div id="bTit" align="center"><h2>글작성</h2></div>
			<div align="center">
				<form id="insertForm" name="insertForm" enctype="multipart/form-data">
					<table width="800px" id="wirteForm">
						<tr>
							<td><b>작성자</b></td>
							<td colspan="3"><input type="text" name="lid" id="lid"></td>
						</tr>
						<tr>
							<td><b>비밀번호</b></td>
							<td><input type="password" name="lpw" id="lpw">
							<td><b>비밀번호 확인</b></td>
							<td><input type="password" name="reLpw" id="reLpw">
						</tr>
						<tr>
							<td><b>제목</b></td>
							<td colspan="3"><input type="text" name="ltitle" id="ltitle" class="ltitle" size="50"></td>
						</tr>
						<tr>
							<td><b>내용</b></td>
							<td colspan="3"><textarea rows="16" cols="80" name="lcontent" id="lcontent" class="lcontent" style="width:100%; min-width:600px; height:30em;"></textarea></td>
						</tr>
						<tr>
							<td ><b>이미지</b></td>
							<td colspan="3"><input type="file" name="limage" id="limage"><input type="reset" value="취소"></td></td>
						</tr>
					</table>
					<div align="right">
						<input type="button" value="저장"  class="but" id="insertBoard" name="insertBoard">
					</div>
				</form>
			</div>
		</div>
	</body>
</html>