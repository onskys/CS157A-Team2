<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
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

    .button:hover {
      background-color: #45a049;
    }
  </style>
</head>
<body>
  <h1>Shuffle Buddy Default Playlist</h1>
  
  <%
  try {
      Class.forName("com.mysql.jdbc.Driver");
      String dbURL = "jdbc:mysql://localhost:3306/cs157a_team2?autoReconnect=true&useSSL=false";
      String dbUser = "root";
      String dbPassword = "sbhSQLcc59!3%";
      Connection con = DriverManager.getConnection(dbURL, dbUser, dbPassword);
      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery("SELECT spotify_id FROM default_playlist");
      
      ArrayList<String> songs = new ArrayList<>();
      int i = 0;
      while (rs.next()) {
    	  songs.add(rs.getString(i));
    	  i++;
      }
      
      for (String s : songs) {
    	  out.println(s);
      }
      
      String s1 = "https://open.spotify.com/embed/track/" + songs.get(0) + "?utm_source=generator&theme=0";
      String s2 = "https://open.spotify.com/embed/track/" + songs.get(1) + "?utm_source=generator&theme=0";
      String s3 = "https://open.spotify.com/embed/track/" + songs.get(2) + "?utm_source=generator&theme=0";
      String s4 = "https://open.spotify.com/embed/track/" + songs.get(3) + "?utm_source=generator&theme=0";
      String s5 = "https://open.spotify.com/embed/track/" + songs.get(4) + "?utm_source=generator&theme=0";
      String s6 = "https://open.spotify.com/embed/track/" + songs.get(5) + "?utm_source=generator&theme=0";
      String s7 = "https://open.spotify.com/embed/track/" + songs.get(6) + "?utm_source=generator&theme=0";
      String s8 = "https://open.spotify.com/embed/track/" + songs.get(7) + "?utm_source=generator&theme=0";
      String s9 = "https://open.spotify.com/embed/track/" + songs.get(8) + "?utm_source=generator&theme=0";
      String s10 = "https://open.spotify.com/embed/track/" + songs.get(9) + "?utm_source=generator&theme=0";
      
      
      rs.close();
      stmt.close();
      con.close();
  } 
  catch (SQLException | ClassNotFoundException e) {
      e.printStackTrace();
  }
  %>

  <iframe style="border-radius:12px" 
  src=s1
  width="100%" height="152" frameBorder="0" allowfullscreen="" 
  allow="autoplay; clipboard-write; encrypted-media; fullscreen; 
  picture-in-picture" loading="lazy"></iframe>
  
  <iframe style="border-radius:12px" 
  src=s2
  width="100%" height="152" frameBorder="0" allowfullscreen="" 
  allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" 
  loading="lazy"></iframe>
  
  <iframe style="border-radius:12px" 
  src=s3
  width="100%" height="152" frameBorder="0" allowfullscreen="" 
  allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" 
  loading="lazy"></iframe>
  
  <iframe style="border-radius:12px" 
  src=s4
  width="100%" height="152" frameBorder="0" allowfullscreen="" 
  allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" 
  loading="lazy"></iframe>
  
  <iframe style="border-radius:12px" 
  src=s5
  width="100%" height="152" frameBorder="0" allowfullscreen="" 
  allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" 
  loading="lazy"></iframe>
  
  <iframe style="border-radius:12px" 
  src=s6
  width="100%" height="152" frameBorder="0" allowfullscreen="" 
  allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" 
  loading="lazy"></iframe>

  <iframe style="border-radius:12px" 
  src=s7
  width="100%" height="152" frameBorder="0" allowfullscreen="" 
  allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" 
  loading="lazy"></iframe>

  <iframe style="border-radius:12px" 
  src=s8
  width="100%" height="152" frameBorder="0" allowfullscreen=""
   allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" 
   loading="lazy"></iframe>

  <iframe style="border-radius:12px" 
  src=s9
  width="100%" height="152" frameBorder="0" allowfullscreen="" 
  allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" 
  loading="lazy"></iframe>

  <iframe style="border-radius:12px" 
  src=s10
  width="100%" height="152" frameBorder="0" allowfullscreen="" 
  allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" 
  loading="lazy"></iframe>
  
</body>
</html>
