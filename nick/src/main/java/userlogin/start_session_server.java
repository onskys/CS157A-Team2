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
      
      // Set response content type
//      response.setContentType("text/html");
//      String selectedPlaylist = (String) request.getParameter("playlist-question");
//      HttpSession session = request.getSession();
//      session.setAttribute("selectedPlaylistID", selectedPlaylist);
//      
//      try {
//    	  System.out.println("In try catch block");
//    	  Connection con = databaseconnection.getConnection();
//          System.out.println(" database connection successfully opened.<br/><br/>");
//          PreparedStatement ps = con.prepareStatement("SELECT name FROM playlist WHERE playlist_id=?");
//          System.out.println("this is selected playlist" + session.getAttribute("selectedPlaylistID"));
//          ps.setString(1,(String) session.getAttribute("selectedPlaylistID"));
//          ResultSet rs=ps.executeQuery();
//          if(rs.next()) {
//        	  String playlist_name = rs.getString("name");
//        	  System.out.println("polaylist name: " + playlist_name);
//        	  session.setAttribute("selectedPlaylistName", playlist_name);
//          }
//      } catch (SQLException e) {
//          e.printStackTrace();
//      }
//     
//      request.getRequestDispatcher("jsp/specific_playlist.jsp").forward(request, response);
   }
}