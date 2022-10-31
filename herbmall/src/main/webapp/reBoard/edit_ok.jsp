<%@page import="com.herbmall.reboard.model.ReBoardVO"%>
<%@page import="com.herbmall.reboard.model.ReBoardDAO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>edit_ok.jsp</title>
</head>
<body>
<%
	//edit.jsp에서 post방식으로 서브밋됨
	//1
	request.setCharacterEncoding("utf-8");
	String title=request.getParameter("title");
	String name=request.getParameter("name");
	String pwd=request.getParameter("pwd");
	String email=request.getParameter("email");
	String content=request.getParameter("content");
	String no=request.getParameter("no");
	
	//2
	ReBoardDAO dao = new ReBoardDAO();
	ReBoardVO vo = new ReBoardVO();
	vo.setContent(content);
	vo.setEmail(email);
	vo.setName(name);
	vo.setNo(Integer.parseInt(no));
	vo.setPwd(pwd);
	vo.setTitle(title);
	
	try{
		if(dao.checkPwd(Integer.parseInt(no), pwd)){
			int cnt=dao.updateReBoard(vo);
			
			//3
			if(cnt>0){ %>
				<script type="text/javascript">
					alert('글수정되었습니다.');
					location.href="detail.jsp?no=<%=no%>";
				</script>
			<%}else{%>
				<script type="text/javascript">
					alert('글수정 실패!');
					history.go(-1);
				</script>			
			<%}
		}else{ %>
			<script type="text/javascript">
				alert('비밀번호가 일치하지 않습니다!');
				history.go(-1);
			</script>
	<%	}
	}catch(SQLException e){
		e.printStackTrace();
	}
	
%>
</body>
</html>