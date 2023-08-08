<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/cs157a_team2/css/adminlogin.css" />
</head>
<body>
    <h2>Shuffle Buddy</h2><br>
    <div class="login">
        <form id="login" action="../auth_server" method="GET" >
            <label for="Uname" name="admincheck" class="form-label">Admin Name</label>
            <input type="text" name="Uname" id="Uname" class="input-uname-password" placeholder="Admin name">
            <label for="Pass" class="form-label">Password</label>
            <input type="password" name="Pass" id="Pass" class="input-uname-password" placeholder="Password">
            <button type="submit" name="log" id="log">Sign In</button>
            <input type="hidden" value="admincheck" name="admincheck" />
            <% String errorMessage = (String) session.getAttribute("errormess");
	        if (errorMessage != null) { %>
	          <p><%= errorMessage %></p>
              
	        <% } %>
            <br><br>
        </form>
    </div>
</body>
</html>
