<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>bookWrite</title>
</head>
<body>
<h1>���� ���</h1>
<form name="frmBook" method="post" action="bookWrite_ok.jsp">
	������: <input type="text" name="bookTitle"><br>
	����: <input type="text" name="price"><br>
	���ǻ�: <input type="text" name="publisher"><br><br>
	<input type="submit" value="���">
	<input type="reset" value="���">
</form>
<br><br>
<a href="bookList.jsp">���� ���</a>
</body>
</html>