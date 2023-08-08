package userlogin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class reset_password_servlet
 */
@WebServlet("/reset_password_servlet")
public class reset_password_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public reset_password_servlet() {
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
	        String username = request.getParameter("username");
	        String securityQuestion = "";
	        Connection con = databaseconnection.getConnection();
	        PreparedStatement ps = con.prepareStatement("SELECT question_text FROM security_question WHERE security_id = (SELECT security_id from user where username = ?)");
	        ps.setString(1, username);

	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            securityQuestion = rs.getString("question_text");
	            // Store the security question and username in request attributes
	            

	            // Forward the request to the reset_password.jsp page
	            response.sendRedirect(request.getContextPath() + "/jsp/forgotpass.jsp?securityQuestion=" + securityQuestion + "&username=" + username);
	        } else {
	            // If the username is not found, show an error message
	        	response.sendRedirect(request.getContextPath() + "/jsp/forgotpass.jsp?resetStatus=Invalid+username");

	        }
	    } catch (Exception e) {
	        System.out.println(e);
	    }
	}
    
	}

