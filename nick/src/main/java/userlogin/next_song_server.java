package userlogin;
import java.io.*;
// import javax.servlet.*;
// import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;  
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import userlogin.databaseconnection;

import java.sql.*;

@WebServlet("/next_song_server")
// Extend HttpServlet class
public class next_song_server extends HttpServlet {

   public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
	   HttpSession session = request.getSession();
	   Integer sessionID = (Integer) session.getAttribute("sessionID");
	   
	   try {
		   System.out.print("\n\nin next song server try catch block");
		   Connection con = databaseconnection.getConnection();
		   System.out.println(" database connection successfully opened.<br/><br/>");
		   
		   String durationParam = request.getParameter("duration");
		   System.out.println("<><><>duration: " + durationParam);
		   int duration = (int) Float.parseFloat(durationParam);
		   
		   Song suggested_song = (Song) session.getAttribute("suggested_song");
		   
		   //System.out.println("This is spotify_uri: " + suggested_song.getSpotifyURI());
		   //System.out.println("This is session_id: " + suggested_song.getSpotifyURI());
		   
		   //add the song that was just played into the plays table using the sessionID and the song object stored in the HTML session
		   PreparedStatement add_new_play = con.prepareStatement("INSERT INTO play (spotify_uri, session_id, duration) VALUES (?,?,?)");
		   add_new_play.setString(1, suggested_song.getSpotifyURI());
		   add_new_play.setString(2, sessionID.toString());
		   add_new_play.setString(3, Integer.toString(duration));
		   System.out.println("about to execute: \n" + add_new_play.toString());
		   int update_return = add_new_play.executeUpdate();
		   
		   System.out.println("about to dispatch to populate session server");
		   RequestDispatcher dispatcher = request.getRequestDispatcher("/populate_session_server");
		   dispatcher.forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}
   }
}