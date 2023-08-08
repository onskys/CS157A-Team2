<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
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
	align-items: center;
	
}

.button {
	display: inline-block;
	padding: 10px 20px;
	background-color: #4CAF50;
	color: white;
	text-decoration: none;
	margin-bottom: 15px;
	border-radius: 4px;
	align-items: center;
	cursor: pointer;
	margin: 10px;
}

button[type="start_listening"] {
  display: block;
  width: 100%;
  padding: 10px 20px;
  margin-bottom: 15px;
  background-color: #4caf50;
  color: white;
  border: none;
  border-radius: 3px;
  cursor: pointer;
}

.button:hover {
	background-color: #45a049;
}
</style>
</head>

<body>
	<h1>Shuffle Buddy</h1>
	<p>Welcome, ${sessionScope.username}!</p>
	<p>This is playlist: ${sessionScope.selectedPlaylistName}</p>
	<ul>
		<%
		try{
			
			Connection con = databaseconnection.getConnection();
			System.out.println(" database connection successfully opened.<br/><br/>");
        	PreparedStatement ps = con.prepareStatement("SELECT name, artist FROM playlist_contains_songs JOIN song ON playlist_contains_songs.spotify_uri = song.spotify_uri WHERE playlist_id =?");
        	//System.out.println("this is selected playlist" + session.getAttribute("selectedPlaylistID"));
        	ps.setString(1,(String) session.getAttribute("selectedPlaylistID"));
        	ResultSet rs=ps.executeQuery();
        	while (rs.next()) {
				String song_name = rs.getString("name");
				String song_artist = rs.getString("artist");
				%>
				<li><%=song_name%> - <%=song_artist %></li>
				<%
        	}
            
            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>
	</ul>                            

	<div class="button-container">
		<form id="form1" action="start_session_server" method="get">
        	<button type="start_listening" >Start Listening</button>
    	</form>
	</div>
	
	<a href="#" class="button" onclick="goToEditPage()">Edit Playlist</a>
	
	<a href="#" class="button" onclick="returnHome()">Home</a>
	

	<script>
		function goToEditPage() {
			window.location.href='../cs157a_team2/jsp/edit.jsp'
		}
		
		function returnHome() {
			window.location.href = '../cs157a_team2/jsp/home_screen.jsp'
		}
	</script>
</body>
</html>