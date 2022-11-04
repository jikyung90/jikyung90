<%@page import="java.sql.SQLException"%>
<%@page import="mystudy.book.model.BookDTO"%>
<%@page import="mystudy.book.model.BookDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>bookWrite_ok.jsp</title>
</head>
<body>
<%
	//bookWrite.jsp에서 post방식으로 전송
	//요청 파라미터에 대한 한글 인코딩 처리
	request.setCharacterEncoding("euc-kr");

	//1. 요청 파라미터 읽어오기
	String bookTitle = request.getParameter("bookTitle");
	String price = request.getParameter("price");
	String publisher = request.getParameter("publisher");
	
	//2. db 작업
	BookDAO bookDao = new BookDAO();
	BookDTO dto = new BookDTO();
	
	dto.setTitle(bookTitle);
	dto.setPrice(Integer.parseInt(price));
	dto.setPublisher(publisher);
	
	try{
		int cnt = bookDao.insertBook(dto);
		
		//3. 결과 처리
		if(cnt > 0){
			response.sendRedirect("bookList.jsp");
		}else{
			System.out.println("도서 등록 실패");
			response.sendRedirect("bookWrite.jsp");
		}	
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
</body>
</html>