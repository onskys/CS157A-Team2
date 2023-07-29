<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
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
	<p>This is playlist: ${sessionScope.selectedPlaylistName}</p>
	<ul>
		<%
		try{
			java.sql.Connection con;
            Class.forName("com.mysql.jdbc.Driver");
            String dbURL = "jdbc:mysql://localhost:3306/cs157a_team2?autoReconnect=true&useSSL=false";
            String dbUser = "root";
            String dbPassword = "sbhSQLcc59!3%";
            con = DriverManager.getConnection(dbURL, dbUser, dbPassword);        	System.out.println(" database connection successfully opened.<br/><br/>");
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
		<form id="form1" action="../start_session_server" method="get">
        	<button type="start_listening" >Start Listening</button>
    	</form>
    	<form id="form2" action="../return_to_home_server" method="get">
        	<button type="back_to_home" >Back to Home</button>
    	</form>
	</div>
	
	<a href="#" class="button" onclick="goToEditPage()">Edit Playlist</a>


	<script>
		function goToEditPage() {
			window.location.href='../cs157a_team2/jsp/edit.jsp'
		}
	</script>
</body>
</html>
