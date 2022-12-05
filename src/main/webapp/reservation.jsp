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
	String sql = "";
	%>
	<h4>------ Reservation --------</h4>
	<%
	int return_check = 0;
	String Car_Number = null;
	String Car_Model = null;
	String Disabled_vehicle = null;
	String full_state = "Y";
	String date;
	Integer nop;
	Integer storeid;
	String parking;
	String rrn;

	date = request.getParameter("redate");
	nop = Integer.parseInt(request.getParameter("pernum"));
	storeid = Integer.parseInt(request.getParameter("restore"));
	parking = request.getParameter("repark");
	rrn = request.getParameter("rrn1");
	try {
		while (return_check == 0) {
			sql = "SELECT Rno " + "FROM STORE_RESERVATION WHERE RRN = " + rrn;
			rs = stmt.executeQuery(sql);
			Integer check = 0;
			if (rs.next()) {
		check = rs.getInt(1);
		if (check != 0) {
			out.println("You already reserve!");
			%><h4></h4><%
			return_check = 2;
			break;
		}
			}

			if (parking.equals("Y")) {
		sql = "SELECT * " + "FROM CAR WHERE CRRN = " + rrn;
		rs = stmt.executeQuery(sql);
		String check1 = null;
		if (rs.next() == false) {
			if (check1 == null) {
				out.println("You don't reserve your car!");
				%><h4></h4><%
				out.println("You must reserve your car first!");
				%><h4></h4><%
				return_check = 2;
				break;
			}
		} else {
			Car_Number = rs.getString(1);
			Car_Model = rs.getString(2);
			Disabled_vehicle = rs.getString(3);
			check1 = rs.getString(4);
		}
			}

			Integer Pno = null;
			if (parking.equals("Y")) {// 주차장 이용 원할시

		if (Disabled_vehicle.equals("N")) {// 장애인전용 자리 이용 불가 차량
			sql = "SELECT Pno " + "FROM PARKING_LOT  " + "WHERE UseAble = 'Y' " + "and Disable_Vehicle_Area = 'N' ";
			rs = stmt.executeQuery(sql);
			if (rs.next())
				Pno = rs.getInt(1);
		}

		if (Disabled_vehicle.equals("Y")) {// 장애인전용 자리 이용 가능 차량
			sql = "SELECT Pno " + "FROM PARKING_LOT  " + "WHERE UseAble = 'Y' " + "and Disable_Vehicle_Area = 'Y' ";
			rs = stmt.executeQuery(sql);

			if (rs.next())
				Pno = rs.getInt(1);
			else {// 장애인전용 자리가 다 사용중일 경우 일반 자리 이용
				sql = "SELECT Pno " + "FROM PARKING_LOT  " + "WHERE UseAble = 'Y' ";
				rs = stmt.executeQuery(sql);

				if (rs.next())
					Pno = rs.getInt(1);
			}
		}

		if (Pno == null) {// 주차장 자리없는 경우 가게예약만이라도 할지 물어봄
			out.print("Parking lot is full statement ");
			%><h4></h4><%
			return_check = 2;
			break;
		}
			}

			// 예약을 원하는 가게에 자리가 있는지
			int need_table_count;
			if (nop % 4 == 0)
		need_table_count = nop / 4;
			else
		need_table_count = nop / 4 + 1;

			sql = "SELECT Tno " + "FROM SEAT_INFO WHERE Enable_Reservation = 'Y' AND SID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, storeid);
			rs = pstmt.executeQuery();

			int[] table_no_array = new int[10];
			for (int i = 0; i < need_table_count; i++) {
		if (rs.next())
			table_no_array[i] = rs.getInt(1);
		else {
			out.println("필요한 테이블수가 부족합니다. 죄송합니다. ");
			%><h4></h4><%
			return_check = 2;
			break;
		}
			}
			// 예약번호 확인
			sql = "SELECT Rno " + "FROM STORE_RESERVATION  ";
			rs = stmt.executeQuery(sql);
			int size = 0;
			while (rs.next())
				size++;
			int rno = size + 1;

			// 예약정보 삽입
			sql = "INSERT INTO STORE_RESERVATION (Rno,RDate,NoP,Sno,RRN) VALUES(?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rno);
			pstmt.setDate(2, java.sql.Date.valueOf(date));
			pstmt.setInt(3, nop);
			pstmt.setInt(4, storeid);
			pstmt.setString(5, rrn);

			pstmt.executeUpdate();
			out.println("Your store reservation no is '" + rno + "'");
			%><h4></h4><%
			// 예약정보에 따른 자리 업데이트
			sql = "UPDATE SEAT_INFO SET Enable_Reservation = ? , Rno =?  WHERE Tno = ? and sid = " + storeid;
			pstmt = conn.prepareStatement(sql);

			for (int i = 0; i < need_table_count; i++) {

		pstmt.setString(1, "N");
		pstmt.setInt(2, rno);
		pstmt.setInt(3, table_no_array[i]);
		pstmt.executeUpdate();
			}
			out.print("Your reservation seat no is ");
			for (int i = 0; i < need_table_count; i++) {
		out.print("'" + table_no_array[i] + "' ");
			}
			
			%><h4></h4><%
			if (Pno != null) {// 주차예약 정보 업데이트

		sql = "SELECT Rno FROM PARKING_RESERVATION  ";
		rs = stmt.executeQuery(sql);

		size = 0;
		while (rs.next())
			size++;

		int crno = size + 1;

		sql = "INSERT INTO PARKING_RESERVATION (Rno,Cno,PRDate,Pno,Vehicle_Useable,RRN) VALUES(?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, crno);
		pstmt.setString(2, Car_Number);
		pstmt.setDate(3, java.sql.Date.valueOf(date));
		pstmt.setInt(4, Pno);
		pstmt.setString(5, Disabled_vehicle);
		pstmt.setString(6, rrn);

		pstmt.executeUpdate();

		sql = "UPDATE PARKING_LOT SET UseAble = ? , Rno = ? WHERE Pno = ? ";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, "N");
		pstmt.setInt(2, crno);
		pstmt.setInt(3, Pno);

		pstmt.executeUpdate();

		out.println("You must park at '" + Pno + "'");

			}
			%><h4></h4><%
			out.println("reservation is complete!! Thank you!!^^");
			%><h4></h4><%
			return_check = 1;
			break;

		}
	} catch (SQLException e) {
		out.println("옮바르지 않습니다");
		%><h4></h4><%
		out.println("메뉴로 돌아갑니다");

	}
	%>
	<a href=menu.html target=_self>확인</a>


</body>
</html>