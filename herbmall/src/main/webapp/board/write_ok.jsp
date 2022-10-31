<%@page import="com.herbmall.board.model.BoardVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.board.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write_ok.jsp</title>
</head>
<body>
<%
	//write.jsp 에서 post방식 이동
	
	request.setCharacterEncoding("UTF-8");
	
	//1. 요청파라미터 읽어오기
	String title=request.getParameter("title");
	String name=request.getParameter("name");
	String pwd=request.getParameter("pwd");
	String email=request.getParameter("email");
	String content=request.getParameter("content");
	
	//ip읽어오기
	String ip = request.getRemoteAddr();
	System.out.println("ip="+ip);
	
	ip=request.getRemoteHost();
	System.out.println("ip="+ip);
	
	
	//2. db작업
	BoardDAO bdao= new BoardDAO();
	BoardVO vo = new BoardVO();
	vo.setTitle(title);
	vo.setName(name);
	vo.setPwd(pwd);
	vo.setEmail(email);
	vo.setContent(content);
	
	int cnt=0;
	
	try{
	cnt = bdao.insertBoard(vo);
		//3. 결과처리
	
		
		 if(cnt>0){ %>
		 <script type="text/javascript">
		 	alert('글 등록되었습니다.');
		 	location.href="list.jsp";
		 </script>
		<% }else{ %>
		<script type="text/javascript">
			alert('글 등록 실패!');
			history.back();
		</script>
		<%} 
	}catch(SQLException e){
		e.printStackTrace();
	}
	
%>
</body>
</html>