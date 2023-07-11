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
	String user_username = request.getParameter("Uname");
	String user_password = request.getParameter("Pass");
	String db = "cs157a_team2";
    String my_sql_server_username = "root";
    String my_sql_server_password = "LTAndr3w";
    try {
        
        java.sql.Connection con; 
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a_team2?autoReconnect=true&useSSL=false",my_sql_server_username, my_sql_server_password);
        Statement stmt = con.createStatement();
        String Query = "SELECT COUNT(*) from Listener where BINARY username = '" + user_username + "' and BINARY password = '" + user_password + "'";
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