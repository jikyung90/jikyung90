<%@page import="java.io.BufferedOutputStream"%>
<%@page import="com.herbmall.common.Utility"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.reboard.model.ReBoardDAO"%>
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
	//detail.jsp에서 get방식으로 이동
	//=> http://localhost:9090/herbmall/pds/download.jsp?no=2&fileName=a.txt
	//1
	String no=request.getParameter("no");
	String fileName=request.getParameter("fileName");

	//2
	ReBoardDAO dao = new ReBoardDAO();
	try{
		int cnt=dao.updateDownCount(Integer.parseInt(no));
		
		//3
		//파일 다운로드 처리
		response.reset(); //page의 설정을 바꾸기 위해서 response를 다 날려버림
		
		//octet-stream으로 지정시, content type 형식을 지정하지 않겠다는 것
		response.setContentType("application/octet-stream");
		
		//브라우저 파일 확장자를 포함하여 모든 확장자의 파일들에 대해 다운로드시 무조건 
		//파일다운로드 대화상자가 뜨도록 하는 헤더속성
		response.setHeader("Content-Disposition", "attachment;filename="
			+ new String(fileName.getBytes("euc-kr"),"ISO-8859-1"));
		//=> 파일이름을 인코딩한다.(euc-kr => ISO-8859-1) 
		//=> url전송시에는 모든 문자가 ISO-8859-1로 인코딩 되기 때문에
		
		out.clear();
		out=pageContext.pushBody();
		//=> 이를 생략하면 프로그램 상엔 이상이 없으나 이미 존재하고 있는
		//out객체로 바이트 기반의 스트림 작업을 명시하면서 오류가 발생함
		
		String saveDir = application.getRealPath(Utility.UPLOAD_DIR);
		saveDir=Utility.TEST_DIR;
		File myfile = new File(saveDir, fileName);
		
		byte[] data=new byte[1024*1024];
		BufferedInputStream bis 
			= new BufferedInputStream(new FileInputStream(myfile));
		BufferedOutputStream bos
			= new BufferedOutputStream(response.getOutputStream());
		
		int count=0;
		while((count=bis.read(data))!=-1){
			bos.write(data);
		}
		
		if(bis!=null) bis.close();
		if(bos!=null) bos.close();		
	}catch(SQLException e){
		e.printStackTrace();
	}
	
%>
</body>
</html>