package com.mybook.book.model;

import java.sql.SQLException;
import java.util.List;

public class BookService {
	private BookDAO bookDao;
	
	public BookService() {
		bookDao = new BookDAO();
	}
	public int insertBook(BookVO bookVo) throws SQLException {
		 return bookDao.insertBook(bookVo);
	}

	public BookVO selectByNo(int no) throws SQLException {
		return bookDao.selectByNo(no);
	}

	public List<BookVO> selectAll(String condition, String keyword) throws SQLException {
		return bookDao.selectAll(condition, keyword);
	}

	public int deleteBook(int no) throws SQLException {
		return bookDao.deleteBook(no);
	}

	public int updateBook(BookVO bookVo) throws SQLException {
		return bookDao.updateBook(bookVo);
	}
}
