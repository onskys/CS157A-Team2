<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Insert title here</title>
    <link rel="stylesheet" type="text/css" href="css/index.css" />
</head>
<body>
    <h2>Shuffle Buddy</h2><br>
    <div class="login">
        <form id="login" action="auth_server" method="GET" >
        	<%-- Taking user information for username and password. --%>
            <label for="Uname" class="form-label">User Name</label>
            <input type="text" name="Uname" id="Uname" class="input-uname-password" placeholder="Username">
            <label for="Pass" class="form-label">Password</label>
            <input type="password" name="Pass" id="Pass" class="input-uname-password" placeholder="Password">
            <button type="submit" name="log" id="log">Sign In</button>
            
			<% String username = request.getParameter("Uname");
        	if (username != null && !username.isEmpty()) {
            	session.setAttribute("username", username);
        	} %>
            <% String errorMessage = (String) request.getAttribute("errorMessage");
	        if (errorMessage != null) { %>
	          <p><%= errorMessage %></p>
	        <% } %>
            <div class="forgot-signup">
                <button type="button" name="pass" class="Pass" onclick="window.location.href='jsp/forgotpass.jsp'">Forgot Password</button>
                <button type="button" name="signup" class="Pass" onclick="window.location.href='jsp/signup.jsp'">Sign Up</button>
                 <button type="button" name="admin" class="Pass" onclick="window.location.href='jsp/adminlogin.jsp'">Admin Login</button>
            </div>
            <% String successMessage = (String) request.getAttribute("successMessage");
    		if (successMessage != null && !successMessage.isEmpty()) { %>
        	<div class="success-message">
            	<%= successMessage %>
        	</div>
    <% } %>
            <br><br>
        </form>
    </div>

    
    
</body>
</html>
