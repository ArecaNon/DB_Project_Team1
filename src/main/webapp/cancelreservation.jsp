<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="java.text.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CANCEL RESERVATION</title>
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
	<h4>------ Cancel Reservation --------</h4>
	<%	
	String rrn = request.getParameter("rrn_cancel");

	try {// 등록된 가게예약 번호와 가게번호 찾아냄
		sql = "SELECT Rno, Sno " + "FROM STORE_RESERVATION " + "WHERE RRN = " + rrn;
		rs = stmt.executeQuery(sql);
		rs.next();
		Integer s_rno = rs.getInt(1);
		Integer sno = rs.getInt(2);
		// 가게예약번호로 예약되어있는 좌석 찾아서 빈자리로 수정
		sql = "SELECT Tno " + "FROM SEAT_INFO " + "WHERE Rno = " + s_rno;
		rs = stmt.executeQuery(sql);
		int[] tno = new int[10];
		int i = 0;
		while (rs.next()) {
			tno[i++] = rs.getInt(1);
		}

		sql = "UPDATE SEAT_INFO SET Enable_Reservation = 'Y', Rno = 0  WHERE SID = ? and  Tno = ? ";
		pstmt = conn.prepareStatement(sql);

		for (int j = 0; j < i; j++) {
			pstmt.setInt(1, sno);
			pstmt.setInt(2, tno[j]);
			pstmt.executeUpdate();
		}
		// 등록된 가게예약 번호로 정보 삭제
		sql = "DELETE FROM STORE_RESERVATION " + "WHERE Rno = " + s_rno;
		stmt.executeUpdate(sql);
		// 등록된 주차장예약 번호와 주차공간 번호 찾아냄
		sql = "SELECT Rno, Pno " + "FROM PARKING_RESERVATION " + "WHERE RRN = " + rrn;
		rs = stmt.executeQuery(sql);
		if(rs.next())
		{
		Integer p_rno = rs.getInt(1);
		Integer pno = rs.getInt(2);
		// 주차공간 번호로 빈공간으로 수정
		sql = "UPDATE PARKING_LOT SET UseAble = 'Y' , Rno = 0   WHERE Pno = ? ";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, pno);
		pstmt.executeUpdate();
		// 주차 예약 삭제
		sql = "DELETE FROM PARKING_RESERVATION " + "WHERE Rno = " + p_rno;
		stmt.executeUpdate(sql);

		out.println("Your reservation is all deteled ");
		}
	} catch (SQLException ex2) {
		//System.err.println("sql error = " + ex2.getMessage());
		//ex2.printStackTrace();
		out.println("Error");

	}	
	%>	
	
	<a href=menu.html target=_self>확인</a>



</body>
</html>