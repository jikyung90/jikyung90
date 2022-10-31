<%@page import="java.io.File"%>
<%@page import="com.herbmall.common.Utility"%>
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
	String fileName=request.getParameter("fileName");
	
	//2
	ReBoardDAO dao = new ReBoardDAO();
	try{
		if(dao.checkPwd(Integer.parseInt(no), pwd)){
			dao.deleteReBoard(Integer.parseInt(no));
			
			//파일이 첨부되었다면 파일 삭제
			if(fileName!=null && !fileName.isEmpty()){
				String saveDir = application.getRealPath(Utility.UPLOAD_DIR);
				saveDir = config.getServletContext().getRealPath(Utility.UPLOAD_DIR);
				saveDir = Utility.TEST_DIR;
				
				File myfile= new File(saveDir, fileName);
				
				if(myfile.exists()){
					boolean bool=myfile.delete();
					System.out.println("파일 삭제 여부:"+bool);
				}
			}//if
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