<%@page import="com.herbmall.board.model.BoardVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.board.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<%
	//detail.jsp 에서 [삭제]클릭 하면 get방식으로 이동
	
	//1.	
	String no = request.getParameter("no");
	if(no==null || no.isEmpty()){%>
		<script type="text/javascript">
		
		</script>
	<% }else{
		
	}


	BoardDAO dao = new BoardDAO();
	
	BoardVO vo=null;
	try{
		vo=dao.selectByNo(Integer.parseInt(no));
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>자유게시판 글 삭제 - 허브몰</title>
<link rel="stylesheet" type="text/css" href="../css/mainstyle.css" />
<link rel="stylesheet" type="text/css" href="../css/clear.css" />
<link rel="stylesheet" type="text/css" href="../css/formLayout.css" />
<link rel="stylesheet" type="text/css" href="../css/mystyle.css" />
<style type="text/css">
	body{
		padding:5px;
		margin:5px;
	 }
	.divForm{
		width:650px;
		border:1px solid #ddd;		
	}
	/* .divForm form{
		width:650px;
	} */
	.divForm div	{
		/* clear: both; */
		border:none;
		padding: 7px 0;
		margin: 0;
		overflow: auto;
	}	
	.sp{
		font-size:0.9em;
		color:#0056AC;			
	}
	.divForm fieldset	{
		border:0;
	}
</style>
<script type="text/javascript" src="../js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		$('form[name=frmDelete]').submit(function(){
			if($('#pwd').val().length<1){
				alert('비밀번호를 입력하세요');
				$('#pwd').focus();
				//event.preventDefault();
				return false;
			}
			
			if(!confirm('삭제하시겠습니까?')){
				event.preventDefault();
			}
			
			
		<%-- 	if(confirm('삭제하시겠습니까?')){
				if($('#pwd').val()==<%=vo.getPwd()%>){
					return true;
				}else{
					alert('비밀번호가 틀렸습니다');
					return false;
					event.preventDefault();
					//history.back();
				}
			}else{
				return false;
				event.preventDefault();
			} --%>
		});
	})
</script>
</head>
<body>
<div class="divForm">
<form name="frmDelete" method="post" action="delete_ok.jsp" >
		<input type="hidden" name="no" value="<%=vo.getNo()%>">
		<fieldset>
		<legend>글 삭제</legend>
	        <div>           
	        	<span class="sp"> <%=vo.getNo() %> 번 글을 삭제하시겠습니까?</span>                        
	        </div>
	        <div>           
	            <label for="pwd">비밀번호</label>
	            <input type="password" id="pwd" name="pwd" />   
	        </div>
	        <div class="center">
	            <input type ="submit"  value="삭제" />
	            <input type = "Button" value="글목록" 
                	OnClick="location.href='list.jsp'" />
	        </div>
	    </fieldset>
    </form>
</div>

</body>
</html>