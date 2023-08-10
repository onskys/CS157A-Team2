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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@WebServlet("/default_editor")
//Extend HttpServlet class
public class default_editor extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) {		
		System.out.println("In default editor.");
		
		String toAdd = request.getParameter("add-song");
		String toDelete = request.getParameter("delete-song");
		String adminName = request.getParameter("admin-name");
				
		System.out.println("Add request: " + toAdd);
		System.out.println("Delete request: " + toDelete);
		
		if (!toDelete.equals("Delete Song:")) {
			System.out.println("Delete checked");
		}
		
		if (toAdd.equals("Add Song:")) {
			System.out.println("Add checked");
		}
		
		if (!toDelete.equals("Delete Song:") && toAdd.equals("Add Song:")) {
			delete(toDelete);
		}
		
		else if (!toAdd.equals("Add Song:") && toDelete.equals("Delete Song:")) {
			add(toAdd, adminName);
		}
		else if (!toAdd.equals("Add Song:") && !toDelete.equals("Delete Song:")) {
			delete(toDelete);
			add(toAdd, adminName);
		}	
		try {
			response.sendRedirect("../cs157a_team2/jsp/default_playlist.jsp");
		}
		catch(Exception e) {
	    	System.out.println(e);
	        System.out.println("SQLException caught: " + e.getMessage());
	    }
	}
	
	protected void delete(String toDelete) {
		try {
			System.out.println("Deleting Song");

		    Connection con = databaseconnection.getConnection();
	        
	        PreparedStatement deleteStatement = con.prepareStatement("DELETE FROM default_playlist WHERE spotify_uri = ?");
	        deleteStatement.setString(1, toDelete);
	        deleteStatement.execute();
	        
//	        PreparedStatement deleteStatementContains = con.prepareStatement("DELETE FROM playlist_contains_songs WHERE spotify_uri = ? AND playlist_id = 1");
//	        deleteStatementContains.setString(1, toDelete);
//	        deleteStatementContains.execute();
		    
	        System.out.println("Song deleted successfully.");
	
		}
		catch(Exception e) {
	    	System.out.println(e);
	        System.out.println("SQLException caught: " + e.getMessage());
	    }
	}
	
	protected void add(String toAdd, String adminName) {
		try {
			System.out.println("Adding Song");
			
		    Connection con = databaseconnection.getConnection();
	        
	        LocalDate localDate = LocalDate.now();
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	        String createDate = localDate.format(formatter);
	        	        
	        PreparedStatement addStatement = con.prepareStatement("INSERT INTO default_playlist (spotify_uri, add_date, admin_name) VALUES (?, NOW(), ?)");
		    
		    addStatement.setString(1, toAdd);
		    addStatement.setString(2,  adminName);
		    addStatement.execute();
		    
//	        PreparedStatement addStatementContains = con.prepareStatement("INSERT INTO playlist_contains_songs (playlist_id, spotify_uri) VALUES (1, ?)");
//		    addStatementContains.setString(1, toAdd);
//		    
//		    addStatementContains.execute();
	        
		    // Execute
		    int rowsInserted = addStatement.executeUpdate();

		    if (rowsInserted > 0) {
		    	
		        System.out.println("Song added successfully.");
		        
		    } else {
		        System.out.println("Failed to add song.");
		    }
		}
		catch(Exception e) {
	    	System.out.println(e);
	        System.out.println("SQLException caught: " + e.getMessage());
	    }
	}
}
