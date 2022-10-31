package com.herbmall.reboard.model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.herbmall.db.ConnectionPoolMgr1;

public class ReBoardDAO {	
	private ConnectionPoolMgr1 pool;

	public ReBoardDAO(){
		pool=ConnectionPoolMgr1.getInstance();
	}

	public int insertReBoard(ReBoardVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;

		try {
			//1,2 con
			con=pool.getConnection();

			//3. ps
			String sql="insert into reBoard(no, name, pwd, title, "
					+ "email, content, groupno, fileName, fileSize,"
					+ "originalFileName)"
					+ " values(reBoard_seq.nextval, ?,?,?,?,?, "
					+ "reBoard_seq.nextval,?,?,?)";
			ps=con.prepareStatement(sql);

			ps.setString(1, vo.getName());
			ps.setString(2, vo.getPwd());
			ps.setString(3, vo.getTitle());
			ps.setString(4, vo.getEmail());
			ps.setString(5, vo.getContent());
			ps.setString(6, vo.getFileName());
			ps.setLong(7, vo.getFileSize());
			ps.setString(8, vo.getOriginalFileName());

			//4. exec
			int cnt=ps.executeUpdate();
			System.out.println("글 등록 결과 cnt="+cnt+", 매개변수 vo="+vo);

			return cnt;
		}finally {
			//5.
			pool.dbClose(ps, con);
		}
	}

	public List<ReBoardVO> selectAll(String condition, String keyword) 
			throws SQLException {
		/*
			select * from reBoard
			where name like '%길동%';

			select * from reBoard
			where title like '%안녕%';

			select * from reBoard
			where content like '%내용%';*/

		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;

		List<ReBoardVO> list=new ArrayList<>();
		try {
			//1,2 con
			con=pool.getConnection();

			//3. ps
			String sql="select * from reBoard";

			//검색의 경우
			if(keyword!=null && !keyword.isEmpty()) {
				sql+=" where "+ condition +" like '%' || ? || '%'";
			}			
			sql+=" order by groupno desc, sortno";
			ps=con.prepareStatement(sql);

			if(keyword!=null && !keyword.isEmpty()) {
				ps.setString(1, keyword);
			}

			//4. exec
			rs=ps.executeQuery();
			while(rs.next()) {
				int no=rs.getInt("no");
				int readcount=rs.getInt("readcount");
				String title=rs.getString("title");
				String name=rs.getString("name");
				String pwd=rs.getString("pwd");
				String email=rs.getString("email");
				String content=rs.getString("content");
				Timestamp regdate=rs.getTimestamp("regdate");

				//답변형 게시판 추가
				int groupNo=rs.getInt("groupno");
				int step=rs.getInt("step");
				int sortNo=rs.getInt("sortno");
				String delFlag=rs.getString("delflag");
				
				//자료실 추가
				String fileName=rs.getString("filename");
				String originalFName=rs.getString("originalfilename");
				long fileSize=rs.getLong("filesize");
				int downcount=rs.getInt("downcount");
				
				ReBoardVO vo = new ReBoardVO(no, name, pwd, title, 
						email, regdate, readcount, content, groupNo, 
						step, sortNo, delFlag, fileName, fileSize, 
						downcount, originalFName);
				
				list.add(vo);
			}
			System.out.println("글 전체 조회 결과 list.size="+list.size()
			+", 매개변수 condition="+condition+", keyword="+keyword);

			return list;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}

	public ReBoardVO selectByNo(int no) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;

		ReBoardVO vo = new ReBoardVO();
		try {
			//1,2 con
			con=pool.getConnection();

			//3 ps
			String sql="select * from reBoard where no=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, no);

			//4 exec
			rs=ps.executeQuery();
			while(rs.next()) {
				int readcount=rs.getInt("readcount");
				String title=rs.getString("title");
				String name=rs.getString("name");
				String pwd=rs.getString("pwd");
				String email=rs.getString("email");
				String content=rs.getString("content");
				Timestamp regdate=rs.getTimestamp("regdate");

				//답변형 게시판 추가
				int groupNo=rs.getInt("groupno");
				int step=rs.getInt("step");
				int sortNo=rs.getInt("sortno");
				String delFlag=rs.getString("delflag");

				//자료실 추가
				String fileName=rs.getString("filename");
				String originalFName=rs.getString("originalfilename");
				long fileSize=rs.getLong("filesize");
				int downcount=rs.getInt("downcount");
				
				vo.setContent(content);
				vo.setEmail(email);
				vo.setName(name);
				vo.setNo(no);
				vo.setPwd(pwd);
				vo.setReadcount(readcount);
				vo.setRegdate(regdate);
				vo.setTitle(title);
				vo.setGroupNo(groupNo);
				vo.setStep(step);
				vo.setSortNo(sortNo);
				vo.setDelFlag(delFlag);
				vo.setFileName(fileName);
				vo.setFileSize(fileSize);
				vo.setOriginalFileName(originalFName);
				vo.setDownCount(downcount);
			}
			System.out.println("글상세보기 결과 vo="+vo+", 매개변수 no="+no);
			return vo;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}

	public int updateReBoard(ReBoardVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;

		try {
			//1,2 
			con=pool.getConnection();

			//3
			String sql="update reBoard";
			sql+= " set name=?,title=?,email=?,content=?";
			if(vo.getFileName()!=null && vo.getFileName().isEmpty()) {
				sql+=", filename=?, filesize=?, originalfilename=?";
			}
			sql+= " where no=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getTitle());
			ps.setString(3, vo.getEmail());
			ps.setString(4, vo.getContent());
			if(vo.getFileName()!=null && vo.getFileName().isEmpty()) {
				ps.setString(5, vo.getFileName());
				ps.setLong(6, vo.getFileSize());
				ps.setString(7, vo.getOriginalFileName());
				ps.setInt(8, vo.getNo());
			}
			ps.setInt(5, vo.getNo());

			//4
			int cnt=ps.executeUpdate();
			System.out.println("글수정 결과 cnt="+cnt+", 매개변수 vo="+vo);

			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}

	/*
	--deleteReboard.sql
	--exec deleteReboard(8);
	create or replace procedure deleteReboard --프로시저 이름 
	(
	--매개변수
	    m_no  number
	)
	is
	--변수선언부
	    cnt number;
	    v_groupNo   number;
	    v_step  number;
	begin
	--답변이 있는 원본글인 경우에는 레코드를 삭제하지 말고 DelFlag = Y 로 update
	select step, groupno into v_step, v_groupNo
	from reboard
	where no=m_no;
	
	    --원본글인 경우
	    if v_step=0 then
	        --답변글이 존재하는지 체크
	        select count(*) into cnt
	        from reboard
	        where groupno=v_groupNo;
	        
	        --답변글이 존재한다면
	        if cnt>1 then
	            update reboard
	            set delflag='Y'
	            where no=m_no;
	        else --답변글이 없는 경우
	            delete from reboard
	            where no=m_no;
	        end if;
	    else  --답변글인 경우
	        delete from reboard
	        where no=m_no;
	    end if;
	    
	    commit;
	EXCEPTION
	    WHEN OTHERS THEN
		raise_application_error(-20001, '글 삭제 실패!');
	        ROLLBACK;
	end;
 
	*/
	public void deleteReBoard(int no) throws SQLException{
		Connection con=null;
		CallableStatement ps=null;

		try{
			//[1][2] con
			con=pool.getConnection();

			//[3] ps			
			String sql="call deleteReboard(?)";
			ps=con.prepareCall(sql);
			ps.setInt(1, no);

			//[4] 실행
			boolean bool= ps.execute();
			System.out.println("글 삭제 결과 bool="+bool+",입력값 no: "+no);
		}finally{
			pool.dbClose(ps, con);
		}		
	}

	public int updateReadCount(int no) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;

		try {
			//1,2
			con=pool.getConnection();

			//3
			String sql="update reBoard"
					+ " set readcount=readcount+1"
					+ " where no=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, no);

			//4
			int cnt=ps.executeUpdate();
			System.out.println("조회수 증가 결과 cnt="+cnt+", 매개변수 no="+no);
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}

	public int reply(ReBoardVO vo) throws SQLException {
		//답변 처리
		Connection con=null;
		PreparedStatement ps=null;

		int cnt = 0;
		try {
			//1,2
			con=pool.getConnection();

			//트랜잭션 시작
			con.setAutoCommit(false); //자동커밋 안되게 막는다

			//3
			//[1] update
			String sql="update reboard"
					+ " set sortno=sortno+1"
					+ " where groupno=? and sortno>?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, vo.getGroupNo());
			ps.setInt(2, vo.getSortNo());

			//4
			cnt = ps.executeUpdate();

			//[2] insert
			sql="insert into reBoard(no, name, pwd, title, "
					+ "email, content, groupno, step, sortno)"
					+ "values(reBoard_seq.nextval, ?,?,?,?,?,"
					+ "?,?,?)";
			ps=con.prepareStatement(sql);
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getPwd());
			ps.setString(3, vo.getTitle());
			ps.setString(4, vo.getEmail());
			ps.setString(5, vo.getContent());
			ps.setInt(6, vo.getGroupNo());
			ps.setInt(7, vo.getStep()+1);
			ps.setInt(8, vo.getSortNo()+1);

			cnt=ps.executeUpdate();

			//모두 성공하면 commit
			con.commit();

			//트랜잭션 종료
		}catch(SQLException e) {
			e.printStackTrace();

			//하나라도 실패하면 rollback
			con.rollback();
		}finally {
			//다시 자동커밋되도록 셋팅
			con.setAutoCommit(true);

			pool.dbClose(ps, con);
		}

		return cnt;
	}

	public boolean checkPwd(int no, String pwd) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		try {
			//1,2
			con=pool.getConnection();
			
			//3
			String sql="select pwd from reboard where no=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, no);
			
			//4
			boolean result=false;
			rs=ps.executeQuery();
			if(rs.next()) {
				String dbPwd=rs.getString("pwd");
				if(dbPwd.equals(pwd)) {
					result=true; //비밀번호 일치하면
				}
			}
			
			System.out.println("비밀번호 체크 결과 result="+result
					+", 매개변수 no="+no+", pwd="+pwd);
			return result;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	public int updateDownCount(int no) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			//1,2
			con=pool.getConnection();
			
			//3
			String sql="update reboard\r\n"
					+ "set downcount= downcount+1\r\n"
					+ "where no=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, no);
			
			//4
			int cnt = ps.executeUpdate();
			System.out.println("다운로두수 증가 결과 cnt="+cnt+", 매개변수 no="+no);
			return cnt;
			
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
}