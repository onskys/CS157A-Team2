package userlogin;
import java.io.*;
//import javax.servlet.*;
//import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;  
import javax.servlet.ServletException;
import java.io.PrintWriter;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import userlogin.databaseconnection;

import java.sql.*;

@WebServlet("/remove_playlist")
//Extend HttpServlet class
public class remove_playlist extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("In playlist remover.");
		
		String playlistToRemove = request.getParameter("delete-playlist");
		
		if (playlistToRemove.equals("Delete Playlist:")) {
			System.out.println("No name given.");
			return;
		}
		
		System.out.println("Deleting Playlist: " + playlistToRemove);
		
		
		try {
			Connection con = databaseconnection.getConnection();
	        
	        PreparedStatement deletePlaylist = con.prepareStatement("DELETE FROM playlist WHERE playlist_id = " + playlistToRemove);
	        
	        deletePlaylist.execute();
	        
	        PreparedStatement deleteCreated = con.prepareStatement("DELETE FROM created WHERE playlist_id = " + playlistToRemove);
	        
	        deleteCreated.execute();
	        
	        System.out.println("Playlist deleted successfully.");
	        
	        request.setAttribute("successMessage", "Playlist deleted!");

			response.sendRedirect("../cs157a_team2/jsp/home_screen.jsp");
	    }
		catch(Exception e) {
	    	System.out.println(e);
	        System.out.println("SQLException caught: " + e.getMessage());
	    }

	}
}