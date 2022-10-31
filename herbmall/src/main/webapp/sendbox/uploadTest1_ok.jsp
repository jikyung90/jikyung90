<%@page import="java.io.IOException"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
	//MultipartRequest 객체 생성 성공 => 업로드 완료
	//실패 => IOException 발생(파일 용량 초과 등)
	
	String upDir = "pds_upload";  //업로드할 폴더
	//업로드할 폴더의 절대 경로 구하기
	String saveDir = application.getRealPath(upDir);
	System.out.println("1.saveDir="+saveDir);
	
	saveDir = config.getServletContext().getRealPath(upDir);
	System.out.println("2.saveDir="+saveDir);
	
	saveDir="C:\\lecture\\workspace_list\\jsp_ws\\herbmall\\src\\main\\webapp\\pds_upload";
	System.out.println("3.saveDir="+saveDir);
	
	int maxSize=2*1024*1024;  //업로드 최대용량, 2M로 제한	
	
	//업로드시 동일한 파일명이 있을 경우 나중에 업로드한 파일에 번호를 붙여 구분해줌
	DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
	try{
	MultipartRequest mr = new MultipartRequest(request, saveDir, maxSize,
			"utf-8", policy);
	out.print("업로드 완료!<br>");
	
	String fileName=mr.getFilesystemName("fileName");  //업로드된 파일명
	String originalFName = mr.getOriginalFileName("fileName");//변경전 파일명
	File file = mr.getFile("fileName");
	long fileSize=file.length();
	
	out.print("업로드된 파일명(변경 후) : " + fileName+"<br>");
	out.print("변경전 파일명(원래이름) : " + originalFName+"<br>");
	out.print("업로드된 파일크기 : " + fileSize+"<br>");
	
	String id=request.getParameter("id");
	String id2=mr.getParameter("id");
	
	out.print("요청 파라미터 id(request이용) : " + id+"<br>");
	out.print("요청 파라미터 id(mr이용) : " + id2+"<br>");
	}catch(IOException e){
		System.out.println("2M 이상의 파일은 업로드 불가!");
		e.printStackTrace();
	}
	%>
</body>
</html>