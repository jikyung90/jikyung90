<%@page import="java.io.IOException"%>
<%@page import="java.io.File"%>
<%@page import="com.herbmall.common.Utility"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
	
	//업로드할 경로
	String saveDir=application.getRealPath(Utility.UPLOAD_DIR);
	saveDir=config.getServletContext().getRealPath(Utility.UPLOAD_DIR);
	System.out.println("saveDir="+saveDir);
	
	saveDir=Utility.TEST_DIR;
	System.out.println("testDir="+saveDir);
			
	int maxSize=2*1024*1024; //업로드할 최대 용량, 2M
	
	try{
		DefaultFileRenamePolicy policy=new DefaultFileRenamePolicy();
		MultipartRequest mr
			=new MultipartRequest(request, saveDir, maxSize, "utf-8", policy);
		System.out.println("업로드 완료!");
		
		//업로드 파일 정보 구하기
		String fileName=mr.getFilesystemName("upfile");
		long fileSize=0;
		String originalFName="";
		if(fileName!=null){  //파일이 첨부된 경우만
			File file = mr.getFile("upfile");
			fileSize=file.length();
			
			originalFName=mr.getOriginalFileName("upfile");
		}
		
		//1
		String title=mr.getParameter("title");
		String name=mr.getParameter("name");
		String pwd=mr.getParameter("pwd");
		String email=mr.getParameter("email");
		String content=mr.getParameter("content");
		
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
		vo.setFileName(fileName);
		vo.setFileSize(fileSize);
		vo.setOriginalFileName(originalFName);
		
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
	}catch(IOException e){%>
		<script type="text/javascript">
			alert('2M 이상의 파일은 업로드할 수 없습니다!');
			history.back();
		</script>
	<%	e.printStackTrace();
	}
%>
</body>
</html>