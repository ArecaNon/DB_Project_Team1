<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="java.text.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert</title>
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
	<h4>------ Insert --------</h4>
	<%

	String table_name = request.getParameter("table_name");

	try {
		if (table_name.equals("CUSTOMER")) {
			String input1 = request.getParameter("input1");
			String input2 = request.getParameter("input2");
			String input3 = request.getParameter("input3");
			String input4 = request.getParameter("input4");
		
			sql = "INSERT INTO CUSTOMER (RRN,Sex,Birth,Name) VALUES(?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, input1);
			pstmt.setString(2, input2);
			pstmt.setDate(3, java.sql.Date.valueOf(input3));
			pstmt.setString(4, input4);
			pstmt.executeUpdate();
			out.println("Succes insert data in CUSTOMER!");
		}
		
		else if (table_name.equals("CAR")) {
			
			String input1 = request.getParameter("input1");
			String input2 = request.getParameter("input2");
			String input3 = request.getParameter("input3");
			String input4 = request.getParameter("input4");
			
			sql = "INSERT INTO CAR (Car_Number,Car_Model, Disabled_vehicle, CRRN) VALUES(?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, input1);
			pstmt.setString(2, input2);
			pstmt.setString(3, input3);
			pstmt.setString(4, input4);
			pstmt.executeUpdate();
			out.println("Succes insert data in CAR!");
		}
		else if (table_name.equals("DEPARTMENT")) {
			String input1 = request.getParameter("input1");
			String input2 = request.getParameter("input2");
			
			sql = "INSERT INTO DEPENDENT (Dnumber, Dname) VALUES(?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, input1);
			pstmt.setString(2, input2);
			pstmt.executeUpdate();
			out.println("Succes insert data in DEPARTMENT!");

		}
		 else if (table_name.equals("STORE")) {
				String input1 = request.getParameter("input1");
				String input2 = request.getParameter("input2");
				String input3 = request.getParameter("input3");
				String input4 = request.getParameter("input4");
				String input5 = request.getParameter("input5");
				String input6 = request.getParameter("input6");
				
				sql = "INSERT INTO STORE (STORE_ID,Store_Location, Opening_Hours, Closing_Hours, MAX_TC, Dno) VALUES(?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(input1));
				pstmt.setString(2, input2);
				pstmt.setString(3, input3);
				pstmt.setString(4, input4);
				pstmt.setInt(5, Integer.parseInt(input5));
				pstmt.setInt(6, Integer.parseInt(input6));
				pstmt.executeUpdate();
				out.println("Succes insert data in STORE!");

			}
		 else if (table_name.equals("EMPLOYEE")) {

			 String input1 = request.getParameter("input1");
				String input2 = request.getParameter("input2");
				String input3 = request.getParameter("input3");
				String input4 = request.getParameter("input4");
				String input5 = request.getParameter("input5");
				String input6 = request.getParameter("input6");
				
				sql = "INSERT INTO EMPLOYEE (EID, Sex, Name, Birth, Dno, Sid) VALUES(?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(input1));
				pstmt.setString(2, input2);
				pstmt.setString(3, input3);
				pstmt.setDate(4, java.sql.Date.valueOf(input4));
				pstmt.setInt(5, Integer.parseInt(input5));
				pstmt.setInt(6, Integer.parseInt(input6));
				pstmt.executeUpdate();
				out.println("Succes insert data in EMPLOYEE!");

			} else if (table_name.equals("PARKING_LOT")) {

				String input1 = request.getParameter("input1");
				String input2 = request.getParameter("input2");
				String input3 = request.getParameter("input3");
				String input4 = request.getParameter("input4");
				String input5 = request.getParameter("input5");
				String input6 = request.getParameter("input6");
				String input7 = request.getParameter("input7");
				String input8 = request.getParameter("input8");


				sql = "INSERT INTO PARKING_LOT (PFloor, Location, Pno, UseAble, Disable_Vehicle_Area, PDate, Dno, Rno) VALUES(?,?,?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, input1);
				pstmt.setString(2, input2);
				pstmt.setInt(1, Integer.parseInt(input3));
				pstmt.setString(4, input4);
				pstmt.setString(5, input5);
				pstmt.setDate(6, java.sql.Date.valueOf(input6));
				pstmt.setInt(7, Integer.parseInt(input7));
				pstmt.setInt(8, Integer.parseInt(input8));

				pstmt.executeUpdate();
				out.println("Succes insert data in PARKING_LOT!");

			} else if (table_name.equals("STORE_RESERVATION")) {
				String input1 = request.getParameter("input1");
				String input2 = request.getParameter("input2");
				String input3 = request.getParameter("input3");
				String input4 = request.getParameter("input4");
				String input5 = request.getParameter("input5");

				
				sql = "INSERT INTO STORE_RESERVATION (Rno, RDate, NoP, Sno, RRN) VALUES(?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(input1));
				pstmt.setDate(2, java.sql.Date.valueOf(input2));
				pstmt.setInt(3, Integer.parseInt(input3));
				pstmt.setInt(4, Integer.parseInt(input4));
				pstmt.setString(5, input5);

				pstmt.executeUpdate();
				out.println("Succes insert data in STORE_RESERVATION!");

			} else if (table_name.equals("PARKING_RESERVATION")) {
				String input1 = request.getParameter("input1");
				String input2 = request.getParameter("input2");
				String input3 = request.getParameter("input3");
				String input4 = request.getParameter("input4");
				String input5 = request.getParameter("input5");
				String input6 = request.getParameter("input6");
				
				sql = "INSERT INTO PARKING_RESERVATION (Rno, Cno, PRDate, Pno, Vehicle_Useable, RRN) VALUES(?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(input1));
				pstmt.setString(2, input2);
				pstmt.setDate(3, java.sql.Date.valueOf(input3));
				pstmt.setInt(4, Integer.parseInt(input4));
				pstmt.setString(5, input5);
				pstmt.setString(6, input6);
				pstmt.executeUpdate();
				out.println("Succes insert data in PARKING_RESERVATION!");

			} else if (table_name.equals("DISCOUNT")) {
				String input1 = request.getParameter("input1");
				String input2 = request.getParameter("input2");
				String input3 = request.getParameter("input3");
				String input4 = request.getParameter("input4");
				
				sql = "INSERT INTO DISCOUNT (SID, DCName, How, DCPercent ) VALUES(?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(input1));
				pstmt.setString(2, input2);
				pstmt.setString(3, input3);
				pstmt.setInt(4, Integer.parseInt(input4));
				pstmt.executeUpdate();
				out.println("Succes insert data in DISCOUNT!");

			} else if (table_name.equals("SEAT_INFO")) {
				String input1 = request.getParameter("input1");
				String input2 = request.getParameter("input2");
				String input3 = request.getParameter("input3");
				String input4 = request.getParameter("input4");
				
				sql = "INSERT INTO SEAT_INFO (SID, Tno, Maxnum, Enable_Reservation ) VALUES(?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(input1));
				pstmt.setInt(2, Integer.parseInt(input2));
				pstmt.setInt(3, Integer.parseInt(input3));
				pstmt.setString(4, input4);
				pstmt.executeUpdate();
				out.println("Succes insert data in SEAT_INFO!");

			} 				
		
	}
	catch (SQLException ex2) {
		// System.err.println("sql error = " + ex2.getMessage());
		out.println("Error!!");
	}	
	
	%>
	<a href=adminmenu.html target=_self>확인</a>

</body>
</html>