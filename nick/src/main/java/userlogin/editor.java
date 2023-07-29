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

@WebServlet("/editor")
//Extend HttpServlet class
public class editor extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) {		
		System.out.println("In post.");
		
		String toAdd = request.getParameter("add-song");
		String toDelete = request.getParameter("delete-song");
		String playlistID = request.getParameter("playlist-id");
		System.out.println("Playlist: " + playlistID);
		
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
			add(toAdd, playlistID);
		}
		else if (!toAdd.equals("Add Song:") && !toDelete.equals("Delete Song:")) {
			delete(toDelete);
			add(toAdd, playlistID);
		}	
		try {
			response.sendRedirect("../cs157a_team2/jsp/edit.jsp");
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
	        
	        PreparedStatement findNumSongs = con.prepareStatement("SELECT COUNT(spotify_uri) FROM playlist_contains_songs");
	        ResultSet rs2=findNumSongs.executeQuery();
	        
	        int numSongsBefore = 0;
	        
	        while (rs2.next()) {
		        numSongsBefore = Integer.parseInt(rs2.getString(1));
		        break;
	        }
	        
	        String deleteStatement = "DELETE FROM playlist_contains_songs WHERE spotify_uri = '" + toDelete + "'";
	        System.out.println(deleteStatement);
		    PreparedStatement sqlDelete = con.prepareStatement(deleteStatement);
		    sqlDelete.executeUpdate();
		    
	        ResultSet rs3=findNumSongs.executeQuery();
	        
	        int numSongsAfter = 0;
	        
	        while (rs3.next()) {
		        numSongsAfter = Integer.parseInt(rs3.getString(1));
		        break;
	        }
	        
	        if (numSongsAfter < numSongsBefore) {
		        System.out.println("Song deleted successfully.");
	        }
	        else {
	        	System.out.println("Failed to delete song.");
	        }
	
		}
		catch(Exception e) {
	    	System.out.println(e);
	        System.out.println("SQLException caught: " + e.getMessage());
	    }
	}
	
	protected void add(String toAdd, String playlistID) {
		try {
			System.out.println("Adding Song");
			
		    Connection con = databaseconnection.getConnection();
	        
		    String addStatement = "INSERT INTO playlist_contains_songs (playlist_id, spotify_uri) VALUES (" + playlistID + ", " + "'" + toAdd + "')";
		    PreparedStatement sqlAdd = con.prepareStatement(addStatement);
		    
		    // Execute
		    int rowsInserted = sqlAdd.executeUpdate();

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
