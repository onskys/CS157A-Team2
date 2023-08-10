<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<%@ page import="userlogin.databaseconnection"%>
<html>
<head>
<title>Shuffle Buddy - Music Web App</title>
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
	<h1>Shuffle Buddy</h1>
	<p>Welcome, ${sessionScope.username}!</p>
	<form id="playlist-form" action="../specific_playlist_server" method="get" autocomplete="off">
		<label for="playlist-question">Choose a Playlist to Listen or Edit:</label> 
		<select id="playlist-question" name="playlist-question" onchange="toggleButton()" required>
			<option>Select a Playlist</option>
			<%
			try {
				Connection con = databaseconnection.getConnection();
				Statement stmt = con.createStatement();
				//ResultSet rs = stmt.executeQuery("SELECT playlist_id, name FROM playlist");
					
				PreparedStatement ps = con.prepareStatement("SELECT p.playlist_id, p.name FROM playlist p, created c WHERE p.playlist_id = c.playlist_id AND c.username =?");
				//HttpSession session = request.getSession();
				String username = (String) session.getAttribute("username");
				ps.setString(1, username); 
				ResultSet rs=ps.executeQuery();
					
				while (rs.next()) {
					String playlistID = rs.getString("playlist_id");
					String playlistName = rs.getString("name");
					%>
					<option value="<%=playlistID%>"> <%=playlistName%> </option>
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
		<button id="selectButton" type="submit" disabled>Select Playlist</button>
	</form>

	<div class="button-container">
		<a href="#" class="button" onclick="createPlaylist()">Create New Playlist</a>
		<a href="#" class="button" onclick="deletePlaylist()">Delete A Playlist</a>	
		<a href="#" class="button" onclick="signOut()">Sign Out</a>		

	</div>

	<script>
		
	    function toggleButton() {
	        var playlistQuestion = document.getElementById("playlist-question");
	        var selectButton = document.getElementById("selectButton");
	        /* var newPlaylistButton = document.getElementById("newPlaylistButton"); */
			//console.log("playlistSelect.value: " + playlistQuestion.value)
			//console.log("playlistSelect.value === \"default\": " + playlistQuestion.value === "default")
	        selectButton.disabled = playlistQuestion.value === "default";
	        /* newPlaylistButton.disabled = playlistSelect.value !== "default"; */
	    }
	
	
		function createPlaylist() {
			window.location.href='../jsp/new_playlist.jsp'
		}
		
		function deletePlaylist() {
			window.location.href='../jsp/delete_playlist.jsp'
		}
		
		function signOut() {
			window.location.href='../jsp/index.jsp'
		}
	</script>
</body>
</html>
