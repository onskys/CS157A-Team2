package userlogin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

@WebServlet("/databaseconnection")
public class databaseconnection extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public databaseconnection() {
        super();
    }
    
    // Used for establishing connection to database.Update url,username,password with your mysql credentials
    public static Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/cs157a_team2?autoReconnect=true&useSSL=false";
        String username = "root";
        String password = "LTAndr3w";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC driver not found.");
        }

        return DriverManager.getConnection(url, username, password);
    }
}
