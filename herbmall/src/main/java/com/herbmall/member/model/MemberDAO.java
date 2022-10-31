package com.herbmall.member.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.herbmall.db.ConnectionPoolMgr2;

public class MemberDAO {
	private ConnectionPoolMgr2 pool;

	public MemberDAO(){
		pool=new ConnectionPoolMgr2();
	}

	public int insertMember(MemberVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		try {
			con=pool.getConnection();

			String sql="insert into member(no, userid, name, pwd,email,"
					+ "hp, zipcode, address, addressDetail)"
					+ " values(member_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?)";
			ps=con.prepareStatement(sql);

			ps.setString(1, vo.getUserid());
			ps.setString(2,vo.getName());
			ps.setString(3, vo.getPwd());
			ps.setString(4, vo.getEmail());
			ps.setString(5, vo.getHp());
			ps.setString(6, vo.getZipcode());
			ps.setString(7, vo.getAddress());
			ps.setString(8, vo.getAddressDetail());


			int cnt=ps.executeUpdate();
			System.out.println("회원가입 결과 cnt="+cnt+", 매개변수 vo="+vo);

			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
}
