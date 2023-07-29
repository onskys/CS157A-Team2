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

		    if (rowsInserted > 0) {
		    	
		    	request.setAttribute("successMessage", "Signup Successful!");
		        out.println("User data inserted successfully.");
		        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/index.jsp");
                dispatcher.forward(request, response);
		        
		    } else {
		        out.println("Failed to insert user data.");
		    }

		    // Clean up resources
		    statement.close();
		    con.close();
			
			
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println(e);
			e.printStackTrace();
		}
	}

}
