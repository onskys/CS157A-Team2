<%@ page import="java.util.Objects" %>
<%@ page import="java.util.Optional" %>
<!DOCTYPE html>
<html>
<head>
    <title>Password Reset</title>
    <link rel="stylesheet" type="text/css" href="../css/forgotpassword.css">
</head>
<body>
    <h2>Password Reset</h2>

    <form method="post" action="../reset_password_servlet">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" placeholder="Username" required><br><br>

        <input type="submit" value="Submit">
    </form>

    <hr>

    <%-- Check if securityQuestion exists in the request --%>
    <% if (request.getAttribute("securityQuestion") != null) { %>
        <form method="get" action="passwordupdate">
            <input type="hidden" name="username" value="<%= request.getAttribute("username") %>">

            <label for="securityAnswer">Security Question:</label>
            <p><%= request.getAttribute("securityQuestion") %></p>

            <label for="securityAnswer">Security Answer:</label>
            <input type="text" id="securityAnswer" name="securityAnswer" required><br><br>

            <label for="newPassword">New Password:</label>
            <input type="password" id="newPassword" name="newPassword" required><br><br>

            <input type="submit" value="Reset Password">
        </form>
    <% } %>

    <%-- Check if resetStatus exists in the request --%>
<% String resetStatus = request.getParameter("resetStatus"); %>
<% if (resetStatus != null) { %>
    <p><%= resetStatus %></p>
<% } %>
</body>
</html>
