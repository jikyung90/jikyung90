<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.herbmall.common.Utility"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="javax.swing.plaf.multi.MultiMenuItemUI"%>
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
	try{
		//upload
		String saveDir=application.getRealPath(Utility.UPLOAD_DIR);
		saveDir=config.getServletContext().getRealPath(Utility.UPLOAD_DIR);
		saveDir=Utility.TEST_DIR;
		
		int maxSize=2*1024*1024; //2M
		DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
		
		MultipartRequest mr
			= new MultipartRequest(request, saveDir, maxSize, "utf-8",
					policy);
		System.out.println("업로드 완료!");
		
		//
		String fileName=mr.getFilesystemName("upfile");
		long fileSize=0;
		String originalFName="";
		if(fileName!=null && fileName.isEmpty()){
			originalFName=mr.getOriginalFileName("upfile");
			File file = mr.getFile("upfile");
			fileSize =file.length();
		}
		
		//1
		String title=mr.getParameter("title");
		String name=mr.getParameter("name");
		String pwd=mr.getParameter("pwd");
		String email=mr.getParameter("email");
		String content=mr.getParameter("content");
		String no=mr.getParameter("no");
		String oldFileName=mr.getParameter("oldFileName");
		
		
		//2
		ReBoardDAO dao = new ReBoardDAO();
		ReBoardVO vo = new ReBoardVO();
		vo.setContent(content);
		vo.setEmail(email);
		vo.setName(name);
		vo.setNo(Integer.parseInt(no));
		vo.setPwd(pwd);
		vo.setTitle(title);
		vo.setFileName(fileName);
		vo.setFileSize(fileSize);
		vo.setOriginalFileName(originalFName);
		
		if(dao.checkPwd(Integer.parseInt(no), pwd)){
			int cnt=dao.updateReBoard(vo);
			
			//3
			if(cnt>0){ 
				//새로 첨부파일을 지정한 경우(새로 업로드한 경우)
				if(fileName!=null && fileName.isEmpty()){
					if(oldFileName!=null &&oldFileName.isEmpty()){
						
					}
				}
			%>
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