<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<%@ page import="userlogin.databaseconnection"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Security Question</title>
    <link rel="stylesheet" type="text/css" href="../css/securityQuestion.css">
</head>
<body>
    <h1>Existing Security Questions</h1>
    <button type='button' class="back-button" onclick="window.location.href='adminhome.jsp'"">Back</button>
    <form action="../SecurityQuestionServlet" method="post">
        
        <select id="user-list" name="user-list" multiple>
            <%
                try {
                    Connection con = databaseconnection.getConnection();
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT question_text from security_question");
                    while (rs.next()) {
                        String username = rs.getString("question_text");
            %>
                        <option value="<%=username%>"> <%=username%> </option>
            <%
                    }
                    rs.close();
                    stmt.close();
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </select>
        <input type="text" id="question-text" name = "question-text" placeholder="New Security Question" required>
        <input type="submit" id="delete-button" value="Add">
    </form>

</body>
</html>
