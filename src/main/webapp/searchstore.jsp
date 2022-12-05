<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="java.text.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	<h2>가게 정보</h2>
	<%
	
	try {
		int check = 0;
	query = "SELECT store_location , opening_hours, closing_hours, max_tc " + "FROM store WHERE store_id = " + "'"
			+ request.getParameter("searchstore") + "'";

	rs = stmt.executeQuery(query);

	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();

	while (rs.next()) {
		
		if(check ==0)
		
			for (int i = 1; i <= cnt; i++) {

				out.println("<th>" + rsmd.getColumnName(i) + "</th>");
			}
		check =1;
		out.println("<tr>");
		out.println("<td>" + rs.getString(1) + "</td>");
		out.println("<td>" + rs.getString(2) + "</td>");
		out.println("<td>" + rs.getString(3) + "</td>");
		out.println("<td>" + rs.getString(4) + "</td>");
		out.println("</tr>");
	}
	out.println("</table>");
	
	if(check ==0)
	{
		out.println("없는 가게 입니다!");
	}
	
	} catch (SQLException ex2) {
		out.println("Error!");
		}
	%>
<h4></h4>
	<a href=reservation.html target=_self>예약 하기</a>

	<a href=menu.html target=_self>메인 메뉴</a>


</body>
</html>