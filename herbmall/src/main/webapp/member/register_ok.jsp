<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="memberDao" 
	class="com.herbmall.member.model.MemberDAO" scope="session"></jsp:useBean>
<jsp:useBean id="memberVo" 
	class="com.herbmall.member.model.MemberVO" scope="page"></jsp:useBean>

<%
	//post방식
	request.setCharacterEncoding("utf-8");

	//1.
	String userid = request.getParameter("userid");
	String name = request.getParameter("name");
	String pwd = request.getParameter("pwd");
	String zipcode = request.getParameter("zipcode");
	String hp1 = request.getParameter("hp1");
	String hp2 = request.getParameter("hp2");
	String hp3 = request.getParameter("hp3");	
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email2");
	String email3 = request.getParameter("email3");
	String address = request.getParameter("address");
	String addressDetail = request.getParameter("addressDetail");
	
	//2.
	String hp ="", email ="";
	if(hp2!= null && !hp2.isEmpty() && hp3!= null && !hp3.isEmpty()){
		hp = hp1 + "-" + hp2 + "-" + hp3;
	}
	
	if(email1 != null && !email1.isEmpty()){
		if(email2.equals("etc")){
			if(email3!=null && !email.isEmpty()){
				email = email1 + "@" + email3;		
			}
		}else{
			email = email1 + "@" + email2;
		}
	}
	
	memberVo.setUserid(userid);
	memberVo.setName(name);
	memberVo.setPwd(pwd);
	memberVo.setZipcode(zipcode);
	memberVo.setHp(hp);
	memberVo.setEmail(email);
	memberVo.setAddress(address);
	memberVo.setAddressDetail(addressDetail);
	
	String msg="회원가입 실패!", url="register.jsp";
	
	try{
		int cnt = memberDao.insertMember(memberVo);
		
		if(cnt>0){
			msg="회원가입되었습니다.";
			url="../index.jsp";
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3.
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
	
%>
<jsp:forward page="../common/message.jsp"></jsp:forward>
</body>
</html>