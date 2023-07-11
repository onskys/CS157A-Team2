package userlogin;
import java.io.*;
// import javax.servlet.*;
// import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;  
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import userlogin.databaseconnection;

import java.sql.*;

@WebServlet("/auth_server")
// Extend HttpServlet class
public class auth_server extends HttpServlet {

   public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
      // Set response content type
      response.setContentType("text/html");
      PrintWriter out = response.getWriter(); 
      
      boolean isValid = false;

      String user_username = request.getParameter("Uname");
      String user_password = request.getParameter("Pass");
      try {
              
         
         Connection con = databaseconnection.getConnection();
         out.println(" database successfully opened.<br/><br/>");
         // Statement stmt = con.createStatement();
         // ResultSet rs = stmt.executeQuery("SELECT * FROM Listener WHERE username='" + user_username + "' AND password='" + user_password);
         PreparedStatement ps = con.prepareStatement("SELECT * FROM User WHERE BINARY username=? and BINARY user_password=?");  
         ps.setString(1,user_username);  
         ps.setString(2,user_password);  
               
         ResultSet rs=ps.executeQuery();
         if(rs.next()){
            isValid = true;
         }

         rs.close();
         ps.close();
         con.close();
      
      

      if (isValid) {
         // Redirect to the home page or perform other actions for successful login
         out.println("is valid");
         response.sendRedirect("jsp/home_screen.jsp");
      } else {
         // Password is incorrect
         out.println("is not valid");
         request.setAttribute("errorMessage", "Incorrect password. Please try again.");
         RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/index.jsp");
         dispatcher.forward(request, response);
      }
      } catch(Exception e) {
    	  System.out.println(e);
         out.println("SQLException caught: " + e.getMessage());
      }
   }
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	   
	   
   }
   public void destroy() {
      // do nothing.
   }
}