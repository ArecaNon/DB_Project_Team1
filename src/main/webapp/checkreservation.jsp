<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="java.text.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHECK RESERVATION</title>
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
	<h4>------ 가게 예약 목록 --------</h4>
	<%
	int check_s = 0;
	int check_p = 0;
	try {
		int rno = 0;
		query = "SELECT rno as 예약번호, rdate as 예약날짜, nop as 인원, sno as 가게 " + "FROM store_reservation WHERE rrn = " + "'" + request.getParameter("rrn2")
		+ "'";

		rs = stmt.executeQuery(query);

		out.println("<table border=\"1\">");
		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();

		while (rs.next()) {
			if (check_s == 0)
		for (int i = 1; i <= cnt; i++) {
			out.println("<th>" + rsmd.getColumnName(i) + "</th>");
		}
			check_s = 1;

			out.println("<tr>");
			rno = rs.getInt(1);
			out.println("<td>" + rno + "</td>");
			out.println("<td>" + rs.getString(2) + "</td>");
			out.println("<td>" + rs.getInt(3) + "</td>");
			out.println("<td>" + rs.getInt(4) + "</td>");
			out.println("</tr>");
		}
		out.println("</table>");

		if (check_s == 0)
			out.println("No Store reservation");

		// print reservation seat info
		else {
	%>
	<h4></h4>
	<h4>------ 가게 테이블 목록 --------</h4>
	<%
	out.println("<table border=\"1\">");

	query = "SELECT Tno as 테이블_번호 " + "FROM SEAT_INFO " + "WHERE Rno = " + rno;
	rs = stmt.executeQuery(query);

	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	for (int i = 1; i <= cnt; i++) {
		out.println("<th>" + rsmd.getColumnName(i) + "</th>");
	}
	while (rs.next()) {
		out.println("<tr>");
		out.println("<td>" + rs.getInt(1) + "</td>");
		out.println("</tr>");
	}
	out.println("</table>");

	}
	%>
	<h4></h4>
	<h4>------ 주차장 예약 목록 --------</h4>
	<%
	query = "SELECT rno as 예약번호 , prdate as 예약날짜 " + "FROM parking_reservation WHERE rrn = " + "'" + request.getParameter("rrn2") + "'";

	rs = stmt.executeQuery(query);

	out.println("<table border=\"1\">");
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();

	while (rs.next()) {

		if (check_p == 0)
			for (int i = 1; i <= cnt; i++)
		out.println("<th>" + rsmd.getColumnName(i) + "</th>");
		check_p = 1;
		out.println("<tr>");
		rno = rs.getInt(1);
		out.println("<td>" + rno + "</td>");
		out.println("<td>" + rs.getString(2) + "</td>");

		out.println("</tr>");
	}
	out.println("</table>");

	if (check_p == 0) {
		out.println("No Parking lot reservation");

	} else {// print parking location
	%>
	<h4></h4>
	<h4>------ 예약된 주차 장소 --------</h4>
	<%
	out.println("<table border=\"1\">");

	query = "SELECT PFloor as 층, Location as 위치, Pno as 주차장소_번호 " + "FROM PARKING_LOT " + "WHERE Rno = " + rno;
	rs = stmt.executeQuery(query);

	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	for (int i = 1; i <= cnt; i++) {
		out.println("<th>" + rsmd.getColumnName(i) + "</th>");
	}
	while (rs.next()) {
		out.println("<tr>");
		out.println("<td>" + rs.getString(1) + "</td>");
		out.println("<td>" + rs.getString(2) + "</td>");
		out.println("<td>" + rs.getInt(3) + "</td>");
		out.println("</tr>");
	}
	out.println("</table>");

	}

	} catch (SQLException ex2) {
	out.println("Error!");
	}
	%>
	<h4></h4>

	<a href=cancelreservation.html target=_self>예약 취소</a>
	<a href=menu.html target=_self>메인 메뉴</a>



</body>
</html>