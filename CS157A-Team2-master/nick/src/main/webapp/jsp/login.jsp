<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	String Username = request.getParameter("Uname");
	String Password = request.getParameter("Pass");
	String db = "cs157a_team2";
    String user;
    user = "root";
    String password = "Shroot123@";
    try {
        
        java.sql.Connection con; 
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a_team2?autoReconnect=true&useSSL=false",user, password);
        Statement stmt = con.createStatement();
        String Query = "SELECT COUNT(*) from user where BINARY Username = '" + Username + "' and BINARY user_password = '" + Password + "'";
        ResultSet rs = stmt.executeQuery(Query);
        int count = 0;
        if (rs.next()) {
            count = rs.getInt(1); // Retrieve the value of the first column
        }
        rs.close();
        stmt.close();
        con.close();
        if (count > 0) {
            out.println("Username and password matched.");
        } else {
            out.println("Username and password do not match.");
        }
    } catch(SQLException e) { 
    	out.println("failed");
        out.println("SQLException caught: " + e.getMessage()); 
    }
%>


	


%>
</body>
</html>