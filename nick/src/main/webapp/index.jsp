<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="index.css" />
</head>
<body>
<h2>Shuffle Buddy</h2><br>
    <div class="login">
	    <form id="login" method="post" action="login.jsp">
	        <label for="Uname" class="form-label">User Name</label>
	        <input type="text" name="Uname" id="Uname" class="input-uname-password" placeholder="Username">
	        <label for="Pass" class="form-label">Password</label>
	        <input type="password" name="Pass" id="Pass" class="input-uname-password" placeholder="Password">
	        <button type="submit" name="log" id="log">Sign In</button>
	        <div class="forgot-signup">
		        <button type="button" name="pass" class="Pass">Forgot Password</button>
		        <button type="button" name="signup" class="Pass" onclick="window.location.href='signup.jsp'">Sign Up</button>
	        </div>
	        <br><br>
	    </form>
	</div>
</body>
</html>