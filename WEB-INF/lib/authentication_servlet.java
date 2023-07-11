// Import required java libraries
import java.io.*;
// import javax.servlet.*;
// import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;  
import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  


import java.sql.*;

// Extend HttpServlet class
public class authentication_servlet extends HttpServlet {

   public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
      // Set response content type
      response.setContentType("text/html");
      PrintWriter out = response.getWriter(); 
      
      boolean isValid = false;

      String user_username = request.getParameter("Uname");
      String user_password = request.getParameter("Pass");
      
      // validate the username and password
      String db = "cs157a_team2";
      String my_sql_server_username = "root";
      String my_sql_server_password = "LTAndr3w";
      try {
              
         java.sql.Connection con; 
         //Class.forName("com.mysql.jdbc.Driver");
         con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a_team2?autoReconnect=true&useSSL=false",my_sql_server_username, my_sql_server_password);
         out.println(db + " database successfully opened.<br/><br/>");
         // Statement stmt = con.createStatement();
         // ResultSet rs = stmt.executeQuery("SELECT * FROM Listener WHERE username='" + user_username + "' AND password='" + user_password);
         PreparedStatement ps = con.prepareStatement("SELECT * FROM Listener WHERE username=? and password=?");  
         ps.setString(1,user_username);  
         ps.setString(2,user_password);  
               
         ResultSet rs=ps.executeQuery();
         
         if(rs.next()){
            isValid = true;
         }

         rs.close();
         ps.close();
         con.close();
      
      } catch(SQLException e) {
         out.println("SQLException caught: " + e.getMessage());
      }

      if (isValid) {
         // Redirect to the home page or perform other actions for successful login
         out.println("is valid");
         response.sendRedirect("home_screen.jsp");
      } else {
         // Password is incorrect
         out.println("is not valid");
         request.setAttribute("errorMessage", "Incorrect password. Please try again.");
         RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
         dispatcher.forward(request, response);
      }
   }

   public void destroy() {
      // do nothing.
   }
}