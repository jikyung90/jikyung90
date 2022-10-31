<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>forwardTest_ok.jsp</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	
		request.setAttribute("message", "안녕");
		request.setAttribute("lang", "java");
	%>
	<h1>forwardTest_ok.jsp 페이지</h1>
	<jsp:forward page="a.jsp">
		<jsp:param value="축구" name="hobby"/>
	</jsp:forward>
	<!-- a.jsp로 포워드
		현재 페이지인 forwardTest_ok.jsp와 a.jsp는 request를 공유함
	 -->
</body>
</html>