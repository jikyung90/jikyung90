<%@page import="java.sql.SQLException"%>
<%@page import="mystudy.book.model.BookDTO"%>
<%@page import="mystudy.book.model.BookDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%
	//bookList.jsp에서 get 방식으로 이동
	//1. 요청 파라미터 읽어오기
	String no = request.getParameter("no");
	//String title = request.getParameter("title");
	//2. DB 작업
	BookDAO bookDao = new BookDAO();
	BookDTO dto = null;
	
	try{
		dto = bookDao.selectByNo(Integer.parseInt(no));
	}catch(SQLException e){
		e.printStackTrace();
	}
	//3. 출력하기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>bookDetail.jsp</title>
<script type="text/javascript" 
src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#delete").click(function(){
			if(confirm("삭제하시겠습니까?")){
				location.href = "bookDelete.jsp?no=<%=no%>";
			}
		});
	})
</script>
</head>
<body>
	<h1>도서 상세 보기</h1>
	<p>번호: <%=dto.getNo() %></p>
	<p>도서명: <%=dto.getTitle() %></p>
	<p>가격: <%=dto.getPrice() %></p>
	<p>출판사: <%=dto.getPublisher() %></p>
	<p>등록일: <%=dto.getJoindate() %></p>
	
	<a href = "bookList.jsp">목록</a>
	<a href = "bookEdit.jsp?no=<%=no %>">수정</a>
	<a href = "#" id="delete">삭제</a>
</body>
</html>