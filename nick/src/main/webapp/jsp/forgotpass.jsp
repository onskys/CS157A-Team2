<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
    <title>Password Reset</title>
    <link rel="stylesheet" type="text/css" href="../css/forgotpassword.css">
</head>
<body>
    <h2>Password Reset</h2>

    <form id = "container2" method="post" action="/cs157a_team2/reset_password_servlet">
        
        <input type="text" id="username" name="username" placeholder="Username" required>

        <input type="submit" value="Submit">
    </form>

    <hr>

    <%-- Check if securityQuestion exists in the request --%>
    <% if (request.getParameter("securityQuestion") != null) { %>
        <form id="container" method="get" action="/cs157a_team2/passwordupdate">
            <input type="hidden" name="username1" value="<%= request.getParameter("username") %>">
			<div class = "securityQ" >
            <label for="securityAnswer">Security Question:</label>
            <p class="security-question"><%= request.getParameter("securityQuestion") %></p>
			</div>
            <label for="securityAnswer">Security Answer:</label>
            <input type="text" id="securityAnswer" name="securityAnswer" required>

            <label for="newPassword">New Password:</label>
            <input type="password" id="newPassword" name="newPassword" required>

            <input type="submit" value="Reset Password">
        </form>
    <% } %>

    <%-- Check if resetStatus exists in the request --%>
    <%	System.out.println(request.getParameter("securityQuestion"));
    	System.out.println("here");
        String resetStatus = request.getParameter("resetStatus");
        if (resetStatus != null && !resetStatus.isEmpty()) {
    %>
        <p><%= resetStatus %></p>
    <%
        }
    %>
</body>
</html>
