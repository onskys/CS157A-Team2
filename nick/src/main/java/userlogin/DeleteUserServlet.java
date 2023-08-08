package userlogin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 * Servlet implementation class DeleteUserServlet
 */
@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteUserServlet() {
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
		String[] selectedUsers = request.getParameterValues("user-list");
	    if (selectedUsers != null && selectedUsers.length > 0) {
	        try {
	            Connection con = databaseconnection.getConnection();

	            // Use a prepared statement to avoid SQL injection
	            String userDeleteSql = "DELETE FROM user WHERE username = ?";
	            String createdDeleteSql = "DELETE FROM created WHERE username = ?";
	            
	            PreparedStatement userDeleteStmt = con.prepareStatement(userDeleteSql);
	            PreparedStatement createdDeleteStmt = con.prepareStatement(createdDeleteSql);
	            

	            // Looping through the selected users
	            for (String selectedUser : selectedUsers) {
	            	userDeleteStmt.setString(1, selectedUser);
	            	userDeleteStmt.executeUpdate();
	            	createdDeleteStmt.setString(1, selectedUser);
	            	createdDeleteStmt.executeUpdate();
	                
	            }

	            createdDeleteStmt.close();
	            userDeleteStmt.close();
	            con.close();

	            
	            response.sendRedirect("/cs157a_team2/jsp/deleteuser.jsp");
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}

}
