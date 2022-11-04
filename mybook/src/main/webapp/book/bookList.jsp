<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="mystudy.book.model.BookDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="mystudy.book.model.BookDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>bookList.jsp</title>
</head>
<body>
<%
	//[1] bookWrite.jsp에서 [도서목록] 클릭하면 get 방식으로 이동
	//[2] bookWrite_ok.jsp에서 성공하면 get 방식으로 이동
	//[3] booklist.jsp에서 [검색]하면 post 방식으로 서브밋됨
	//[4] booklist.jsp에서 [페이지번호]클릭하면 get 방식으로 이동
	
	//1. 요청 파라미터 읽어오기
	request.setCharacterEncoding("euc-kr");
	String condition = request.getParameter("searchCondition");
	String keyword = request.getParameter("searchKeyword");
	
	if(keyword == null) keyword="";
	
	//2. db작업
	BookDAO bookDao = new BookDAO();
	List<BookDTO> list = null;
	
	try{
		list = bookDao.selectAll(condition, keyword);
	}catch(SQLException e){
		e.printStackTrace();
	}
	//3. 결과 처리
	DecimalFormat df = new DecimalFormat("#,###");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	//페이지 처리
	int currentPage = 1;
	
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	//현재 페이지와 무관한 변수들
	int totalRecord = 0; //총 레코드 개수
	
	if(list != null && !list.isEmpty()){
		totalRecord = list.size();
	}
	
	int pageSize = 5; //한 페이지에 보여줄 레코드 개수
	int totalPage = (int)Math.ceil((float)totalRecord/pageSize);
	int blockSize = 10; //한 블럭에 보여줄 페이지 수
	
	//현재 페이지를 이용해 계산하는 변수들
	int firstPage = currentPage - ((currentPage-1)%blockSize);
	int lastPage = firstPage + (blockSize-1);
	int curPos = (currentPage-1)*pageSize;
	
	int num = totalRecord - curPos;
	
%>

<h1>도서 목록</h1>	
<% if(keyword!=null && !keyword.isEmpty()){ %>
		<p>검색어: <%=keyword %>, <%=list.size() %>건 검색되었습니다.</p>
<% }%>
<div class = 'divList'>
	<table border="1" style="width: 600px; border-collapse: collapse;">
		<tr>
			<th>번호</th>
			<th>도서명</th>
			<th>가격</th>
			<th>출판사</th>
			<th>등록일</th>
		</tr>
		<!-- 반복 시작 -->
		<% 
			for(int i=0; i<pageSize; i++){ 
				if(num < 1) break;
				
				BookDTO dto = list.get(curPos++); 
				num--;
		%>
				
				<tr>
					<td><%=dto.getNo() %></td>
					<td><a href="bookDetail.jsp?no=<%=dto.getNo() %>"><%=dto.getTitle() %></a></td>
					<td style="text-align: right;"><%=df.format(dto.getPrice()) %></td>
					<td><%=dto.getPublisher() %></td>
					<td><%=sdf.format(dto.getJoindate()) %></td>
				</tr>
		<%	} %>
		<!-- 반복 종료 -->
	</table>
</div><br>
<div class="divPage">
	<!-- 이전 블록으로 이동 -->
	<%
		if(firstPage>1){ %>
			<a href="bookList.jsp?currentPage=<%=currentPage-1%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>">
				<img src="../images/first.JPG">
			</a>
	<%	}
	%>
	<!-- 페이지 번호 추가 -->
	<!-- [1][2][3][4][5][6][7][8][9][10] -->
	<%
		for(int i=firstPage; i<=lastPage; i++){
			if(i>totalPage) break; 
			
			if(i==currentPage) {%>
			<span style="font-weight: bold; font-size: 1em;"><%=i %></span> 
		<%	} else {%>
			<a href="bookList.jsp?currentPage=<%=i%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>">
				[<%=i %>]</a>
		<%	}
		} %>
	<!-- 페이지 번호 끝 -->
	<!-- 다음 페이지로 이동 -->
	<%
		if(lastPage<totalPage){ %>
			<a href="bookList.jsp?currentPage=<%=lastPage+1%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>">
				<img src="../images/last.JPG">
			</a>
	<%	}
	%>
</div>
<br>
<div class="divSearch" style="margin-left: 140px;">
	<form name="frmSearch" method = "post" action="bookList.jsp">
		<select name="searchCondition">
			<option value="title"
		<%  if("title".equals(condition)){ %>
				selected="selected"
		<%	}  %>
			>도서명</option>
			<option value="publisher"
		<%  if("publisher".equals(condition)){ %>
				selected="selected"
		<%	}  %>
			>출판사</option>
		</select>
		<input type="text" name="searchKeyword" title="검색어 입력" value="<%=keyword%>">
		<input type="submit" value="검색">
	</form>
</div>
<div class="divWrite" style="margin-left: 520px;"> <br>
	<a href="bookWrite.jsp">도서 등록</a>
</div>
</body>
</html>