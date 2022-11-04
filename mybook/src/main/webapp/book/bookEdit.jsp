<%@page import="mystudy.book.model.BookDTO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="mystudy.book.model.BookDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	//bookDetail.jsp 에서 get 방식으로 이동
	//1. 요청 파라미터 읽어오기
	String no = request.getParameter("no");

	//2. db 작업
	BookDAO bookDao = new BookDAO();
	BookDTO dto = new BookDTO();
	
	try{
		dto = bookDao.selectByNo(Integer.parseInt(no));
		
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
<h2>도서 수정</h2>
<form name="frmBook" method="post" action="bookEdit_ok.jsp">
	<input type="hidden" name="no" value="<%=no%>">
	도서 제목: <input type="text" name="title" value="<%=dto.getTitle()%>"><br>
	가격: <input type="text" name="price" value="<%=dto.getPrice()%>"><br>
	출판사: <input type="text" name="publisher" value="<%=dto.getPublisher()%>"> <br><br>
	<input type="submit" value="등록">
	<input type="reset" value="취소">
</form><br>
	<a href = "bookList.jsp">도서 목록</a>
</body>
</html>