<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.reboard.model.ReBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>delete_ok.jsp</title>
</head>
<body>
<%
	//delete.jsp에서 post방식으로 서브밋됨
	//1
	request.setCharacterEncoding("utf-8");
	String no=request.getParameter("no");
	String pwd=request.getParameter("pwd");
	
	//2
	ReBoardDAO dao = new ReBoardDAO();
	try{
		if(dao.checkPwd(Integer.parseInt(no), pwd)){
			dao.deleteReBoard(Integer.parseInt(no));
			
			//3
			%>
			<script type="text/javascript">
				alert('글삭제되었습니다.');
				location.href="list.jsp";
			</script>			
	<%	}else{ %>
			<script type="text/javascript">
				alert('비밀번호가 일치하지 않습니다!');
				history.back();
			</script>
	<%	}
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	
%>
</body>
</html>