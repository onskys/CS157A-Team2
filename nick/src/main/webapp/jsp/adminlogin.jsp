<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/adminlogin.css" />
</head>
<body>
    <h2>Shuffle Buddy</h2><br>
    <div class="login">
        <form id="login" action="auth_server" method="GET" >
            <label for="Uname" class="form-label">Admin Name</label>
            <input type="text" name="Uname" id="Uname" class="input-uname-password" placeholder="Admin name">
            <label for="Pass" class="form-label">Password</label>
            <input type="password" name="Pass" id="Pass" class="input-uname-password" placeholder="Password">
            <button type="submit" name="log" id="log">Sign In</button>
            <% String errorMessage = (String) request.getAttribute("errorMessage");
	        if (errorMessage != null) { %>
	          <p><%= errorMessage %></p>
	        <% } %>
            <br><br>
        </form>
    </div>

    
    
</body>
</html>