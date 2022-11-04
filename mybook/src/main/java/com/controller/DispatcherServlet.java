package com.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DispatcherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Properties props;

	// 최초에 한번만 실행되는 메서드 -> 맵핑파일을 읽어서 properties 컬렉션에 저장
	public void init(ServletConfig config) {
		// web.xml에서 init-param 값 읽어온다
		String configFile = config.getInitParameter("configFile");

		// 맵핑파일 실제 경로 구하기
		String realConfigFile = config.getServletContext().getRealPath(configFile);

		// 맵핑파일 properties에 저장
		props = new Properties();
		FileInputStream fis = null;

		try {
			fis = new FileInputStream(realConfigFile);
			props.load(fis);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		requestPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		requestPro(request, response);

	}

	// 사용자가 호출할때마나 불러옴 -> 대표가 해당 직원을 찾아서 일시긴다
	private void requestPro(HttpServletRequest request, HttpServletResponse response)
			throws UnsupportedEncodingException {
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");

		// 해당 직원(Controller) 찾기
		String uri = request.getRequestURI(); // => /mymvc/tips/menuForm
		String contextPath = request.getContextPath(); // => /mymvc -> contextPath 제거하면, 명령어 찾을 수 있음

		if (uri.indexOf(contextPath) != -1) { // contextPath가 존재하지 않으면 -1
			uri = uri.substring(contextPath.length());
		}

		String commendStr = props.getProperty(uri);

		// String을 클래스로 만들기 (forClass())
		try {
			Class commendClass = Class.forName(commendStr);
			Controller controller = (Controller) commendClass.newInstance();

			// 담당자 메서드 호출
			String viewPage = controller.requestProcess(request, response);

			if (controller.isRedirect()) {
				System.out.println("redirect");
				response.sendRedirect(contextPath + viewPage);
			} else {
				System.out.println("forward");
				RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
				dispatcher.forward(request, response);
			}

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}

	}

}
