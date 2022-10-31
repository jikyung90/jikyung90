<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.IOException"%>
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
	String upDir="pds_upload";
	String saveDir=application.getRealPath(upDir);
	System.out.println("1.saveDir="+saveDir);
	
	saveDir = config.getServletContext().getRealPath(upDir);
	System.out.println("2.saveDir="+saveDir);
	
	saveDir="C:\\lecture\\workspace_list\\jsp_ws\\herbmall\\src\\main\\webapp\\pds_upload";
	System.out.println("3.saveDir="+saveDir);
	
	int maxSize=2*1024*1024;
	
	try{
		MultipartRequest mr = new MultipartRequest(request, saveDir, maxSize, "utf-8",
				new DefaultFileRenamePolicy());
		
		out.print("업로드 완료");
		
		//업로드된 파일의 정보 읽어오기
		Enumeration fnames = mr.getFileNames();
		//=>여러개 파일을 업로드하는 경우 파일이름 목록을 리턴
				
		while(fnames.hasMoreElements()){
			String fname=(String)fnames.nextElement();
			//=> upfile1, upfile2, upfile3
					
			String fileName=mr.getFilesystemName(fname);
			//=>업로드된  파일의 이름(변경된 파일 이름)
			String originalFname = mr.getOriginalFileName(fname);
			//=> 변경전 원래 파일 이름
			File file = mr.getFile(fname);
			long fileSize=0;
			if(file!=null){
				fileSize=file.length();
			}
			
			out.print("업로드된 파일명:"+fileName+"<br>");
			out.print("원래 파일명:"+originalFname+"<br>");
			out.print("파일크기:"+fileSize+"<br>");
		}//while
			
			//요청 파라미터 읽어오기
			String id=mr.getParameter("id");
			String address=mr.getParameter("address");
			
			out.print("아이디:"+ id +"<br>");
			out.print("주소:"+ address +"<br>");
	}catch(IOException e){
		e.printStackTrace();
	}
%>
</body>
</html>