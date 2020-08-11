<!-- paging.jsp : 전체목록(selectBoard) 페이징 및 검색어 유지 -->
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collection" %>

<%
   String url = null;
   String str = null;
   String ctrl=null;
   String search = null;
   String keyword = null;
   
   url = request.getParameter("url");
   str = request.getParameter("str");
   ctrl=request.getParameter("pageSize");
   keyword = request.getParameter("keyword");
   search = request.getParameter("search");
   
   if(str != null) str = str + "&";
%>

<%
   /****네비게이션에서 사용하는 변수****/

   int pageSize = 0;   // 한페이지에 보여질 게시물의 수
   int groupSize = 0;  // 그룹의 크기
   int totalCount = 0; // 전체 게시물의 개수
   int curPage = 0; //현재 페이지
   int pageCount = 0; // 전체 페이지의 개수
   
   if(request.getParameter("pageSize") != null) pageSize = Integer.parseInt(request.getParameter("pageSize"));
   if(request.getParameter("groupSize") != null) groupSize = Integer.parseInt(request.getParameter("groupSize"));
   if(request.getParameter("curPage") != null) curPage = Integer.parseInt(request.getParameter("curPage"));
   if(request.getParameter("totalCount") != null) totalCount = Integer.parseInt(request.getParameter("totalCount"));
   
   //전체 게시물 수/ 페이지 크기 == 전체 페이지 개수를 계산(소수까지 계산해서 오류 방지)
   pageCount = (int)Math.ceil(totalCount / (pageSize+0.0));
   
   //현재그룹 설정
   int curGroup = (curPage-1) / groupSize;
   int linkPage = curGroup * groupSize;
%>
<p align="center">
<%
   //첫번째 그룹인 아닌경우
   if(curGroup > 0) {
%>
   <a href="<%=url%>?<%=str%>curPage=1&pageCtrl=<%=ctrl%>&keyword=<%=keyword %>&search=<%=search%>">◁◁</a>&nbsp;&nbsp;&nbsp;
   <a href="<%=url%>?<%=str%>curPage=<%=linkPage%>&pageCtrl=<%=ctrl%>&keyword=<%=keyword %>&search=<%=search%>">◀</a>&nbsp;&nbsp;&nbsp;
<%
   }else{
%>
◁◁&nbsp;&nbsp;&nbsp;◀&nbsp;&nbsp;&nbsp;
<%
   }
   
   //다음 링크를 위해 증가시킴
   linkPage++;
   
   int loopCount = groupSize;
   //그룹범위내에서 페이지 링크만듬.
   while((loopCount > 0) && (linkPage <= pageCount)){
      if(linkPage == curPage){
%>
   <%=linkPage%>
<%
      }else{
%>
      [<a href="<%=url%>?<%=str%>curPage=<%=linkPage%>&pageCtrl=<%=ctrl%>&keyword=<%=keyword %>&search=<%=search%>"><%=linkPage%></a>]&nbsp;
<%
      }
      
      linkPage++;
      loopCount--;
   }
   
   //다음그룹이 있는 경우
   if(linkPage <= pageCount){
%>
      <a href="<%=url%>?<%=str%>curPage=<%=linkPage%>&pageCtrl=<%=ctrl%>&keyword=<%=keyword %>&search=<%=search%>">▶</a>&nbsp;&nbsp;&nbsp;
      <a href="<%=url%>?<%=str%>curPage=<%=pageCount%>&pageCtrl=<%=ctrl%>&keyword=<%=keyword %>&search=<%=search%>">▷▷</a>&nbsp;&nbsp;&nbsp;
<%
   }else{
%>
      &nbsp;&nbsp;&nbsp;▶&nbsp;&nbsp;&nbsp;▷▷
<%
   }
%>
</p>