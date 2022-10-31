<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String no=request.getParameter("no");
		String name=request.getParameter("name");
	
		Date d = new Date();
		String str = d.toLocaleString();
	%>
	<hr>
	<h3>현재일자 : <%=str %></h3>
	<h4>요청 파라미터</h4>
	<p>no  :<%=no %></p>
	<p>name  :<%=name %></p>
</body>
</html>