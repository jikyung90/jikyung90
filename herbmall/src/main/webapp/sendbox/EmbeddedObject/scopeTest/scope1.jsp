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
	scope="page" />
<jsp:setProperty property="count" name="counterVo"/>
<h1>scope1.jsp</h1>
<p>count : <jsp:getProperty property="count" name="counterVo"/></p>
<a href="result1.jsp">result1.jsp</a>

</body>
</html>