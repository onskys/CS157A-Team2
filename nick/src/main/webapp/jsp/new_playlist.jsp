<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="userlogin.databaseconnection"%>

<html>
<head>
<title>New Playlist</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 20px;
	background-color: #f2f2f2;
	display: flex;
	align-items: center;
	justify-content: center;
	min-height: 100vh;
	flex-direction: column;
}

h1 {
	text-align: center;
}

.button-container {
	text-align: center;
}

.button {
	display: inline-block;
	padding: 10px 20px;
	background-color: #4CAF50;
	color: white;
	text-decoration: none;
	border-radius: 4px;
	cursor: pointer;
	margin: 10px;
}

.button:hover {
	background-color: #45a049;
}
</style>
</head>

<body>
	<h1>New Playlist</h1>
	<p>Enter a name for your new playlist.</p>
    <form id="name-form" action="../add_playlist" method="POST">
		<div class="form-group">
		     <input type="hidden" value=${sessionScope.username} name="username" />
           	 <label for="playlist-name">Playlist Name:</label>
			 <input id="playlist-name" name="playlist-name">
             <button type="make-playlist">MAKE PLAYLIST</button>        	
        </div>
        <% String successMessage = (String) request.getAttribute("successMessage");
    		if (successMessage != null && !successMessage.isEmpty()) { %>
        	<div class="success-message">
            	<%= successMessage %>
        	</div>
    	<% } %>
    </form>
</body>
</html>
