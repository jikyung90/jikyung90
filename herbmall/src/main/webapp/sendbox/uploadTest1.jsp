<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form name="frm1" method="post" action="uploadTest1_ok.jsp" 
	enctype="multipart/form-data">
	아이디 : <input type="text" name="id"><br>
	파일 업로드 : <input type="file" name="fileName" size="30"><br>
	<input type = "submit" value="등록"><br>
</form>
</body>
</html>