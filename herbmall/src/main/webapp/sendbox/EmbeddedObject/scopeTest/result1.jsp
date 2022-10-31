<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="counterVo" class="com.herbmall.test.CounterVO"
	scope="page"></jsp:useBean>
	<h1>result1.jsp</h1>
	<hr>
	
	<p>count : <jsp:getProperty property="count" name="counterVo"/> </p>
	<a href="scope1.jsp">scope1.jsp로 이동</a>
</body>
</html>