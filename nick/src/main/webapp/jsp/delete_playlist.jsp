<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="userlogin.databaseconnection"%>

<html>
<head>
<title>Delete Playlist</title>
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
	<h1>Delete A Playlist</h1>
	<p>Select the playlist you want to delete.</p>
    <form id="name-form" action="../remove_playlist" method="POST">
		<div class="form-group">
		     <label for="delete-playlist">Delete Playlist:</label>
			 <select id="delete-playlist" name="delete-playlist">
             	  <option>Delete Playlist:</option>
              	  <% 
                	    try {
                        Connection con = databaseconnection.getConnection();
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT p.playlist_id, p.name FROM playlist p, created c WHERE p.playlist_id = c.playlist_id AND c.username = '" + session.getAttribute("username") + "'");
                        
                        while (rs.next()) {
                            String playlistName = rs.getString("name");
                            String playlistID = rs.getString("playlist_id");
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
            <button type="delete-playlist">DELETE PLAYLIST</button>        	
                 	
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
