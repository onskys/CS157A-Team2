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

@WebServlet("/start_session_server")
// Extend HttpServlet class
public class start_session_server extends HttpServlet {

   public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
	   HttpSession session = request.getSession();
	   String selectedPlaylistID = (String) session.getAttribute("selectedPlaylistID");
	   
	   try {
		   System.out.print("\n\nin start session server try catch block");
		   Connection con = databaseconnection.getConnection();
		   System.out.println(" database connection successfully opened.<br/><br/>");
		   
//		   PreparedStatement findPrevID = con.prepareStatement("SELECT MAX(session_id) FROM session");
//		   System.out.println("about to execute: \n" + findPrevID.toString());
//		   ResultSet rs=findPrevID.executeQuery();
//	       //int prevID = 0;
//	       int newID = 0;
//	       
//	       if (rs.next()) {
//	    	   //int prevID = Integer.parseInt(rs.getString(1));
//		       int prevID = rs.getInt(1);
//		       if(!rs.wasNull()) {
//		    	   System.out.println("previous ID: " + Integer.toString(prevID));
//		    	   newID = prevID + 1;
//		       }
//	       }
		   
		   PreparedStatement insertNewSession = con.prepareStatement("INSERT INTO session(start_time, playlist_id) VALUES (NOW(),?)", PreparedStatement.RETURN_GENERATED_KEYS);
		   System.out.println("this is selected playlist" + session.getAttribute("selectedPlaylistID"));
		   //insertNewSession.setString(1, Integer.toString(newID));
		   insertNewSession.setString(1, selectedPlaylistID);
		   System.out.println("about to execute: \n" + insertNewSession.toString());
		   int update_return = insertNewSession.executeUpdate();
		   
		   // Retrieve the generated primary key
           int generatedID = -1;
           ResultSet generatedKeys = insertNewSession.getGeneratedKeys();
           if (generatedKeys.next()) {
               generatedID = generatedKeys.getInt(1);
           } else {
        	   System.out.println("failed to return generated session_id in start session server");
           }
		   
		   session.setAttribute("sessionID", generatedID);
		   request.setAttribute("init", true);
		   
		   System.out.println("dispatching to populate session server");
		   RequestDispatcher dispatcher = request.getRequestDispatcher("/populate_session_server");
		   dispatcher.forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}
   }
}