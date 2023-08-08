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
import java.time.*;
import java.time.format.DateTimeFormatter;

@WebServlet("/add_playlist")
//Extend HttpServlet class
public class add_playlist extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) {		
		System.out.println("In playlist maker.");
		
		String playlistName = request.getParameter("playlist-name");
		String username = request.getParameter("username");
		
		if (playlistName.equals("")) {
			System.out.println("No name given.");
			return;
		}
		
		System.out.println("Adding playlist: " + playlistName);
		
		try {
			Connection con = databaseconnection.getConnection();
	        
	        PreparedStatement findPrevID = con.prepareStatement("SELECT MAX(playlist_id) FROM playlist");
	        
	        ResultSet rs=findPrevID.executeQuery();
	        
	        int prevID = 0;
	        
	        while (rs.next()) {
		        prevID = Integer.parseInt(rs.getString(1));
		        break;
	        }
	        
	        int newID = prevID + 1;
	        
	        LocalDate localDate = LocalDate.now();
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	        String createDate = localDate.format(formatter);
	        System.out.println(createDate);
	        
	        PreparedStatement playlistInsert = con.prepareStatement("INSERT INTO playlist (playlist_id, name, created_date) VALUES (?, ?, ?)");
	        
		    playlistInsert.setInt(1, newID);
		    playlistInsert.setString(2, playlistName);
		    playlistInsert.setString(3, createDate);

	        playlistInsert.execute();
	        
	        PreparedStatement createdInsert = con.prepareStatement("INSERT INTO created (username, playlist_id) VALUES (?, ?)");
	        
	        createdInsert.setString(1, username);
		    createdInsert.setInt(2, newID);
	        
	        createdInsert.execute();
	        
	        System.out.println("Playlist added successfully.");
	        
	        request.setAttribute("successMessage", "Playlist created! Navigate to the editor to add songs.");

			response.sendRedirect("../cs157a_team2/jsp/home_screen.jsp");

		}
		catch(Exception e) {
	    	System.out.println(e);
	        System.out.println("SQLException caught: " + e.getMessage());
	    }
		
	}
}