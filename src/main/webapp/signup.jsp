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
	<h4>------ 회원가입 --------</h4>

	<%
	try {
		sql = "INSERT INTO CUSTOMER (RRN,Sex,Birth,Name) VALUES(?,?,?,?)";

		pstmt = conn.prepareStatement(sql);

		String sex = request.getParameter("signsex");
		String rrn = request.getParameter("signrrn");
		String birth = request.getParameter("signbirth");
		String name = request.getParameter("signname");

		pstmt.setString(1, rrn);
		pstmt.setString(2, sex);
		pstmt.setString(3, birth);
		pstmt.setString(4, name);
		pstmt.executeUpdate();

		String car_use = request.getParameter("havecar");
		if (car_use == null)
			car_use = "N";
		
		if (car_use.equals("Y")) {
			sql = "INSERT INTO CAR (Car_Number,Car_Model,Disabled_vehicle,CRRN) VALUES(?,?,?,?)";
			pstmt = conn.prepareStatement(sql);

			String Car_Number = request.getParameter("signcarnumber");
			String Car_Model = request.getParameter("signcarmodel");
			String Disabled_vehicle = request.getParameter("signdisable");
			String CRRN = request.getParameter("signrrn");

			pstmt.setString(1, Car_Number);
			pstmt.setString(2, Car_Model);
			pstmt.setString(3, Disabled_vehicle);
			pstmt.setString(4, CRRN);
			pstmt.executeUpdate();
		}

		out.println("환영합니다.고객님 ");

	} catch (SQLException  ex2) {
		out.println("Error! ");
	}
	%>
	<a href=start.html target=_self>확인</a>


</body>
</html>