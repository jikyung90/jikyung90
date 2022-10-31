<%@page import="com.herbmall.reboard.model.ReBoardVO"%>
<%@page import="com.herbmall.reboard.model.ReBoardDAO"%>
<%@page import="java.sql.SQLException"%>
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
	//write.jsp에서 post방식으로 서브밋됨
	request.setCharacterEncoding("utf-8");

	//1
	String title=request.getParameter("title");
	String name=request.getParameter("name");
	String pwd=request.getParameter("pwd");
	String email=request.getParameter("email");
	String content=request.getParameter("content");
	
	//ip 읽어오기
	String ip = request.getRemoteAddr();
	System.out.println("ip="+ip);
	
	ip=request.getRemoteHost();
	System.out.println("ip="+ip);
	
	//2
	ReBoardDAO dao = new ReBoardDAO();
	ReBoardVO vo = new ReBoardVO();
	vo.setContent(content);
	vo.setEmail(email);
	vo.setName(name);
	vo.setPwd(pwd);
	vo.setTitle(title);
	try{
		int cnt=dao.insertReBoard(vo);
		
		//3
		if(cnt>0){%>
			<script type="text/javascript">
				alert('글 등록되었습니다.');
				location.href="list.jsp";
			</script>
		<%}else{%>
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