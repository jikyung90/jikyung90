<%@page import="java.sql.SQLException"%>
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
		request.setCharacterEncoding("UTF-8");
		String no=request.getParameter("no");
		String pwd=request.getParameter("pwd");
			
		System.out.println("no="+no+"pwd"+pwd);
		BoardDAO dao=new BoardDAO();
		
		try{
			int cnt = dao.deleteBoard(Integer.parseInt(no),pwd);
			
			if(cnt>0){%>
			<script type="text/javascript">
				alert('글 삭제되었습니다');
				location.href="list.jsp";
			</script>
			<%}else{%>
			<script type="text/javascript">
			alert('글 삭제 실패!');
			history.back();
		</script>
		<%} 
		}catch(SQLException e){
			e.printStackTrace();
		}
	%>
</body>
</html>