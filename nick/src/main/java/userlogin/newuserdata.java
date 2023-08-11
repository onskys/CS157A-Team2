package userlogin;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import userlogin.databaseconnection;

/**
 * Servlet implementation class newuserdata
 */
@WebServlet("/newuserdata")
public class newuserdata extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public newuserdata() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			PrintWriter out = response.getWriter();
		    Connection con = databaseconnection.getConnection();
		    String username = request.getParameter("username");
		    String firstname = request.getParameter("firstname");
		    String lastname = request.getParameter("lastname");
		    String password = request.getParameter("password");
		    String security_id = request.getParameter("security-question");
		    String security_answer = request.getParameter("Security-answer");
		    // Prepare the SQL statement
		    String sql = "INSERT INTO user (username, first_name, last_name, password,security_id,security_answer) VALUES (?, ?, ?, ?, ?, ?)";
		    PreparedStatement statement = con.prepareStatement(sql);
		    statement.setString(1, username);
		    statement.setString(2, firstname);
		    statement.setString(3, lastname);
		    statement.setString(4, password);
		    statement.setString(5, security_id);
		    statement.setString(6, security_answer);

		    // Execute the SQL statement
		    int rowsInserted = statement.executeUpdate();
		    
		    //create copy of default playlist for new user
		    PreparedStatement copy_default_playlist = con.prepareStatement("INSERT INTO playlist (name, created_date) VALUES (?, NOW())", PreparedStatement.RETURN_GENERATED_KEYS);
		    copy_default_playlist.setString(1, "default_copy_for_" + firstname);
		    copy_default_playlist.execute();
		    int generatedID = -1;
	        ResultSet generatedKeys = copy_default_playlist.getGeneratedKeys();
	        if (generatedKeys.next()) {
	        	generatedID = generatedKeys.getInt(1);
	        } else {
	        	System.out.println("failed to return generated playlist_id in newuserdate server");
	        }
	        
	        //copy songs from default playlist to playlist contains songs
	        PreparedStatement copy_default_playlist_songs = con.prepareStatement("INSERT INTO playlist_contains_songs SELECT ?, d.spotify_uri FROM default_playlist d");
	        copy_default_playlist_songs.setString(1, Integer.toString(generatedID));
	        copy_default_playlist_songs.execute();
		    
		    // Adding default playlist to new user created
		    PreparedStatement addDefault = con.prepareStatement("INSERT INTO created (username, playlist_id) VALUES (?, ?)");
		    addDefault.setString(1,  username);
		    addDefault.setString(2, Integer.toString(generatedID));
		    addDefault.execute();

		    // Clean up resources
		    statement.close();
		    con.close();

		    if (rowsInserted > 0) {
		    	
		    	request.setAttribute("successMessage", "Signup Successful!");
		        out.println("User data inserted successfully.");
		        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/index.jsp");
                dispatcher.forward(request, response);
		        
		    } else {
		        out.println("Failed to insert user data.");
		    }	
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println(e);
			e.printStackTrace();
		}
	}

}