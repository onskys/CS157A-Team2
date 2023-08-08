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
 * Servlet implementation class SecurityQuestionServlet
 */
@WebServlet("/SecurityQuestionServlet")
public class SecurityQuestionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SecurityQuestionServlet() {
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
		String selectedUsers = request.getParameter("question-text");
	    
	        try {
	            Connection con = databaseconnection.getConnection();

	            // Use a prepared statement to avoid SQL injection
	            String sql = "select max(security_id) as maxi from security_question";
	            PreparedStatement pstmt = con.prepareStatement(sql);
	            ResultSet resultSet = pstmt.executeQuery();
	            int val = -100;
	            if (resultSet.next()) {
	                val = resultSet.getInt("maxi") + 1;
	            }
	            // Loop through the selected users and execute the delete query for each username
	            System.out.println(val);
	            pstmt.close();
	            String sql1 = "Insert into security_question(security_id,question_text) values(?,?);";
	            PreparedStatement pstmt1 = con.prepareStatement(sql1);
	            
	            pstmt1.setInt(1, val);
	            pstmt1.setString(2, selectedUsers);
	            pstmt1.executeUpdate();
	            pstmt1.close();
	            con.close();

	            
	            response.sendRedirect("/cs157a_team2/jsp/securityQuestion.jsp");
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	}

}
