<%@page import="java.sql.Timestamp"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>dbcp 이용 - pd목록</h1>
	<table border="1">
		<tr>
			<th>번호</th>
			<th>상품명</th>
			<th>가격</th>
			<th>등록일</th>
		</tr>



<%
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
	try{
		Context initCtx = new InitialContext();
		Context ctx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)ctx.lookup("jdbc/oracledb");
		//=> DataSource - 톰캣이 구현한 커넥션풀 객체
		con=ds.getConnection();
		
		//3
		String sql="select * from pd order by no desc";
		ps=con.prepareStatement(sql);
		
		rs=ps.executeQuery();
		while(rs.next()){
			int no = rs.getInt("no");
			String pdName=rs.getString("pdname");
			int price = rs.getInt("price");
			Timestamp regdate=rs.getTimestamp("regdate");%>
			
			<tr>
				<td><%=no %></td>
				<td><%=pdName %></td>
				<td><%=price %></td>
				<td><%=regdate %></td>
			</tr>
		<% }
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(rs!=null) rs.close();
		if(ps!=null) ps.close();
		if(con!=null) con.close();
	}
%>
</table>
</body>
</html>