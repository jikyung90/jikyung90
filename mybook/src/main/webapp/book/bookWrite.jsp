<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>bookWrite</title>
</head>
<body>
<h1>도서 등록</h1>
<form name="frmBook" method="post" action="bookWrite_ok.jsp">
	도서명: <input type="text" name="bookTitle"><br>
	가격: <input type="text" name="price"><br>
	출판사: <input type="text" name="publisher"><br><br>
	<input type="submit" value="등록">
	<input type="reset" value="취소">
</form>
<br><br>
<a href="bookList.jsp">도서 목록</a>
</body>
</html>