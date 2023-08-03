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
import javax.servlet.http.HttpSession;

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
      String labelValue = request.getParameter("admincheck");
      out.println("here");
      out.println(labelValue);
      try {
              
         
         Connection con = databaseconnection.getConnection();
         PreparedStatement ps;
         if(labelValue != null) {
        	 ps = con.prepareStatement("SELECT * FROM Admin WHERE BINARY username=? and BINARY user_password=?");  
         } else {
        	 ps = con.prepareStatement("SELECT * FROM User WHERE BINARY username=? and BINARY user_password=?");  
         }
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
       	  if(labelValue != null) {
       		  response.sendRedirect("jsp/adminhome.jsp"); 
             } else {
           	  response.sendRedirect("jsp/music.jsp"); 
             }
            
            
         
         } else {
            // Password or Username is incorrect
       	  if(labelValue != null) {
       		String errorMessage = "Incorrect password. Please try again.";
       		request.getSession().setAttribute("errormess", errorMessage);
       		response.sendRedirect(request.getContextPath() + "/jsp/adminlogin.jsp");
       		  
             } else {
            	 String errorMessage = "Incorrect password. Please try again.";
            	 request.getSession().setAttribute("errorMessage", errorMessage);
//            	 response.sendRedirect(request.getContextPath() + "/jsp/index.jsp");
            	 response.sendRedirect(request.getContextPath() + "/");
             }
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