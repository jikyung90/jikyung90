<%@page import="java.sql.SQLException"%>
<%@page import="mystudy.book.model.BookDTO"%>
<%@page import="mystudy.book.model.BookDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%
	//bookList.jsp���� get ������� �̵�
	//1. ��û �Ķ���� �о����
	String no = request.getParameter("no");
	//String title = request.getParameter("title");
	//2. DB �۾�
	BookDAO bookDao = new BookDAO();
	BookDTO dto = null;
	
	try{
		dto = bookDao.selectByNo(Integer.parseInt(no));
	}catch(SQLException e){
		e.printStackTrace();
	}
	//3. ����ϱ�
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
			if(confirm("�����Ͻðڽ��ϱ�?")){
				location.href = "bookDelete.jsp?no=<%=no%>";
			}
		});
	})
</script>
</head>
<body>
	<h1>���� �� ����</h1>
	<p>��ȣ: <%=dto.getNo() %></p>
	<p>������: <%=dto.getTitle() %></p>
	<p>����: <%=dto.getPrice() %></p>
	<p>���ǻ�: <%=dto.getPublisher() %></p>
	<p>�����: <%=dto.getJoindate() %></p>
	
	<a href = "bookList.jsp">���</a>
	<a href = "bookEdit.jsp?no=<%=no %>">����</a>
	<a href = "#" id="delete">����</a>
</body>
</html>