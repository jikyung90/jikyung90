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
	//bookDetail ���� post ������� �̵�
	request.setCharacterEncoding("euc-kr");
	
	//1. ��û �Ķ���� �о����
	String no = request.getParameter("no");
	String title = request.getParameter("title");
	String price = request.getParameter("price");
	String publisher = request.getParameter("publisher");
	
	//3. db ����
	BookDAO bookDao = new BookDAO();
	BookDTO dto = new BookDTO();
	
	dto.setNo(Integer.parseInt(no));
	dto.setTitle(title);
	dto.setPrice(Integer.parseInt(price));
	dto.setPublisher(publisher);
	
	try{
		int cnt = bookDao.updateBook(dto);
		if(cnt>0){
			response.sendRedirect("bookList.jsp?no="+no);
		}else{
			response.sendRedirect("bookEdit.jsp?no="+no);
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
</body>
</html>