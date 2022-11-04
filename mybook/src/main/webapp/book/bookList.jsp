<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="mystudy.book.model.BookDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="mystudy.book.model.BookDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>bookList.jsp</title>
</head>
<body>
<%
	//[1] bookWrite.jsp���� [�������] Ŭ���ϸ� get ������� �̵�
	//[2] bookWrite_ok.jsp���� �����ϸ� get ������� �̵�
	//[3] booklist.jsp���� [�˻�]�ϸ� post ������� ����Ե�
	//[4] booklist.jsp���� [��������ȣ]Ŭ���ϸ� get ������� �̵�
	
	//1. ��û �Ķ���� �о����
	request.setCharacterEncoding("euc-kr");
	String condition = request.getParameter("searchCondition");
	String keyword = request.getParameter("searchKeyword");
	
	if(keyword == null) keyword="";
	
	//2. db�۾�
	BookDAO bookDao = new BookDAO();
	List<BookDTO> list = null;
	
	try{
		list = bookDao.selectAll(condition, keyword);
	}catch(SQLException e){
		e.printStackTrace();
	}
	//3. ��� ó��
	DecimalFormat df = new DecimalFormat("#,###");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	//������ ó��
	int currentPage = 1;
	
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	//���� �������� ������ ������
	int totalRecord = 0; //�� ���ڵ� ����
	
	if(list != null && !list.isEmpty()){
		totalRecord = list.size();
	}
	
	int pageSize = 5; //�� �������� ������ ���ڵ� ����
	int totalPage = (int)Math.ceil((float)totalRecord/pageSize);
	int blockSize = 10; //�� ���� ������ ������ ��
	
	//���� �������� �̿��� ����ϴ� ������
	int firstPage = currentPage - ((currentPage-1)%blockSize);
	int lastPage = firstPage + (blockSize-1);
	int curPos = (currentPage-1)*pageSize;
	
	int num = totalRecord - curPos;
	
%>

<h1>���� ���</h1>	
<% if(keyword!=null && !keyword.isEmpty()){ %>
		<p>�˻���: <%=keyword %>, <%=list.size() %>�� �˻��Ǿ����ϴ�.</p>
<% }%>
<div class = 'divList'>
	<table border="1" style="width: 600px; border-collapse: collapse;">
		<tr>
			<th>��ȣ</th>
			<th>������</th>
			<th>����</th>
			<th>���ǻ�</th>
			<th>�����</th>
		</tr>
		<!-- �ݺ� ���� -->
		<% 
			for(int i=0; i<pageSize; i++){ 
				if(num < 1) break;
				
				BookDTO dto = list.get(curPos++); 
				num--;
		%>
				
				<tr>
					<td><%=dto.getNo() %></td>
					<td><a href="bookDetail.jsp?no=<%=dto.getNo() %>"><%=dto.getTitle() %></a></td>
					<td style="text-align: right;"><%=df.format(dto.getPrice()) %></td>
					<td><%=dto.getPublisher() %></td>
					<td><%=sdf.format(dto.getJoindate()) %></td>
				</tr>
		<%	} %>
		<!-- �ݺ� ���� -->
	</table>
</div><br>
<div class="divPage">
	<!-- ���� ������� �̵� -->
	<%
		if(firstPage>1){ %>
			<a href="bookList.jsp?currentPage=<%=currentPage-1%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>">
				<img src="../images/first.JPG">
			</a>
	<%	}
	%>
	<!-- ������ ��ȣ �߰� -->
	<!-- [1][2][3][4][5][6][7][8][9][10] -->
	<%
		for(int i=firstPage; i<=lastPage; i++){
			if(i>totalPage) break; 
			
			if(i==currentPage) {%>
			<span style="font-weight: bold; font-size: 1em;"><%=i %></span> 
		<%	} else {%>
			<a href="bookList.jsp?currentPage=<%=i%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>">
				[<%=i %>]</a>
		<%	}
		} %>
	<!-- ������ ��ȣ �� -->
	<!-- ���� �������� �̵� -->
	<%
		if(lastPage<totalPage){ %>
			<a href="bookList.jsp?currentPage=<%=lastPage+1%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>">
				<img src="../images/last.JPG">
			</a>
	<%	}
	%>
</div>
<br>
<div class="divSearch" style="margin-left: 140px;">
	<form name="frmSearch" method = "post" action="bookList.jsp">
		<select name="searchCondition">
			<option value="title"
		<%  if("title".equals(condition)){ %>
				selected="selected"
		<%	}  %>
			>������</option>
			<option value="publisher"
		<%  if("publisher".equals(condition)){ %>
				selected="selected"
		<%	}  %>
			>���ǻ�</option>
		</select>
		<input type="text" name="searchKeyword" title="�˻��� �Է�" value="<%=keyword%>">
		<input type="submit" value="�˻�">
	</form>
</div>
<div class="divWrite" style="margin-left: 520px;"> <br>
	<a href="bookWrite.jsp">���� ���</a>
</div>
</body>
</html>