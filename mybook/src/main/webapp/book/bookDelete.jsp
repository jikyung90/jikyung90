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
	//bookDetail.jsp���� get ������� �̵�
	//1. ��û �Ķ���� �о����
	String no = request.getParameter("no");
	//2. ����۾�
	BookDAO bookDao = new BookDAO();
	
	try{
		int cnt = bookDao.deleteBook(Integer.parseInt(no));
		
		//3. ���ó��
		if(cnt>0){
			response.sendRedirect("bookList.jsp");
		}else{
			response.sendRedirect("bookDetail.jsp?no="+no);
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
</body>
</html>