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
	scope="session" />
<jsp:setProperty property="count" name="counterVo"/>
<h1>scope3.jsp</h1>
<p>count : <jsp:getProperty property="count" name="counterVo"/></p>
<a href="result3.jsp">result3.jsp</a>
<br><br>
<p>세션 아이디 : <%=session.getId() %></p>
</body>
</html>