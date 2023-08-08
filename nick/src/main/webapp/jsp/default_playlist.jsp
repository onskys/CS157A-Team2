<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="userlogin.databaseconnection"%>

<html>
<head>
<title>Default Playlist</title>
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

button[type="home"] {
  display: block;
  width: 20%;
  padding: 10px;
  align-item: center;
  background-color: #4caf50;
  color: white;
  border: none;
  border-radius: 3px;
  cursor: pointer;
}

button[type="edit"] {
  display: block;
  width: 20%;
  padding: 10px;
  background-color: #4caf50;
  margin-left: auto;
  margin-right: auto;
  margin-bottom: 20px;
  margin-top: 20px;
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
	<h1>Default Playlist Editor For Admins</h1>
	<p>Update the default playlist for all users.</p>
	<ul>
		<%
		try{
			Connection con = databaseconnection.getConnection();
        	PreparedStatement ps = con.prepareStatement("SELECT name, artist FROM default_playlist JOIN song ON default_playlist.spotify_uri = song.spotify_uri");
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
    <form id="edit-form" action="../default_editor" method="POST">
		<div class="form-group">
		     <input type="hidden" value=${sessionScope.adminName} name="admin-name" />		
           	 <label for="delete-song">Delete Song:</label>
			 <select id="delete-song" name="delete-song">
             	  <option>Delete Song:</option>
              	  <% 
                	    try {
                        Connection con = databaseconnection.getConnection();
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT song.name, default_playlist.spotify_uri FROM song JOIN default_playlist ON song.spotify_uri = default_playlist.spotify_uri");
                        
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
        	<div><button type="edit">MAKE EDIT</button></div>
        </div>
    </form>
    <button type="home" onClick="returnHome()">BACK TO ADMIN PAGE</button>
    
    <script>
    function returnHome() {
    	window.location.href = '../jsp/adminhome.jsp'
    }
    </script>
</body>
</html>
