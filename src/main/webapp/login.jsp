<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="java.text.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGIN</title>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "teamproject";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
	Connection conn = null;
	PreparedStatement pstmt;
	Statement stmt = null;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	stmt = conn.createStatement();
	String query = "";
	%>
	<h4>------ Login --------</h4>
	<%
	try {
		int check;

		query = "SELECT NAME, RRN FROM CUSTOMER WHERE  Name = ? and RRN = ?";

		pstmt = conn.prepareStatement(query);
		String name = request.getParameter("name");
		String rrn = request.getParameter("rrn");

		pstmt.setString(1, name);
		pstmt.setString(2, rrn);

		rs = pstmt.executeQuery();

		if (rs.next() != false && name.equals(rs.getString(1)) && rrn.equals(rs.getString(2))) {

			//등록된 경우			
			check = 1;
			out.println("환영합니다");

		} else {
			check = 0; //등뢱되지 않은 경우
			out.println("죄송합니다");
		}
		if (check == 1 && rrn.equals("1234567") && name.equals("조준표")) {

			check = 2;
			out.println("관리자");

		}

		if (check == 1) {
	%>
	<a href=menu.html target=_self>확인</a>
	<%
	}
	if (check == 0) {
	%>
	<a href=login.html target=_self>확인</a>
	<%
	}

	if (check == 2) {
	%>
	<a href=adminmenu.html target=_self>admin</a>
	<%
	}

	} catch (SQLException ex2) {
	out.println("Error! ");
	}
	%>

</body>
</html>