<%@page import="com.herbmall.reboard.model.ReBoardVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.reboard.model.ReBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="../css/mainstyle.css" />
<link rel="stylesheet" type="text/css" href="../css/clear.css" />
<link rel="stylesheet" type="text/css" href="../css/formLayout.css" />
<link rel="stylesheet" type="text/css" href="../css/mystyle.css" />

<title>답변형 게시판 답변하기 - 허브몰</title>
<script type="text/javascript" src="../js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('form[name=frmWrite]').submit(function(){
			$('.infobox').each(function(index, item){
				if($(this).val().length<1){
					alert($(this).prev().text() + '을(를) 입력하세요');
					$(this).focus();
					event.preventDefault();
					return false;
				}
			});
		});
	});
</script>

</head>
<body>
<%
	//detail.jsp에서 [답변]클릭하면 get방식으로 이동
	//=> http://localhost:9090/herbmall/reBoard/reply.jsp?no=4
	//1
	String no=request.getParameter("no");
	if(no==null || no.isEmpty()){ %>
		<script type="text/javascript">
			alert('잘못된 url입니다.');
			location.href="list.jsp";
		</script>
		
	<%	return;
	}
	
	//2
	ReBoardDAO dao = new ReBoardDAO();
	ReBoardVO vo=null;
	try{
		vo=dao.selectByNo(Integer.parseInt(no));	
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3
	
%>

<div class="divForm">
<form name="frmWrite" method="post" action="reply_ok.jsp" >
	<input type="text" name="groupNo" value="<%=vo.getGroupNo()%>">
	<input type="text" name="step" value="<%=vo.getStep()%>">
	<input type="text" name="sortNo" value="<%=vo.getSortNo()%>">
	 
 <fieldset>
	<legend>답변하기</legend>
        <div class="firstDiv">
            <label for="title">제목</label>
            <input type="text" id="title" name="title" class="infobox" 
            	value="Re : <%=vo.getTitle()%>"/>
        </div>
        <div>
            <label for="name">작성자</label>
            <input type="text" id="name" name="name" class="infobox"/>
        </div>
        <div>
            <label for="pwd">비밀번호</label>
            <input type="password" id="pwd" name="pwd" class="infobox"/>
        </div>
        <div>
            <label for="email">이메일</label>
            <input type="text" id="email" name="email" />
        </div>
        <div>  
        	<label for="content">내용</label>        
 			<textarea id="content" name="content" rows="12" cols="40"></textarea>
        </div>
        <div class="center">
            <input type = "submit" value="답변"/>
            <input type = "Button" value="글목록" 
            onclick="location.href	='list.jsp'" />         
        </div>
    </fieldset>
</form>
</div>   
</body>
</html>