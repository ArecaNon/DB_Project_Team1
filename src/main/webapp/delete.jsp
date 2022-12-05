<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="java.text.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DELETE</title>
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
	String sql = "";
	%>
	<h4>------ Delete --------</h4>
	<%
	String table_name = request.getParameter("table_name");

	try {

		if (table_name.equals("CUSTOMER")) {
			String input = request.getParameter("input1");

			sql = "DELETE FROM CUSTOMER " + "WHERE RRN = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, input);
			pstmt.executeUpdate();
			out.println("succes delete data in CUSTOMER!");

		} else if (table_name.equals("CAR")) {
			String input = request.getParameter("input1");

			sql = "DELETE FROM CAR " + "WHERE CAR_NUMBER = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, input);
			pstmt.executeUpdate();
			out.println("succes delete data in CAR!");

		} else if (table_name.equals("DEPARTMENT")) {
			String input = request.getParameter("input1");

			sql = "DELETE FROM DEPARTMENT " + "WHERE Dnumber = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, input);
			pstmt.executeUpdate();
			out.println("succes delete data in DEPARTMENT!");
			
		} else if (table_name.equals("STORE")) {
			String input = request.getParameter("input1");

			sql = "DELETE FROM STORE " + "WHERE STORE_ID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, input);
			pstmt.executeUpdate();
			out.println("succes delete data in STORE!");

		} else if (table_name.equals("EMPLOYEE")) {
			String input = request.getParameter("input1");

			sql = "DELETE FROM EMPLOYEE " + "WHERE EID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, input);
			pstmt.executeUpdate();
			out.println("succes delete data in STORE!");

		} else if (table_name.equals("PARKING_LOT")) {
			String input1 = request.getParameter("input1");
			String input2 = request.getParameter("input2");

			sql = "DELETE FROM PARKING_LOT " + "WHERE Pno = ? and PDate = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(input1));
			pstmt.setDate(2, java.sql.Date.valueOf(input2));
			pstmt.executeUpdate();
			out.println("succes delete data in PARKING_LOT!");

		} else if (table_name.equals("STORE_RESERVATION")) {
			String input = request.getParameter("input1");

			sql = "DELETE FROM STORE_RESERVATION " + "WHERE Rno = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(input));
			pstmt.executeUpdate();
			out.println("succes delete data in STORE_RESERVATION!");

		} else if (table_name.equals("PARKING_RESERVATION")) {
			String input = request.getParameter("input1");
;
			sql = "DELETE FROM PARKING_RESERVATION " + "WHERE Rno = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(input));
			pstmt.executeUpdate();
			out.println("succes delete data in STORE_RESERVATION!");

		} else if (table_name.equals("DISCOUNT")) {
			String input1 = request.getParameter("input1");
			String input2 = request.getParameter("input2");
		
			sql = "DELETE FROM DISCOUNT " + "WHERE SID = ? and DCName = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(input1));
			pstmt.setString(2, input2);
			pstmt.executeUpdate();
			out.println("succes delete data in DISCOUNT!");

		} else if (table_name.equals("SEAT_INFO")) {
			String input1 = request.getParameter("input1");
			String input2 = request.getParameter("input2");
			
			sql = "DELETE FROM SEAT_INFO " + "WHERE SID = ? and Tno = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(input1));
			pstmt.setInt(2, Integer.parseInt(input2));
			pstmt.executeUpdate();
			out.println("succes delete data in SEAT_INFO!");

		}

	} catch (SQLException ex2) {
		out.println("Error!");
	}	
	
	%>
	
		<a href=adminmenu.html target=_self>확인</a>
	
	
</body>
</html>