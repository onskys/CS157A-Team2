<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<%@ page import="userlogin.databaseconnection"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete User</title>
    <link rel="stylesheet" type="text/css" href="../css/deleteuser.css">
</head>
<body>
    <h1>Select Users to Delete</h1>
    <button type='button' class="back-button" onclick="window.location.href='adminhome.jsp'">Back</button>
    <form action="../DeleteUserServlet" method="post">
        <input type="text" id="search-box" placeholder="Search for users">
        <select id="user-list" name="user-list" multiple required>
            <%
                try {
                    Connection con = databaseconnection.getConnection();
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT username from user");
                    while (rs.next()) {
                        String username = rs.getString("username");
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
        <input type="submit" id="delete-button" value="Delete Selected Users">
    </form>

    <script>
        // JavaScript to filter options based on user input
        document.getElementById('search-box').addEventListener('input', function() {
            var searchValue = this.value.toLowerCase();
            var options = document.getElementById('user-list').options;

            for (var i = 0; i < options.length; i++) {
                var optionValue = options[i].textContent.toLowerCase();
                if (optionValue.includes(searchValue)) {
                    options[i].style.display = 'block';
                } else {
                    options[i].style.display = 'none';
                }
            }
        });
    </script>
</body>
</html>
