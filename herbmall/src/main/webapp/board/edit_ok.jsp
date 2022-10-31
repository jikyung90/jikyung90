<%@page import="java.sql.SQLException"%>
<%@page import="java.awt.PrintGraphics"%>
<%@page import="com.herbmall.board.model.BoardVO"%>
<%@page import="com.herbmall.board.model.BoardDAO"%>
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
	//edit.jsp에서 post 방식으로
	request.setCharacterEncoding("UTF-8");
	//1
	String title=request.getParameter("title");
	String name=request.getParameter("name");
	String pwd=request.getParameter("pwd");
	String email=request.getParameter("email");
	String content=request.getParameter("content");
	String no=request.getParameter("no");
	//2
	BoardDAO dao= new BoardDAO();
	BoardVO vo= new BoardVO();
	vo.setContent(content);
	vo.setName(name);
	vo.setPwd(pwd);
	vo.setEmail(email);
	vo.setTitle(title);
	vo.setNo(Integer.parseInt(no));
	
	
	try{
		//3
		int cnt=dao.updateBoard(vo);
		
		if(cnt>0){%>
			<script type="text/javascript">
				alert('글 수정되었습니다.')
				location.href="detail.jsp?no=<%=no%>";
			</script>
		<% }else{%>
			<script type="text/javascript">
				alert('글 수정 실패!');
				history.go(-1);
			</script>
		<%}
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
</body>
</html>