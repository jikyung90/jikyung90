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
	//bookWrite.jsp���� post������� ����
	//��û �Ķ���Ϳ� ���� �ѱ� ���ڵ� ó��
	request.setCharacterEncoding("euc-kr");

	//1. ��û �Ķ���� �о����
	String bookTitle = request.getParameter("bookTitle");
	String price = request.getParameter("price");
	String publisher = request.getParameter("publisher");
	
	//2. db �۾�
	BookDAO bookDao = new BookDAO();
	BookDTO dto = new BookDTO();
	
	dto.setTitle(bookTitle);
	dto.setPrice(Integer.parseInt(price));
	dto.setPublisher(publisher);
	
	try{
		int cnt = bookDao.insertBook(dto);
		
		//3. ��� ó��
		if(cnt > 0){
			response.sendRedirect("bookList.jsp");
		}else{
			System.out.println("���� ��� ����");
			response.sendRedirect("bookWrite.jsp");
		}	
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
</body>
</html>