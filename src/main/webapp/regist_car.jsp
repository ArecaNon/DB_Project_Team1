<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="java.text.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADCAR</title>
</head>
<body>
	<% 
request.setCharacterEncoding("utf-8");
String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "teamproject";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	Connection conn = null;	
	PreparedStatement pstmt;
	Statement stmt = null;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url,user,pass);
	stmt = conn.createStatement();
	String sql = "";
%>
	<h4>------ 차량 등록 --------</h4>

	<%

String Car_Number =request.getParameter("signcarnumber");
String Car_Model =request.getParameter("signcarmodel");
String Disabled_vehicle =request.getParameter("signdisable");
String CRRN =request.getParameter("signrrn");

try {
	int check1=0;
while(check1 ==0)
{
	// 이미 등록한 차가 있다면 경고후 return
	sql = "SELECT CRRN " + "FROM CAR WHERE CRRN = " + CRRN;
	rs = stmt.executeQuery(sql);
	String check = null;
	if (rs.next()) {
		check = rs.getString(1);
		if (check != null) {
			out.println("You already reserve your car!");
			break;
		}
	}

		sql = "INSERT INTO CAR (Car_Number,Car_Model,Disabled_vehicle,CRRN) VALUES(?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, Car_Number);
		pstmt.setString(2, Car_Model);
		pstmt.setString(3, Disabled_vehicle);
		pstmt.setString(4, CRRN);
		pstmt.executeUpdate();

	out.println("등록이 완료되었습니다.고객님 ");
	check1=1;
}
	
} catch (SQLException ex2) {
	System.err.println("Error! ");	
}
	
%>
<h4></h4>
	<a href=reservation.html target=_self>예약 하기</a>
	<a href=menu.html target=_self>메인 메뉴</a>

</body>
</html>
