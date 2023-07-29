<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="userlogin.databaseconnection"%>

<html>
<head>
<title>Playlist Editor</title>
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
	<h1>Playlist Editor</h1>
	<p>Edit your playlist by deleting or adding songs.</p>
	<ul>
		<%
		try{
			Connection con = databaseconnection.getConnection();
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
    <form id="edit-form" action="../editor" method="POST">
		<div class="form-group">
			 <input type="hidden" value=${sessionScope.selectedPlaylistID} name="playlist-id" />
           	 <label for="delete-song">Delete Song:</label>
			 <select id="delete-song" name="delete-song">
             	  <option>Delete Song:</option>
              	  <% 
                	    try {
                        /* java.sql.Connection con;
                        Class.forName("com.mysql.jdbc.Driver");
                        String dbURL = "jdbc:mysql://localhost:3306/cs157a_team2?autoReconnect=true&useSSL=false";
                        String dbUser = "root";
                        String dbPassword = "Shroot123@";
                        con = DriverManager.getConnection(dbURL, dbUser, dbPassword); */
                        Connection con = databaseconnection.getConnection();
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT song.name, playlist_contains_songs.spotify_uri FROM song JOIN playlist_contains_songs ON song.spotify_uri = playlist_contains_songs.spotify_uri WHERE playlist_id = "  + (String) session.getAttribute("selectedPlaylistID"));
                        
                        while (rs.next()) {
                            String songName = rs.getString("name");
                            String spotify_uri = rs.getString("spotify_uri");
                            %>
                            <option value="<%=spotify_uri%>"> <%=songName%> </option>
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
        	<label for="add-song">Add Song:</label>
        	<select id="add-song" name="add-song">
        		<option>Add Song:</option>
        		<% 
                	    try {
                        /* java.sql.Connection con;
                        Class.forName("com.mysql.jdbc.Driver");
                        String dbURL = "jdbc:mysql://localhost:3306/cs157a_team2?autoReconnect=true&useSSL=false";
                        String dbUser = "root";
                        String dbPassword = "Shroot123@";
                        con = DriverManager.getConnection(dbURL, dbUser, dbPassword); */
                        Connection con = databaseconnection.getConnection();
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT song.name, song.spotify_uri FROM song");
                        while (rs.next()) {
                            String songName = rs.getString("name");
                            String spotify_uri = rs.getString("spotify_uri");
                            %>
                            <option value="<%=spotify_uri%>"> <%=songName%> </option>
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
        	<button type="edit">MAKE EDIT</button>
        	
        	
        </div>
    </form>
</body>
</html>
