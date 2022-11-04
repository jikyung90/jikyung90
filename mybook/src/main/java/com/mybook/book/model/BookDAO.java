package com.mybook.book.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.mybook.db.ConnectionPoolMgr;

public class BookDAO {
	private ConnectionPoolMgr pool;

	public BookDAO() {
		pool = new ConnectionPoolMgr();
	}

	public int insertBook(BookVO bookVo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		int cnt = 0;
		try {
			// 1 & 2
			con = pool.getConnection();

			// 3.
			String sql = "insert into book(no, title, price, publisher)\r\n" + "values (book_seq.nextval, ?, ?, ?)";
			ps = con.prepareStatement(sql);

			// in parameter setting
			ps.setString(1, bookVo.getTitle());
			ps.setInt(2, bookVo.getPrice());
			ps.setString(3, bookVo.getPublisher());

			// 4.
			cnt = ps.executeUpdate();
			System.out.println("수행된 행의 개수: " + cnt);

		} finally {
			pool.dbClose(ps, con);
		}
		return cnt;
	}

	public BookVO selectByNo(int no) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		BookVO bookVo = new BookVO();
		try {
			// 1 & 2
			con = pool.getConnection();

			// 3.
			String sql = "select * from book where no = ?";
			ps = con.prepareStatement(sql);

			ps.setInt(1, no);

			// 4.
			rs = ps.executeQuery();
			if (rs.next()) {
				String title = rs.getString(2);
				int price = rs.getInt(3);
				String publisher = rs.getString(4);
				Timestamp joindate = rs.getTimestamp(5);

				bookVo.setNo(no);
				bookVo.setTitle(title);
				bookVo.setPrice(price);
				bookVo.setPublisher(publisher);
				bookVo.setJoindate(joindate);

				bookVo = new BookVO(no, title, price, publisher, joindate);
			}
			return bookVo;
		} finally {
			pool.dbClose(rs, ps, con);
		}
	}

	public List<BookVO> selectAll(String condition, String keyword) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		List<BookVO> list = new ArrayList<>();

		try {
			// 1&2
			con = pool.getConnection();

			// 3.
			String sql = "select * from book";

			// 검색의 경우
			if (keyword != null && !keyword.isEmpty()) {
				sql += " where " + condition + " like '%' || ? ||'%'";
			}
			sql += " order by no desc";
			ps = con.prepareStatement(sql);

			if (keyword != null && !keyword.isEmpty()) {
				ps.setString(1, keyword);
			}

			// 4
			rs = ps.executeQuery();
			while (rs.next()) {
				int no = rs.getInt(1);
				String title = rs.getString(2);
				int price = rs.getInt(3);
				String publisher = rs.getString(4);
				Timestamp joindate = rs.getTimestamp(5);

				BookVO bookVo = new BookVO(no, title, price, publisher, joindate);
				list.add(bookVo);
			} // if
			System.out.println("글 전체 조회 결과 list.size = " + list.size() + ", 매개변수 condition = " + condition
					+ ", keyword = " + keyword);
			return list;
		} finally {
			pool.dbClose(rs, ps, con);
		}
	}

	public int deleteBook(int no) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;

		try {
			con = pool.getConnection();

			String sql = "delete from book where no=?";
			ps = con.prepareStatement(sql);

			ps.setInt(1, no);

			int cnt = ps.executeUpdate();

			return cnt;
		} finally {
			pool.dbClose(ps, con);
		}
	}

	public int updateBook(BookVO bookVo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;

		try {
			con = pool.getConnection();

			String sql = "update book" + " set title=?, price=?, publisher=?" + " where no = ?";
			ps = con.prepareStatement(sql);

			ps.setString(1, bookVo.getTitle());
			ps.setInt(2, bookVo.getPrice());
			ps.setString(3, bookVo.getPublisher());
			ps.setInt(4, bookVo.getNo());

			int cnt = ps.executeUpdate();

			return cnt;
		} finally {
			pool.dbClose(ps, con);
		}
	}

}
