<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="java.text.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHECK CAR</title>
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
		int check = 0;
		out.println("<table border=\"1\">");

		query = "SELECT * FROM CAR WHERE CRRN = ?";

		pstmt = conn.prepareStatement(query);
		String rrn = request.getParameter("rrn");

		pstmt.setString(1, rrn);
		rs = pstmt.executeQuery();

		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();

		while (rs.next()) {

			if (check == 0) 

		for (int i = 1; i <= cnt; i++) {

			out.println("<th>" + rsmd.getColumnName(i) + "</th>");
		}
			
			check = 1;
			out.println("<tr>");
			out.println("<td>" + rs.getString(1) + "</td>");
			out.println("<td>" + rs.getString(2) + "</td>");
			out.println("<td>" + rs.getString(3) + "</td>");
			out.println("<td>" + rs.getString(4) + "</td>");
			out.println("</tr>");

		}
		out.println("</table>");
		if (check == 0) {
			out.println("등록된 차량이 없습니다!");
		}

	} catch (SQLException ex2) {
		out.println("Error!");
	}
	%>
<h4></h4>>
	<a href=menu.html target=_self>확인</a>



</body>
</html>