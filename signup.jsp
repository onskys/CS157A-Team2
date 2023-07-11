<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sign Up</title>
<link rel="stylesheet" type="text/css" href="signup.css">
</head>
<body>
<body>
    <h2>Sign Up</h2>
    <form id="signup-form" action="signup-process.jsp" method="POST">
        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
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
            <select id="security-question" name="securityquestion" required>
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
                        ResultSet rs = stmt.executeQuery("SELECT question_text FROM security_question");
                        
                        while (rs.next()) {
                            %>
                            	<option> <%=rs.getString("question_text")%> </option>
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
</body>
</html>