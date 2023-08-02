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

@WebServlet("/delete_session_server")
// Extend HttpServlet class
public class delete_session_server extends HttpServlet {

   public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
	   HttpSession session = request.getSession();
	   Integer sessionID = (Integer) session.getAttribute("sessionID");
	   
	   try {
		   System.out.print("\n\nin start session server try catch block");
		   Connection con = databaseconnection.getConnection();
		   System.out.println(" database connection successfully opened.<br/><br/>");
		   
		   PreparedStatement delete_session_row = con.prepareStatement("DELETE FROM session WHERE session_id =?");
		   delete_session_row.setInt(1, sessionID);
		   System.out.println("about to execute: \n" + delete_session_row.toString());
		   int update_return =delete_session_row.executeUpdate();
	        
	       PreparedStatement delete_play_row = con.prepareStatement("DELETE FROM play WHERE session_id =?");
		   delete_play_row.setInt(1, sessionID);
		   System.out.println("about to execute: \n" + delete_play_row.toString());
		   update_return =delete_play_row.executeUpdate();
	       
	       //decide where to change the playlistName and playlistID and sessionID values in session
	       //probably change the suggested song object in session here too
		   
		   System.out.println("about to send redirect to hme screen jsp");
	       response.sendRedirect("jsp/home_screen.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		}
   }
}