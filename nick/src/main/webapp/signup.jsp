<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sign Up</title>
<link rel="stylesheet" type="text/css" href="signup.css">
</head>
<body>
    <h2>Sign Up</h2>
    <form id="signup-form" action="newuserdata" method="POST">
        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
            <% 
            String username = request.getParameter("username");
            if (username != null && !username.isEmpty()) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    String dbURL = "jdbc:mysql://localhost:3306/cs157a_team2?autoReconnect=true&useSSL=false";
                    String dbUser = "root";
                    String dbPassword = "Shroot123@";
                    Connection con = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM users WHERE username = '" + username + "'");
                    
                    if (rs.next()) {
                    	System.out.println("here");
                        // Username exists, display error message and allow the user to change it
                        %>
                        <span class="error">Username already exists. Please choose a different username.</span>
                        <%                        
                    }
                    
                    rs.close();
                    stmt.close();
                    con.close();
                } catch (SQLException | ClassNotFoundException e) {
                    e.printStackTrace();
                }
            }
            %>
        </div>
        <div class="form-group">
            <label for="firstname">First Name:</label>
            <input type="text" id="firstname" name="firstname" required>
        </div>
        <div class="form-group">
            <label for="lastname">Last Name:</label>
            <input type="text" id="lastname" name="lastname" required>
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <label for="security-question">Security Question:</label>
            <select id="security-question" name="security-question" required>
                <option> Select a security question</option>
                <% 
                    try {
                        java.sql.Connection con;
                        Class.forName("com.mysql.jdbc.Driver");
                        String dbURL = "jdbc:mysql://localhost:3306/cs157a_team2?autoReconnect=true&useSSL=false";
                        String dbUser = "root";
                        String dbPassword = "Shroot123@";
                        con = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT security_id, question_text FROM security_question");
                        
                        while (rs.next()) {
                            String securityId = rs.getString("security_id");
                            String questionText = rs.getString("question_text");
                            %>
                            <option value="<%=securityId%>"> <%=questionText%> </option>
                            <%                        
                        }
                        
                        rs.close();
                        stmt.close();
                        con.close();
                    } catch (SQLException | ClassNotFoundException e) {
                        e.printStackTrace();
                    }
                %>
            </select>
        </div>
        <div class="form-group">
            <label for="Security-answer">Security answer:</label>
            <input type=text id="Security-answer" name="Security-answer" required>
        </div>
        <button type="submit">Sign Up</button>
    </form>
</body>
</html>
