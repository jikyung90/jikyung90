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
	scope="application"></jsp:useBean>
	<h1>result4.jsp</h1>
	<hr>
	
	<p>count : <jsp:getProperty property="count" name="counterVo"/> </p>
	<a href="scope4.jsp">scope4.jsp로 이동</a>
	<br><br>
<p>세션 아이디 : <%=session.getId() %></p>
</body>
</html>