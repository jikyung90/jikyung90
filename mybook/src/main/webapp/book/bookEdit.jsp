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
	//bookDetail.jsp ���� get ������� �̵�
	//1. ��û �Ķ���� �о����
	String no = request.getParameter("no");

	//2. db �۾�
	BookDAO bookDao = new BookDAO();
	BookDTO dto = new BookDTO();
	
	try{
		dto = bookDao.selectByNo(Integer.parseInt(no));
		
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
<h2>���� ����</h2>
<form name="frmBook" method="post" action="bookEdit_ok.jsp">
	<input type="hidden" name="no" value="<%=no%>">
	���� ����: <input type="text" name="title" value="<%=dto.getTitle()%>"><br>
	����: <input type="text" name="price" value="<%=dto.getPrice()%>"><br>
	���ǻ�: <input type="text" name="publisher" value="<%=dto.getPublisher()%>"> <br><br>
	<input type="submit" value="���">
	<input type="reset" value="���">
</form><br>
	<a href = "bookList.jsp">���� ���</a>
</body>
</html>